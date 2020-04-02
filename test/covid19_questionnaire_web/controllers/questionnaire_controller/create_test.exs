defmodule Covid19QuestionnaireWeb.QuestionnaireController.CreateQuestionnaire do
  use Covid19QuestionnaireWeb.ConnCase, async: true
  alias Covid19Questionnaire.Data.Store
  alias Covid19QuestionnaireWeb.Schemas.{QuestionnaireRequest, QuestionnaireResponse}

  test "donne un résultat à partir des paramètres", %{conn: conn, spec: spec} do
    token = "faketoken"
    request = QuestionnaireRequest.schema().example
    response = QuestionnaireResponse.schema().example

    body =
      conn
      |> put_req_header("content-type", "application/json")
      |> put_req_header("x-token", token)
      |> post("/questionnaire", request)
      |> response(201)
      |> Jason.decode!()

    body
    |> assert_schema("QuestionnaireResponse", spec)

    response
    |> Kernel.put_in(["data", "metadata", "date"], body["data"]["metadata"]["date"])
    |> Kernel.==(body)
    |> assert

    :timer.sleep(Store.tick_interval())

    assert Store.read(body["data"]["metadata"]["date"]) == [body]
  end
end
