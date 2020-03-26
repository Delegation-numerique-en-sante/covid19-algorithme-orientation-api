defmodule Covid19Orientation.TreeTraversalTest do
  use ExUnit.Case
  alias Covid19Orientation.{Tree, TreeTraversal}

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

  test "aplatit l'arbre", %{trees: trees} do
    types =
      trees
      |> TreeTraversal.flatten()
      |> Enum.map(& &1.type)

    assert types == [:branch, :branch, :leaf, :branch, :branch, :leaf, :leaf]
  end

  describe "traverse l'arbre" do
    test "s'arrête à la première feuille vraie", %{trees: trees} do
      {:ok, tree} =
        trees
        |> TreeTraversal.flatten()
        |> TreeTraversal.traverse(1)

      assert tree.type == :leaf
    end

    test "s'arrête à la fin du chemin, s'il n'y a pas de feuille vraie", %{trees: trees} do
      {:ok, ok} =
        trees
        |> TreeTraversal.flatten()
        |> TreeTraversal.traverse(1.0)

      assert ok == :done
    end
  end
end
