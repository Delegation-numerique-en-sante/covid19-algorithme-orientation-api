defmodule Covid19QuestionnaireWeb.TokenController do
  use Covid19QuestionnaireWeb, :controller
  alias Covid19Questionnaire.Data.Token
  alias Covid19QuestionnaireWeb.Operations.CreateToken

  defdelegate open_api_operation(action), to: CreateToken

  def create(conn, _params) do
    with {:ok, token} <- Token.create(),
         {:ok, json} <- Jason.encode(%{data: token}) do
      send_resp(conn, 201, json)
    else
      {:error, _} ->
        conn
        |> put_status(409)
        |> halt()

      _ ->
        conn
        |> put_status(400)
        |> halt()
    end
  end
end
