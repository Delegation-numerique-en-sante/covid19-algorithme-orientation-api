defmodule Covid19OrientationWeb.Operations.EvaluateOrientation.AutresTest do
  @moduledoc """
  Autres.
  """

  use ExUnit.Case, async: true
  alias Covid19Orientation.Tests.Test
  alias Covid19OrientationWeb.Operations.EvaluateOrientation
  alias Covid19OrientationWeb.Schemas.{Orientation, Pronostiques, Symptomes}

  test "Bastien Guerry #1" do
    {:ok, orientation} =
      %Orientation{
        symptomes: %Symptomes{temperature: 36.6, anosmie: true, fatigue: true},
        pronostiques: %Pronostiques{age: 50, cardiaque: false, taille: 1.2, poids: 40.0}
      }
      |> EvaluateOrientation.call()

    assert Test.facteurs_pronostique(orientation) == 0
    assert Test.facteurs_gravite_mineurs(orientation) == 1
    assert Test.facteurs_gravite_majeurs(orientation) == 0
    assert orientation.conclusion.code == "FIN8"
  end

  test "Bastien Guerry #2" do
    {:ok, orientation} =
      %Orientation{
        symptomes: %Symptomes{temperature: 36.6, toux: true, fatigue: true},
        pronostiques: %Pronostiques{age: 50, cardiaque: true, taille: 1.2, poids: 40.0}
      }
      |> EvaluateOrientation.call()

    assert Test.facteurs_pronostique(orientation) == 1
    assert Test.facteurs_gravite_mineurs(orientation) == 1
    assert Test.facteurs_gravite_majeurs(orientation) == 0
    assert orientation.conclusion.code == "FIN8"
  end

  test "Mauko Quiroga #1" do
    {:ok, orientation} =
      %Orientation{
        symptomes: %Symptomes{temperature: 36.6, fatigue: true},
        pronostiques: %Pronostiques{age: 50, cardiaque: false, taille: 1.2, poids: 40.0}
      }
      |> EvaluateOrientation.call()

    assert Test.facteurs_pronostique(orientation) == 0
    assert Test.facteurs_gravite_mineurs(orientation) == 1
    assert Test.facteurs_gravite_majeurs(orientation) == 0
    assert orientation.conclusion.code == "FIN9"
  end
end
