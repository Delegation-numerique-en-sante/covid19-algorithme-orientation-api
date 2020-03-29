defmodule Covid19OrientationWeb.Operations.PopulateStatistics do
  @moduledoc """
  Populate statistics.
  """

  alias Covid19Orientation.Tests.Test
  alias Covid19OrientationWeb.Schemas.{Orientation, Statistiques}

  @type orientation :: Orientation.t()

  @spec call(orientation) :: orientation

  def call(orientation = %Orientation{}) do
    Map.put(
      orientation,
      :statistiques,
      %Statistiques{}
      |> Map.from_struct()
      |> Map.keys()
      |> Enum.reduce(%Statistiques{}, fn key, statistiques ->
        statistiques
        |> Map.put(key, apply(Test, key, [orientation]))
      end)
    )
  end
end
