defmodule Covid19QuestionnaireWeb.Plugs.Authenticate do
  @moduledoc """
  If the token sent by the client isn't legit, the request gets rejected.
  """

  import Covid19QuestionnaireWeb.Router.Helpers, only: [token_url: 2]
  import Plug.Conn
  use PlugAttack
  alias Covid19Questionnaire.Data.Token
  alias Covid19QuestionnaireWeb.Schemas.Error

  rule "authenticate", conn do
    conn
    |> get_req_header("x-token")
    |> hd
    |> Token.find()
    |> case do
      nil -> block(true)
      token -> allow(token)
    end
  end

  def block_action(conn, _data, _opts) do
    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(403, forbidden(conn))
    |> halt()
  end

  def allow_action(conn, token, _opts) do
    assign(conn, :token, token)
  end

  defp forbidden(conn) do
    Jason.encode!(%{
      errors: [
        %Error{
          title: "Forbidden",
          source: %{"pointer" => conn.request_path},
          message:
            "The token provided is not valid, please create a new one #{token_url(conn, :create)}"
        }
      ]
    })
  end
end
