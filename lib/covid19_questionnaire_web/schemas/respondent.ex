defmodule Covid19QuestionnaireWeb.Schemas.Respondent do
  @moduledoc """
  Caractéristiques du respondent.
  """

  require OpenApiSpex
  alias OpenApiSpex.Schema

  OpenApiSpex.schema(%{
    title: "Respondent",
    description:
      "[Caractéristiques du respondent](https://docs.google.com/spreadsheets/d/1Ne7QEp_oMHRxxYhqT56AWugfTaywu-cNRZsWPrMGvkY/edit#gid=0)",
    type: :object,
    properties: %{
      age_range: %Schema{
        type: :string,
        enum: ["inf_15", "from_15_to_49", "from_50_to_64", "sup_65"],
        description: "Tranche d’âge"
      },
      imc: %Schema{type: :number, description: "IMC de la personne en kg/(cm/100)2"},
      postal_code: %Schema{type: :string, description: "Le code postal"}
    },
    example: %{
      "age_range" => "sup_65",
      "imc" => 21.9,
      "postal_code" => "75000"
    }
  })
end
