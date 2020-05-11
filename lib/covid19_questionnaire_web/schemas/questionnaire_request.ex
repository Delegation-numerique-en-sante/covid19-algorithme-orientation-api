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
          "form_version" => "2020-04-29",
          "algo_version" => "2020-04-29",
          "orientation" => "SAMU"
        },
        "respondent" => %{
          "age_range" => "sup_65",
          "imc" => 21.9,
          "postal_code" => "75000"
        },
        "symptoms" => %{
          "sore_throat_aches" => true,
          "temperature_cat" => "35.5-37.7",
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
          "heart_disease" => 1,
          "kidney_disease" => true,
          "liver_disease" => true,
          "diabetes" => true,
          "immunosuppressant_disease" => 1,
          "immunosuppressant_drug" => 1,
          "cancer" => true,
          "pregnant" => 1
        },
        "calculations" => %{
          "fever_algo" => true,
          "heart_disease_algo" => true,
          "immunosuppressant_disease_algo" => true,
          "immunosuppressant_drug_algo" => true
        }
      }
    }
  })
end
