defmodule Covid19QuestionnaireWeb.Operations.CreateToken do
  @moduledoc """
  Open API CreateToken operation.
  """

  import OpenApiSpex.Operation, only: [response: 3]

  alias Covid19QuestionnaireWeb.Schemas.{ErrorResponse, TokenResponse}
  alias OpenApiSpex.{Operation, Schema}

  @type action :: :create
  @type operation :: Operation.t()

  @spec open_api_operation(action) :: operation

  def open_api_operation(:create), do: call()
  def open_api_operation(_), do: nil

  @spec call() :: operation

  def call do
    %Operation{
      summary: "Create a token",
      description: "Create a token",
      operationId: "TokenController.create",
      responses: %{
        204 => response("Token", "application/json", TokenResponse),
        400 =>
          response("Token", "application/json", %Schema{
            type: :string,
            description: "Bad Request"
          }),
        407 =>
          response("Token", "application/json", %Schema{
            type: :string,
            description: "Proxy Authentication Required"
          }),
        409 =>
          response("Token", "application/json", %Schema{
            type: :string,
            description: "Conflict"
          }),
        500 => response("Token", "application/json", ErrorResponse)
      }
    }
  end
end
