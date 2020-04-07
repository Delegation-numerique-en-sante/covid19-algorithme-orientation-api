defmodule Covid19QuestionnaireWeb.Schemas.TokenResponse do
  @moduledoc """
  Schéma de la réponse de l'algorithme d'orientation.
  """

  require OpenApiSpex
  alias OpenApiSpex.Schema

  OpenApiSpex.schema(%{
    title: "TokenResponse",
    description: "TokenResponse",
    headers: [
      "x-token": %{
        description: "Token to send the questionnaire",
        schema: %Schema{type: :string, format: :uuid}
      }
    ]
  })
end
