defmodule Covid19OrientationWeb.Operations.EvaluateOrientation do
  @moduledoc """
  Evaluate orientation test.
  """

  alias Covid19Orientation.Tests.{Algorithme, Codes}
  alias Covid19Orientation.Trees.{FlattenTree, TraverseTree, Tree}
  alias Covid19OrientationWeb.Operations.{PopulateConclusion, PopulateStatistics}
  alias Covid19OrientationWeb.Schemas.Orientation

  @type orientation() :: Orientation.t()
  @type code() :: String.t()

  @spec call(orientation) :: {:ok, orientation}

  def call(orientation = %Orientation{}) do
    Tree
    |> Algorithme.call()
    |> FlattenTree.call()
    |> TraverseTree.call(orientation)
    |> case do
      {:ok, %{key: key}} -> {:ok, populate(orientation, key.())}
      {:error, :done} -> {:ok, populate(orientation, Codes.fin9())}
    end
  end

  @spec populate(orientation, code) :: orientation

  defp populate(orientation = %Orientation{}, code) do
    orientation
    |> PopulateConclusion.call(code)
    |> PopulateStatistics.call()
  end
end
