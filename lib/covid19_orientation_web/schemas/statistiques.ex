defmodule Covid19OrientationWeb.Schemas.Statistiques do
  @moduledoc """
  Schéma des statistiques.
  """

  require OpenApiSpex
  alias OpenApiSpex.Schema

  OpenApiSpex.schema(%{
    title: "Statistiques",
    description:
      "https://github.com/Delegation-numerique-en-sante/covid19-algorithme-orientation/blob/master/implementation.org#conseils-pour-limpl%C3%A9mentation-de-lalgorithme",
    type: :object,
    properties: %{
      moins_de_15_ans: %Schema{type: :boolean, description: "Si la personne a moins de 15 ans"},
      moins_de_50_ans: %Schema{
        type: :boolean,
        description: "Si la personne a moins de 50 ans"
      },
      entre_50_et_69_ans: %Schema{
        type: :boolean,
        description: "Si la personne a entre 50 et 69 ans"
      },
      moins_de_70_ans: %Schema{
        type: :boolean,
        description: "Si la personne a moins de 70 ans"
      },
      au_moins_70_ans: %Schema{
        type: :boolean,
        description: "Si la personne a au moins de 70 ans"
      },
      au_moins_30_imc: %Schema{
        type: :boolean,
        description: "Si la personne a au moins 30 d'IMC en kg/m2"
      },
      fievre: %Schema{type: :boolean, description: "Indicateur de fièvre"},
      au_moins_39_de_temperature: %Schema{
        type: :boolean,
        description: "Si la personne a au moins 39°C de température"
      },
      cardiaque: %Schema{
        type: :boolean,
        description: "Si la personne a des problèms hypertension / cardiaques"
      },
      facteurs_gravite: %Schema{
        type: :integer,
        description: "Facteurs de gravité mineurs + majeurs"
      },
      facteurs_gravite_mineurs: %Schema{
        type: :integer,
        description: "Facteurs de gravité mineurs"
      },
      facteurs_gravite_majeurs: %Schema{
        type: :integer,
        description: "Facteurs de gravité majeurs"
      },
      facteurs_pronostique: %Schema{
        type: :integer,
        description: "Facteurs pronostique défavorables liés au terrain"
      }
    },
    required: [],
    example: %{
      "moins_de_15_ans" => false,
      "moins_de_50_ans" => false,
      "entre_50_et_69_ans" => false,
      "moins_de_70_ans" => false,
      "au_moins_70_ans" => true,
      "au_moins_30_imc" => true,
      "fievre" => true,
      "au_moins_39_de_temperature" => true,
      "cardiaque" => true,
      "facteurs_gravite" => 3,
      "facteurs_gravite_mineurs" => 2,
      "facteurs_gravite_majeurs" => 1,
      "facteurs_pronostique" => 1
    }
  })
end
