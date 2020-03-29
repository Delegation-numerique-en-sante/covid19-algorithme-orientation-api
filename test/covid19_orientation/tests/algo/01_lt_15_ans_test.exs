defmodule Covid19Orientation.Tests.Test.L15AnsTest do
  @moduledoc """
  STOP si < 15 ans
  """

  use ExUnit.Case, async: true
  alias Covid19Orientation.Tests.Test
  alias Covid19OrientationWeb.Schemas.{Orientation, Pronostiques, Symptomes}

  test "STOP si < 15 ans" do
    {:ok, orientation} =
      %Orientation{
        symptomes: %Symptomes{},
        pronostiques: %Pronostiques{
          age: 14
        }
      }
      |> Test.evaluate()

    assert orientation.conclusion.code == "FIN1"
  end
end
