defmodule Covid19QuestionnaireWeb.Operations.EvaluateQuestionnaire.AutresTest do
  @moduledoc """
  Autres.
  """

  use ExUnit.Case, async: true
  alias Covid19Questionnaire.Tests.Conditions
  alias Covid19QuestionnaireWeb.Operations.EvaluateQuestionnaire
  alias Covid19QuestionnaireWeb.Schemas.{Patient, Pronostiques, Questionnaire, Symptoms}

  test "Bastien Guerry #1" do
    {:ok, questionnaire} =
      %Questionnaire{
        patient: %Patient{age_less_50: false, age_less_70: true, height: 120, weight: 40.0},
        symptomes: %Symptoms{temperature: 36.6, agueusia_anosmia: true, tiredness: true},
        pronostiques: %Pronostiques{heart_disease: false}
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
        patient: %Patient{age_less_50: false, age_less_70: true, height: 120, weight: 40.0},
        symptomes: %Symptoms{temperature: 36.6, cough: true, tiredness: true},
        pronostiques: %Pronostiques{heart_disease: true}
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
        patient: %Patient{age_less_50: false, age_less_70: true, height: 120, weight: 40.0},
        symptomes: %Symptoms{temperature: 36.6, tiredness: true},
        pronostiques: %Pronostiques{heart_disease: false}
      }
      |> EvaluateQuestionnaire.call()

    assert Conditions.symptomes4(questionnaire)
    assert Conditions.facteurs_pronostique(questionnaire) == 0
    assert Conditions.facteurs_gravite_mineurs(questionnaire) == 1
    assert Conditions.facteurs_gravite_majeurs(questionnaire) == 0
    # FIXME
    assert questionnaire.conclusion.code == "FIN9"
  end
end
