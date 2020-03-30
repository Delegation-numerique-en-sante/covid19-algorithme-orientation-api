defmodule Covid19OrientationWeb.Operations.EvaluateOrientation.AucunSymptomeTest do
  @moduledoc """
  Patient avec aucun symtôme.
  """

  use ExUnit.Case, async: true
  alias Covid19Orientation.Tests.Conditions
  alias Covid19OrientationWeb.Operations.EvaluateOrientation
  alias Covid19OrientationWeb.Schemas.{Orientation, Pronostiques, Symptomes}

  test "patient avec aucun symtôme" do
    {:ok, orientation} =
      %Orientation{
        symptomes: %Symptomes{temperature: 36.6},
        pronostiques: %Pronostiques{cardiaque: false}
      }
      |> EvaluateOrientation.call()

    assert Conditions.symptomes4(orientation)
    assert Conditions.facteurs_pronostique(orientation) == 0
    assert Conditions.facteurs_gravite_mineurs(orientation) == 0
    assert Conditions.facteurs_gravite_majeurs(orientation) == 0
    assert orientation.conclusion.code == "FIN9"
  end
end
