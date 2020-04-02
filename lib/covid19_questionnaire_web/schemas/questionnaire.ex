defmodule Covid19QuestionnaireWeb.Schemas.Questionnaire do
  @moduledoc """
  Schéma de l'algorithme d'orientation du Covid-19.
  """

  require OpenApiSpex

  alias Covid19QuestionnaireWeb.Schemas.{
    Conclusion,
    Metadata,
    Patient,
    Pronostiques,
    Statistiques,
    Symptoms
  }

  OpenApiSpex.schema(%{
    title: "Questionnaire",
    description:
      "[Algorithme d'orientation du Covid-19](https://github.com/Delegation-numerique-en-sante/covid19-algorithme-questionnaire/blob/master/pseudo-code.org#pr%C3%A9sentation-de-lalgorithme-dquestionnaire-covid19)",
    type: :object,
    properties: %{
      metadata: Metadata,
      patient: Patient,
      symptoms: Symptoms,
      pronostiques: Pronostiques,
      conclusion: Conclusion,
      statistiques: Statistiques
    },
    required: [:metadata, :patient, :symptoms, :pronostiques],
    example: %{
      "metadata" => %{
        "form_version" => "2020-03-29 15:20:11.875767Z",
        "algo_version" => "2020-03-29 15:20:11.875767Z",
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
        "au_moins_30_imc" => true,
        "fever" => true,
        "au_moins_39_de_temperature" => true,
        "heart_disease" => true,
        "facteurs_gravite" => 3,
        "facteurs_gravite_mineurs" => 2,
        "facteurs_gravite_majeurs" => 1,
        "facteurs_pronostique" => 1
      },
      "conclusion" => %{
        "code" => "orientation_SAMU"
      }
    }
  })
end
