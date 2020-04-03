defmodule Covid19Orientation.Data.Token do
    use Ecto.Schema
    import Ecto.Changeset
    alias Covid19Orientation.Data.Repo

    @primary_key {:id, :binary_id, autogenerate: true}

    schema "token" do
        timestamps()
    end

    def create(), do: Repo.insert(%__MODULE__{})
end