defmodule Covid19QuestionnaireWeb.Operations.PopulateStatistics do
  @moduledoc """
  Populate statistics.
  """

  alias Covid19Questionnaire.Tests.Conditions
  alias Covid19QuestionnaireWeb.Schemas.{Questionnaire, Statistiques}

  @type questionnaire :: Questionnaire.t()

  @spec call(questionnaire) :: questionnaire

  def call(questionnaire = %Questionnaire{}) do
    Map.put(
      questionnaire,
      :statistiques,
      %Statistiques{}
      |> Map.from_struct()
      |> Map.keys()
      |> Enum.reduce(%Statistiques{}, fn key, statistiques ->
        statistiques
        |> Map.put(key, apply(Conditions, key, [questionnaire]))
      end)
    )
  end
end
