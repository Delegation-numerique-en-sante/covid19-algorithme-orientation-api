defmodule Covid19Questionnaire.Trees.FlattenTree do
  @moduledoc """
  Applatit l'arbre.
  """

  alias Covid19Questionnaire.Trees.Tree

  @type tree() :: Tree.t()
  @type trees() :: [tree] | []
  @type stack() :: stack
  @type depth() :: integer

  @spec call(trees) :: stack

  def call(trees), do: call(trees, [], 0) |> Enum.reverse()

  @spec call(trees, stack) :: stack

  def call([], stack), do: stack

  @spec call(trees, stack, depth) :: stack

  def call(trees, stack, depth) do
    Enum.reduce(trees, stack, fn tree, acc ->
      case tree.children do
        [] ->
          call([], [%Tree{tree | depth: depth, type: :leaf} | acc])

        children ->
          call(children, [%Tree{tree | depth: depth, type: :branch} | acc], depth + 1)
      end
    end)
  end
end
