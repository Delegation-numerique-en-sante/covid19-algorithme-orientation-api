defmodule Covid19QuestionnaireWeb.BienvenueController do
  use Covid19QuestionnaireWeb, :controller

  def index(conn, _params) do
    {:ok, body} =
      %{bienvenue: "Bienvenue à l'API d'orientation du COVID19 !"}
      |> Jason.encode()

    conn
    |> resp(200, body)
  end
end
