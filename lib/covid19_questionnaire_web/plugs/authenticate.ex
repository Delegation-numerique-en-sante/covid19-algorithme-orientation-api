defmodule Covid19QuestionnaireWeb.Plugs.Authenticate do
  @moduledoc """
  If the token sent by the client isn't legit, the request gets rejected.
  """

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
    |> send_resp(
      403,
      Jason.encode!(%{
        error: %Error{
          code: 403,
          info: "Token invalid",
          action: "Please create a new token."
        }
      })
    )
    |> halt()
  end

  def allow_action(conn, token, _opts) do
    assign(conn, :token, token)
  end
end
