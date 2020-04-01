defmodule Covid19QuestionnaireWeb.QuestionnaireController.CreateQuestionnaire do
  use Covid19QuestionnaireWeb.ConnCase, async: true
  alias Covid19Questionnaire.Data.Store

  test "donne un résultat à partir des paramètres", %{conn: conn, spec: spec} do
    payload = %{
      "questionnaire" => %{
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
<<<<<<< HEAD:test/covid19_orientation_web/controllers/orientation_controller/create_test.exs
      |> put_req_header("x-token", token)
      |> post("/orientation", payload)
=======
      |> post("/questionnaire", payload)
>>>>>>> Rename Questionnaire => Questionnaire:test/covid19_questionnaire_web/controllers/questionnaire_controller/create_test.exs
      |> response(201)
      |> Jason.decode!()

    assert_schema(body, "QuestionnaireResponse", spec)
    assert body["data"]["conclusion"]["code"] == "FIN5"

    :timer.sleep(Store.tick_interval())

    assert Store.read({body["data"]["date"], body["data"]["uuid"]})
           |> List.first()
           |> Map.has_key?("data")
  end
end
