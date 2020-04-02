defmodule Covid19QuestionnaireWeb.Schemas.Pronostiques do
  @moduledoc """
  Schéma des questions sur les facteurs pronostiques défavorables au terrain.
  """

  require OpenApiSpex
  alias OpenApiSpex.Schema

  OpenApiSpex.schema(%{
    title: "Pronostiques",
    description:
      "[Questions sur les facteurs pronostiques défavorables au terrain](https://github.com/Delegation-numerique-en-sante/covid19-algorithme-questionnaire/blob/master/pseudo-code.org#questions-sur-les-facteurs-pronostiques-d%C3%A9favorables-au-terrain)",
    type: :object,
    properties: %{
      heart_disease: %Schema{
        type: :boolean,
        description:
          "Avez-vous une tension artérielle mal équilibrée ? Ou une maladie cardiaque ou vasculaire ? Ou prenez-vous un traitement à visée cardiologique ?"
      },
      diabetes: %Schema{type: :boolean, description: "Êtes-vous diabétique ?"},
      cancer: %Schema{type: :boolean, description: "Avez-vous ou avez-vous eu un cancer ?"},
      breathing_disease: %Schema{
        type: :boolean,
        description:
          "Avez-vous une maladie respiratoire ? Ou êtes-vous suivi par un pneumologue ?"
      },
      kidney_disease: %Schema{
        type: :boolean,
        description: "Avez-vous une insuffisance rénale chronique dialysée ?"
      },
      liver_disease: %Schema{
        type: :boolean,
        description: "Avez-vous une maladie chronique du foie ?"
      },
      pregnant: %Schema{type: :boolean, description: "Êtes-vous enceinte ?"},
      immunodeprime: %Schema{
        type: :boolean,
        description: "Avez-vous une maladie connue pour diminuer vos défenses immunitaires ?"
      },
      immunosuppressant_drug: %Schema{
        type: :boolean,
        description: "Prenez-vous un traitement immunosuppresseur ?"
      }
    },
    example: %{
      "heart_disease" => true,
      "diabetes" => true,
      "cancer" => true,
      "breathing_disease" => true,
      "kidney_disease" => true,
      "liver_disease" => true,
      "pregnant" => true,
      "immunodeprime" => true,
      "immunosuppressant_drug" => true
    }
  })
end
