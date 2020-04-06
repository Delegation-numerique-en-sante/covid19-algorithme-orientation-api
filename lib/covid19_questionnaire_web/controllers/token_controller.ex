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
        |> send_resp(409, conflict(conn))
        |> halt()

      _ ->
        conn
        |> put_resp_header("content-type", "application/json")
        |> send_resp(400, bad_request(conn))
        |> halt()
    end
  end

  defp conflict(conn) do
    Jason.encode!(%{
      errors: [
        %Error{
          title: "Conflict",
          source: %{"pointer" => conn.request_path},
          message: "We couldn't create a token, please try again or open an issue #{issue()}"
        }
      ]
    })
  end

  defp bad_request(conn) do
    Jason.encode!(%{
      errors: [
        %Error{
          title: "Bad Request",
          source: %{"pointer" => conn.request_path},
          message: "We weren't able to process the request, please open an issue #{issue()}"
        }
      ]
    })
  end

  defp issue do
    Application.fetch_env!(:covid19_questionnaire, :issue_url)
  end
end
