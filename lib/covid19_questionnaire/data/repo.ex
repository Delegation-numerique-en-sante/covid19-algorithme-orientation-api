defmodule Covid19Questionnaire.Data.Repo do
  use Ecto.Repo,
    otp_app: :covid19_questionnaire,
    adapter: Ecto.Adapters.Postgres
end
