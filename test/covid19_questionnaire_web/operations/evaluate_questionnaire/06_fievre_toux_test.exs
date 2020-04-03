defmodule Covid19QuestionnaireWeb.Operations.EvaluateQuestionnaire.FievreTouxTest do
  @moduledoc """
  Patient avec fièvre + toux.
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
         temperature_cat: "[37.8, 38.9]",
         cough: true
       },
       risk_factors: %RiskFactors{heart_disease: false}
     }}
  end

  describe "tout patient sans facteur pronostique" do
    test "sans facteur de gravité", %{questionnaire: questionnaire} do
      {:ok, questionnaire} =
        questionnaire
        |> EvaluateQuestionnaire.call()

      assert Conditions.symptoms2(questionnaire)
      assert Conditions.risk_factors(questionnaire) == 0
      assert Conditions.gravity_factors_minor(questionnaire) == 0
      assert Conditions.gravity_factors_major(questionnaire) == 0
      assert questionnaire.orientation.code == "orientation_consultation_surveillance_3"
    end

    test "avec au moins un facteur de gravité mineur sans facteur de gravité majeur", %{
      questionnaire: questionnaire
    } do
      {:ok, questionnaire} =
        %Questionnaire{
          questionnaire
          | symptoms: %Symptoms{questionnaire.symptoms | tiredness_details: true}
        }
        |> EvaluateQuestionnaire.call()

      assert Conditions.symptoms2(questionnaire)
      assert Conditions.risk_factors(questionnaire) == 0
      assert Conditions.gravity_factors_minor(questionnaire) >= 1
      assert Conditions.gravity_factors_major(questionnaire) == 0
      assert questionnaire.orientation.code == "orientation_consultation_surveillance_3"
    end
  end

  describe "tout patient avec un facteur pronostique ou plus" do
    test "aucun facteur de gravité", %{questionnaire: questionnaire} do
      {:ok, questionnaire} =
        %Questionnaire{
          questionnaire
          | risk_factors: %RiskFactors{questionnaire.risk_factors | heart_disease: true}
        }
        |> EvaluateQuestionnaire.call()

      assert Conditions.symptoms2(questionnaire)
      assert Conditions.risk_factors(questionnaire) >= 1
      assert Conditions.gravity_factors_minor(questionnaire) == 0
      assert Conditions.gravity_factors_major(questionnaire) == 0
      assert questionnaire.orientation.code == "orientation_consultation_surveillance_3"
    end

    test "un seul facteur de gravité mineur", %{questionnaire: questionnaire} do
      {:ok, questionnaire} =
        %Questionnaire{
          questionnaire
          | symptoms: %Symptoms{questionnaire.symptoms | tiredness_details: true},
            risk_factors: %RiskFactors{questionnaire.risk_factors | heart_disease: true}
        }
        |> EvaluateQuestionnaire.call()

      assert Conditions.symptoms2(questionnaire)
      assert Conditions.risk_factors(questionnaire) >= 1
      assert Conditions.gravity_factors_minor(questionnaire) == 1
      assert Conditions.gravity_factors_major(questionnaire) == 0
      assert questionnaire.orientation.code == "orientation_consultation_surveillance_3"
    end

    test "les deux facteurs de gravité mineurs", %{questionnaire: questionnaire} do
      {:ok, questionnaire} =
        %Questionnaire{
          questionnaire
          | symptoms: %Symptoms{
              questionnaire.symptoms
              | temperature_cat: "[39, +∞)",
                tiredness_details: true
            },
            risk_factors: %RiskFactors{questionnaire.risk_factors | heart_disease: true}
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
    assert Conditions.risk_factors(questionnaire) == 0
    assert Conditions.gravity_factors_minor(questionnaire) == 0
    assert Conditions.gravity_factors_major(questionnaire) >= 1
    assert questionnaire.orientation.code == "orientation_SAMU"
  end
end
