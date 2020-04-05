defmodule Covid19QuestionnaireWeb.Schemas.Calculations do
  @moduledoc """
  Schéma des calculs faits par l'API.
  """

  require OpenApiSpex
  alias OpenApiSpex.Schema

  OpenApiSpex.schema(%{
    title: "Calculations",
    description:
      "[Calculations](https://github.com/Delegation-numerique-en-sante/covid19-algorithme-questionnaire/blob/master/implementation.org#conseils-pour-limpl%C3%A9mentation-de-lalgorithme)",
    type: :object,
    properties: %{
      age_less_15: %Schema{type: :boolean, description: "Si la personne a age_less_15"},
      age_less_50: %Schema{type: :boolean, description: "Si la personne a age_less_50"},
      age_less_70: %Schema{type: :boolean, description: "Si la personne a age_less_70"},
      age_more_15: %Schema{type: :boolean, description: "Si la personne a age_more_15"},
      age_more_50: %Schema{type: :boolean, description: "Si la personne a age_more_50"},
      age_more_70: %Schema{type: :boolean, description: "Si la personne a age_more_70"},
      bmi_less_30: %Schema{type: :boolean, description: "Moins 30 d'IMC en kg/(cm/100)2"},
      bmi_more_30: %Schema{type: :boolean, description: "Au moins 30 d'IMC en kg/(cm/100)2"},
      bmi: %Schema{type: :number, description: "BMI de la personne en kg/(cm/100)2"},
      bmi_algo: %Schema{type: :number, description: "BMI de la personne en kg/(cm/100)2"},
      imc: %Schema{type: :number, description: "IMC de la personne en kg/(cm/100)2"},
      imc_algo: %Schema{type: :number, description: "IMC de la personne en kg/(cm/100)2"},
      pregnant_algo: %Schema{type: :boolean, description: "Si la personne est enceinte"},
      fever_algo: %Schema{type: :boolean, description: "Si la personne a de la fièvre"},
      heart_disease_algo: %Schema{type: :boolean, description: "Maladie cardiaque"},
      immunosuppressant_disease_algo: %Schema{
        type: :boolean,
        description: "Maladie défenses immunitaires"
      },
      immunosuppressant_drug_algo: %Schema{
        type: :boolean,
        description: "Traitement immunodépresseur"
      },
      symptoms1: %Schema{type: :boolean, description: "Fièvre ET toux"},
      symptoms2: %Schema{
        type: :boolean,
        description:
          "Fièvre OU (pas de fièvre et (diarrhée OU (toux ET douleurs) OU (toux ET anosmie))"
      },
      symptoms3: %Schema{type: :boolean, description: "Toux OU douleurs OU anosmie"},
      symptoms4: %Schema{type: :boolean, description: "NI toux NI douleurs NI anosmie"},
      gravity_factors: %Schema{
        type: :integer,
        description: "Facteurs de gravité mineurs + majeurs"
      },
      gravity_factors_minor: %Schema{type: :integer, description: "Facteurs de gravité mineurs"},
      gravity_factors_major: %Schema{type: :integer, description: "Facteurs de gravité majeurs"},
      risk_factors: %Schema{
        type: :integer,
        description: "Facteurs pronostique défavorables liés au terrain"
      }
    },
    required: [
      :age_less_15,
      :age_less_50,
      :age_less_70,
      :age_more_15,
      :age_more_50,
      :age_more_70,
      :bmi_less_30,
      :bmi_more_30,
      :bmi,
      :bmi_algo,
      :imc,
      :imc_algo,
      :pregnant_algo,
      :fever_algo,
      :heart_disease_algo,
      :immunosuppressant_disease_algo,
      :immunosuppressant_drug_algo,
      :symptoms1,
      :symptoms2,
      :symptoms3,
      :symptoms4,
      :gravity_factors,
      :gravity_factors_minor,
      :gravity_factors_major,
      :risk_factors
    ],
    example: %{
      "age_less_15" => true,
      "age_less_50" => true,
      "age_less_70" => true,
      "age_more_15" => true,
      "age_more_50" => true,
      "age_more_70" => true,
      "bmi_less_30" => true,
      "bmi_more_30" => true,
      "bmi" => 21.9,
      "bmi_algo" => 21.9,
      "imc" => 21.9,
      "imc_algo" => 21.9,
      "pregnant_algo" => true,
      "fever_algo" => true,
      "heart_disease_algo" => true,
      "immunosuppressant_disease_algo" => true,
      "immunosuppressant_drug_algo" => true,
      "symptoms1" => true,
      "symptoms2" => true,
      "symptoms3" => true,
      "symptoms4" => true,
      "gravity_factors" => 3,
      "gravity_factors_minor" => 2,
      "gravity_factors_major" => 1,
      "risk_factors" => 1
    }
  })
end
