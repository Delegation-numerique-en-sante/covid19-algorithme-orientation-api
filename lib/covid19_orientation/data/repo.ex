defmodule Covid19Orientation.Data.Repo do
  use Ecto.Repo,
    otp_app: :covid19_orientation,
    adapter: Ecto.Adapters.Postgres
end
