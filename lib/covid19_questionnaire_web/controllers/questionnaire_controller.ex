defmodule Covid19QuestionnaireWeb.QuestionnaireController do
  use Covid19QuestionnaireWeb, :controller

  alias Covid19Questionnaire.Data.Store

  alias Covid19QuestionnaireWeb.Operations.{
    CreateQuestionnaire,
    EvaluateQuestionnaire,
    ValidateQuestionnaire
  }

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
         {:ok, questionnaire} <- EvaluateQuestionnaire.call(params),
         {:ok, questionnaire} <- ValidateQuestionnaire.call(questionnaire),
         {:ok, data} <- Store.write({date, token}, questionnaire),
         {:ok, json} <- Jason.encode(data) do
      send_resp(conn, 201, json)
    else
      {:error, :age_less_15} ->
        conn
        |> put_status(451)
        |> halt()

      _ ->
        conn
        |> put_status(400)
        |> halt()
    end
  end

  defexception plug_status: 500, message: "no route found", conn: nil, router: nil
end
