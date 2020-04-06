defmodule Covid19QuestionnaireWeb.Schemas.Error do
  @moduledoc """
  Generic Error.
  """

  require OpenApiSpex
  alias OpenApiSpex.Schema

  OpenApiSpex.schema(%{
    title: "Error",
    description: "Something bad happened!",
    type: :object,
    properties: %{
      title: %Schema{type: :string, description: "What happened"},
      source: %Schema{type: :object, description: "Where did that happen"},
      message: %Schema{type: :string, description: "Explanation of what happened"}
    },
    required: [:title, :source, :message],
    example: %{
      "message" =>
        "Failed to cast value using any of: Schema(title: \"Questionnaire\", type: :object)",
      "source" => %{"pointer" => "/questionnaire"},
      "title" => "Invalid value"
    }
  })
end
