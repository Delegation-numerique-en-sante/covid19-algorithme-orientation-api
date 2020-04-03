defmodule Covid19Questionnaire.Data.Repo.Migrations.AddToken do
  use Ecto.Migration

  def up do
    create table(:token, primary_key: false) do
      add(:uuid, :uuid, primary_key: true)
      add(:date, :utc_datetime_usec, null: false)
    end
  end

  def down do
    drop_if_exists table(:token)
  end
end
