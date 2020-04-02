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
        "symptoms" => %{
          "sore_throat_aches" => true,
          "fever" => false,
          "temperature_cat" => "[35.5, 35.7]",
          "agueusia_anosmia" => true,
          "breathlessness" => true,
          "cough" => true,
          "diarrhea" => true,
          "tiredness" => true,
          "tiredness_details" => true,
          "feeding_day" => true
        },
        "risk_factors" => %{
          "breathing_disease" => true,
          "heart_disease" => true,
          "kidney_disease" => true,
          "liver_disease" => true,
          "diabetes" => true,
          "immunosuppressant_disease" => true,
          "immunosuppressant_drug" => true,
          "cancer" => true,
          "pregnant" => "1"
        }
      }
    }
  })
end
