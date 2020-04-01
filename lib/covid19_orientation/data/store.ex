defmodule Covid19Orientation.Data.Store do
  alias Covid19Orientation.Data.Repo
  alias Ecto.Adapters.SQL
  @moduledoc """
  Store data in PostgreSQL.
  """

  def write({date, uuid}, data = %{}) do
    SQL.query!(
      Repo, 
      "INSERT INTO journal (date, uuid, data) VALUES($1, $2, $3)",
      [date, uuid, data]
    )

    data
  end

  @spec read(tuple) :: {:ok, map} | {:error, any}
  def read({date, uuid}) do
    select(date, uuid)
  end

  defp select("" <> date, uuid) do
    date
    |> DateTime.from_iso8601()
    |> case do
      {:ok, utc, _} -> select(utc, uuid)
      {:error, error} -> {:error, error}
    end
  end

  defp select(date, uuid) do
    Repo
    |> SQL.query!("SELECT data FROM journal WHERE date = $1 AND uuid = $2", [date, uuid])
    |> Map.get(:rows)
    |> Enum.find(&([_data] = &1))
  end
end
