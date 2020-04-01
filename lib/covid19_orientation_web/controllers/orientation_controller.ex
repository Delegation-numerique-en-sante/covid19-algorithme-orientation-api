defmodule Covid19OrientationWeb.OrientationController do
  use Covid19OrientationWeb, :controller

  alias Covid19Orientation.Data.Store

  alias Covid19OrientationWeb.Operations.{
    CreateOrientation,
    EvaluateOrientation,
    SetDate,
    SetUUID
  }

  alias Covid19OrientationWeb.Schemas.OrientationRequest
  alias OpenApiSpex.Plug.CastAndValidate

  defdelegate open_api_operation(action), to: CreateOrientation

  plug CastAndValidate

  def create(conn = %{body_params: %OrientationRequest{orientation: params}}, _params) do
    {:ok, orientation} =
      params
      |> EvaluateOrientation.call()

    orientation =
      %{date: date, uuid: uuid} =
      orientation
      |> SetDate.call()
      |> SetUUID.call()

    body =
      %{data: orientation}
      |> (&Store.write({date, uuid}, &1)).()
      |> Jason.encode!()
      |> (&send_resp(conn, 201, &1)).()
  end
end
