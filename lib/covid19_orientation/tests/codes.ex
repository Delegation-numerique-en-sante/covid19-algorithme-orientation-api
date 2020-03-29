defmodule Covid19Orientation.Tests.Codes do
  @moduledoc """
  Codes des résultats du test d’orientation du Covid-19.
  """

  @type name :: atom
  @type code :: String.t()

  @codes ~w|fin1 fin2 fin3 fin4 fin5 fin6 fin7 fin8 fin9|a

  @codes
  |> Enum.each(fn name ->
    @spec unquote(name)() :: code
    def unquote(name)() do
      unquote(name) |> Atom.to_string() |> String.upcase()
    end
  end)
end
