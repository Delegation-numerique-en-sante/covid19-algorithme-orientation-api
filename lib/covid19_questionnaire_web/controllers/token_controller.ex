defmodule Covid19QuestionnaireWeb.TokenController do
  use Covid19QuestionnaireWeb, :controller
  alias Covid19Questionnaire.Data.Token

  def create(conn, _params) do
    case Token.create() do
        {:ok, token} ->
            send_resp(conn, 201, token.id)
        {:error, error} ->
            conn
            |> put_status(500)
            |> halt()
    end
  end
end
