defmodule Covid19QuestionnaireWeb.Operations.SetUUID do
  @moduledoc """
  Set questionnaire ID.
  """

  alias Covid19QuestionnaireWeb.Schemas.Questionnaire

  @type questionnaire :: Questionnaire.t()

  @spec call(questionnaire) :: questionnaire

  def call(questionnaire = %Questionnaire{}) do
    %Questionnaire{questionnaire | uuid: uuid()}
  end

  defp uuid do
    UUID.uuid1()
  end
end
