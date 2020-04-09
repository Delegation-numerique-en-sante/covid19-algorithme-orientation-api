defmodule Covid19Questionnaire.Data.Repo.Migrations.AddExport do
  use Ecto.Migration

  def change do
    create table(:export) do
      add(:date, :date, null: false)
    end
  end
end
