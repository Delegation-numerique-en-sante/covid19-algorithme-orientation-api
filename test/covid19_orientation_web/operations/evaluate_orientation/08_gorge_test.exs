defmodule Covid19OrientationWeb.Operations.EvaluateOrientation.MalDeGorgeTest do
  @moduledoc """
  Patient avec seulement mal de gorge.
  """

  use ExUnit.Case, async: true
  alias Covid19Orientation.Tests.Conditions
  alias Covid19OrientationWeb.Operations.EvaluateOrientation
  alias Covid19OrientationWeb.Schemas.{Orientation, Pronostiques, Symptomes}

  setup do
    {:ok,
     orientation: %Orientation{
       symptomes: %Symptomes{
         temperature: 36.6,
         mal_de_gorge: true
       },
       pronostiques: %Pronostiques{cardiaque: false}
     }}
  end

  test "sans facteur de gravité", %{orientation: orientation} do
    {:ok, orientation} =
      orientation
      |> EvaluateOrientation.call()

    assert Conditions.symptomes3(orientation)
    assert Conditions.facteurs_gravite(orientation) == 0
    assert orientation.conclusion.code == "FIN7"
  end

  test "avec au moins un facteur de gravité", %{orientation: orientation} do
    {:ok, orientation} =
      %Orientation{
        orientation
        | symptomes: %Symptomes{orientation.symptomes | fatigue: true}
      }
      |> EvaluateOrientation.call()

    assert Conditions.symptomes3(orientation)
    assert Conditions.facteurs_gravite_mineurs(orientation) >= 1
    assert orientation.conclusion.code == "FIN8"
  end

  test "avec au moins un facteur pronostique", %{orientation: orientation} do
    {:ok, orientation} =
      %Orientation{
        orientation
        | pronostiques: %Pronostiques{orientation.pronostiques | cardiaque: true}
      }
      |> EvaluateOrientation.call()

    assert Conditions.symptomes3(orientation)
    assert Conditions.facteurs_pronostique(orientation) >= 1
    assert orientation.conclusion.code == "FIN8"
  end
end
