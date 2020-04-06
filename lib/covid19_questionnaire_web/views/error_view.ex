defmodule Covid19QuestionnaireWeb.ErrorView do
  alias Covid19QuestionnaireWeb.Schemas.Error

  def render("404.json", %{conn: conn}) do
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

  def render("500.json", %{conn: conn}) do
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

  defp doc do
    Application.fetch_env!(:covid19_questionnaire, :documentation_url)
  end

  defp issue do
    Application.fetch_env!(:covid19_questionnaire, :issue_url)
  end
end
