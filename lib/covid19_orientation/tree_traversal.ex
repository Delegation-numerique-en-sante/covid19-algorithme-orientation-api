defmodule Covid19Orientation.TreeTraversal do
  @moduledoc """
  Implémentation basique d'un algorithme de parcours d'arbre.
  """

  alias Covid19Orientation.Tree
  alias Covid19OrientationWeb.Schemas.Orientation

  @type tree() :: Tree.t()
  @type trees() :: [trees] | []
  @type stack() :: stack
  @type depth() :: integer
  @type value() :: Orientation.t()
  @type previous() :: {depth, boolean}

  @spec flatten(trees) :: stack

  def flatten(trees), do: flatten(trees, [], 0) |> Enum.reverse()

  @spec flatten(trees, stack, depth) :: stack

  def flatten([], stack, _), do: stack

  def flatten(trees, stack, depth) do
    Enum.reduce(trees, stack, fn tree, acc ->
      case tree.children do
        [] ->
          flatten([], [%Tree{tree | depth: depth, type: :leaf} | acc], depth)

        children ->
          flatten(children, [%Tree{tree | depth: depth, type: :branch} | acc], depth + 1)
      end
    end)
  end

  @spec traverse(stack, value, previous) :: {:ok, tree} | {:ok, :done}

  def traverse(stack, value, previous \\ {0, true})

  def traverse([], _, _), do: {:ok, :done}

  def traverse([tree | stack], value, {prev_depth, prev_result}) do
    with result <- tree.operation.(value) do
      cond do
        prev_depth < tree.depth && !prev_result ->
          traverse(stack, value, {prev_depth, prev_result})

        tree.type != :leaf || !result ->
          traverse(stack, value, {tree.depth, result})

        result ->
          {:ok, tree}
      end
    end
  end
end
