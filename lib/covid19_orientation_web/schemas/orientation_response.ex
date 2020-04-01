defmodule Covid19OrientationWeb.Schemas.OrientationResponse do
  @moduledoc """
  Schéma de la réponse de l'algorithme d'orientation.
  """

  require OpenApiSpex
  alias Covid19OrientationWeb.Schemas.Orientation

  OpenApiSpex.schema(%{
    title: "OrientationResponse",
    description: "Réponse de l'algorithme d'orientation",
    type: :object,
    properties: %{
      data: Orientation
    },
    example: %{
      "data" => %{
        "date" => "2020-03-29 15:20:11.875767Z",
        "uuid" => "5976423a-ee35-11e3-8569-14109ff1a304",
        "symptomes" => %{
          "temperature" => 37.5,
          "cough" => true,
          "anosmia" => true,
          "mal_de_gorge" => true,
          "diarrhee" => true,
          "fatigue" => true,
          "diffs_alim_boire" => true,
          "breathlessness" => true
        },
        "pronostiques" => %{
          "age" => 70,
          "weight" => 65.5,
          "height" => 1.73,
          "heart_disease" => true,
          "diabetique" => true,
          "cancer" => true,
          "breathing_disease" => true,
          "kidney_disease" => true,
          "liver_disease" => true,
          "enceinte" => true,
          "immunodeprime" => true,
          "traitement_immunosuppresseur" => true
        },
        "statistiques" => %{
          "moins_de_15_ans" => false,
          "moins_de_50_ans" => false,
          "au_moins_50_ans" => false,
          "moins_de_70_ans" => false,
          "entre_50_et_69_ans" => false,
          "au_moins_70_ans" => true,
          "au_moins_30_imc" => true,
          "fever" => true,
          "au_moins_39_de_temperature" => true,
          "heart_disease" => true,
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
    },
    "x-struct": __MODULE__
  })
end
