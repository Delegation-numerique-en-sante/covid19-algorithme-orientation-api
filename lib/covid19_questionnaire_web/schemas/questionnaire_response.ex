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
        "statistiques" => %{
          "moins_de_15_ans" => false,
          "moins_de_50_ans" => false,
          "au_moins_50_ans" => true,
          "moins_de_70_ans" => false,
          "entre_50_et_69_ans" => false,
          "au_moins_70_ans" => true,
          "au_moins_30_imc" => false,
          "fever" => false,
          "au_moins_39_de_temperature" => false,
          "heart_disease" => true,
          "facteurs_gravite" => 3,
          "facteurs_gravite_mineurs" => 1,
          "facteurs_gravite_majeurs" => 2,
          "facteurs_pronostique" => 10
        },
        "supplementaires" => %{
          "postal_code" => "75000"
        },
        "conclusion" => %{
          "code" => "FIN5"
        }
      }
    },
    "x-struct": __MODULE__
  })
end
