defmodule Covid19Questionnaire.Trees.TraverseTreeTest do
  use ExUnit.Case, async: true
  alias Covid19Questionnaire.Trees.{FlattenTree, TraverseTree, Tree}

  setup do
    operation = &is_integer/1

    {:ok,
     trees: [
       %Tree{
         operation: operation,
         children: [
           %Tree{
             operation: operation,
             children: [%Tree{operation: operation}]
           },
           %Tree{
             operation: operation,
             children: [
               %Tree{
                 operation: operation,
                 children: [%Tree{operation: operation}]
               }
             ]
           }
         ]
       },
       %Tree{operation: operation}
     ]}
  end

  describe "traverse l'arbre" do
    test "s'arrête à la première feuille vraie", %{trees: trees} do
      {:ok, tree} =
        trees
        |> FlattenTree.call()
        |> TraverseTree.call(1)

      assert tree.type == :leaf
    end

    test "s'arrête à la fin du chemin, s'il n'y a pas de feuille vraie", %{trees: trees} do
      {:error, error} =
        trees
        |> FlattenTree.call()
        |> TraverseTree.call(1.0)

      assert error == :done
    end
  end
end
