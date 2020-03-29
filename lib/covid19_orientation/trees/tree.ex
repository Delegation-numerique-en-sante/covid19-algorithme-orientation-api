defmodule Covid19Orientation.Trees.Tree do
  @moduledoc """
  Implémentation basique d'un arbre.
  """

  alias __MODULE__

  defstruct key: nil, type: nil, depth: nil, operation: nil, children: []

  @type key() :: any
  @type type() :: :branch | :leaf
  @type depth() :: integer
  @type operation() :: (any -> boolean)
  @type t :: %Tree{key: nil, type: type, depth: depth, operation: operation, children: [t]}
end
