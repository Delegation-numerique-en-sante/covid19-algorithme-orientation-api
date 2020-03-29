defmodule Covid19OrientationWeb.Operations.EvaluateOrientation.AucunSymptomeTest do
  @moduledoc """
  Patient avec aucun symtôme.
  """

  use ExUnit.Case, async: true
  alias Covid19OrientationWeb.Operations.EvaluateOrientation
  alias Covid19OrientationWeb.Schemas.{Orientation, Pronostiques, Symptomes}

  test "patient avec aucun symtôme" do
    {:ok, orientation} =
      %Orientation{
        symptomes: %Symptomes{temperature: 36.6},
        pronostiques: %Pronostiques{cardiaque: false}
      }
      |> EvaluateOrientation.call()

    assert orientation.conclusion.code == "FIN9"
  end
end
