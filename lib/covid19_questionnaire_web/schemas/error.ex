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
      code: %Schema{type: :integer, description: "HTTP status code"},
      info: %Schema{type: :string, description: "Explanation of what happened"},
      action: %Schema{type: :string, description: "Recommended action to fix/solve the problem"},
      stacktrace: %Schema{type: :object, description: "Additional information for developers"}
    },
    required: [:code, :info, :action],
    example: %{
      "code" => 500,
      "info" => "Oopsie, we don't know what happened!",
      "action" =>
        "Please open an issue https://github.com/Delegation-numerique-en-sante/covid19-algorithme-orientation-elixir/issues/new",
      "stacktrace" => %{
        "kind" => "Error, error!",
        "why" => "DKN! DKN!"
      }
    }
  })
end
