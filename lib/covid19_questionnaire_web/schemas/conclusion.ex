defmodule Covid19QuestionnaireWeb.Schemas.Conclusion do
  @moduledoc """
  Schéma des conclusions possibles.
  """

  require OpenApiSpex
  alias OpenApiSpex.Schema

  OpenApiSpex.schema(%{
    title: "Conclusion",
    description:
      "[Conclusion de l'questionnaire du Covid-19](https://github.com/Delegation-numerique-en-sante/covid19-algorithme-questionnaire/blob/master/pseudo-code.org#conclusions-possibles)",
    type: :object,
    properties: %{
      code: %Schema{
        type: :string,
        enum: [
          "questionnaire_SAMU",
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
          "[Conclusions possibles](https://github.com/Delegation-numerique-en-sante/covid19-algorithme-questionnaire/blob/master/pseudo-code.org#conclusions-possibles)"
      }
    },
    required: [:code],
    example: %{
      "code" => "questionnaire_SAMU"
    }
  })
end
