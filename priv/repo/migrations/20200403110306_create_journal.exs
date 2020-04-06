defmodule Covid19Questionnaire.Data.Repo.Migrations.CreateJournal do
  use Ecto.Migration

  def up do
    create table(:journal, primary_key: false) do
      add(:uuid, :uuid, primary_key: true)
      add(:date, :utc_datetime_usec, null: false)
      add(:data, :jsonb, null: false)
    end
  end

  def down do
    drop table(:journal)
  end
end
