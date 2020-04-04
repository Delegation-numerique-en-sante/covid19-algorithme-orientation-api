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
          "date" => "2020-03-29 15:20:11.875767Z"
        },
        "metadata" => %{
          "form_version" => "2020-04-04T13:24:44.389249Z",
          "algo_version" => "2020-04-04T13:24:44.389249Z",
          "date" => "2020-04-04T13:24:44.389249Z",
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
          "immunosuppressant_disease" => true,
          "immunosuppressant_drug" => true,
          "cancer" => true,
          "pregnant" => 1
        },
        "calculations" => %{
          "bmi_more_30" => false,
          "fever" => false,
          "gravity_factors" => 3,
          "gravity_factors_minor" => 1,
          "gravity_factors_major" => 2,
          "risk_factors" => 9
        },
        "orientation" => %{
          "code" => "orientation_SAMU"
        }
      }
    }
  })
end
