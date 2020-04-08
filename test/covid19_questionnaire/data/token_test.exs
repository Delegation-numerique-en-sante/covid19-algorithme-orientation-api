defmodule Covid19Questionnaire.Data.TokenTest do
  use ExUnit.Case, async: true
  alias Covid19Questionnaire.Data.Token

  test "stores & retrieves tokens" do
    {:ok, %{uuid: token, date: date}} = Token.create()

    {:ok, start_datetime} = Token.decrypt(token)

    assert_in_delta(DateTime.to_unix(date, :microsecond), DateTime.to_unix(start_datetime, :microsecond), 1000)
  end
end
