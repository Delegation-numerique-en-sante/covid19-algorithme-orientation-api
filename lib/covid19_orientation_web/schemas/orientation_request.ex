defmodule Covid19OrientationWeb.Schemas.OrientationRequest do
  @moduledoc """
  Schéma de la requête pour lancer le algorithme d'orientation.
  """

  require OpenApiSpex
  alias Covid19OrientationWeb.Schemas.Orientation
  alias OpenApiSpex.Schema

  OpenApiSpex.schema(%{
    title: "OrientationRequest",
    description: "Corps de la requête POST pour lancer l'algorithme d'orientation",
    type: :object,
    properties: %{
      orientation: %Schema{anyOf: [Orientation]}
    },
    required: [:orientation],
    example: %{
      "orientation" => %{
        "symptomes" => %{
          "temperature" => 37.5,
          "toux" => true,
          "anosmie" => true,
          "mal_de_gorge" => true,
          "diarrhee" => true,
          "fatigue" => true,
          "diffs_alim_boire" => true,
          "essoufle" => true
        },
        "pronostiques" => %{
          "age" => 70,
          "poids" => 65.5,
          "taille" => 1.73,
          "cardiaque" => true,
          "diabetique" => true,
          "cancer" => true,
          "respiratoire" => true,
          "insuffisance_renale" => true,
          "maladie_chronique_foie" => true,
          "enceinte" => true,
          "immunodeprime" => true,
          "traitement_immunosuppresseur" => true
        },
        "supplementaires" => %{
          "code_postal" => "75000"
        }
      }
    }
  })
end
