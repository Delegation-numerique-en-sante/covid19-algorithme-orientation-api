defmodule Covid19QuestionnaireWeb.Operations.EvaluateQuestionnaire.L15AnsTest do
  @moduledoc """
  STOP si < 15 ans
  """

  use ExUnit.Case, async: true
  alias Covid19QuestionnaireWeb.Operations.EvaluateQuestionnaire
  alias Covid19QuestionnaireWeb.Schemas.{Pronostiques, Questionnaire, Symptomes}

  test "STOP si < 15 ans" do
    {:ok, questionnaire} =
      %Questionnaire{
        symptomes: %Symptomes{},
        pronostiques: %Pronostiques{
          age: 14
        }
      }
      |> EvaluateQuestionnaire.call()

    assert questionnaire.conclusion.code == "FIN1"
  end
end
