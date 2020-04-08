defmodule Covid19QuestionnaireWeb.Plugs.Authenticate do
  @moduledoc """
  If the token sent by the client isn't legit, the request gets rejected.
  """

  import Plug.Conn
  use PlugAttack
  alias Covid19Questionnaire.Data.Token

  rule "authenticate", conn do
    token =
      conn
      |> get_req_header("x-token")
      |> hd

    case Token.decrypt(token) do
      {:ok, start_datetime} -> allow(%{date: start_datetime, uuid: token})
      _ -> block(true)
    end
  end

  def block_action(conn, _data, _opts) do
    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(403, "")
    |> halt()
  end

  def allow_action(conn, token, _opts) do
    assign(conn, :token, token)
  end
end
