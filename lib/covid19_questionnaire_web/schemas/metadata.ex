defmodule Covid19QuestionnaireWeb.Schemas.Metadata do
  @moduledoc """
  Caractéristiques du questionnaire.
  """

  require OpenApiSpex
  alias OpenApiSpex.Schema

  OpenApiSpex.schema(%{
    title: "Metadata",
    description:
      "[Caractéristiques du questionnaire](https://docs.google.com/spreadsheets/d/1Ne7QEp_oMHRxxYhqT56AWugfTaywu-cNRZsWPrMGvkY/edit#gid=0)",
    type: :object,
    properties: %{
      form_version: %Schema{
        type: :string,
        description: "Version du questionnaire",
        format: :"date-time"
      },
      algo_version: %Schema{
        type: :string,
        description: "Version de l'algorithme médical",
        format: :"date-time"
      },
      date: %Schema{
        type: :string,
        description: "Date de fin de remplissage du questionnaire",
        format: :"date-time"
      },
      duration: %Schema{
        type: :integer,
        description: "Durée de remplissage du questionnaire (seconds)"
      }
    },
    required: [:duration],
    example: %{
      "form_version" => "2020-03-29 15:20:11.875767Z",
      "algo_version" => "2020-03-29 15:20:11.875767Z",
      "date" => "2020-03-29 15:20:11.875767Z",
      "duration" => 3600
    }
  })
end
