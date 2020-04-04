defmodule Covid19Questionnaire.Data.TokenTest do
  use ExUnit.Case, async: true
  alias Covid19Questionnaire.Data.Token

  test "stores & retrieves tokens" do
    {:ok, token = %{uuid: uuid}} = Token.create()

    assert token == Token.find(uuid)
  end
end
