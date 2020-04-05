defmodule Covid19QuestionnaireWeb.Operations.EvaluateQuestionnaire.AutresTest do
  @moduledoc """
  Autres.
  """

  use ExUnit.Case, async: true
  alias Covid19Questionnaire.Tests.Conditions
  alias Covid19QuestionnaireWeb.Operations.EvaluateQuestionnaire
  alias Covid19QuestionnaireWeb.Schemas.{Patient, Questionnaire, RiskFactors, Symptoms}

  test "Bastien Guerry #1" do
    {:ok, questionnaire} =
      %Questionnaire{
        patient: %Patient{
          age_range: "from_50_to_69",
          height: 120,
          weight: 40.0
        },
        symptoms: %Symptoms{
          temperature_cat: "35.5-37.7",
          agueusia_anosmia: true,
          tiredness_details: true
        },
        risk_factors: %RiskFactors{heart_disease: 0}
      }
      |> EvaluateQuestionnaire.call()

    assert Conditions.symptoms3(questionnaire)
    assert Conditions.risk_factors(questionnaire) == 0
    assert Conditions.gravity_factors_minor(questionnaire) == 1
    assert Conditions.gravity_factors_major(questionnaire) == 0
    assert questionnaire.orientation.code == "orientation_domicile_surveillance_1"
  end

  test "Bastien Guerry #2" do
    {:ok, questionnaire} =
      %Questionnaire{
        patient: %Patient{
          age_range: "from_50_to_69",
          height: 120,
          weight: 40.0
        },
        symptoms: %Symptoms{temperature_cat: "35.5-37.7", cough: true, tiredness_details: true},
        risk_factors: %RiskFactors{heart_disease: 1}
      }
      |> EvaluateQuestionnaire.call()

    assert Conditions.symptoms3(questionnaire)
    assert Conditions.risk_factors(questionnaire) == 1
    assert Conditions.gravity_factors_minor(questionnaire) == 1
    assert Conditions.gravity_factors_major(questionnaire) == 0
    assert questionnaire.orientation.code == "orientation_consultation_surveillance_4"
  end

  test "Mauko Quiroga #1" do
    {:ok, questionnaire} =
      %Questionnaire{
        patient: %Patient{
          age_range: "from_50_to_69",
          height: 120,
          weight: 40.0
        },
        symptoms: %Symptoms{temperature_cat: "35.5-37.7", tiredness_details: true},
        risk_factors: %RiskFactors{heart_disease: 0}
      }
      |> EvaluateQuestionnaire.call()

    assert Conditions.symptoms4(questionnaire)
    assert Conditions.risk_factors(questionnaire) == 0
    assert Conditions.gravity_factors_minor(questionnaire) == 1
    assert Conditions.gravity_factors_major(questionnaire) == 0
    # FIXME
    assert questionnaire.orientation.code == "orientation_surveillance"
  end
end
