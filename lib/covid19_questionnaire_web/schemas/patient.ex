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
      age_range: %Schema{
        type: :string,
        enum: ["inf_15", "from_15_to_49", "from_50_to_69", "sup_70"],
        description: "Tranche d’âge"
      },
      height: %Schema{type: :integer, description: "Quelle est votre taille en centimètres ?"},
      weight: %Schema{type: :number, description: "Quel est votre poids en kilogrammes ?"},
      postal_code: %Schema{type: :string, description: "Le code postal"}
    },
    example: %{
      "age_range" => "sup_70",
      "height" => 173,
      "weight" => 65.5,
      "postal_code" => "75000"
    }
  })
end
