defmodule Covid19QuestionnaireWeb.TokenController do
  use Covid19QuestionnaireWeb, :controller
  alias Covid19Questionnaire.Data.Token
  alias Covid19QuestionnaireWeb.Operations.CreateToken
  alias Covid19QuestionnaireWeb.Schemas.Error

  defdelegate open_api_operation(action), to: CreateToken

  def create(conn, _params) do
    with {:ok, token} <- Token.create(),
         {:ok, json} <- Jason.encode(%{data: token}) do
      conn
      |> put_resp_header("content-type", "application/json")
      |> send_resp(201, json)
    else
      {:error, _} ->
        conn
        |> put_resp_header("content-type", "application/json")
        |> send_resp(
          409,
          Jason.encode!(%Error{
            code: 403,
            info: "We couldn't create a token",
            action: "Please try again."
          })
        )
        |> halt()

      _ ->
        conn
        |> put_resp_header("content-type", "application/json")
        |> send_resp(
          400,
          Jason.encode!(%Error{
            code: 400,
            info: "We don't know what happened",
            action:
              "Please open an issue https://github.com/Delegation-numerique-en-sante/covid19-algorithme-orientation-elixir/issues/new."
          })
        )
        |> halt()
    end
  end
end
