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
          "orientation_moins_de_15_ans",
          "orientation_domicile_surveillance_1",
          "orientation_consultation_surveillance_1",
          "orientation_consultation_surveillance_2",
          "orientation_SAMU",
          "orientation_consultation_surveillance_3",
          "orientation_consultation_surveillance_4",
          "orientation_surveillance"
        ],
        description:
          "[Orientations possibles](https://github.com/Delegation-numerique-en-sante/covid19-algorithme-questionnaire/blob/master/pseudo-code.org#conclusions-possibles)"
      }
    },
    required: [:form_version, :algo_version],
    example: %{
      "form_version" => "2020-04-04",
      "algo_version" => "2020-04-04",
      "date" => "2020-04-04T13:24:44.389249Z",
      "duration" => 3600,
      "orientation" => "orientation_SAMU"
    }
  })
end
