defmodule Covid19Orientation.Tests.Test.FievreDiarrheeTest do
  @moduledoc """
  Patient avec fièvre + diarrhée.
  """

  use ExUnit.Case, async: true
  alias Covid19Orientation.Tests.Test
  alias Covid19OrientationWeb.Schemas.{Orientation, Pronostiques, Symptomes}

  setup do
    {:ok,
     orientation: %Orientation{
       symptomes: %Symptomes{
         temperature: 37.8,
         diarrhee: true
       },
       pronostiques: %Pronostiques{cardiaque: false}
     }}
  end

  describe "tout patient sans facteur pronostique" do
    test "sans facteur de gravité & < 50 ans", %{orientation: orientation} do
      {:ok, orientation} =
        %Orientation{
          orientation
          | pronostiques: %Pronostiques{orientation.pronostiques | age: 49}
        }
        |> Test.evaluate()

      assert Test.symptomes1(orientation)
      assert Test.facteurs_pronostique(orientation) == 0
      assert Test.facteurs_gravite(orientation) == 0
      assert orientation.conclusion.code == "FIN2"
    end

    test "sans facteur de gravité & 50-69 ans", %{orientation: orientation} do
      {:ok, orientation} =
        %Orientation{
          orientation
          | pronostiques: %Pronostiques{orientation.pronostiques | age: 50}
        }
        |> Test.evaluate()

      assert Test.symptomes1(orientation)
      assert Test.facteurs_pronostique(orientation) == 0
      assert Test.facteurs_gravite(orientation) == 0
      assert orientation.conclusion.code == "FIN3"
    end

    test "avec au moins un facteur de gravité mineur", %{orientation: orientation} do
      {:ok, orientation} =
        %Orientation{
          orientation
          | symptomes: %Symptomes{orientation.symptomes | fatigue: true}
        }
        |> Test.evaluate()

      assert Test.symptomes1(orientation)
      assert Test.facteurs_pronostique(orientation) == 0
      assert Test.facteurs_gravite_mineurs(orientation) == 1
      assert orientation.conclusion.code == "FIN3"
    end
  end

  describe "tout patient avec un facteur pronostique ou plus" do
    test "aucun facteur de gravité ", %{orientation: orientation} do
      {:ok, orientation} =
        %Orientation{
          orientation
          | pronostiques: %Pronostiques{orientation.pronostiques | cardiaque: true}
        }
        |> Test.evaluate()

      assert Test.symptomes1(orientation)
      assert Test.facteurs_pronostique(orientation) >= 1
      assert Test.facteurs_gravite(orientation) == 0
      assert orientation.conclusion.code == "FIN3"
    end

    test "un seul facteur de gravité mineur", %{orientation: orientation} do
      {:ok, orientation} =
        %Orientation{
          orientation
          | symptomes: %Symptomes{orientation.symptomes | fatigue: true},
            pronostiques: %Pronostiques{orientation.pronostiques | cardiaque: true}
        }
        |> Test.evaluate()

      assert Test.symptomes1(orientation)
      assert Test.facteurs_pronostique(orientation) >= 1
      assert Test.facteurs_gravite_mineurs(orientation) == 1
      assert orientation.conclusion.code == "FIN3"
    end

    test "les deux facteurs de gravité mineurs", %{orientation: orientation} do
      {:ok, orientation} =
        %Orientation{
          orientation
          | symptomes: %Symptomes{orientation.symptomes | temperature: 39.0, fatigue: true},
            pronostiques: %Pronostiques{orientation.pronostiques | cardiaque: true}
        }
        |> Test.evaluate()

      assert Test.symptomes1(orientation)
      assert Test.facteurs_pronostique(orientation) >= 1
      assert Test.facteurs_gravite_mineurs(orientation) == 2
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
      |> Test.evaluate()

    assert Test.symptomes1(orientation)
    assert Test.facteurs_gravite_majeurs(orientation) >= 1
    assert orientation.conclusion.code == "FIN5"
  end
end
