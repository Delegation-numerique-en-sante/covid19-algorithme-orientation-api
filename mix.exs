defmodule Covid19Orientation.MixProject do
  use Mix.Project

  def project do
    [
      app: :covid19_orientation,
      version: "0.1.0",
      elixir: "~> 1.10",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      releases: [
        covid19_orientation: [
          include_executables_for: [:unix],
          steps: [:assemble, :tar]
        ]
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Covid19Orientation.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:elixir_uuid, "~> 1.2"},
      {:jason, "~> 1.2.0"},
      {:nebulex_redis_adapter, "~> 1.1"},
      {:open_api_spex, "~> 3.6"},
      {:phoenix, "~> 1.4.16"},
      {:phoenix_pubsub, "~> 1.1"},
      {:plug_cowboy, "~> 2.0"},
      {:credo, "~> 1.3.1", only: [:dev, :test], runtime: false},
      {:postgrex, "~> 0.15.3"},
    ]
  end
end
