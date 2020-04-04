defmodule Covid19QuestionnaireWeb.Plugs.Authorize do
  @moduledoc """
  If there's no token sent by the client, the request gets rejected.
  """

  import Plug.Conn
  use PlugAttack

  rule "authorize", conn do
    conn
    |> get_req_header("x-token")
    |> Enum.at(0)
    |> is_nil
    |> block
  end

  def block_action(conn, _data, _opts) do
    conn
    |> put_status(401)
    |> halt()
  end
end
