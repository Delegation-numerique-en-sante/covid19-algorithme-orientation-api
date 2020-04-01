defmodule Covid19OrientationWeb.Schemas.Supplementaires do
  @moduledoc """
  Schéma des questions supplémentaires.
  """

  require OpenApiSpex
  alias OpenApiSpex.Schema

  OpenApiSpex.schema(%{
    title: "Supplementaires",
    description:
      "[Questions supplémentaires](https://github.com/Delegation-numerique-en-sante/covid19-algorithme-orientation/blob/master/pseudo-code.org#question-suppl%C3%A9mentaire)",
    type: :object,
    properties: %{
      postal_code: %Schema{type: :string, description: "Code postal"}
    },
    example: %{
      "postal_code" => "75000"
    }
  })
end
