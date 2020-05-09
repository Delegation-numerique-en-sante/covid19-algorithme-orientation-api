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
        format: :date
      },
      algo_version: %Schema{
        type: :string,
        description: "Version de l’algorithme",
        format: :date
      },
      date: %Schema{type: :string, description: "Date de saisie", format: :"date-time"},
      duration: %Schema{type: :integer, description: "Durée de saisie en secondes"},
      orientation: %Schema{
        type: :string,
        enum: [
          "less_15",
          "home_surveillance",
          "consultation_surveillance_1",
          "consultation_surveillance_2",
          "SAMU",
          "consultation_surveillance_3",
          "consultation_surveillance_4",
          "surveillance"
        ],
        description:
          "[Orientations possibles](https://github.com/Delegation-numerique-en-sante/covid19-algorithme-orientation/blob/master/implementation.org#variables-qui-correspondent-%C3%A0-lorientation-affich%C3%A9e)"
      }
    },
    required: [:form_version, :algo_version],
    example: %{
      "form_version" => "2020-04-29",
      "algo_version" => "2020-04-29",
      "date" => "2020-04-29T13:24:44.389249Z",
      "duration" => 3600,
      "orientation" => "SAMU"
    }
  })
end
