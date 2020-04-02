defmodule Covid19QuestionnaireWeb.Operations.SetVersion do
  @moduledoc """
  Set questionnaire version.
  """

  alias Covid19QuestionnaireWeb.ApiSpec
  alias Covid19QuestionnaireWeb.Schemas.{Metadata, Questionnaire}

  @type questionnaire :: Questionnaire.t()

  @spec call(questionnaire) :: questionnaire

  def call(questionnaire = %Questionnaire{metadata: metadata}) do
    %Questionnaire{
      questionnaire
      | metadata: %Metadata{metadata | form_version: version(), algo_version: version()}
    }
  end

  defp version do
    ApiSpec.spec().info.version
  end
end
