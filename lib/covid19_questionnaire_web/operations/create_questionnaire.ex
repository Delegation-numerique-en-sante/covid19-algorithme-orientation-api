defmodule Covid19QuestionnaireWeb.Operations.CreateQuestionnaire do
  @moduledoc """
  Open API CreateQuestionnaire operation.
  """

  import OpenApiSpex.Operation, only: [request_body: 4, response: 3]

  alias Covid19QuestionnaireWeb.Schemas.{ErrorResponse, QuestionnaireRequest}

  alias OpenApiSpex.{Operation, Parameter, Schema}

  @type action :: :create
  @type operation :: Operation.t()

  @spec open_api_operation(action) :: operation

  def open_api_operation(:create), do: call()
  def open_api_operation(_), do: nil

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
        202 =>
          response("Questionnaire", "application/json", %Schema{
            type: :string,
            description: "Accepted"
          }),
        400 =>
          response("Questionnaire", "application/json", %Schema{
            type: :string,
            description: "Bad Request"
          }),
        401 =>
          response("Questionnaire", "application/json", %Schema{
            type: :string,
            description: "Unauthorized"
          }),
        403 =>
          response("Questionnaire", "application/json", %Schema{
            type: :string,
            description: "Forbidden"
          }),
        407 =>
          response("Questionnaire", "application/json", %Schema{
            type: :string,
            description: "Proxy Authentication Required"
          }),
        422 =>
          response("Questionnaire", "application/json", %Schema{
            type: :string,
            description: "Unprocessable Entity"
          }),
        451 =>
          response("Questionnaire", "application/json", %Schema{
            type: :string,
            description: "Unavailable For Legal Reasons"
          }),
        500 => response("Questionnaire", "application/json", ErrorResponse)
      }
    }
  end
end
