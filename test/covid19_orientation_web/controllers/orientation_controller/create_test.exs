defmodule Covid19OrientationWeb.OrientationController.CreateOrientation do
  use Covid19OrientationWeb.ConnCase, async: true

  test "donne un résultat à partir des paramètres" do
    payload = %{
      "orientation" => %{
        "symptomes" => %{
          "temperature" => 39.0,
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
          "poids" => 100,
          "taille" => 1.5,
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
        "supplementaires" => %{
          "code_postal" => "75000"
        }
      }
    }

    conn =
      build_conn()
      |> put_req_header("content-type", "application/json")
      |> post("/orientation", payload)

    body = conn |> response(201) |> Jason.decode!()

    assert body["data"]["conclusion"]["code"] == "FIN5"
    assert body["data"]["statistiques"]["moins_de_15_ans"] == false
  end
end
