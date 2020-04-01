defmodule Covid19QuestionnaireWeb.BienvenueController do
  use Covid19QuestionnaireWeb, :controller

  def index(conn, _params) do
    {:ok, body} =
      %{
        bienvenue: """
        Bienvenue à l'API d'orientation du Covid-19, \
        consultez notre documentation interactive : \
        https://covid19-auto-evaluation.sante.gouv.fr/swagger.
        """
      }
      |> Jason.encode()

    conn
    |> resp(200, body)
  end
end
