defmodule Covid19OrientationWeb.Schemas.Pronostiques do
  @moduledoc """
  Schéma des questions sur les facteurs pronostiques défavorables au terrain.
  """

  require OpenApiSpex
  alias OpenApiSpex.Schema

  OpenApiSpex.schema(%{
    title: "Pronostiques",
    description:
      "[Questions sur les facteurs pronostiques défavorables au terrain](https://github.com/Delegation-numerique-en-sante/covid19-algorithme-orientation/blob/master/pseudo-code.org#questions-sur-les-facteurs-pronostiques-d%C3%A9favorables-au-terrain)",
    type: :object,
    properties: %{
      age: %Schema{type: :integer, description: "Quel est votre âge ?"},
      weight: %Schema{type: :number, description: "Quel est votre poids en kilogrammes ?"},
      height: %Schema{type: :number, description: "Quelle est votre taille en mètres ?"},
      cardiaque: %Schema{
        type: :boolean,
        description:
          "Avez-vous une tension artérielle mal équilibrée ? Ou une maladie cardiaque ou vasculaire ? Ou prenez-vous un traitement à visée cardiologique ?"
      },
      diabetique: %Schema{type: :boolean, description: "Êtes-vous diabétique ?"},
      cancer: %Schema{type: :boolean, description: "Avez-vous ou avez-vous eu un cancer ?"},
      respiratoire: %Schema{
        type: :boolean,
        description:
          "Avez-vous une maladie respiratoire ? Ou êtes-vous suivi par un pneumologue ?"
      },
      insuffisance_renale: %Schema{
        type: :boolean,
        description: "Avez-vous une insuffisance rénale chronique dialysée ?"
      },
      maladie_chronique_foie: %Schema{
        type: :boolean,
        description: "Avez-vous une maladie chronique du foie ?"
      },
      enceinte: %Schema{type: :boolean, description: "Êtes-vous enceinte ?"},
      immunodeprime: %Schema{
        type: :boolean,
        description: "Avez-vous une maladie connue pour diminuer vos défenses immunitaires ?"
      },
      traitement_immunosuppresseur: %Schema{
        type: :boolean,
        description: "Prenez-vous un traitement immunosuppresseur ?"
      }
    },
    example: %{
      "age" => 70,
      "weight" => 65.5,
      "height" => 1.73,
      "cardiaque" => true,
      "diabetique" => true,
      "cancer" => true,
      "respiratoire" => true,
      "insuffisance_renale" => true,
      "maladie_chronique_foie" => true,
      "enceinte" => true,
      "immunodeprime" => true,
      "traitement_immunosuppresseur" => true
    }
  })
end
