# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
import Config

config :covid19_questionnaire, Covid19QuestionnaireWeb.Endpoint,
  http: [
    port: {:system, "PORT"},
    transport_options: [
      {:num_acceptors, 2500},
      {:max_connections, :infinity},
      {:socket_opts, [:inet6]}
    ],
    protocol_options: [{:max_keepalive, 20_000_000}, {:timeout, 2000}]
  ],
  url: [scheme: "https", host: System.get_env("PROXY_HOST"), port: 443],
  force_ssl: [rewrite_on: [:x_forwarded_proto]],
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  server: true

# Configure PostgreSQL
config :covid19_questionnaire, Covid19Questionnaire.Data.Repo,
  hostname: System.get_env("PG_HOSTNAME"),
  port: System.get_env("PG_PORT"),
  username: System.get_env("PG_USER"),
  password: System.get_env("PG_PASSWORD"),
  database: System.get_env("PG_DATABASE"),
  pool_size: System.get_env("PG_POOL_SIZE") |> String.to_integer(),
  ssl: true

# Configure CORS
config :cors_plug,
  origin: ["http://localhost:3000" | System.get_env("CORS_WHITELIST") |> String.split(",")],
  headers: ["Accept", "Content-Type", "Origin", "X-Auth-Token", "X-CSRF-Token", "X-Token"],
  methods: ["POST", "OPTIONS"]

# Configure Connive
config :covid19_questionnaire, Covid19QuestionnaireWeb.Plugs.Connive,
  whitelist: ["127.0.0.0/8" | System.get_env("IP_WHITELIST") |> String.split(",")]

# Configure Errors
config :covid19_questionnaire, Covid19QuestionnaireWeb.ErrorView,
  doc_url: System.get_env("DOC_URL"),
  issue_url: System.get_env("ISSUE_URL")

# Do not print debug messages in production
config :logger,
  level: :error,
  compile_time_purge_matching: [[application: :remote_ip], [level_lower_than: :error]]

# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:
#
#     config :covid19_questionnaire, Covid19QuestionnaireWeb.Endpoint, server: true
#
# Then you can assemble a release by calling `mix release`.
# See `mix help release` for more information.
