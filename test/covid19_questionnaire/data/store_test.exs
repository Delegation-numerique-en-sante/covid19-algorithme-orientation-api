defmodule Covid19Questionnaire.Data.StoreTest do
  use ExUnit.Case, async: true
  alias Covid19Questionnaire.Data.{Journal, Store, Token}
  alias Covid19QuestionnaireWeb.Schemas.{Metadata, Questionnaire}

  test "stores data" do
    questionnaire = %Questionnaire{
      metadata: %Metadata{}
    }

    {:ok, %{date: token_date} = token} = Token.create
    date_quiz = DateTime.add(token_date, 3600, :second)

    {:ok, data} = Store.write({date_quiz, token}, questionnaire)

    data =
      data
      |> Jason.encode!()
      |> Jason.decode!()
      |> Kernel.put_in(["data", "metadata", "duration"], 3600)

    :timer.sleep(Store.tick_interval())

    assert data == Journal.find(date_quiz).data
  end
end
