defmodule Covid19QuestionnaireWeb.Operations.EvaluateQuestionnaire.FievrePasTouxTest do
  @moduledoc """
  Patient avec fièvre et pas toux.
  """

  use ExUnit.Case
  alias Covid19Questionnaire.Tests.Conditions
  alias Covid19QuestionnaireWeb.Operations.EvaluateQuestionnaire
  alias Covid19QuestionnaireWeb.Schemas.{Patient, Questionnaire, RiskFactors, Symptoms}

  setup do
    {:ok,
     questionnaire: %Questionnaire{
       patient: %Patient{},
       symptoms: %Symptoms{
         temperature_cat: "NSP",
         fever: 999
       },
       risk_factors: %RiskFactors{heart_disease: 0}
     }}
  end

  describe "tout patient sans facteur pronostique" do
    test "avec au moins un facteur de gravité mineur", %{questionnaire: questionnaire} do
      {:ok, questionnaire} =
        %Questionnaire{
          questionnaire
          | symptoms: %Symptoms{questionnaire.symptoms | tiredness_details: true}
        }
        |> EvaluateQuestionnaire.call()

      assert Conditions.symptoms2(questionnaire)
      assert Conditions.risk_factors(questionnaire) == 0
      assert Conditions.gravity_factors_minor(questionnaire) == 2
      assert Conditions.gravity_factors_major(questionnaire) == 0
      assert questionnaire.orientation.code == "orientation_consultation_surveillance_1"
    end
  end

  describe "tout patient avec un facteur pronostique ou plus" do
    test "un seul facteur de gravité mineur", %{questionnaire: questionnaire} do
      {:ok, questionnaire} =
        %Questionnaire{
          questionnaire
          | risk_factors: %RiskFactors{questionnaire.risk_factors | heart_disease: 1}
        }
        |> EvaluateQuestionnaire.call()

      assert Conditions.symptoms2(questionnaire)
      assert Conditions.risk_factors(questionnaire) >= 1
      assert Conditions.gravity_factors_minor(questionnaire) == 1
      assert Conditions.gravity_factors_major(questionnaire) == 0
      assert questionnaire.orientation.code == "orientation_consultation_surveillance_1"
    end

    test "les deux facteurs de gravité mineurs", %{questionnaire: questionnaire} do
      {:ok, questionnaire} =
        %Questionnaire{
          questionnaire
          | symptoms: %Symptoms{
              questionnaire.symptoms
              | temperature_cat: "sup_39",
                tiredness_details: true
            },
            risk_factors: %RiskFactors{questionnaire.risk_factors | heart_disease: 1}
        }
        |> EvaluateQuestionnaire.call()

      assert Conditions.symptoms2(questionnaire)
      assert Conditions.risk_factors(questionnaire) >= 1
      assert Conditions.gravity_factors_minor(questionnaire) == 2
      assert Conditions.gravity_factors_major(questionnaire) == 0
      assert questionnaire.orientation.code == "orientation_consultation_surveillance_2"
    end
  end

  test "tout patient avec ou sans facteur pronostique avec au moins un facteur de gravité majeur",
       %{questionnaire: questionnaire} do
    {:ok, questionnaire} =
      %Questionnaire{
        questionnaire
        | symptoms: %Symptoms{questionnaire.symptoms | breathlessness: true}
      }
      |> EvaluateQuestionnaire.call()

    assert Conditions.symptoms2(questionnaire)
    assert Conditions.gravity_factors_minor(questionnaire) == 1
    assert Conditions.gravity_factors_major(questionnaire) >= 1
    assert questionnaire.orientation.code == "orientation_SAMU"
  end
end
