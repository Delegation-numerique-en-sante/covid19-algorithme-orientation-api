defmodule Covid19QuestionnaireWeb.Schemas.TokenResponse do
  @moduledoc """
  Schéma de la réponse de l'algorithme d'orientation.
  """

  require OpenApiSpex
  alias Covid19QuestionnaireWeb.Schemas.Token

  OpenApiSpex.schema(%{
    title: "TokenResponse",
    description: "TokenResponse",
    type: :object,
    properties: %{
      data: Token
    },
    example: %{
      "data" => %{
        "uuid" => "c9e77845-83cf-4891-88d6-804d659e81c5",
        "date" => "2020-03-29 15:20:11.875767Z"
      }
    }
  })
end
