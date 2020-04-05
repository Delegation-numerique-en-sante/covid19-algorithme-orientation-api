defmodule Covid19QuestionnaireWeb.Schemas.QuestionnaireResponse do
  @moduledoc """
  Schéma de la réponse de l'algorithme d'orientation.
  """

  require OpenApiSpex
  alias Covid19QuestionnaireWeb.Schemas.Questionnaire

  OpenApiSpex.schema(%{
    title: "QuestionnaireResponse",
    description: "Réponse de l'algorithme d'orientation",
    type: :object,
    properties: %{
      data: Questionnaire
    },
    example: %{
      "data" => %{
        "token" => %{
          "uuid" => "c9e77845-83cf-4891-88d6-804d659e81c5",
          "date" => "2020-04-04T13:24:44.389249Z"
        },
        "metadata" => %{
          "form_version" => "2020-04-04T13:24:44.389249Z",
          "algo_version" => "2020-04-04T13:24:44.389249Z",
          "date" => "2020-04-04T13:24:44.389249Z",
          "duration" => 1
        },
        "patient" => %{
          "age_range" => "sup_70",
          "height" => 173,
          "weight" => 65.5,
          "postal_code" => "75000"
        },
        "symptoms" => %{
          "sore_throat_aches" => true,
          "fever" => 999,
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
          "heart_disease" => true,
          "kidney_disease" => true,
          "liver_disease" => true,
          "diabetes" => true,
          "immunosuppressant_disease" => 1,
          "immunosuppressant_drug" => 1,
          "cancer" => true,
          "pregnant" => 1
        },
        "calculations" => %{
          "bmi_more_30" => true,
          "bmi" => 21.9,
          "imc" => 21.9,
          "fever_algo" => true,
          "hearth_desease_algo" => true,
          "immunosuppressant_disease_algo" => true,
          "immunosuppressant_drug_algo" => true,
          "gravity_factors" => 3,
          "gravity_factors_minor" => 2,
          "gravity_factors_major" => 1,
          "risk_factors" => 1
        },
        "orientation" => %{
          "code" => "orientation_SAMU"
        }
      }
    }
  })
end
