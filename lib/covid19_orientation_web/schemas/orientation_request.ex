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
          "cough" => true,
          "anosmia" => true,
          "mal_de_gorge" => true,
          "diarrhee" => true,
          "fatigue" => true,
          "diffs_alim_boire" => true,
          "breathlessness" => true
        },
        "pronostiques" => %{
          "age" => 70,
          "weight" => 65.5,
          "height" => 1.73,
          "cardiaque" => true,
          "diabetique" => true,
          "cancer" => true,
          "breathing_disease" => true,
          "insuffisance_renale" => true,
          "liver_disease" => true,
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
