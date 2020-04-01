defmodule Covid19Orientation.Data.Store do
  @moduledoc """
  Store data in PostgreSQL.

  Test table:

  ```sql
  DROP TABLE IF EXISTS journal;
  CREATE TABLE journal (
      date TIMESTAMP WITHOUT TIME ZONE NOT NULL,
      uuid VARCHAR NOT NULL,
      data JSONB NOT NULL
  );
  ```
  """

  use Agent

  def start_link(_initial) do
    Agent.start_link(
      fn ->
        settings = Application.fetch_env!(:covid19_orientation, __MODULE__)[:conn_opts]
        {:ok, pid} = Postgrex.start_link(settings)
        {:pid, pid}
      end,
      name: __MODULE__
    )
  end

  def write({date, uuid}, data = %{}) do
    Agent.update(__MODULE__, fn state ->
      insert(state, date, uuid, data)
      state
    end)

    data

    # Tip: Use cast for even more speed
    # Agent.cast(__MODULE__, fn(state) -> (write_to_pg(state.pg, timestamp, id, data); state) end)
  end

  @spec read(tuple) :: {:ok, map} | {:error, any}

  def read({date, uuid}) do
    Agent.get(__MODULE__, &select(&1, date, uuid))
  end

  defp insert({:pid, pid}, date, uuid, data) do
    Postgrex.query!(pid, "INSERT INTO journal (date, uuid, data) VALUES($1, $2, $3)", [
      date,
      uuid,
      data
    ])
  end

  defp select({:pid, pid}, "" <> date, uuid) do
    date
    |> DateTime.from_iso8601()
    |> case do
      {:ok, utc, _} -> select({:pid, pid}, utc, uuid)
      {:error, error} -> {:error, error}
    end
  end

  defp select({:pid, pid}, date, uuid) do
    pid
    |> Postgrex.query!("SELECT data FROM journal WHERE date = $1 AND uuid = $2", [date, uuid])
    |> Map.get(:rows)
    |> Enum.find(&([_data] = &1))
  end
end
