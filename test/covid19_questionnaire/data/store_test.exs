defmodule Covid19Questionnaire.Data.StoreTest do
  use ExUnit.Case, async: true
  alias Covid19Questionnaire.Data.{Journal, Store}

  alias Covid19QuestionnaireWeb.Operations.EvaluateQuestionnaire

  alias Covid19QuestionnaireWeb.Schemas.{
    Metadata,
    Patient,
    Questionnaire,
    RiskFactors,
    Symptoms
  }

  test "stores data" do
    {:ok, questionnaire} =
      %Questionnaire{
        metadata: %Metadata{},
        patient: %Patient{age_more_70: true},
        symptoms: %Symptoms{temperature_cat: "sup_39"},
        risk_factors: %RiskFactors{}
      }
      |> EvaluateQuestionnaire.call()

    date = DateTime.utc_now()
    uuid = "faketoken"
    {:ok, data} = Store.write({date, %{uuid: uuid, date: date}}, questionnaire)

    :timer.sleep(Store.tick_interval())

    assert data |> Jason.encode!() |> Jason.decode!() == Journal.find(date).data
  end
end
