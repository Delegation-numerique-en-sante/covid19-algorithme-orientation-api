defmodule Covid19QuestionnaireWeb.QuestionnaireController.CreateQuestionnaire do
  use Covid19QuestionnaireWeb.ConnCase, async: true
  alias Covid19Questionnaire.Data.Token
  alias Covid19QuestionnaireWeb.Schemas.QuestionnaireRequest

  test "donne un résultat à partir des paramètres", %{conn: conn} do
    request = QuestionnaireRequest.schema().example
    {:ok, token} = Token.create()

    conn =
      conn
      |> put_req_header("content-type", "application/json")
      |> put_req_header("x-token", token.uuid)
      |> post("/questionnaire", request)

    assert conn.status == 202
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
        "less_15"
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

    assert %{"errors" => [%{"title" => "Unprocessable Entity"}]} = body
  end
end
