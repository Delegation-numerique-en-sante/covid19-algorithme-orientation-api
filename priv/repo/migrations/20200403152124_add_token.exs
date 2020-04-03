defmodule Covid19Orientation.Data.Repo.Migrations.AddToken do
  use Ecto.Migration

  def change do
    create table(:token, primary_key: false) do
      add :id, :uuid, primary_key: true

      timestamps
    end
  end
end
