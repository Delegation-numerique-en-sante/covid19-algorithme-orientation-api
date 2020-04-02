defmodule Covid19QuestionnaireWeb.Schemas.Statistiques do
  @moduledoc """
  Schéma des statistiques.
  """

  require OpenApiSpex
  alias OpenApiSpex.Schema

  OpenApiSpex.schema(%{
    title: "Statistiques",
    description:
      "[Statistiques](https://github.com/Delegation-numerique-en-sante/covid19-algorithme-questionnaire/blob/master/implementation.org#conseils-pour-limpl%C3%A9mentation-de-lalgorithme)",
    type: :object,
    properties: %{
      au_moins_30_imc: %Schema{
        type: :boolean,
        description: "Si la personne a au moins 30 d'IMC en kg/m2"
      },
      fever: %Schema{type: :boolean, description: "Indicateur de fièvre"},
      au_moins_39_de_temperature: %Schema{
        type: :boolean,
        description: "Si la personne a au moins 39°C de température"
      },
      heart_disease: %Schema{
        type: :boolean,
        description: "Si la personne a des problèmes d'hypertension / cardiaques"
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
    required: [
      :fever,
      :au_moins_39_de_temperature,
      :heart_disease,
      :facteurs_gravite,
      :facteurs_gravite_mineurs,
      :facteurs_gravite_majeurs,
      :facteurs_pronostique
    ],
    example: %{
      "fever" => true,
      "au_moins_39_de_temperature" => true,
      "heart_disease" => true,
      "facteurs_gravite" => 3,
      "facteurs_gravite_mineurs" => 2,
      "facteurs_gravite_majeurs" => 1,
      "facteurs_pronostique" => 1
    }
  })
end
