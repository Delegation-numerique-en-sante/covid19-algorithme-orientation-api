defmodule Covid19QuestionnaireWeb.QuestionnaireController do
  use Covid19QuestionnaireWeb, :controller

  alias Covid19Questionnaire.Data.Store

  alias Covid19QuestionnaireWeb.Operations.{CreateQuestionnaire, ValidateQuestionnaire}

  alias Covid19QuestionnaireWeb.Plugs.{Authenticate, Authorize}
  alias Covid19QuestionnaireWeb.Schemas.{Error, QuestionnaireRequest}
  alias OpenApiSpex.Plug.CastAndValidate

  defdelegate open_api_operation(action), to: CreateQuestionnaire

  plug Authorize
  plug Authenticate
  plug CastAndValidate

  def create(conn = %{body_params: %QuestionnaireRequest{questionnaire: params}}, _params) do
    with date <- DateTime.utc_now(),
         %{token: token} <- conn.assigns,
         {:ok, questionnaire} <- ValidateQuestionnaire.call(params),
         {:ok, data} <- Store.write({date, token}, questionnaire),
         {:ok, json} <- Jason.encode(data) do
      conn
      |> put_resp_header("content-type", "application/json")
      |> send_resp(201, json)
    else
      {:error, :age_less_15} ->
        conn
        |> put_resp_header("content-type", "application/json")
        |> send_resp(
          451,
          Jason.encode!(%{
            error: %Error{
              code: 451,
              info: "We won't collect that data",
              action: "But don;t worry, there's nothing to do on your side, it's all good :)."
            }
          })
        )
        |> halt()

      _ ->
        conn
        |> put_resp_header("content-type", "application/json")
        |> send_resp(
          400,
          Jason.encode!(%{
            error: %Error{
              code: 400,
              info: "We don't know what happened",
              action:
                "Please open an issue https://github.com/Delegation-numerique-en-sante/covid19-algorithme-orientation-elixir/issues/new."
            }
          })
        )
        |> halt()
    end
  end
end
