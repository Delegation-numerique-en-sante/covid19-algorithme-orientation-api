defmodule Covid19QuestionnaireWeb.Operations.PopulateCalculations do
  @moduledoc """
  Populate calculations.
  """

  alias Covid19Questionnaire.Tests.Conditions
  alias Covid19QuestionnaireWeb.Schemas.{Calculations, Questionnaire}

  @type questionnaire :: Questionnaire.t()

  @spec call(questionnaire) :: questionnaire

  def call(questionnaire = %Questionnaire{}) do
    Map.put(
      questionnaire,
      :calculations,
      %Calculations{}
      |> Map.from_struct()
      |> Map.keys()
      |> Enum.reduce(%Calculations{}, fn key, calculations ->
        calculations
        |> Map.put(key, apply(Conditions, key, [questionnaire]))
      end)
    )
  end
end
