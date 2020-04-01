defmodule Covid19QuestionnaireWeb.QuestionnaireController do
  use Covid19QuestionnaireWeb, :controller

  alias Covid19Questionnaire.Data.Store

  alias Covid19QuestionnaireWeb.Operations.{
    CreateQuestionnaire,
    EvaluateQuestionnaire,
  }

  alias Covid19QuestionnaireWeb.Schemas.QuestionnaireRequest
  alias OpenApiSpex.Plug.CastAndValidate

  defdelegate open_api_operation(action), to: CreateQuestionnaire

  plug CastAndValidate

  def create(conn = %{body_params: %QuestionnaireRequest{questionnaire: params}}, _params) do
    with [token] when not is_nil(token) <- get_req_header(conn, "x-token"),
         date <- DateTime.utc_now(),
         {:ok, questionnaire} <- EvaluateQuestionnaire.call(params),
         stored_questionnaire <- Store.write({date, token}, questionnaire),
         {:ok, json} <- Jason.encode(stored_questionnaire) do

        send_resp(conn, 201, json)
    else
      _ ->
        conn
        |> put_status(400)
        |> halt()
    end
  end
end
