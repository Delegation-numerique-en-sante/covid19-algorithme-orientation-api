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
      sore_throat_aches: %Schema{
        type: :boolean,
        description: "Avez-vous un mal de gorge apparu ces derniers jours ?"
      },
      fever: %Schema{
        type: :boolean,
        description: "Pensez-vous avoir eu de la fièvre ces derniers jours (frissons, sueurs) ?"
      },
      temperature_cat: %Schema{
        type: :string,
        enum: ["(−∞, 35.4]", "[35.5, 35.7]", "[37.8, 38.9]", "[39, +∞)", "DNK"],
        description: "Quelle est votre température ?"
      },
      agueusia_anosmia: %Schema{
        type: :boolean,
        description:
          "Avez-vous noté une forte diminution de votre goût ou de l’odorat ces derniers jours ?"
      },
      breathlessness: %Schema{
        type: :boolean,
        description:
          "Dans les dernières 24 heures, avez-vous noté un manque de souffle INHABITUEL lorsque vous parlez ou faites un petit effort ?"
      },
      cough: %Schema{
        type: :boolean,
        description:
          "Avez-vous une toux ou une augmentation de votre toux habituelle ces derniers jours ?"
      },
      diarrhea: %Schema{
        type: :boolean,
        description:
          "Avez-vous de la diarrhée ces dernières 24 heures (au moins 3 selles molles) ?"
      },
      tiredness: %Schema{
        type: :boolean,
        description: "Avez-vous une fatigue inhabituelle ces derniers jours ?"
      },
      tiredness_details: %Schema{
        type: :boolean,
        description:
          "Cette fatigue vous oblige-t-elle à vous reposer plus de la moitié de la journée ?"
      },
      feeding_day: %Schema{
        type: :boolean,
        description:
          "Êtes-vous dans l’impossibilité de vous alimenter ou boire DEPUIS 24 HEURES OU PLUS ?"
      }
    },
    example: %{
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
    }
  })
end
