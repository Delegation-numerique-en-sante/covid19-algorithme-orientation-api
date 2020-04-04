defmodule Covid19Questionnaire.Trees.FlattenTreeTest do
  use ExUnit.Case, async: true
  alias Covid19Questionnaire.Trees.{FlattenTree, Tree}

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
      |> FlattenTree.call()
      |> Enum.map(& &1.type)

    assert types == [:branch, :branch, :leaf, :branch, :branch, :leaf, :leaf]
  end
end
