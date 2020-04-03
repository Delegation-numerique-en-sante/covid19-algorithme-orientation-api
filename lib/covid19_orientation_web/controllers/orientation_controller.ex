defmodule Covid19OrientationWeb.OrientationController do
  use Covid19OrientationWeb, :controller

  alias Covid19Orientation.Data.Store

  alias Covid19OrientationWeb.Operations.{
    CreateOrientation,
    EvaluateOrientation,
  }

  alias Covid19OrientationWeb.Schemas.OrientationRequest
  alias OpenApiSpex.Plug.CastAndValidate

  defdelegate open_api_operation(action), to: CreateOrientation

  plug CastAndValidate

  def create(conn = %{body_params: %OrientationRequest{orientation: params}}, _params) do
    with [token] when not is_nil(token) <- get_req_header(conn, "x-token"),
         date <- DateTime.utc_now(),
         {:ok, orientation} <- EvaluateOrientation.call(params),
         stored_orientation <- Store.write({date, token}, orientation),
         {:ok, json} <- Jason.encode(stored_orientation) do

        send_resp(conn, 201, json)
    else
      _ ->
        conn
        |> put_status(400)
        |> halt()
    end
  end
end
