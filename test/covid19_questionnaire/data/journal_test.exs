defmodule Covid19Questionnaire.Data.JournalTest do
  use ExUnit.Case, async: true
  alias Covid19Questionnaire.Data.{Journal, Token}

  test "stores & retrieves journals" do
    date = DateTime.utc_now()
    {:ok, token} = Token.create()
    {:ok, {1, nil}} = Journal.create_many([%{date: date, data: %{token: token, crap: %{}}}])
    journal = Journal.find(date)

    assert journal
    assert journal == Journal.find(journal.uuid)
  end
end
