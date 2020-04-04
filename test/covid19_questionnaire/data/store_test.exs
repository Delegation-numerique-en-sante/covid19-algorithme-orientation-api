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
        patient: %Patient{age_range: "sup_70"},
        symptoms: %Symptoms{temperature_cat: "sup_39"},
        risk_factors: %RiskFactors{}
      }
      |> EvaluateQuestionnaire.call()

    date_tokn = DateTime.utc_now()
    date_quiz = date_tokn |> DateTime.add(3600, :second)
    uuid = "faketoken"
    {:ok, data} = Store.write({date_quiz, %{uuid: uuid, date: date_tokn}}, questionnaire)

    data =
      data
      |> Jason.encode!()
      |> Jason.decode!()
      |> Kernel.put_in(["data", "metadata", "duration"], 3600)

    :timer.sleep(Store.tick_interval())

    assert data == Journal.find(date_quiz).data
  end
end
