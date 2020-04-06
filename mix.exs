defmodule Covid19Questionnaire.MixProject do
  use Mix.Project

  def project do
    [
      app: :covid19_questionnaire,
      version: "0.1.0",
      elixir: "~> 1.10",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      releases: [
        covid19_questionnaire: [
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
      mod: {Covid19Questionnaire.Application, []},
      extra_applications: [:logger, :runtime_tools, :ssl]
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
      {:ecto_sql, "~> 3.0"},
      {:jason, "~> 1.2.0"},
      {:open_api_spex, "~> 3.6"},
      {:phoenix, "~> 1.4.16"},
      {:phoenix_pubsub, "~> 1.1"},
      {:plug_attack, "~> 0.3.0"},
      {:plug_cowboy, "~> 2.0"},
      {:postgrex, "~> 0.15.3"},
      {:remote_ip, "~> 0.2.0"},
      {:credo, "~> 1.3.1", only: [:dev, :test], runtime: false}
    ]
  end
end
