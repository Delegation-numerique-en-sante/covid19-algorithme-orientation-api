defmodule Covid19Questionnaire.Tests.Codes do
  @moduledoc """
  Codes des résultats du test d'orientation du COVID19.
  """

  @type name :: atom
  @type code :: String.t()

  @codes [
    :less_15,
    :home_surveillance,
    :consultation_surveillance_1,
    :consultation_surveillance_2,
    :SAMU,
    :consultation_surveillance_3,
    :consultation_surveillance_4,
    :surveillance
  ]

  @codes
  |> Enum.each(fn name ->
    @spec unquote(name)() :: code
    def unquote(name)() do
      unquote(name) |> Atom.to_string()
    end
  end)
end
