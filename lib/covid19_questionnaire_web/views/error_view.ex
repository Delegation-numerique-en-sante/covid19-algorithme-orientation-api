defmodule Covid19QuestionnaireWeb.ErrorView do
  alias Covid19QuestionnaireWeb.Schemas.Error

  def render("404.json", %{conn: conn}) do
    not_found(conn)
  end

  def render("500.json", %{conn: conn}) do
    internal_server_error(conn)
  end

  defp not_found(conn) do
    %{
      errors: [
        %Error{
          title: "Not Found",
          source: %{"pointer" => conn.request_path},
          message: "Please take a look at the doc #{doc()} or open an issue #{issue()}"
        }
      ]
    }
  end

  defp internal_server_error(conn) do
    %{
      errors: [
        %Error{
          title: "Internal Server Error",
          source: %{"pointer" => conn.request_path},
          message: "Please open an issue #{issue()}"
        }
      ]
    }
  end

  defp config do
    Application.fetch_env!(:covid19_questionnaire, __MODULE__)
  end

  defp doc do
    config()[:doc_url]
  end

  defp issue do
    config()[:issue_url]
  end
end
