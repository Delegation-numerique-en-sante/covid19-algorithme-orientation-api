defmodule Covid19QuestionnaireWeb.BienvenueController.IndexQuestionnaire do
  use Covid19QuestionnaireWeb.ConnCase, async: true

  test "bienvenue", %{conn: conn} do
    body =
      conn
      |> get("/")
      |> response(200)
      |> Jason.decode!()

    assert body["bienvenue"] =~ "Bienvenue à l'API d'orientation du COVID19"
  end
end
