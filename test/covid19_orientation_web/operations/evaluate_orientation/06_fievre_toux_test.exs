defmodule Covid19OrientationWeb.Operations.EvaluateOrientation.FievreTouxTest do
  @moduledoc """
  Patient avec fièvre + toux.
  """

  use ExUnit.Case, async: true
  alias Covid19Orientation.Tests.Conditions
  alias Covid19OrientationWeb.Operations.EvaluateOrientation
  alias Covid19OrientationWeb.Schemas.{Orientation, Pronostiques, Symptomes}

  setup do
    {:ok,
     orientation: %Orientation{
       symptomes: %Symptomes{
         temperature: 37.8,
         toux: true
       },
       pronostiques: %Pronostiques{heart_disease: false}
     }}
  end

  describe "tout patient sans facteur pronostique" do
    test "sans facteur de gravité", %{orientation: orientation} do
      {:ok, orientation} =
        orientation
        |> EvaluateOrientation.call()

      assert Conditions.symptomes2(orientation)
      assert Conditions.facteurs_pronostique(orientation) == 0
      assert Conditions.facteurs_gravite_mineurs(orientation) == 0
      assert Conditions.facteurs_gravite_majeurs(orientation) == 0
      assert orientation.conclusion.code == "FIN6"
    end

    test "avec au moins un facteur de gravité mineur sans facteur de gravité majeur", %{
      orientation: orientation
    } do
      {:ok, orientation} =
        %Orientation{
          orientation
          | symptomes: %Symptomes{orientation.symptomes | fatigue: true}
        }
        |> EvaluateOrientation.call()

      assert Conditions.symptomes2(orientation)
      assert Conditions.facteurs_pronostique(orientation) == 0
      assert Conditions.facteurs_gravite_mineurs(orientation) >= 1
      assert Conditions.facteurs_gravite_majeurs(orientation) == 0
      assert orientation.conclusion.code == "FIN6"
    end
  end

  describe "tout patient avec un facteur pronostique ou plus" do
    test "aucun facteur de gravité", %{orientation: orientation} do
      {:ok, orientation} =
        %Orientation{
          orientation
          | pronostiques: %Pronostiques{orientation.pronostiques | heart_disease: true}
        }
        |> EvaluateOrientation.call()

      assert Conditions.symptomes2(orientation)
      assert Conditions.facteurs_pronostique(orientation) >= 1
      assert Conditions.facteurs_gravite_mineurs(orientation) == 0
      assert Conditions.facteurs_gravite_majeurs(orientation) == 0
      assert orientation.conclusion.code == "FIN6"
    end

    test "un seul facteur de gravité mineur", %{orientation: orientation} do
      {:ok, orientation} =
        %Orientation{
          orientation
          | symptomes: %Symptomes{orientation.symptomes | fatigue: true},
            pronostiques: %Pronostiques{orientation.pronostiques | heart_disease: true}
        }
        |> EvaluateOrientation.call()

      assert Conditions.symptomes2(orientation)
      assert Conditions.facteurs_pronostique(orientation) >= 1
      assert Conditions.facteurs_gravite_mineurs(orientation) == 1
      assert Conditions.facteurs_gravite_majeurs(orientation) == 0
      assert orientation.conclusion.code == "FIN6"
    end

    test "les deux facteurs de gravité mineurs", %{orientation: orientation} do
      {:ok, orientation} =
        %Orientation{
          orientation
          | symptomes: %Symptomes{orientation.symptomes | temperature: 39.0, fatigue: true},
            pronostiques: %Pronostiques{orientation.pronostiques | heart_disease: true}
        }
        |> EvaluateOrientation.call()

      assert Conditions.symptomes2(orientation)
      assert Conditions.facteurs_pronostique(orientation) >= 1
      assert Conditions.facteurs_gravite_mineurs(orientation) == 2
      assert Conditions.facteurs_gravite_majeurs(orientation) == 0
      assert orientation.conclusion.code == "FIN4"
    end
  end

  test "tout patient avec ou sans facteur pronostique avec au moins un facteur de gravité majeur",
       %{orientation: orientation} do
    {:ok, orientation} =
      %Orientation{
        orientation
        | symptomes: %Symptomes{orientation.symptomes | essoufle: true}
      }
      |> EvaluateOrientation.call()

    assert Conditions.symptomes2(orientation)
    assert Conditions.facteurs_pronostique(orientation) == 0
    assert Conditions.facteurs_gravite_mineurs(orientation) == 0
    assert Conditions.facteurs_gravite_majeurs(orientation) >= 1
    assert orientation.conclusion.code == "FIN5"
  end
end
