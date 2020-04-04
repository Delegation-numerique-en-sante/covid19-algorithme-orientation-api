defmodule Covid19QuestionnaireWeb.Schemas.Orientation do
  @moduledoc """
  Schéma des orientations possibles.
  """

  require OpenApiSpex
  alias OpenApiSpex.Schema

  OpenApiSpex.schema(%{
    title: "Orientation",
    description:
      "[Orientation du questionnaire COVID19](https://github.com/Delegation-numerique-en-sante/covid19-algorithme-questionnaire/blob/master/pseudo-code.org#conclusions-possibles)",
    type: :object,
    properties: %{
      code: %Schema{
        type: :string,
        enum: [
          "orientation_moins_de_15_ans",
          "orientation_domicile_surveillance_1",
          "orientation_consultation_surveillance_1",
          "orientation_consultation_surveillance_2",
          "orientation_SAMU",
          "orientation_consultation_surveillance_3",
          "orientation_consultation_surveillance_4",
          "orientation_surveillance"
        ],
        description:
          "[Orientations possibles](https://github.com/Delegation-numerique-en-sante/covid19-algorithme-questionnaire/blob/master/pseudo-code.org#conclusions-possibles)"
      }
    },
    required: [:code],
    example: %{
      "code" => "orientation_SAMU"
    }
  })
end
