defmodule Covid19Questionnaire.Data.Repo.Migrations.CreateJournal do
  use Ecto.Migration

  def up do
    create table(:journal, primary_key: false) do
      add(:uuid, :uuid, primary_key: true)
      add(:date, :utc_datetime_usec, null: false)
      add(:data, :jsonb, null: false)
    end

    create index(:journal, [:date], using: :brin)
    create index(:journal, [:data], using: :gin)
  end

  def down do
    drop index(:journal, [:data])
    drop index(:journal, [:date])
    drop table(:journal)
  end
end
