defmodule Covid19OrientationWeb.BienvenueController.IndexOrientation do
  use Covid19OrientationWeb.ConnCase

  test "bienvenue" do
    conn =
      build_conn()
      |> get("/")

    body = conn |> response(200) |> Jason.decode!()

    assert body["bienvenue"] =~ "Bienvenue à l'API d'orientation du Covid-19"
  end
end
