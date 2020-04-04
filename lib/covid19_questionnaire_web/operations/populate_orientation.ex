defmodule Covid19QuestionnaireWeb.Operations.PopulateOrientation do
  @moduledoc """
  Populate orientation.
  """

  alias Covid19QuestionnaireWeb.Schemas.{Orientation, Questionnaire}

  @type questionnaire :: Questionnaire.t()
  @type code :: String.t()

  @spec call(questionnaire, code) :: questionnaire

  def call(questionnaire = %Questionnaire{}, code) do
    %Questionnaire{
      questionnaire
      | orientation: %Orientation{code: code}
    }
  end
end
