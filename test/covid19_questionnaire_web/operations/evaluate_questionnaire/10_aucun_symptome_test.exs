defmodule Covid19QuestionnaireWeb.Operations.EvaluateQuestionnaire.AucunSymptomeTest do
  @moduledoc """
  Patient avec aucun symtôme.
  """

  use ExUnit.Case, async: true
  alias Covid19Questionnaire.Tests.Conditions
  alias Covid19QuestionnaireWeb.Operations.EvaluateQuestionnaire
  alias Covid19QuestionnaireWeb.Schemas.{Patient, Questionnaire, RiskFactors, Symptoms}

  test "patient avec aucun symtôme" do
    {:ok, questionnaire} =
      %Questionnaire{
        patient: %Patient{},
        symptoms: %Symptoms{temperature_cat: "35.5-37.7"},
        risk_factors: %RiskFactors{heart_disease: false}
      }
      |> EvaluateQuestionnaire.call()

    assert Conditions.symptoms4(questionnaire)
    assert Conditions.risk_factors(questionnaire) == 0
    assert Conditions.gravity_factors_minor(questionnaire) == 0
    assert Conditions.gravity_factors_major(questionnaire) == 0
    # FIXME
    assert questionnaire.orientation.code == "orientation_surveillance"
  end
end
