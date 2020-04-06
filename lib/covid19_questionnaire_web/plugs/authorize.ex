defmodule Covid19QuestionnaireWeb.Plugs.Authorize do
  @moduledoc """
  If there's no token sent by the client, the request gets rejected.
  """

  import Covid19QuestionnaireWeb.Router.Helpers, only: [token_url: 2]
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
    |> send_resp(401, unauthorized(conn))
    |> halt()
  end

  defp unauthorized(conn) do
    Jason.encode!(%{
      errors: [
        %Error{
          title: "Unauthorized",
          source: %{"pointer" => conn.request_path},
          message: "A token is required, please provide one #{token_url(conn, :create)}"
        }
      ]
    })
  end
end
