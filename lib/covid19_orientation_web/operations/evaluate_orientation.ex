defmodule Covid19OrientationWeb.Operations.EvaluateOrientation do
  @moduledoc """
  Evaluate orientation test.
  """

  alias Covid19Orientation.Tests.{Algorithme, Test}
  alias Covid19Orientation.Trees.Tree

  @type orientation() :: Orientation.t()

  @spec call(orientation) :: {:ok, orientation}

  def call(orientation) do
    Tree
    |> Test.algorithme()
    |> Tree.flatten()
    |> Tree.traverse(orientation)
    |> case do
      {:ok, :done} -> {:ok, Test.fin9(orientation)}
      {:ok, %{key: key}} -> {:ok, key.(orientation)}
    end
  end
end
