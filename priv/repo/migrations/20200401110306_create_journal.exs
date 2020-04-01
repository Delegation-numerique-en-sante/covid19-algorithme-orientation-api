defmodule Covid19Questionnaire.Data.Repo.Migrations.CreateJournal do
  use Ecto.Migration

  def up do
    execute "DROP TABLE IF EXISTS journal;"

    execute """
    CREATE TABLE journal (
        date TIMESTAMP WITHOUT TIME ZONE NOT NULL,
        uuid VARCHAR NOT NULL,
        data JSONB NOT NULL
    );
    """
  end

  def down do
    execute "drop table journal;"
  end
end
