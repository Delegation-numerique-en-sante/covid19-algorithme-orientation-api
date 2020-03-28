defmodule Covid19OrientationWeb.OrientationController do
  use Covid19OrientationWeb, :controller
  alias Covid19Orientation.TestOrientation
  alias Covid19OrientationWeb.OrientationOperation
  alias Covid19OrientationWeb.Schemas.OrientationRequest
  alias OpenApiSpex.Plug.CastAndValidate

  defdelegate open_api_operation(action), to: OrientationOperation

  plug CastAndValidate

  def create(conn = %{body_params: %OrientationRequest{orientation: params}}, _params) do
    {:ok, orientation} =
      params
      |> TestOrientation.populate_statistiques()
      |> TestOrientation.evaluate()

    conn
    |> put_status(:created)
    |> render("create.json", orientation: orientation)
  end
end
