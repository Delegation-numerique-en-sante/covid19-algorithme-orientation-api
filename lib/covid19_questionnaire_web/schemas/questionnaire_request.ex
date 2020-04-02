defmodule Covid19QuestionnaireWeb.Schemas.QuestionnaireRequest do
  @moduledoc """
  Schéma de la requête pour lancer le algorithme d'orientation.
  """

  require OpenApiSpex
  alias Covid19QuestionnaireWeb.Schemas.Questionnaire
  alias OpenApiSpex.Schema

  OpenApiSpex.schema(%{
    title: "QuestionnaireRequest",
    description: "Corps de la requête POST pour lancer l'algorithme d'orientation",
    type: :object,
    properties: %{
      questionnaire: %Schema{anyOf: [Questionnaire]}
    },
    required: [:questionnaire],
    example: %{
      "questionnaire" => %{
        "metadata" => %{
          "duration" => 3600
        },
        "patient" => %{
          "age_less_15" => false,
          "age_less_50" => false,
          "age_less_70" => false,
          "age_more_70" => true,
          "height" => 173,
          "weight" => 65.5,
          "postal_code" => "75000"
        },
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
      }
    }
  })
end
