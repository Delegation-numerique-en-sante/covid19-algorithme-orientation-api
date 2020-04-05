defmodule Covid19QuestionnaireWeb.Schemas.RiskFactors do
  @moduledoc """
  Schéma des questions sur les facteurs risk_factors défavorables au terrain.
  """

  require OpenApiSpex
  alias OpenApiSpex.Schema

  OpenApiSpex.schema(%{
    title: "RiskFactors",
    description:
      "[Questions sur les facteurs risk_factors défavorables au terrain](https://github.com/Delegation-numerique-en-sante/covid19-algorithme-questionnaire/blob/master/pseudo-code.org#questions-sur-les-facteurs-risk_factors-d%C3%A9favorables-au-terrain)",
    type: :object,
    properties: %{
      breathing_disease: %Schema{type: :boolean, description: "Maladie respiratoire"},
      heart_disease: %Schema{type: :integer, enum: [0, 1, 999], description: "Maladie cardiaque"},
      kidney_disease: %Schema{type: :boolean, description: "Insuffisance rénale"},
      liver_disease: %Schema{type: :boolean, description: "Maladie chronique du foie"},
      diabetes: %Schema{type: :boolean, description: "Diabète"},
      immunosuppressant_disease: %Schema{
        type: :integer,
        enum: [0, 1, 999],
        description: "Maladie défenses immunitaires"
      },
      immunosuppressant_drug: %Schema{
        type: :integer,
        enum: [0, 1, 999],
        description: "Traitement immunodépresseur"
      },
      cancer: %Schema{type: :boolean, description: "Cancer actuel ou < moins de 3 ans"},
      pregnant: %Schema{type: :integer, enum: [0, 1, 888], description: "Enceinte"}
    },
    example: %{
      "breathing_disease" => true,
      "heart_disease" => 1,
      "kidney_disease" => true,
      "liver_disease" => true,
      "diabetes" => true,
      "immunosuppressant_disease" => 1,
      "immunosuppressant_drug" => 1,
      "cancer" => true,
      "pregnant" => 1
    }
  })
end
