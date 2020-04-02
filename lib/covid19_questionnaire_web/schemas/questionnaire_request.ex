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
          "postal_code" => "75000"
        }
      }
    }
  })
end
