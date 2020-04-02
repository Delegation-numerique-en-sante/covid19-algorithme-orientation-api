defmodule Covid19Orientation.Data.Repo.Migrations.CreateJournal do
  use Ecto.Migration

  def up do
    execute "DROP INDEX IF EXISTS journal_date_brin;"
    execute "DROP TABLE IF EXISTS journal;"
    
    execute """
    CREATE TABLE journal (
        uuid UUID DEFAULT uuid_generate_v4(),
        date TIMESTAMP WITHOUT TIME ZONE NOT NULL,
        data JSONB NOT NULL,
        PRIMARY KEY(uuid)
    );
    CREATE INDEX journal_date_brin ON journal USING BRIN(date) WITH (pages_per_range = 256);
    """
  end

  def down do
    execute "DROP INDEX IF EXISTS journal_date_brin;"
    execute "DROP TABLE IF EXISTS journal;"
  end
end
