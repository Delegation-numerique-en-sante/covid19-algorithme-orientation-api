defmodule Covid19OrientationWeb.Schemas.Symptomes do
  @moduledoc """
  Schéma des questions sur les symptômes.
  """

  require OpenApiSpex
  alias OpenApiSpex.Schema

  OpenApiSpex.schema(%{
    title: "Symptomes",
    description:
      "[Questions sur les symptômes](https://github.com/Delegation-numerique-en-sante/covid19-algorithme-orientation/blob/master/pseudo-code.org#questions-sur-les-sympt%C3%B4mes)",
    type: :object,
    properties: %{
      temperature: %Schema{
        type: :number,
        description:
          "Pensez-vous avoir eu de la fièvre ces derniers jours (frissons, sueurs) ? Quelle est votre température ?"
      },
      cough: %Schema{
        type: :boolean,
        description:
          "Avez-vous une toux ou une augmentation de votre toux habituelle ces derniers jours ?"
      },
      anosmie: %Schema{
        type: :boolean,
        description:
          "Avez-vous noté une forte diminution de votre goût ou de l’odorat ces derniers jours ?"
      },
      mal_de_gorge: %Schema{
        type: :boolean,
        description: "Avez-vous un mal de gorge apparu ces derniers jours ?"
      },
      diarrhee: %Schema{
        type: :boolean,
        description:
          "Avez-vous de la diarrhée ces dernières 24 heures (au moins 3 selles molles) ?"
      },
      fatigue: %Schema{
        type: :boolean,
        description:
          "Avez-vous une fatigue inhabituelle ces derniers jours ? Cette fatigue vous oblige-t-elle à vous reposer plus de la moitié de la journée ?"
      },
      diffs_alim_boire: %Schema{
        type: :boolean,
        description:
          "Êtes-vous dans l’impossibilité de vous alimenter ou boire DEPUIS 24 HEURES OU PLUS ?"
      },
      breathlessness: %Schema{
        type: :boolean,
        description:
          "Dans les dernières 24 heures, avez-vous noté un manque de souffle INHABITUEL lorsque vous parlez ou faites un petit effort ?"
      }
    },
    example: %{
      "temperature" => 37.5,
      "cough" => true,
      "anosmie" => true,
      "mal_de_gorge" => true,
      "diarrhee" => true,
      "fatigue" => true,
      "diffs_alim_boire" => true,
      "breathlessness" => true
    }
  })
end
