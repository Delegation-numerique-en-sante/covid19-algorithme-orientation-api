defmodule Covid19Orientation.Data.StoreTest do
  use ExUnit.Case, async: true
  alias Covid19Orientation.Data.Store

  alias Covid19OrientationWeb.Operations.{
    EvaluateOrientation,
  }

  alias Covid19OrientationWeb.Schemas.{
    Orientation,
    Pronostiques,
    Supplementaires,
    Symptomes
  }

  test "stores & retrieves data" do
    {:ok, orientation} =
      %Orientation{
        symptomes: %Symptomes{temperature: 39.0},
        pronostiques: %Pronostiques{age: 70},
        supplementaires: %Supplementaires{code_postal: "75000"}
      }
      |> EvaluateOrientation.call()

    date = DateTime.utc_now()
    uuid = "faketoken"
    data = Store.write({date, uuid}, orientation)

    :timer.sleep(Store.tick_interval())

    assert [data |> Jason.encode!() |> Jason.decode!()] == Store.read({date, uuid})
  end
end
