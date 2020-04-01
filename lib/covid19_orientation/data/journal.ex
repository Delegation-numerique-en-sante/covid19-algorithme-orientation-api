defmodule Covid19Orientation.Data.Journal do
    use Ecto.Schema
    import Ecto.Changeset

    schema "journal" do
        field :date, :utc_datetime_usec
        field :uuid, :string
        field :data, :map 
    end
end