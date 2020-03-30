defmodule Covid19OrientationWeb.OrientationController.CreateOrientation do
  use Covid19OrientationWeb.ConnCase, async: true
  alias Covid19Orientation.Data.Store

  test "donne un résultat à partir des paramètres", %{conn: conn, spec: spec} do
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

    body =
      conn
      |> put_req_header("content-type", "application/json")
      |> post("/orientation", payload)
      |> response(201)
      |> Jason.decode!()

    assert_schema(body, "OrientationResponse", spec)
    assert body["data"]["conclusion"]["code"] == "FIN5"
    assert Store.read({body["data"]["timestamp"], body["data"]["id"]}) =~ "data"
  end
end
