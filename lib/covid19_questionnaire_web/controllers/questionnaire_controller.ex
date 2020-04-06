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
        |> send_resp(451, unavailable_for_legal_reasons(conn))
        |> halt()

      _ ->
        conn
        |> put_resp_header("content-type", "application/json")
        |> send_resp(400, bad_request(conn))
        |> halt()
    end
  end

  def unavailable_for_legal_reasons(conn) do
    Jason.encode!(%{
      errors: [
        %Error{
          title: "Unavailable For Legal Reasons",
          source: %{"pointer" => conn.request_path},
          message: "We don't collect data of < 15y old respondents for legal reasons #{doc()}"
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

  defp doc do
    Application.fetch_env!(:covid19_questionnaire, :documentation_url)
  end

  defp issue do
    Application.fetch_env!(:covid19_questionnaire, :issue_url)
  end
end
