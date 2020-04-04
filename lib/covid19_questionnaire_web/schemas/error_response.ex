defmodule Covid19QuestionnaireWeb.Schemas.ErrorResponse do
  @moduledoc """
  Generic error response.
  """

  require OpenApiSpex
  alias Covid19QuestionnaireWeb.Schemas.Error

  OpenApiSpex.schema(%{
    title: "ErrorResponse",
    description: "Something bad happened!",
    type: :object,
    properties: %{
      error: Error
    },
    example: %{
      "error" => %{
        "code" => 500,
        "info" => "Oopsie, we don't know what happened!",
        "action" =>
          "Please open an issue https://github.com/Delegation-numerique-en-sante/covid19-algorithme-orientation-elixir/issues/new",
        "stacktrace" => %{
          "kind" => "Error, error!",
          "why" => "DKN! DKN!"
        }
      }
    }
  })
end
