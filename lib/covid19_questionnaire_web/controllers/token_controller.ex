defmodule Covid19QuestionnaireWeb.TokenController do
  use Covid19QuestionnaireWeb, :controller
  alias Covid19Questionnaire.Data.Token
  alias Covid19QuestionnaireWeb.Operations.CreateToken

  defdelegate open_api_operation(action), to: CreateToken

  def create(conn, _params) do
    with {:ok, token} <- Token.create(),
         {:ok, json} <- Jason.encode(%{data: %{uuid: token.uuid}}) do
      conn
      |> put_resp_header("content-type", "application/json")
      |> send_resp(201, json)
    else
      {:error, _} ->
        conn
        |> put_resp_header("content-type", "application/json")
        |> send_resp(409, "")
        |> halt()

      _ ->
        conn
        |> put_resp_header("content-type", "application/json")
        |> send_resp(400, "")
        |> halt()
    end
  end
end
