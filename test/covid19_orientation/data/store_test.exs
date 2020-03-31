defmodule Covid19Orientation.Data.StoreTest do
  use ExUnit.Case, async: true
  alias Covid19Orientation.Data.PgStore

  alias Covid19OrientationWeb.Operations.{
    EvaluateOrientation,
    SetId,
    SetTimestamp
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

    orientation =
      orientation
      |> SetId.call()
      |> SetTimestamp.call()

    %{timestamp: timestamp, id: id} = orientation
    data = PgStore.write({timestamp, id}, %{data: orientation})

    assert data == %{data: orientation}
    assert data == PgStore.read({timestamp, id})
  end
end
