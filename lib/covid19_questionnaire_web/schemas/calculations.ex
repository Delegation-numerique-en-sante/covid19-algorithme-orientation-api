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
      bmi_more_30: %Schema{
        type: :boolean,
        description: "Si la personne a au moins 30 d'IMC en kg/(cm/100)2"
      },
      bmi: %Schema{type: :number, description: "BMI"},
      imc: %Schema{type: :number, description: "IMC"},
      fever_algo: %Schema{type: :boolean, description: "Indicateur de fièvre"},
      hearth_desease_algo: %Schema{
        type: :boolean,
        description: "Indicateur de problèmes cardiaques"
      },
      immunosuppressant_disease_algo: %Schema{
        type: :boolean,
        description: "Indicateur de maladie immuno-déprimante"
      },
      immunosuppressant_drug_algo: %Schema{
        type: :boolean,
        description: "Indicateur de traiment immuno-déprimant"
      },
      gravity_factors: %Schema{
        type: :integer,
        description: "Facteurs de gravité mineurs + majeurs"
      },
      gravity_factors_minor: %Schema{
        type: :integer,
        description: "Facteurs de gravité mineurs"
      },
      gravity_factors_major: %Schema{
        type: :integer,
        description: "Facteurs de gravité majeurs"
      },
      risk_factors: %Schema{
        type: :integer,
        description: "Facteurs pronostique défavorables liés au terrain"
      }
    },
    required: [
      :bmi_more_30,
      :bmi,
      :imc,
      :fever_algo,
      :hearth_desease_algo,
      :immunosuppressant_disease_algo,
      :immunosuppressant_drug_algo,
      :gravity_factors,
      :gravity_factors_minor,
      :gravity_factors_major,
      :risk_factors
    ],
    example: %{
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
    }
  })
end
