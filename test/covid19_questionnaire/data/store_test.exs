defmodule Covid19Questionnaire.Data.StoreTest do
  use ExUnit.Case, async: true
  alias Covid19Questionnaire.Data.Store

  alias Covid19QuestionnaireWeb.Operations.EvaluateQuestionnaire

  alias Covid19QuestionnaireWeb.Schemas.{
    Metadata,
    Pronostiques,
    Questionnaire,
    Supplementaires,
    Symptomes
  }

  test "stores & retrieves data" do
    {:ok, questionnaire} =
      %Questionnaire{
        metadata: %Metadata{},
        symptomes: %Symptomes{temperature: 39.0},
        pronostiques: %Pronostiques{age: 70},
        supplementaires: %Supplementaires{postal_code: "75000"}
      }
      |> EvaluateQuestionnaire.call()

    date = DateTime.utc_now()
    uuid = "faketoken"
    data = Store.write({date, uuid}, questionnaire)

    :timer.sleep(Store.tick_interval())

    assert [data |> Jason.encode!() |> Jason.decode!()] == Store.read(date)
  end
end
