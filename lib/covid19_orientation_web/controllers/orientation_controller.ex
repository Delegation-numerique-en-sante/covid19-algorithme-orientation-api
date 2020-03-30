defmodule Covid19OrientationWeb.OrientationController do
  use Covid19OrientationWeb, :controller

  alias Covid19Orientation.Data.Store

  alias Covid19OrientationWeb.Operations.{
    CreateOrientation,
    EvaluateOrientation,
    SetId,
    SetTimestamp
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
      %{timestamp: timestamp, id: id} =
      orientation
      |> SetId.call()
      |> SetTimestamp.call()

    %{data: orientation}
    |> Jason.encode!()
    |> (&Store.write({timestamp, id}, &1)).()
    |> (&send_resp(conn, 201, &1)).()
  end
end
