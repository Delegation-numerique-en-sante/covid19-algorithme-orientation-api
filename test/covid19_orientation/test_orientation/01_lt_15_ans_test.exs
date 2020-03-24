defmodule Covid19Orientation.TestOrientation.L15AnsTest do
  @moduledoc """
  STOP si < 15 ans
  """

  use ExUnit.Case
  alias Covid19Orientation.TestOrientation
  alias Covid19OrientationWeb.Schemas.{Orientation, Pronostiques, Symptomes}

  test "STOP si < 15 ans" do
    {:ok, orientation} =
      %Orientation{
        symptomes: %Symptomes{},
        pronostiques: %Pronostiques{
          age: 14
        }
      }
      |> TestOrientation.evaluate()

    assert orientation.conclusion.code == "FIN1"
  end
end
