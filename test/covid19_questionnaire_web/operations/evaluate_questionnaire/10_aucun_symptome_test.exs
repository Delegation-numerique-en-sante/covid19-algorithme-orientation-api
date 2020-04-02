defmodule Covid19QuestionnaireWeb.Operations.EvaluateQuestionnaire.AucunSymptomeTest do
  @moduledoc """
  Patient avec aucun symtôme.
  """

  use ExUnit.Case, async: true
  alias Covid19Questionnaire.Tests.Conditions
  alias Covid19QuestionnaireWeb.Operations.EvaluateQuestionnaire
  alias Covid19QuestionnaireWeb.Schemas.{Patient, Pronostiques, Questionnaire, Symptomes}

  test "patient avec aucun symtôme" do
    {:ok, questionnaire} =
      %Questionnaire{
        patient: %Patient{},
        symptomes: %Symptomes{temperature: 36.6},
        pronostiques: %Pronostiques{heart_disease: false}
      }
      |> EvaluateQuestionnaire.call()

    assert Conditions.symptomes4(questionnaire)
    assert Conditions.facteurs_pronostique(questionnaire) == 0
    assert Conditions.facteurs_gravite_mineurs(questionnaire) == 0
    assert Conditions.facteurs_gravite_majeurs(questionnaire) == 0
    assert questionnaire.conclusion.code == "FIN9"
  end
end
