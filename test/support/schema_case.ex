defmodule Covid19QuestionnaireWeb.SchemaCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require validating schemas.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      import Macro, only: [escape: 2]
      import OpenApiSpex.TestAssertions
    end
  end

  setup _tags do
    {:ok, spec: Covid19QuestionnaireWeb.ApiSpec.spec()}
  end
end
