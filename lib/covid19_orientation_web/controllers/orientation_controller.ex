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

    {:ok, orientation} =
      orientation
      |> SetId.call()
      |> SetTimestamp.call()
      |> Store.set()

    conn
    |> put_status(:created)
    |> render("create.json", orientation: orientation)
  end
end
