defmodule Covid19Questionnaire.Tests.ConditionsTest do
  use ExUnit.Case, async: true
  alias Covid19Questionnaire.Tests.Conditions
  alias Covid19QuestionnaireWeb.Schemas.{Pronostiques, Questionnaire, Symptomes}

  setup do
    {:ok, questionnaire: %Questionnaire{symptomes: %Symptomes{}, pronostiques: %Pronostiques{}}}
  end

  describe "calcule si la personne a moins de 15 ans ou pas" do
    test "a moins de 15 ans", %{questionnaire: questionnaire} do
      questionnaire = %Questionnaire{
        questionnaire
        | pronostiques: %Pronostiques{questionnaire.pronostiques | age: 14}
      }

      assert Conditions.moins_de_15_ans(questionnaire)
    end

    test "a au moins 15 ans", %{questionnaire: questionnaire} do
      questionnaire = %Questionnaire{
        questionnaire
        | pronostiques: %Pronostiques{questionnaire.pronostiques | age: 15}
      }

      assert !Conditions.moins_de_15_ans(questionnaire)
    end
  end

  describe "calcule si la personne a moins de 50 ans ou pas" do
    test "a moins de 50 ans", %{questionnaire: questionnaire} do
      questionnaire = %Questionnaire{
        questionnaire
        | pronostiques: %Pronostiques{questionnaire.pronostiques | age: 49}
      }

      assert Conditions.moins_de_50_ans(questionnaire)
    end

    test "a au moins 50 ans", %{questionnaire: questionnaire} do
      questionnaire = %Questionnaire{
        questionnaire
        | pronostiques: %Pronostiques{questionnaire.pronostiques | age: 50}
      }

      assert !Conditions.moins_de_50_ans(questionnaire)
    end
  end

  describe "calcule si la personne a entre 50 et 69 ans" do
    test "a moins de 50 ans", %{questionnaire: questionnaire} do
      questionnaire = %Questionnaire{
        questionnaire
        | pronostiques: %Pronostiques{questionnaire.pronostiques | age: 49}
      }

      assert !Conditions.entre_50_et_69_ans(questionnaire)
    end

    test "a au moins 50 ans", %{questionnaire: questionnaire} do
      questionnaire = %Questionnaire{
        questionnaire
        | pronostiques: %Pronostiques{questionnaire.pronostiques | age: 50}
      }

      assert Conditions.entre_50_et_69_ans(questionnaire)
    end

    test "a au plus 69 ans", %{questionnaire: questionnaire} do
      questionnaire = %Questionnaire{
        questionnaire
        | pronostiques: %Pronostiques{questionnaire.pronostiques | age: 69}
      }

      assert Conditions.entre_50_et_69_ans(questionnaire)
    end

    test "a plus de 69 ans", %{questionnaire: questionnaire} do
      questionnaire = %Questionnaire{
        questionnaire
        | pronostiques: %Pronostiques{questionnaire.pronostiques | age: 70}
      }

      assert !Conditions.entre_50_et_69_ans(questionnaire)
    end
  end

  describe "calcule si la personne a moins de 70 ans ou pas" do
    test "a moins de 70 ans", %{questionnaire: questionnaire} do
      questionnaire = %Questionnaire{
        questionnaire
        | pronostiques: %Pronostiques{questionnaire.pronostiques | age: 69}
      }

      assert Conditions.moins_de_70_ans(questionnaire)
    end

    test "a au moins 70 ans", %{questionnaire: questionnaire} do
      questionnaire = %Questionnaire{
        questionnaire
        | pronostiques: %Pronostiques{questionnaire.pronostiques | age: 70}
      }

      assert !Conditions.moins_de_70_ans(questionnaire)
    end
  end

  describe "calcule si la personne a au moins 70 ans ou pas" do
    test "a au moins 70 ans", %{questionnaire: questionnaire} do
      questionnaire = %Questionnaire{
        questionnaire
        | pronostiques: %Pronostiques{questionnaire.pronostiques | age: 70}
      }

      assert Conditions.au_moins_70_ans(questionnaire)
    end

    test "a moins de 70 ans", %{questionnaire: questionnaire} do
      questionnaire = %Questionnaire{
        questionnaire
        | pronostiques: %Pronostiques{questionnaire.pronostiques | age: 69}
      }

      assert !Conditions.au_moins_70_ans(questionnaire)
    end
  end

  describe "calcule si la personne a une obésité modérée ou pas" do
    test "si IMC au moins 30 oui", %{questionnaire: questionnaire} do
      questionnaire = %Questionnaire{
        questionnaire
        | pronostiques: %Pronostiques{questionnaire.pronostiques | weight: 67.5, height: 1.5}
      }

      assert Conditions.au_moins_30_imc(questionnaire)
    end

    test "si IMC moins 30 non", %{questionnaire: questionnaire} do
      questionnaire = %Questionnaire{
        questionnaire
        | pronostiques: %Pronostiques{questionnaire.pronostiques | weight: 67.4, height: 1.5}
      }

      assert !Conditions.au_moins_30_imc(questionnaire)
    end
  end

  describe "calcule si la personne a fièvre ou pas" do
    test "si la température n'est pas renseignée, alors fièvre", %{questionnaire: questionnaire} do
      questionnaire = %Questionnaire{
        questionnaire
        | symptomes: %Symptomes{questionnaire.symptomes | temperature: nil}
      }

      assert Conditions.fever(questionnaire)
    end

    test "si la température est >= 37,8 la personne a fièvre", %{questionnaire: questionnaire} do
      questionnaire = %Questionnaire{
        questionnaire
        | symptomes: %Symptomes{questionnaire.symptomes | temperature: 37.8}
      }

      assert Conditions.fever(questionnaire)
    end

    test "si la température est < 37,8 la personne n'a pas fièvre", %{
      questionnaire: questionnaire
    } do
      questionnaire = %Questionnaire{
        questionnaire
        | symptomes: %Symptomes{questionnaire.symptomes | temperature: 37.7}
      }

      assert !Conditions.fever(questionnaire)
    end
  end

  describe "calcule si la personne a au moins 39°C de température" do
    test "si la température n'est pas renseignée non", %{questionnaire: questionnaire} do
      questionnaire = %Questionnaire{
        questionnaire
        | symptomes: %Symptomes{questionnaire.symptomes | temperature: nil}
      }

      assert !Conditions.au_moins_39_de_temperature(questionnaire)
    end

    test "si la température est < 39,0°C non", %{questionnaire: questionnaire} do
      questionnaire = %Questionnaire{
        questionnaire
        | symptomes: %Symptomes{questionnaire.symptomes | temperature: 38.9}
      }

      assert !Conditions.au_moins_39_de_temperature(questionnaire)
    end

    test "si la température est >= 39,8°C oui", %{questionnaire: questionnaire} do
      questionnaire = %Questionnaire{
        questionnaire
        | symptomes: %Symptomes{questionnaire.symptomes | temperature: 39.0}
      }

      assert Conditions.au_moins_39_de_temperature(questionnaire)
    end
  end

  describe "détermine si la personne a des troubles d'hypertension / cardiaques ou pas" do
    test "si c'est renseignée, on prend cette information", %{questionnaire: questionnaire} do
      questionnaire = %Questionnaire{
        questionnaire
        | pronostiques: %Pronostiques{questionnaire.pronostiques | heart_disease: false}
      }

      assert !Conditions.heart_disease(questionnaire)
    end

    test "si ce n'est pas renseignée, on considère que oui", %{questionnaire: questionnaire} do
      questionnaire = %Questionnaire{
        questionnaire
        | pronostiques: %Pronostiques{questionnaire.pronostiques | heart_disease: nil}
      }

      assert Conditions.heart_disease(questionnaire)
    end
  end

  test "calcule le nombre de facteurs de gravité mineurs + majeurs", %{
    questionnaire: questionnaire
  } do
    questionnaire = %Questionnaire{
      questionnaire
      | symptomes: %Symptomes{
          questionnaire.symptomes
          | temperature: 39.0,
            feeding: true,
            breathlessness: true
        }
    }

    assert Conditions.facteurs_gravite(questionnaire) == 3
  end

  test "calcule le nombre de facteurs de gravité mineurs", %{questionnaire: questionnaire} do
    questionnaire = %Questionnaire{
      questionnaire
      | symptomes: %Symptomes{
          questionnaire.symptomes
          | temperature: 39.0,
            feeding: true,
            breathlessness: true
        }
    }

    assert Conditions.facteurs_gravite_mineurs(questionnaire) == 1
  end

  test "calcule le nombre de facteurs de gravité majeurs", %{questionnaire: questionnaire} do
    questionnaire = %Questionnaire{
      questionnaire
      | symptomes: %Symptomes{
          questionnaire.symptomes
          | temperature: 39.0,
            feeding: true,
            breathlessness: true
        }
    }

    assert Conditions.facteurs_gravite_majeurs(questionnaire) == 2
  end

  test "calcule le nombre de facteurs pronostique", %{questionnaire: questionnaire} do
    questionnaire = %Questionnaire{
      questionnaire
      | pronostiques: %Pronostiques{
          questionnaire.pronostiques
          | age: 70,
            weight: 67.5,
            height: 1.5,
            heart_disease: nil,
            cancer: nil,
            pregnant: false,
            immunodeprime: true
        }
    }

    assert Conditions.facteurs_pronostique(questionnaire) == 4
  end
end
