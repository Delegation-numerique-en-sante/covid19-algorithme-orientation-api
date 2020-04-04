defmodule Covid19QuestionnaireWeb.Plugs.Authorize do
  @moduledoc """
  If there's no token sent by the client, the request gets rejected.
  """

  import Plug.Conn
  use PlugAttack
  alias Covid19QuestionnaireWeb.Schemas.Error

  rule "authorize", conn do
    conn
    |> get_req_header("x-token")
    |> Enum.at(0)
    |> is_nil
    |> block
  end

  def block_action(conn, _data, _opts) do
    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(
      401,
      Jason.encode!(%Error{code: 401, info: "Token missing", action: "Please create a token."})
    )
    |> halt()
  end
end
