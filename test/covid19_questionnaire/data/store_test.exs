defmodule Covid19Questionnaire.Data.StoreTest do
  use ExUnit.Case, async: true
  alias Covid19Questionnaire.Data.{Journal, Store}
  alias Covid19QuestionnaireWeb.Schemas.{Metadata, Questionnaire}

  test "stores data" do
    questionnaire = %Questionnaire{
      metadata: %Metadata{}
    }

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
