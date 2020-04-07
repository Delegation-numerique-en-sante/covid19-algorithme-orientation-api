defmodule Covid19QuestionnaireWeb.TokenController.CreateTest do
  use Covid19QuestionnaireWeb.ConnCase, async: true

  test "création d'un token", %{conn: conn} do
    conn =
      conn
      |> post("/token")

    assert conn.status == 204
    assert conn |> get_resp_header("x-token") |> Ecto.UUID.cast()
  end
end
