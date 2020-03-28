defmodule Covid19OrientationWeb.BienvenueController.IndexOrientation do
  use Covid19OrientationWeb.ConnCase, async: true

  test "bienvenue", %{conn: conn} do
    body =
      conn
      |> get("/")
      |> response(200)
      |> Jason.decode!()

    assert body["bienvenue"] =~ "Bienvenue à l'API d'orientation du Covid-19"
  end
end
