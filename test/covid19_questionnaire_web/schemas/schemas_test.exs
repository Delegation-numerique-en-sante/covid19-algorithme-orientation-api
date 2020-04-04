defmodule Covid19QuestionnaireWeb.Schemas.SchemasTest do
  use Covid19QuestionnaireWeb.SchemaCase, async: true

  with {:ok, list} <- :application.get_key(:covid19_questionnaire, :modules) do
    list
    |> Enum.filter(&(&1 |> Module.split() |> Enum.at(1) == "Schemas"))
    |> Enum.map(&{&1.schema().example, &1 |> Module.split() |> Enum.at(2)})
    |> Enum.each(fn {example, schema} ->
      test "#{schema} matches schemas", %{spec: spec} do
        assert_schema(unquote(escape(example, unquote: true)), unquote(schema), spec)
      end
    end)
  end
end
