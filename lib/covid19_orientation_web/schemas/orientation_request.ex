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
          "agueusia_anosmia" => true,
          "sore_throat_aches" => true,
          "diarrhea" => true,
          "tiredness" => true,
          "feeding" => true,
          "breathlessness" => true
        },
        "pronostiques" => %{
          "age" => 70,
          "weight" => 65.5,
          "height" => 1.73,
          "heart_disease" => true,
          "diabetes" => true,
          "cancer" => true,
          "breathing_disease" => true,
          "kidney_disease" => true,
          "liver_disease" => true,
          "pregnant" => true,
          "immunodeprime" => true,
          "immunosuppressant_drug" => true
        },
        "supplementaires" => %{
          "code_postal" => "75000"
        }
      }
    }
  })
end
