defmodule Covid19QuestionnaireWeb.Operations.EvaluateQuestionnaire do
  @moduledoc """
  Evaluate questionnaire test.
  """

  alias Covid19Questionnaire.Tests.{Algorithm, Codes}
  alias Covid19Questionnaire.Trees.{FlattenTree, TraverseTree, Tree}

  alias Covid19QuestionnaireWeb.Operations.{
    PopulateConclusion,
    PopulateStatistics
  }

  alias Covid19QuestionnaireWeb.Schemas.Questionnaire

  @type questionnaire() :: Questionnaire.t()
  @type code() :: String.t()

  @spec call(questionnaire) :: {:ok, questionnaire}

  def call(questionnaire = %Questionnaire{}) do
    Tree
    |> Algorithm.call()
    |> FlattenTree.call()
    |> TraverseTree.call(questionnaire)
    |> case do
      {:ok, %{key: key}} -> {:ok, populate(questionnaire, key.())}
      {:error, :done} -> {:ok, populate(questionnaire, Codes.fin9())}
    end
  end

  @spec populate(questionnaire, code) :: questionnaire

  defp populate(questionnaire = %Questionnaire{}, code) do
    questionnaire
    |> PopulateConclusion.call(code)
    |> PopulateStatistics.call()
  end
end
