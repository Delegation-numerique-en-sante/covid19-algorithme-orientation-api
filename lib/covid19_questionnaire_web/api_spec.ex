defmodule Covid19QuestionnaireWeb.ApiSpec do
  @moduledoc """
  Définittion du schéma des données d'auprès la spécification OpenAPI 3.0
  """

  alias Covid19QuestionnaireWeb.{Endpoint, Router}
  alias OpenApiSpex.{Info, OpenApi, Paths, Server}

  @behaviour OpenApi
  @impl OpenApi
  def spec do
    %OpenApi{
      info: %Info{
        title: "API d'orientation COVID19",
        version: "2020-04-16"
      },
      paths: Paths.from_router(Router),
      servers: [Server.from_endpoint(Endpoint)]
    }
    |> OpenApiSpex.resolve_schema_modules()
  end
end
