defmodule Covid19QuestionnaireWeb.QuestionnaireController.CreateQuestionnaire do
  use Covid19QuestionnaireWeb.ConnCase, async: true
  alias Covid19Questionnaire.Data.{Journal, Store, Token}
  alias Covid19QuestionnaireWeb.Schemas.{QuestionnaireRequest, QuestionnaireResponse}

  test "donne un résultat à partir des paramètres", %{conn: conn, spec: spec} do
    request = QuestionnaireRequest.schema().example
    response = QuestionnaireResponse.schema().example
    {:ok, token} = Token.create()

    :timer.sleep(Store.tick_interval())

    body =
      conn
      |> put_req_header("content-type", "application/json")
      |> put_req_header("x-token", token.uuid)
      |> post("/questionnaire", request)
      |> response(201)
      |> Jason.decode!()

    response =
      response
      |> Kernel.put_in(["data", "metadata", "date"], body["data"]["metadata"]["date"])
      |> Kernel.put_in(["data", "token", "uuid"], body["data"]["token"]["uuid"])
      |> Kernel.put_in(["data", "token", "date"], body["data"]["token"]["date"])

    {:ok, date, _} = body["data"]["metadata"]["date"] |> DateTime.from_iso8601()

    :timer.sleep(Store.tick_interval())

    assert_schema(body, "QuestionnaireResponse", spec)
    assert response == body
    assert Journal.find(date).data == body
  end

  test "rejects requests without token", %{conn: conn} do
    conn =
      conn
      |> put_req_header("content-type", "application/json")
      |> post("/questionnaire", %{})

    assert conn.status == 401
  end

  test "rejects requests with spurious token", %{conn: conn} do
    conn =
      conn
      |> put_req_header("content-type", "application/json")
      |> put_req_header("x-token", "asdf1234")
      |> post("/questionnaire", %{})

    assert conn.status == 403
  end

  test "rejects requests with forged token", %{conn: conn} do
    conn =
      conn
      |> put_req_header("content-type", "application/json")
      |> put_req_header("x-token", "c9e77845-83cf-4891-88d6-804d659e81c5")
      |> post("/questionnaire", %{})

    assert conn.status == 403
  end

  test "doesn't store questionnaires of < 15y", %{conn: conn} do
    request = QuestionnaireRequest.schema().example

    request =
      Kernel.put_in(
        request,
        ["questionnaire", "metadata", "orientation"],
        "orientation_moins_de_15_ans"
      )

    {:ok, token} = Token.create()

    conn =
      conn
      |> put_req_header("content-type", "application/json")
      |> put_req_header("x-token", token.uuid)
      |> post("/questionnaire", request)

    assert conn.status == 451
  end

  test "rejects requests without required parameters", %{conn: conn} do
    request =
      QuestionnaireRequest.schema().example
      |> Kernel.put_in(["questionnaire", "metadata", "algo_version"], nil)

    {:ok, token} = Token.create()

    body =
      conn
      |> put_req_header("content-type", "application/json")
      |> put_req_header("x-token", token.uuid)
      |> post("/questionnaire", request)
      |> response(422)
      |> Jason.decode!()

    assert %{"errors" => [%{"title" => "Invalid value"}]} = body
  end

  test "drops spurious data", %{conn: conn} do
    request =
      QuestionnaireRequest.schema().example
      |> Kernel.put_in(["questionnaire", "respondent", "height"], 170)
      |> Kernel.put_in(["questionnaire", "respondent", "weight"], 80.75)

    {:ok, token} = Token.create()

    body =
      conn
      |> put_req_header("content-type", "application/json")
      |> put_req_header("x-token", token.uuid)
      |> post("/questionnaire", request)
      |> response(201)
      |> Jason.decode!()

    assert !body["data"]["respondent"]["height"]
    assert !body["data"]["respondent"]["weight"]
  end
end
