defmodule Covid19Questionnaire.Tests.Codes do
  @moduledoc """
  Codes des résultats du test d'orientation du COVID19.
  """

  @type name :: atom
  @type code :: String.t()

  @codes [
    :orientation_moins_de_15_ans,
    :orientation_domicile_surveillance_1,
    :orientation_consultation_surveillance_1,
    :orientation_consultation_surveillance_2,
    :orientation_SAMU,
    :orientation_consultation_surveillance_3,
    :orientation_consultation_surveillance_4,
    :orientation_surveillance
  ]

  @codes
  |> Enum.each(fn name ->
    @spec unquote(name)() :: code
    def unquote(name)() do
      unquote(name) |> Atom.to_string()
    end
  end)
end
