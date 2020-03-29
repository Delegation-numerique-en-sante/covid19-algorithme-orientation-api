defmodule Covid19OrientationWeb.OrientationController do
  use Covid19OrientationWeb, :controller
  alias Covid19Orientation.Tests.Test
  alias Covid19OrientationWeb.Operations.OpenApi.CreateOrientation
  alias Covid19OrientationWeb.Schemas.OrientationRequest
  alias OpenApiSpex.Plug.CastAndValidate

  defdelegate open_api_operation(action), to: CreateOrientation

  plug CastAndValidate

  def create(conn = %{body_params: %OrientationRequest{orientation: params}}, _params) do
    {:ok, orientation} =
      params
      |> Test.populate_statistiques()
      |> Test.evaluate()

    conn
    |> put_status(:created)
    |> render("create.json", orientation: orientation)
  end
end
