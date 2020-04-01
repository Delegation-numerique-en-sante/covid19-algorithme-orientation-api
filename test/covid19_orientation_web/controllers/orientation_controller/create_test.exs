defmodule Covid19OrientationWeb.OrientationController.CreateOrientation do
  use Covid19OrientationWeb.ConnCase, async: true
  alias Covid19Orientation.Data.Store

  test "donne un résultat à partir des paramètres", %{conn: conn, spec: spec} do
    payload = %{
      "orientation" => %{
        "symptomes" => %{
          "temperature" => 39.0,
          "cough" => true,
          "agueusia_anosmia" => true,
          "sore_throat_aches" => true,
          "diarrhea" => true,
          "tiredness" => true,
          "feeding" => true,
          "breathlessness" => true
        },
        "pronostiques" => %{
          "age" => 70,
          "weight" => 100,
          "height" => 1.5,
          "heart_disease" => true,
          "diabetes" => true,
          "cancer" => true,
          "breathing_disease" => true,
          "kidney_disease" => true,
          "liver_disease" => true,
          "pregnant" => true,
          "immunodeprime" => true,
          "immunosuppressant_drug" => true
        },
        "supplementaires" => %{
          "postal_code" => "75000"
        }
      }
    }

    token = "faketoken"

    body =
      conn
      |> put_req_header("content-type", "application/json")
      |> put_req_header("x-token", token)
      |> post("/orientation", payload)
      |> response(201)
      |> Jason.decode!()

    assert_schema(body, "OrientationResponse", spec)
    assert body["data"]["conclusion"]["code"] == "FIN5"

    :timer.sleep(Store.tick_interval())

    assert Store.read({body["data"]["date"], body["data"]["uuid"]})
           |> List.first()
           |> Map.has_key?("data")
  end
end
