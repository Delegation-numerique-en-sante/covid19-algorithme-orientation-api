defmodule Covid19OrientationWeb.ApiSpec do
  @moduledoc """
  Définittion du schéma des données d'auprès la spécification OpenAPI 3.0
  """

  alias Covid19OrientationWeb.{Endpoint, Router}
  alias OpenApiSpex.{Info, OpenApi, Paths, Server}

  @behaviour OpenApi
  @impl OpenApi
  def spec do
    %OpenApi{
      info: %Info{
        title: "Test d'orientation du Covid-19",
        version: "2020-03-30 20:01:39.836837Z"
      },
      paths: Paths.from_router(Router),
      servers: [Server.from_endpoint(Endpoint)]
    }
    |> OpenApiSpex.resolve_schema_modules()
  end
end
