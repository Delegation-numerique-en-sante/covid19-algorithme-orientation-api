defmodule Covid19OrientationWeb.OrientationController do
  use Covid19OrientationWeb, :controller
  import OpenApiSpex.Operation, only: [request_body: 4, response: 3]
  alias Covid19Orientation.TestOrientation
  alias Covid19OrientationWeb.Schemas.{OrientationRequest, OrientationResponse}
  alias OpenApiSpex.Operation
  alias OpenApiSpex.Plug.CastAndValidate

  plug CastAndValidate

  def open_api_operation(action) do
    apply(__MODULE__, :"#{action}_operation", [])
  end

  def create_operation do
    %Operation{
      summary: "Évaluer le test d'orientation du Covid-19",
      description: "Évaluer le test d'orientation du Covid-19",
      operationId: "OrientationController.create",
      requestBody:
        request_body(
          "Paramètres du test d'orientation",
          "application/json",
          OrientationRequest,
          required: true
        ),
      responses: %{
        201 => response("Orientation", "application/json", OrientationResponse)
      }
    }
  end

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
