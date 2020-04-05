defmodule Covid19Questionnaire.Tests.ConditionsTest do
  use ExUnit.Case, async: true
  alias Covid19Questionnaire.Tests.Conditions
  alias Covid19QuestionnaireWeb.Schemas.{Questionnaire, Respondent, RiskFactors, Symptoms}

  setup do
    {:ok,
     questionnaire: %Questionnaire{
       respondent: %Respondent{},
       symptoms: %Symptoms{},
       risk_factors: %RiskFactors{}
     }}
  end

  describe "calcule si la personne a moins de 15 ans ou pas" do
    test "a moins de 15 ans", %{questionnaire: questionnaire} do
      questionnaire = %Questionnaire{
        questionnaire
        | respondent: %Respondent{questionnaire.respondent | age_range: "inf_15"}
      }

      assert Conditions.age_less_15(questionnaire)
    end

    test "a au moins 15 ans", %{questionnaire: questionnaire} do
      questionnaire = %Questionnaire{
        questionnaire
        | respondent: %Respondent{questionnaire.respondent | age_range: "from_15_to_49"}
      }

      assert !Conditions.age_less_15(questionnaire)
    end
  end

  describe "calcule si la personne a moins de 50 ans ou pas" do
    test "a moins de 50 ans", %{questionnaire: questionnaire} do
      questionnaire = %Questionnaire{
        questionnaire
        | respondent: %Respondent{questionnaire.respondent | age_range: "from_15_to_49"}
      }

      assert Conditions.age_less_50(questionnaire)
    end

    test "a au moins 50 ans", %{questionnaire: questionnaire} do
      questionnaire = %Questionnaire{
        questionnaire
        | respondent: %Respondent{questionnaire.respondent | age_range: "from_50_to_69"}
      }

      assert !Conditions.age_less_50(questionnaire)
    end
  end

  describe "calcule si la personne a au moins 50" do
    test "a moins de 50 ans", %{questionnaire: questionnaire} do
      questionnaire = %Questionnaire{
        questionnaire
        | respondent: %Respondent{questionnaire.respondent | age_range: "from_15_to_49"}
      }

      assert !Conditions.age_more_50(questionnaire)
    end

    test "a au moins 50 ans", %{questionnaire: questionnaire} do
      questionnaire = %Questionnaire{
        questionnaire
        | respondent: %Respondent{questionnaire.respondent | age_range: "from_50_to_69"}
      }

      assert Conditions.age_more_50(questionnaire)
    end
  end

  describe "calcule si la personne a une obésité modérée ou pas" do
    test "si IMC au moins 30 oui", %{questionnaire: questionnaire} do
      questionnaire = %Questionnaire{
        questionnaire
        | respondent: %Respondent{questionnaire.respondent | weight: 67.5, height: 150}
      }

      assert Conditions.bmi_more_30(questionnaire)
    end

    test "si IMC moins 30 non", %{questionnaire: questionnaire} do
      questionnaire = %Questionnaire{
        questionnaire
        | respondent: %Respondent{questionnaire.respondent | weight: 67.0, height: 150}
      }

      assert !Conditions.bmi_more_30(questionnaire)
    end
  end

  describe "calcule si la personne a fièvre ou pas" do
    test "si la température n'est pas renseignée, alors fièvre", %{questionnaire: questionnaire} do
      questionnaire = %Questionnaire{
        questionnaire
        | symptoms: %Symptoms{questionnaire.symptoms | fever: 1, temperature_cat: "NSP"}
      }

      assert Conditions.fever_algo(questionnaire)
    end

    test "si la température est >= 37,8 la personne n'a pas fièvre", %{
      questionnaire: questionnaire
    } do
      questionnaire = %Questionnaire{
        questionnaire
        | symptoms: %Symptoms{questionnaire.symptoms | fever: 1, temperature_cat: "37.7-38.9"}
      }

      assert !Conditions.fever_algo(questionnaire)
    end

    test "si la température est < 37,8 la personne n'a pas fièvre", %{
      questionnaire: questionnaire
    } do
      questionnaire = %Questionnaire{
        questionnaire
        | symptoms: %Symptoms{questionnaire.symptoms | fever: 1, temperature_cat: "35.5-37.7"}
      }

      assert !Conditions.fever_algo(questionnaire)
    end
  end

  test "calcule le nombre de facteurs de gravité mineurs + majeurs", %{
    questionnaire: questionnaire
  } do
    questionnaire = %Questionnaire{
      questionnaire
      | symptoms: %Symptoms{
          questionnaire.symptoms
          | fever: 1,
            temperature_cat: "sup_39",
            feeding_day: true,
            breathlessness: true
        }
    }

    assert Conditions.gravity_factors(questionnaire) == 3
  end

  test "calcule le nombre de facteurs de gravité mineurs", %{questionnaire: questionnaire} do
    questionnaire = %Questionnaire{
      questionnaire
      | symptoms: %Symptoms{
          questionnaire.symptoms
          | fever: 1,
            temperature_cat: "sup_39",
            feeding_day: true,
            breathlessness: true
        }
    }

    assert Conditions.gravity_factors_minor(questionnaire) == 1
  end

  test "calcule le nombre de facteurs de gravité majeurs", %{questionnaire: questionnaire} do
    questionnaire = %Questionnaire{
      questionnaire
      | symptoms: %Symptoms{
          questionnaire.symptoms
          | temperature_cat: "sup_39",
            feeding_day: true,
            breathlessness: true
        }
    }

    assert Conditions.gravity_factors_major(questionnaire) == 2
  end

  test "calcule le nombre de facteurs pronostique", %{questionnaire: questionnaire} do
    questionnaire = %Questionnaire{
      questionnaire
      | respondent: %Respondent{
          questionnaire.respondent
          | age_range: "sup_70",
            weight: 67.5,
            height: 150
        },
        risk_factors: %RiskFactors{
          questionnaire.risk_factors
          | heart_disease: 1,
            cancer: nil,
            pregnant: 0,
            immunosuppressant_disease: 1
        }
    }

    assert Conditions.risk_factors(questionnaire) == 4
  end
end
