defmodule Covid19QuestionnaireWeb.Schemas.Questionnaire do
  @moduledoc """
  Schéma de l'algorithme d'orientation du Covid-19.
  """

  require OpenApiSpex

  alias Covid19QuestionnaireWeb.Schemas.{
    Conclusion,
    Metadata,
    Pronostiques,
    Statistiques,
    Supplementaires,
    Symptomes
  }

  OpenApiSpex.schema(%{
    title: "Questionnaire",
    description:
      "[Algorithme d'orientation du Covid-19](https://github.com/Delegation-numerique-en-sante/covid19-algorithme-questionnaire/blob/master/pseudo-code.org#pr%C3%A9sentation-de-lalgorithme-dquestionnaire-covid19)",
    type: :object,
    properties: %{
      metadata: Metadata,
      symptomes: Symptomes,
      pronostiques: Pronostiques,
      supplementaires: Supplementaires,
      conclusion: Conclusion,
      statistiques: Statistiques
    },
    required: [:metadata, :symptomes, :pronostiques, :supplementaires],
    example: %{
      "metadata" => %{
        "form_version" => "2020-03-29 15:20:11.875767Z",
        "algo_version" => "2020-03-29 15:20:11.875767Z",
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
        "au_moins_50_ans" => false,
        "entre_50_et_69_ans" => false,
        "moins_de_70_ans" => false,
        "au_moins_70_ans" => true,
        "au_moins_30_imc" => true,
        "fever" => true,
        "au_moins_39_de_temperature" => true,
        "heart_disease" => true,
        "facteurs_gravite" => 3,
        "facteurs_gravite_mineurs" => 2,
        "facteurs_gravite_majeurs" => 1,
        "facteurs_pronostique" => 1
      },
      "supplementaires" => %{
        "postal_code" => "75000"
      },
      "conclusion" => %{
        "code" => "orientation_SAMU"
      }
    }
  })
end
