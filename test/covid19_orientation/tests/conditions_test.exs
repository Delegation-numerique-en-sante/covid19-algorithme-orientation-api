defmodule Covid19Orientation.Tests.ConditionsTest do
  use ExUnit.Case, async: true
  alias Covid19Orientation.Tests.Conditions
  alias Covid19OrientationWeb.Schemas.{Orientation, Pronostiques, Symptomes}

  setup do
    {:ok, orientation: %Orientation{symptomes: %Symptomes{}, pronostiques: %Pronostiques{}}}
  end

  describe "calcule si la personne a moins de 15 ans ou pas" do
    test "a moins de 15 ans", %{orientation: orientation} do
      orientation = %Orientation{
        orientation
        | pronostiques: %Pronostiques{orientation.pronostiques | age: 14}
      }

      assert Conditions.moins_de_15_ans(orientation)
    end

    test "a au moins 15 ans", %{orientation: orientation} do
      orientation = %Orientation{
        orientation
        | pronostiques: %Pronostiques{orientation.pronostiques | age: 15}
      }

      assert !Conditions.moins_de_15_ans(orientation)
    end
  end

  describe "calcule si la personne a moins de 50 ans ou pas" do
    test "a moins de 50 ans", %{orientation: orientation} do
      orientation = %Orientation{
        orientation
        | pronostiques: %Pronostiques{orientation.pronostiques | age: 49}
      }

      assert Conditions.moins_de_50_ans(orientation)
    end

    test "a au moins 50 ans", %{orientation: orientation} do
      orientation = %Orientation{
        orientation
        | pronostiques: %Pronostiques{orientation.pronostiques | age: 50}
      }

      assert !Conditions.moins_de_50_ans(orientation)
    end
  end

  describe "calcule si la personne a entre 50 et 69 ans" do
    test "a moins de 50 ans", %{orientation: orientation} do
      orientation = %Orientation{
        orientation
        | pronostiques: %Pronostiques{orientation.pronostiques | age: 49}
      }

      assert !Conditions.entre_50_et_69_ans(orientation)
    end

    test "a au moins 50 ans", %{orientation: orientation} do
      orientation = %Orientation{
        orientation
        | pronostiques: %Pronostiques{orientation.pronostiques | age: 50}
      }

      assert Conditions.entre_50_et_69_ans(orientation)
    end

    test "a au plus 69 ans", %{orientation: orientation} do
      orientation = %Orientation{
        orientation
        | pronostiques: %Pronostiques{orientation.pronostiques | age: 69}
      }

      assert Conditions.entre_50_et_69_ans(orientation)
    end

    test "a plus de 69 ans", %{orientation: orientation} do
      orientation = %Orientation{
        orientation
        | pronostiques: %Pronostiques{orientation.pronostiques | age: 70}
      }

      assert !Conditions.entre_50_et_69_ans(orientation)
    end
  end

  describe "calcule si la personne a moins de 70 ans ou pas" do
    test "a moins de 70 ans", %{orientation: orientation} do
      orientation = %Orientation{
        orientation
        | pronostiques: %Pronostiques{orientation.pronostiques | age: 69}
      }

      assert Conditions.moins_de_70_ans(orientation)
    end

    test "a au moins 70 ans", %{orientation: orientation} do
      orientation = %Orientation{
        orientation
        | pronostiques: %Pronostiques{orientation.pronostiques | age: 70}
      }

      assert !Conditions.moins_de_70_ans(orientation)
    end
  end

  describe "calcule si la personne a au moins 70 ans ou pas" do
    test "a au moins 70 ans", %{orientation: orientation} do
      orientation = %Orientation{
        orientation
        | pronostiques: %Pronostiques{orientation.pronostiques | age: 70}
      }

      assert Conditions.au_moins_70_ans(orientation)
    end

    test "a moins de 70 ans", %{orientation: orientation} do
      orientation = %Orientation{
        orientation
        | pronostiques: %Pronostiques{orientation.pronostiques | age: 69}
      }

      assert !Conditions.au_moins_70_ans(orientation)
    end
  end

  describe "calcule si la personne a une obésité modérée ou pas" do
    test "si IMC au moins 30 oui", %{orientation: orientation} do
      orientation = %Orientation{
        orientation
        | pronostiques: %Pronostiques{orientation.pronostiques | weight: 67.5, height: 1.5}
      }

      assert Conditions.au_moins_30_imc(orientation)
    end

    test "si IMC moins 30 non", %{orientation: orientation} do
      orientation = %Orientation{
        orientation
        | pronostiques: %Pronostiques{orientation.pronostiques | weight: 67.4, height: 1.5}
      }

      assert !Conditions.au_moins_30_imc(orientation)
    end
  end

  describe "calcule si la personne a fièvre ou pas" do
    test "si la température n'est pas renseignée, alors fièvre", %{orientation: orientation} do
      orientation = %Orientation{
        orientation
        | symptomes: %Symptomes{orientation.symptomes | temperature: nil}
      }

      assert Conditions.fievre(orientation)
    end

    test "si la température est >= 37,8 la personne a fièvre", %{orientation: orientation} do
      orientation = %Orientation{
        orientation
        | symptomes: %Symptomes{orientation.symptomes | temperature: 37.8}
      }

      assert Conditions.fievre(orientation)
    end

    test "si la température est < 37,8 la personne n'a pas fièvre", %{orientation: orientation} do
      orientation = %Orientation{
        orientation
        | symptomes: %Symptomes{orientation.symptomes | temperature: 37.7}
      }

      assert !Conditions.fievre(orientation)
    end
  end

  describe "calcule si la personne a au moins 39°C de température" do
    test "si la température n'est pas renseignée non", %{orientation: orientation} do
      orientation = %Orientation{
        orientation
        | symptomes: %Symptomes{orientation.symptomes | temperature: nil}
      }

      assert !Conditions.au_moins_39_de_temperature(orientation)
    end

    test "si la température est < 39,0°C non", %{orientation: orientation} do
      orientation = %Orientation{
        orientation
        | symptomes: %Symptomes{orientation.symptomes | temperature: 38.9}
      }

      assert !Conditions.au_moins_39_de_temperature(orientation)
    end

    test "si la température est >= 39,8°C oui", %{orientation: orientation} do
      orientation = %Orientation{
        orientation
        | symptomes: %Symptomes{orientation.symptomes | temperature: 39.0}
      }

      assert Conditions.au_moins_39_de_temperature(orientation)
    end
  end

  describe "détermine si la personne a des troubles d'hypertension / cardiaques ou pas" do
    test "si c'est renseignée, on prend cette information", %{orientation: orientation} do
      orientation = %Orientation{
        orientation
        | pronostiques: %Pronostiques{orientation.pronostiques | heart_disease: false}
      }

      assert !Conditions.heart_disease(orientation)
    end

    test "si ce n'est pas renseignée, on considère que oui", %{orientation: orientation} do
      orientation = %Orientation{
        orientation
        | pronostiques: %Pronostiques{orientation.pronostiques | heart_disease: nil}
      }

      assert Conditions.heart_disease(orientation)
    end
  end

  test "calcule le nombre de facteurs de gravité mineurs + majeurs", %{orientation: orientation} do
    orientation = %Orientation{
      orientation
      | symptomes: %Symptomes{
          orientation.symptomes
          | temperature: 39.0,
            feeding: true,
            breathlessness: true
        }
    }

    assert Conditions.facteurs_gravite(orientation) == 3
  end

  test "calcule le nombre de facteurs de gravité mineurs", %{orientation: orientation} do
    orientation = %Orientation{
      orientation
      | symptomes: %Symptomes{
          orientation.symptomes
          | temperature: 39.0,
            feeding: true,
            breathlessness: true
        }
    }

    assert Conditions.facteurs_gravite_mineurs(orientation) == 1
  end

  test "calcule le nombre de facteurs de gravité majeurs", %{orientation: orientation} do
    orientation = %Orientation{
      orientation
      | symptomes: %Symptomes{
          orientation.symptomes
          | temperature: 39.0,
            feeding: true,
            breathlessness: true
        }
    }

    assert Conditions.facteurs_gravite_majeurs(orientation) == 2
  end

  test "calcule le nombre de facteurs pronostique", %{orientation: orientation} do
    orientation = %Orientation{
      orientation
      | pronostiques: %Pronostiques{
          orientation.pronostiques
          | age: 70,
            weight: 67.5,
            height: 1.5,
            heart_disease: nil,
            cancer: nil,
            pregnant: false,
            immunodeprime: true
        }
    }

    assert Conditions.facteurs_pronostique(orientation) == 4
  end
end
