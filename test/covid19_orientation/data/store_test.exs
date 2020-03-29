defmodule Covid19Orientation.Data.StoreTest do
  use ExUnit.Case, async: true
  alias Covid19Orientation.Data.Store

  alias Covid19OrientationWeb.Operations.EvaluateOrientation

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

    {:ok, timestamp} = Store.set(orientation)

    assert {:found, orientation} == Store.get(timestamp)
  end
end
