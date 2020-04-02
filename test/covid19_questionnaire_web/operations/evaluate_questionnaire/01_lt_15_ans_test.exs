defmodule Covid19QuestionnaireWeb.Operations.EvaluateQuestionnaire.L15AnsTest do
  @moduledoc """
  STOP si < 15 ans
  """

  use ExUnit.Case, async: true
  alias Covid19QuestionnaireWeb.Operations.EvaluateQuestionnaire
  alias Covid19QuestionnaireWeb.Schemas.{Patient, Pronostiques, Questionnaire, Symptoms}

  test "STOP si < 15 ans" do
    {:ok, questionnaire} =
      %Questionnaire{
        patient: %Patient{age_less_15: true},
        symptomes: %Symptoms{},
        pronostiques: %Pronostiques{}
      }
      |> EvaluateQuestionnaire.call()

    assert questionnaire.conclusion.code == "FIN1"
  end
end
