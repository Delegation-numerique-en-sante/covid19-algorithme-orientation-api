defmodule Covid19QuestionnaireWeb.Operations.PopulateConclusion do
  @moduledoc """
  Populate conclusion.
  """

  alias Covid19QuestionnaireWeb.Schemas.{Conclusion, Questionnaire}

  @type questionnaire :: Questionnaire.t()
  @type code :: String.t()

  @spec call(questionnaire, code) :: questionnaire

  def call(questionnaire = %Questionnaire{}, code) do
    %Questionnaire{
      questionnaire
      | conclusion: %Conclusion{code: code}
    }
  end
end
