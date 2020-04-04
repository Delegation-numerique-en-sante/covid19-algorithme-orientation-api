defmodule Mix.Tasks.Covid19Questionnaire.OpenApi3.GenSpec do
  @moduledoc """
  Generates the OpenAPI 3.0 spec.
  """

  def run([]) do
    Covid19QuestionnaireWeb.Endpoint.start_link()

    Covid19QuestionnaireWeb.ApiSpec.spec()
    |> Jason.encode!(pretty: true, maps: :strict)
    |> (&File.write!("covid19-algorithme-orientation-openapi.json", &1)).()
  end
end
