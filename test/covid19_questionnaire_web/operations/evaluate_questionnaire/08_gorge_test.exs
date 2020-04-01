defmodule Covid19QuestionnaireWeb.Operations.EvaluateQuestionnaire.MalDeGorgeTest do
  @moduledoc """
  Patient avec seulement mal de gorge.
  """

  use ExUnit.Case, async: true
  alias Covid19Questionnaire.Tests.Conditions
  alias Covid19QuestionnaireWeb.Operations.EvaluateQuestionnaire
  alias Covid19QuestionnaireWeb.Schemas.{Pronostiques, Questionnaire, Symptomes}

  setup do
    {:ok,
     questionnaire: %Questionnaire{
       symptomes: %Symptomes{
         temperature: 36.6,
         sore_throat_aches: true
       },
       pronostiques: %Pronostiques{heart_disease: false}
     }}
  end

  test "sans facteur de gravité", %{questionnaire: questionnaire} do
    {:ok, questionnaire} =
      questionnaire
      |> EvaluateQuestionnaire.call()

    assert Conditions.symptomes3(questionnaire)
    assert Conditions.facteurs_pronostique(questionnaire) == 0
    assert Conditions.facteurs_gravite_mineurs(questionnaire) == 0
    assert Conditions.facteurs_gravite_majeurs(questionnaire) == 0
    assert questionnaire.conclusion.code == "FIN2"
  end

  test "avec au moins un facteur de gravité", %{questionnaire: questionnaire} do
    {:ok, questionnaire} =
      %Questionnaire{
        questionnaire
        | symptomes: %Symptomes{questionnaire.symptomes | tiredness: true}
      }
      |> EvaluateQuestionnaire.call()

    assert Conditions.symptomes3(questionnaire)
    assert Conditions.facteurs_pronostique(questionnaire) == 0
    assert Conditions.facteurs_gravite_mineurs(questionnaire) >= 1
    assert Conditions.facteurs_gravite_majeurs(questionnaire) == 0
    assert questionnaire.conclusion.code == "FIN2"
  end

  test "avec au moins un facteur pronostique", %{questionnaire: questionnaire} do
    {:ok, questionnaire} =
      %Questionnaire{
        questionnaire
        | pronostiques: %Pronostiques{questionnaire.pronostiques | heart_disease: true}
      }
      |> EvaluateQuestionnaire.call()

    assert Conditions.symptomes3(questionnaire)
    assert Conditions.facteurs_pronostique(questionnaire) >= 1
    assert Conditions.facteurs_gravite_mineurs(questionnaire) == 0
    assert Conditions.facteurs_gravite_majeurs(questionnaire) == 0
    assert questionnaire.conclusion.code == "FIN7"
  end
end
