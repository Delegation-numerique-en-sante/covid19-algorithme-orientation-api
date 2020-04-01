defmodule Covid19Questionnaire.Data.Token do
    use Ecto.Schema
    import Ecto.Changeset
    alias Covid19Questionnaire.Data.Repo

    @primary_key {:id, :binary_id, autogenerate: true}

    schema "token" do
        timestamps()
    end

    def create(), do: Repo.insert(%__MODULE__{})
end
