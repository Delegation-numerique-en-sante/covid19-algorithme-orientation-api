defmodule Covid19QuestionnaireWeb.Schemas.Symptoms do
  @moduledoc """
  Schéma des questions sur les symptômes.
  """

  require OpenApiSpex
  alias OpenApiSpex.Schema

  OpenApiSpex.schema(%{
    title: "Symptoms",
    description:
      "[Questions sur les symptômes](https://github.com/Delegation-numerique-en-sante/covid19-algorithme-questionnaire/blob/master/pseudo-code.org#questions-sur-les-sympt%C3%B4mes)",
    type: :object,
    properties: %{
      sore_throat_aches: %Schema{type: :boolean, description: "Mal de gorge ou douleurs"},
      fever: %Schema{type: :integer, enum: [0, 1, 999], description: "Fièvre"},
      temperature_cat: %Schema{
        type: :string,
        enum: ["inf_35.5", "35.5-37.7", "37.7-38.9", "sup_39", "NSP"],
        description: "Catégorie de température"
      },
      agueusia_anosmia: %Schema{type: :boolean, description: "Perte de goût et d’odorat"},
      breathlessness: %Schema{type: :boolean, description: "Essoufflement"},
      cough: %Schema{type: :boolean, description: "Toux"},
      diarrhea: %Schema{type: :boolean, description: "Diarrhée"},
      tiredness: %Schema{type: :boolean, description: "Fatigue"},
      tiredness_details: %Schema{type: :boolean, description: "Alitement >=50% du temps diurne"},
      feeding_day: %Schema{type: :boolean, description: "Difficulté pour manger/boire"}
    },
    example: %{
      "sore_throat_aches" => true,
      "fever" => 999,
      "temperature_cat" => "35.5-37.7",
      "agueusia_anosmia" => true,
      "breathlessness" => true,
      "cough" => true,
      "diarrhea" => true,
      "tiredness" => true,
      "tiredness_details" => true,
      "feeding_day" => true
    }
  })
end
