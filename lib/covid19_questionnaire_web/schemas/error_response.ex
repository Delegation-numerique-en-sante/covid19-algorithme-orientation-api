defmodule Covid19QuestionnaireWeb.Schemas.ErrorResponse do
  @moduledoc """
  Generic error response.
  """

  require OpenApiSpex
  alias Covid19QuestionnaireWeb.Schemas.Error
  alias OpenApiSpex.Schema

  OpenApiSpex.schema(%{
    title: "ErrorResponse",
    description: "Something bad happened!",
    type: :object,
    properties: %{
      error: %Schema{type: :array, items: %Schema{anyOf: [Error]}}
    },
    example: %{
      "errors" => [
        %{
          "message" =>
            "Failed to cast value using any of: Schema(title: \"Questionnaire\", type: :object)",
          "source" => %{"pointer" => "/questionnaire"},
          "title" => "Invalid value"
        }
      ]
    }
  })
end
