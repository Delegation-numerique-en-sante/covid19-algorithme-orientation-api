defmodule Covid19QuestionnaireWeb.Operations.SetDate do
  @moduledoc """
  Set questionnaire timestamp.
  """

  alias Covid19QuestionnaireWeb.Schemas.{Metadata, Questionnaire}

  @type questionnaire :: Questionnaire.t()

  @spec call(questionnaire) :: questionnaire

  def call(questionnaire = %Questionnaire{metadata: metadata}) do
    %Questionnaire{questionnaire | metadata: %Metadata{metadata | date: date()}}
  end

  defp date do
    DateTime.utc_now()
  end
end
