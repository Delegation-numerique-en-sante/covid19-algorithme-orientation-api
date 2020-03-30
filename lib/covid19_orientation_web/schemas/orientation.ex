defmodule Covid19OrientationWeb.Schemas.Orientation do
  @moduledoc """
  Schéma de l'algorithme d’orientation du Covid-19.
  """

  require OpenApiSpex

  alias Covid19OrientationWeb.Schemas.{
    Conclusion,
    Pronostiques,
    Statistiques,
    Supplementaires,
    Symptomes
  }

  alias OpenApiSpex.Schema

  OpenApiSpex.schema(%{
    title: "Orientation",
    description:
      "[Algorithme d’orientation du Covid-19](https://github.com/Delegation-numerique-en-sante/covid19-algorithme-orientation/blob/master/pseudo-code.org#pr%C3%A9sentation-de-lalgorithme-dorientation-covid19)",
    type: :object,
    properties: %{
      id: %Schema{type: :string, description: "ID du test d'orientation", format: :uuid4},
      timestamp: %Schema{
        type: :string,
        description: "Date du test d'orientation",
        format: :"date-time"
      },
      symptomes: Symptomes,
      pronostiques: Pronostiques,
      supplementaires: Supplementaires,
      conclusion: Conclusion,
      statistiques: Statistiques
    },
    required: [:symptomes, :pronostiques, :supplementaires],
    example: %{
      "id" => "fcfe5f21-8a08-4c9a-9f97-29d2fd6a27b9",
      "timestamp" => "2020-03-29 15:20:11.875767Z",
      "symptomes" => %{
        "temperature" => 37.5,
        "toux" => true,
        "anosmie" => true,
        "mal_de_gorge" => true,
        "diarrhee" => true,
        "fatigue" => true,
        "diffs_alim_boire" => true,
        "essoufle" => true
      },
      "pronostiques" => %{
        "age" => 70,
        "poids" => 65.5,
        "taille" => 1.73,
        "cardiaque" => true,
        "diabetique" => true,
        "cancer" => true,
        "respiratoire" => true,
        "insuffisance_renale" => true,
        "maladie_chronique_foie" => true,
        "enceinte" => true,
        "immunodeprime" => true,
        "traitement_immunosuppresseur" => true
      },
      "statistiques" => %{
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
      },
      "supplementaires" => %{
        "code_postal" => "75000"
      },
      "conclusion" => %{
        "code" => "FIN1"
      }
    }
  })
end
