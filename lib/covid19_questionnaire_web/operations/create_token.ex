defmodule Covid19QuestionnaireWeb.Operations.CreateToken do
  @moduledoc """
  Open API CreateToken operation.
  """

  import OpenApiSpex.Operation, only: [response: 3]

  alias Covid19QuestionnaireWeb.Schemas.{ErrorResponse, TokenResponse}
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
      summary: "Create a token",
      description: "Create a token",
      operationId: "TokenController.create",
      responses: %{
        201 => response("Questionnaire", "application/json", TokenResponse),
        305 => response("Questionnaire", "application/json", ErrorResponse),
        400 => response("Questionnaire", "application/json", ErrorResponse),
        409 => response("Questionnaire", "application/json", ErrorResponse),
        500 => response("Questionnaire", "application/json", ErrorResponse)
      }
    }
  end
end
