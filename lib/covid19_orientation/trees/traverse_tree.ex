defmodule Covid19Orientation.Trees.TraverseTree do
  @moduledoc """
  Implémentation basique d'un algorithme de parcours d'arbre.
  """

  alias Covid19Orientation.Trees.Tree

  @type tree() :: Tree.t()
  @type trees() :: [tree] | []
  @type stack() :: stack
  @type depth() :: integer
  @type value() :: any
  @type previous() :: {depth, boolean}

  @spec call(stack, value, previous) :: {:ok, tree} | {:ok, :done}

  def call(stack, value, previous \\ {0, true})

  def call([], _, _), do: {:ok, :done}

  def call([tree | stack], value, {prev_depth, prev_result}) do
    with result <- tree.operation.(value) do
      cond do
        prev_depth < tree.depth && !prev_result ->
          call(stack, value, {prev_depth, prev_result})

        tree.type != :leaf || !result ->
          call(stack, value, {tree.depth, result})

        result ->
          {:ok, tree}
      end
    end
  end
end
