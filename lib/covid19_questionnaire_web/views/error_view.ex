defmodule Covid19QuestionnaireWeb.ErrorView do
  require Logger
  import Plug.Conn, only: [put_resp_header: 3, send_resp: 3]
  alias Covid19QuestionnaireWeb.Schemas.Error

  def init(opts), do: opts

  def call(conn, _reason) do
    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(422, render("422.json", conn))
  end

  def render("404.json", %{conn: conn}) do
    not_found(conn)
  end

  def render("422.json", conn) do
    error =
      conn
      |> unprocessable_entity()
      |> Jason.encode!()

    Logger.error(error)
    error
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

  defp unprocessable_entity(conn) do
    %{
      errors: [
        %Error{
          title: "Unprocessable Entity",
          source: %{"pointer" => conn.request_path, "params" => conn.params},
          message: "Please take a look at the data schema #{schema()}"
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

  defp schema do
    config()[:schema_url]
  end
end
