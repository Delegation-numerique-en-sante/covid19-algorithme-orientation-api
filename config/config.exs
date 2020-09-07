# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :covid19_questionnaire, Covid19QuestionnaireWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "v0VEXqMoyB/o5vDkIEXW1/bPRK1DYFCtx7n15FHTpHn2P2CB6poIHmoNugyH9X3e",
  render_errors: [view: Covid19QuestionnaireWeb.ErrorView, accepts: ~w(json)]

# Configure Errors
config :covid19_questionnaire, Covid19QuestionnaireWeb.ErrorView,
  doc_url: "https://github.com/Delegation-numerique-en-sante/covid19-algorithme-orientation",
  issue_url:
    "https://github.com/Delegation-numerique-en-sante/covid19-algorithme-orientation-api/issues/new",
  schema_url:
    "https://github.com/Delegation-numerique-en-sante/covid19-algorithme-orientation-schema-donnees"

# Use Poison for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :covid19_questionnaire, ecto_repos: [Covid19Questionnaire.Data.Repo]

config :covid19_questionnaire, Covid19Questionnaire.Data.Exporter,
  sftp: [
    host: System.get_env("SFTP_HOST"),
    port: 22,
    user: System.get_env("SFTP_USER"),
    password: System.get_env("SFTP_PASSWORD")
  ],
  root_export: System.get_env("SFTP_ROOT_EXPORT")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
