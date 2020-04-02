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
          "orientation_SAMU",
          "FIN2",
          "FIN3",
          "FIN4",
          "FIN5",
          "FIN6",
          "FIN7",
          "FIN8",
          "FIN9"
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
