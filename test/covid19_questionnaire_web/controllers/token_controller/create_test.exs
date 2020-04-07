defmodule Covid19QuestionnaireWeb.TokenController.CreateTest do
  use Covid19QuestionnaireWeb.ConnCase, async: true

  test "création d'un token", %{conn: conn, spec: spec} do
    body =
      conn
      |> post("/token")
      |> response(201)
      |> Jason.decode!()

    assert_schema(body, "TokenResponse", spec)
    assert body["data"]["uuid"] |> Ecto.UUID.cast()
  end
end
