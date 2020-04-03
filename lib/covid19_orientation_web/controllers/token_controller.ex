defmodule Covid19OrientationWeb.TokenController do
  use Covid19OrientationWeb, :controller
  alias Covid19Orientation.Data.Token
  require Logger

  def create(conn, _params) do
    case Token.create() do
        {:ok, token} ->
            send_resp(conn, 201, token.id)
        {:error, error} ->
            Logger.error("Unable to create token")
            Logger.error(error)

            conn
            |> put_status(500)
            |> halt()
    end
  end
end