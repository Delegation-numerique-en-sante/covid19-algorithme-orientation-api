defmodule Covid19Questionnaire.Data.StoreTest do
  use ExUnit.Case, async: true
  alias Covid19Questionnaire.Data.Store

  alias Covid19QuestionnaireWeb.Operations.EvaluateQuestionnaire

  alias Covid19QuestionnaireWeb.Schemas.{
    Metadata,
    Patient,
    Pronostiques,
    Questionnaire,
    Symptomes
  }

  test "stores & retrieves data" do
    {:ok, questionnaire} =
      %Questionnaire{
        metadata: %Metadata{},
        patient: %Patient{age_more_70: true},
        symptomes: %Symptomes{temperature: 39.0},
        pronostiques: %Pronostiques{}
      }
      |> EvaluateQuestionnaire.call()

    date = DateTime.utc_now()
    uuid = "faketoken"
    data = Store.write({date, uuid}, questionnaire)

    :timer.sleep(Store.tick_interval())

    assert [data |> Jason.encode!() |> Jason.decode!()] == Store.read(date)
  end
end
