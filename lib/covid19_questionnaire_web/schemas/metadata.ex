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
        description: "Version du formulaire",
        format: :"date-time"
      },
      algo_version: %Schema{
        type: :string,
        description: "Version de l’algorithme",
        format: :"date-time"
      },
      date: %Schema{type: :string, description: "Date de saisie", format: :"date-time"},
      duration: %Schema{type: :integer, description: "Durée de saisie en secondes"}
    },
    required: [:form_version, :algo_version],
    example: %{
      "form_version" => "2020-04-04T13:24:44.389249Z",
      "algo_version" => "2020-04-04T13:24:44.389249Z",
      "date" => "2020-04-04T13:24:44.389249Z",
      "duration" => 3600
    }
  })
end
