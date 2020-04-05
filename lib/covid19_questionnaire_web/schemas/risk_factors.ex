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
      breathing_disease: %Schema{
        type: :boolean,
        description:
          "Avez-vous une maladie respiratoire ? Ou êtes-vous suivi par un pneumologue ?"
      },
      heart_disease: %Schema{
        type: :boolean,
        description:
          "Avez-vous une tension artérielle mal équilibrée ? Ou une maladie cardiaque ou vasculaire ? Ou prenez-vous un traitement à visée cardiologique ?"
      },
      kidney_disease: %Schema{
        type: :boolean,
        description: "Avez-vous une insuffisance rénale chronique dialysée ?"
      },
      liver_disease: %Schema{
        type: :boolean,
        description: "Avez-vous une maladie chronique du foie ?"
      },
      diabetes: %Schema{type: :boolean, description: "Êtes-vous diabétique ?"},
      immunosuppressant_disease: %Schema{
        type: :integer,
        enum: [0, 1, 999],
        description: "Avez-vous une maladie connue pour diminuer vos défenses immunitaires ?"
      },
      immunosuppressant_drug: %Schema{
        type: :integer,
        enum: [0, 1, 999],
        description: "Prenez-vous un traitement immunosuppresseur ?"
      },
      cancer: %Schema{type: :boolean, description: "Avez-vous ou avez-vous eu un cancer ?"},
      pregnant: %Schema{
        type: :integer,
        enum: [0, 1, 888],
        description: "Êtes-vous enceinte ?"
      }
    },
    example: %{
      "breathing_disease" => true,
      "heart_disease" => true,
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
