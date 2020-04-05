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
      fever_algo: %Schema{type: :boolean, description: "Si la personne a de la fièvre"},
      heart_disease_algo: %Schema{type: :boolean, description: "Maladie cardiaque"},
      immunosuppressant_disease_algo: %Schema{
        type: :boolean,
        description: "Maladie défenses immunitaires"
      },
      immunosuppressant_drug_algo: %Schema{
        type: :boolean,
        description: "Traitement immunodépresseur"
      }
    },
    example: %{
      "fever_algo" => true,
      "heart_disease_algo" => true,
      "immunosuppressant_disease_algo" => true,
      "immunosuppressant_drug_algo" => true
    }
  })
end
