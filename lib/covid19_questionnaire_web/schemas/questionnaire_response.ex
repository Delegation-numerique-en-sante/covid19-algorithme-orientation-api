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
        "metadata" => %{
          "form_version" => "2020-03-30 20:01:39.836837Z",
          "algo_version" => "2020-03-30 20:01:39.836837Z",
          "date" => "2020-03-29 15:20:11.875767Z",
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
        },
        "statistiques" => %{
          "au_moins_30_imc" => false,
          "fever" => false,
          "au_moins_39_de_temperature" => false,
          "heart_disease" => true,
          "facteurs_gravite" => 3,
          "facteurs_gravite_mineurs" => 1,
          "facteurs_gravite_majeurs" => 2,
          "facteurs_pronostique" => 10
        },
        "conclusion" => %{
          "code" => "FIN5"
        }
      }
    },
    "x-struct": __MODULE__
  })
end
