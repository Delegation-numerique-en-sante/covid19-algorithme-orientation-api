defmodule Covid19QuestionnaireWeb.Schemas.Token do
  @moduledoc """
  Token.
  """

  require OpenApiSpex
  alias OpenApiSpex.Schema

  OpenApiSpex.schema(%{
    title: "Token",
    description: "Token",
    type: :object,
    properties: %{
      uuid: %Schema{type: :string, description: "UUID du token", format: :uuid},
      date: %Schema{type: :string, description: "Date de crátion du token", format: :"date-time"}
    },
    example: %{
      "uuid" => "c9e77845-83cf-4891-88d6-804d659e81c5",
      "date" => "2020-04-29T13:24:44.389249Z"
    }
  })
end
