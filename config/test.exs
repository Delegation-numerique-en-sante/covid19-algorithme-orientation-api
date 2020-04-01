use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :covid19_questionnaire, Covid19QuestionnaireWeb.Endpoint,
  http: [port: 4002],
  server: false

# Configure PostgreSQL
config :covid19_questionnaire, Covid19Questionnaire.Data.Repo,
  hostname: "127.0.0.1",
  port: 5432,
  username: "test",
  password: "test",
  database: "test"

# Print only warnings and errors during test
config :logger, level: :warn
