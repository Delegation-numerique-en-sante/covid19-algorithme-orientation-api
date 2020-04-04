defmodule Covid19Questionnaire.Data.Token do
  @moduledoc false

  use Ecto.Schema
  alias Covid19Questionnaire.Data.Repo

  @derive {Jason.Encoder, except: [:__meta__, :__struct__]}
  @primary_key {:uuid, :binary_id, autogenerate: true}

  schema "token" do
    field(:date, :utc_datetime_usec)
  end

  def create, do: Repo.insert(%__MODULE__{date: DateTime.utc_now()})

  def find(uuid) do
    case Ecto.UUID.cast(uuid) do
      :error -> nil
      _ -> Repo.get(__MODULE__, uuid)
    end
  end
end
