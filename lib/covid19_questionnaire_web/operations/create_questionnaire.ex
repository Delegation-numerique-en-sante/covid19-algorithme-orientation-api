defmodule Covid19QuestionnaireWeb.Operations.CreateQuestionnaire do
  @moduledoc """
  Open API CreateQuestionnaire operation.
  """

  import OpenApiSpex.Operation, only: [request_body: 4, response: 3]
  alias Covid19QuestionnaireWeb.Schemas.{QuestionnaireRequest, QuestionnaireResponse}
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
      summary: "Évaluer le test d'orientation du COVID19",
      description: "Évaluer le test d'orientation du COVID19",
      operationId: "QuestionnaireController.create",
      requestBody:
        request_body(
          "Paramètres du test d'orientation",
          "application/json",
          QuestionnaireRequest,
          required: true
        ),
      responses: %{
        201 => response("Questionnaire", "application/json", QuestionnaireResponse)
      }
    }
  end
end
