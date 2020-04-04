defmodule Covid19QuestionnaireWeb.Schemas.Patient do
  @moduledoc """
  Caractéristiques du patient.
  """

  require OpenApiSpex
  alias OpenApiSpex.Schema

  OpenApiSpex.schema(%{
    title: "Patient",
    description:
      "[Caractéristiques du patient](https://docs.google.com/spreadsheets/d/1Ne7QEp_oMHRxxYhqT56AWugfTaywu-cNRZsWPrMGvkY/edit#gid=0)",
    type: :object,
    properties: %{
      age_less_15: %Schema{type: :boolean, description: "Si la personne a moins de 15 ans"},
      age_less_50: %Schema{
        type: :boolean,
        description: "Si la personne a moins de 50 ans"
      },
      age_less_70: %Schema{
        type: :boolean,
        description: "Si la personne a moins de 70 ans"
      },
      age_more_70: %Schema{
        type: :boolean,
        description: "Si la personne a au moins 70 ans"
      },
      height: %Schema{type: :integer, description: "Quelle est votre taille en centimètres ?"},
      weight: %Schema{type: :number, description: "Quel est votre poids en kilogrammes ?"},
      postal_code: %Schema{type: :string, description: "Code postal"}
    },
    example: %{
      "age_less_15" => false,
      "age_less_50" => false,
      "age_less_70" => false,
      "age_more_70" => true,
      "height" => 173,
      "weight" => 65.5,
      "postal_code" => "75000"
    }
  })
end
