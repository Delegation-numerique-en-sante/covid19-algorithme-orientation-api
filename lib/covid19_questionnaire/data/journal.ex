defmodule Covid19Questionnaire.Data.Journal do
  @moduledoc false

  use Ecto.Schema
  alias Covid19Questionnaire.Data.Repo

  @primary_key {:uuid, :binary_id, autogenerate: true}

  schema "journal" do
    field(:date, :utc_datetime_usec)
    field(:data, :map)
  end

  def create_many(journals), do: {:ok, Repo.insert_all(__MODULE__, journals)}
  def find("" <> uuid), do: Repo.get(__MODULE__, uuid)
  def find(date = %DateTime{}), do: Repo.get_by(__MODULE__, date: date)
end
