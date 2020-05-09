defmodule Covid19QuestionnaireWeb.Schemas.Questionnaire do
  @moduledoc """
  Schéma de l'algorithme d'orientation du COVID19.
  """

  require OpenApiSpex

  alias Covid19QuestionnaireWeb.Schemas.{
    Calculations,
    Metadata,
    Respondent,
    RiskFactors,
    Symptoms,
    Token
  }

  OpenApiSpex.schema(%{
    title: "Questionnaire",
    description:
      "[Algorithme d'orientation du COVID19](https://github.com/Delegation-numerique-en-sante/covid19-algorithme-questionnaire/blob/master/pseudo-code.org#pr%C3%A9sentation-de-lalgorithme-dquestionnaire-covid19)",
    type: :object,
    properties: %{
      token: Token,
      metadata: Metadata,
      respondent: Respondent,
      symptoms: Symptoms,
      risk_factors: RiskFactors,
      calculations: Calculations
    },
    required: [:metadata, :respondent, :symptoms, :risk_factors, :calculations],
    example: %{
      "token" => %{
        "uuid" => "c9e77845-83cf-4891-88d6-804d659e81c5",
        "date" => "2020-03-29 15:20:11.875767Z"
      },
      "metadata" => %{
        "form_version" => "2020-04-29",
        "algo_version" => "2020-04-29",
        "date" => "2020-04-29T13:24:44.389249Z",
        "duration" => 3600,
        "orientation" => "SAMU"
      },
      "respondent" => %{
        "age_range" => "sup_70",
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
  })
end
