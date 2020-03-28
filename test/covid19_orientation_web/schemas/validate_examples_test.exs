defmodule Covid19OrientationWeb.Schemas.ValidateExamplesTest do
  use Covid19OrientationWeb.SchemaCase
  alias Covid19OrientationWeb.ApiSpec

  setup do
    {:ok, spec: ApiSpec.spec()}
  end

  with {:ok, list} <- :application.get_key(:covid19_orientation, :modules) do
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
