defmodule Covid19QuestionnaireWeb.Operations.EvaluateQuestionnaire.AutresTest do
  @moduledoc """
  Autres.
  """

  use ExUnit.Case, async: true
  alias Covid19Questionnaire.Tests.Conditions
  alias Covid19QuestionnaireWeb.Operations.EvaluateQuestionnaire
  alias Covid19QuestionnaireWeb.Schemas.{Pronostiques, Questionnaire, Symptomes}

  test "Bastien Guerry #1" do
    {:ok, questionnaire} =
      %Questionnaire{
        symptomes: %Symptomes{temperature: 36.6, agueusia_anosmia: true, tiredness: true},
        pronostiques: %Pronostiques{age: 50, heart_disease: false, height: 1.2, weight: 40.0}
      }
      |> EvaluateQuestionnaire.call()

    assert Conditions.symptomes3(questionnaire)
    assert Conditions.facteurs_pronostique(questionnaire) == 0
    assert Conditions.facteurs_gravite_mineurs(questionnaire) == 1
    assert Conditions.facteurs_gravite_majeurs(questionnaire) == 0
    assert questionnaire.conclusion.code == "FIN2"
  end

  test "Bastien Guerry #2" do
    {:ok, questionnaire} =
      %Questionnaire{
        symptomes: %Symptomes{temperature: 36.6, cough: true, tiredness: true},
        pronostiques: %Pronostiques{age: 50, heart_disease: true, height: 1.2, weight: 40.0}
      }
      |> EvaluateQuestionnaire.call()

    assert Conditions.symptomes3(questionnaire)
    assert Conditions.facteurs_pronostique(questionnaire) == 1
    assert Conditions.facteurs_gravite_mineurs(questionnaire) == 1
    assert Conditions.facteurs_gravite_majeurs(questionnaire) == 0
    assert questionnaire.conclusion.code == "FIN7"
  end

  test "Mauko Quiroga #1" do
    {:ok, questionnaire} =
      %Questionnaire{
        symptomes: %Symptomes{temperature: 36.6, tiredness: true},
        pronostiques: %Pronostiques{age: 50, heart_disease: false, height: 1.2, weight: 40.0}
      }
      |> EvaluateQuestionnaire.call()

    assert Conditions.symptomes4(questionnaire)
    assert Conditions.facteurs_pronostique(questionnaire) == 0
    assert Conditions.facteurs_gravite_mineurs(questionnaire) == 1
    assert Conditions.facteurs_gravite_majeurs(questionnaire) == 0
    assert questionnaire.conclusion.code == "FIN9"
  end
end
