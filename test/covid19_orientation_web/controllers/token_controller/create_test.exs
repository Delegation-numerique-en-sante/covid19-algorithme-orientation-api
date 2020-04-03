defmodule Covid19OrientationWeb.TokenController.CreateTest do
  use Covid19OrientationWeb.ConnCase, async: true

  test "Creation d'un token", %{conn: conn} do

    body =
      conn
      |> post("/token")
      |> response(201)

    assert String.length(body) == 36
  end
end
