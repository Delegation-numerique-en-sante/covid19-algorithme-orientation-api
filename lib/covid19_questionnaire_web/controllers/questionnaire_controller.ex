defmodule Covid19QuestionnaireWeb.QuestionnaireController do
  use Covid19QuestionnaireWeb, :controller
  alias Covid19Questionnaire.Data.Store
  alias Covid19QuestionnaireWeb.Operations.{CreateQuestionnaire, ValidateQuestionnaire}
  alias Covid19QuestionnaireWeb.Plugs.{Authenticate, Authorize}
  alias Covid19QuestionnaireWeb.Schemas.QuestionnaireRequest
  alias OpenApiSpex.Plug.CastAndValidate

  defdelegate open_api_operation(action), to: CreateQuestionnaire

  plug Authorize
  plug Authenticate
  plug CastAndValidate

  def create(conn = %{body_params: %QuestionnaireRequest{questionnaire: params}}, _params) do
    with date <- DateTime.utc_now(),
         %{token: token} <- conn.assigns,
         {:ok, questionnaire} <- ValidateQuestionnaire.call(params),
         {:ok, _data} <- Store.write({date, token}, questionnaire) do
      conn
      |> put_resp_header("content-type", "application/json")
      |> send_resp(202, "")
    else
      {:error, :age_less_15} ->
        conn
        |> put_resp_header("content-type", "application/json")
        |> send_resp(451, "")
        |> halt()

      _ ->
        conn
        |> put_resp_header("content-type", "application/json")
        |> send_resp(400, "")
        |> halt()
    end
  end
end
