defmodule Covid19QuestionnaireWeb.Operations.ValidateQuestionnaire do
  @moduledoc """
  Whether to store the questionnaire or not.
  """

  alias Covid19Questionnaire.Tests.Codes
  alias Covid19QuestionnaireWeb.Schemas.Questionnaire

  @type questionnaire :: Questionnaire.t()

  @spec call(questionnaire) :: boolean

  def call(questionnaire = %Questionnaire{metadata: %{orientation: orientation}}) do
    case Codes.orientation_moins_de_15_ans() do
      ^orientation -> {:error, :age_less_15}
      _ -> {:ok, questionnaire}
    end
  end
end
