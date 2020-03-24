defmodule Covid19Orientation.TreeTraversal do
  @moduledoc """
  Implémentation basique d'un algorithme de parcours d'arbre.
  """

  alias Covid19Orientation.Tree

  @type tree() :: Tree.t()
  @type trees() :: [tree] | []
  @type stack() :: [tree] | []
  @type depth() :: integer
  @type value() :: any
  @type history() :: tuple

  @spec flatten(trees) :: stack

  def flatten(trees), do: flatten(trees, [], 0) |> Enum.reverse()

  @spec flatten(trees, stack, depth) :: stack

  def flatten([], stack, _), do: stack

  def flatten(trees, stack, depth) do
    Enum.reduce(trees, stack, fn tree, acc ->
      case tree.children do
        [] -> flatten([], [%Tree{tree | depth: depth, type: :leaf} | acc], depth - 1)
        [child] -> flatten([child], [%Tree{tree | depth: depth, type: :branch} | acc], depth)
        children -> flatten(children, [%Tree{tree | depth: depth, type: :fork} | acc], depth + 1)
      end
    end)
  end

  @spec traverse(stack, value, history) :: {:ok, tree} | {}

  def traverse(stack, value, history \\ {0, true})

  def traverse([], _, _), do: {:ok, :done}

  def traverse([tree | stack], value, history) do
    {prev_depth, prev_result} = history
    depth = tree.depth
    result = tree.operation.(value)

    cond do
      prev_depth < depth && not prev_result -> traverse(stack, value, {prev_depth, prev_result})
      tree.type != :leaf -> traverse(stack, value, {depth, result})
      not result -> traverse(stack, value, {depth, result})
      true -> {:ok, tree}
    end
  end
end
