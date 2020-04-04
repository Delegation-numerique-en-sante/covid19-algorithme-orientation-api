defmodule Covid19QuestionnaireWeb.Operations.CreateQuestionnaire do
  @moduledoc """
  Open API CreateQuestionnaire operation.
  """

  import OpenApiSpex.Operation, only: [request_body: 4, response: 3]

  alias Covid19QuestionnaireWeb.Schemas.{
    ErrorResponse,
    QuestionnaireRequest,
    QuestionnaireResponse
  }

  alias OpenApiSpex.{Operation, Parameter, Schema}

  @type action :: :create
  @type operation :: Operation.t()

  @spec open_api_operation(action) :: operation

  def open_api_operation(:create) do
    call()
  end

  @spec call() :: operation

  def call do
    %Operation{
      summary: "Évaluer le test d'orientation du COVID19",
      description: "Évaluer le test d'orientation du COVID19",
      operationId: "QuestionnaireController.create",
      parameters: [
        %Parameter{
          name: :"x-token",
          in: :header,
          required: true,
          description: "Token to send the questionnaire",
          schema: %Schema{type: :string}
        }
      ],
      requestBody:
        request_body(
          "Paramètres du test d'orientation",
          "application/json",
          QuestionnaireRequest,
          required: true
        ),
      responses: %{
        201 => response("Questionnaire", "application/json", QuestionnaireResponse),
        305 => response("Questionnaire", "application/json", ErrorResponse),
        400 => response("Questionnaire", "application/json", ErrorResponse),
        401 => response("Questionnaire", "application/json", ErrorResponse),
        403 => response("Questionnaire", "application/json", ErrorResponse),
        407 => response("Questionnaire", "application/json", ErrorResponse),
        451 => response("Questionnaire", "application/json", ErrorResponse),
        500 => response("Questionnaire", "application/json", ErrorResponse)
      }
    }
  end
end
