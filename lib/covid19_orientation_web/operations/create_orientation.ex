defmodule Covid19OrientationWeb.Operations.CreateOrientation do
  @moduledoc """
  Open API CreateOrientation operation.
  """

  import OpenApiSpex.Operation, only: [request_body: 4, response: 3]
  alias Covid19OrientationWeb.Schemas.{OrientationRequest, OrientationResponse}
  alias OpenApiSpex.Operation

  @type action :: :create
  @type operation :: Operation.t()

  @spec open_api_operation(action) :: operation

  def open_api_operation(:create) do
    call()
  end

  @spec call() :: operation

  def call do
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
end
