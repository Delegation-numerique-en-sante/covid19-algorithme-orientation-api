defmodule Covid19QuestionnaireWeb.Operations.EvaluateQuestionnaire.TouxTest do
  @moduledoc """
  Patient avec seulement toux.
  """

  use ExUnit.Case, async: true
  alias Covid19Questionnaire.Tests.Conditions
  alias Covid19QuestionnaireWeb.Operations.EvaluateQuestionnaire
  alias Covid19QuestionnaireWeb.Schemas.{Patient, Questionnaire, RiskFactors, Symptoms}

  setup do
    {:ok,
     questionnaire: %Questionnaire{
       patient: %Patient{},
       symptoms: %Symptoms{
         temperature_cat: "35.5-37.7",
         cough: true
       },
       risk_factors: %RiskFactors{heart_disease: 0}
     }}
  end

  test "sans facteur de gravité", %{questionnaire: questionnaire} do
    {:ok, questionnaire} =
      questionnaire
      |> EvaluateQuestionnaire.call()

    assert Conditions.symptoms3(questionnaire)
    assert Conditions.risk_factors(questionnaire) == 0
    assert Conditions.gravity_factors_minor(questionnaire) == 0
    assert Conditions.gravity_factors_major(questionnaire) == 0
    assert questionnaire.orientation.code == "orientation_domicile_surveillance_1"
  end

  test "avec au moins un facteur de gravité", %{questionnaire: questionnaire} do
    {:ok, questionnaire} =
      %Questionnaire{
        questionnaire
        | symptoms: %Symptoms{questionnaire.symptoms | tiredness_details: true}
      }
      |> EvaluateQuestionnaire.call()

    assert Conditions.symptoms3(questionnaire)
    assert Conditions.risk_factors(questionnaire) == 0
    assert Conditions.gravity_factors_minor(questionnaire) >= 1
    assert Conditions.gravity_factors_major(questionnaire) == 0
    assert questionnaire.orientation.code == "orientation_domicile_surveillance_1"
  end

  test "avec au moins un facteur pronostique", %{questionnaire: questionnaire} do
    {:ok, questionnaire} =
      %Questionnaire{
        questionnaire
        | risk_factors: %RiskFactors{questionnaire.risk_factors | heart_disease: 1}
      }
      |> EvaluateQuestionnaire.call()

    assert Conditions.symptoms3(questionnaire)
    assert Conditions.risk_factors(questionnaire) >= 1
    assert Conditions.gravity_factors_minor(questionnaire) == 0
    assert Conditions.gravity_factors_major(questionnaire) == 0
    assert questionnaire.orientation.code == "orientation_consultation_surveillance_4"
  end
end
