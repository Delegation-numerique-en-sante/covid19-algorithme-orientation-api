defmodule Covid19Orientation.Data.PgStore do
  @moduledoc """
  Store data in PostgreSQL

  Test table:
  ```sql
  DROP TABLE IF EXISTS journal;
  CREATE TABLE journal (
      id_internal SERIAL PRIMARY KEY,
      id VARCHAR,
      timestamp TIMESTAMP WITH TIME ZONE,
      data JSONB,
      date_created TIMESTAMP WITH TIME ZONE DEFAULT now()
  );
  ```

  """

  use Agent

  def start_link(_initial) do
    Agent.start_link(
      fn ->
        {:ok, pid} =
          Postgrex.start_link(
            Application.fetch_env!(:covid19_orientation, __MODULE__)[:conn_opts]
          )

        %{pg: pid}
      end,
      name: __MODULE__
    )
  end

  def write({timestamp, id}, data) when is_map(data) do
    Agent.update(__MODULE__, fn state ->
      write_to_pg(state.pg, timestamp, id, data)
      state
    end)

    # Tip: Use cast for even more speed
    # Agent.cast(__MODULE__, fn(state) -> (write_to_pg(state.pg, timestamp, id, data); state) end)
    data
  end

  def write(meta, data) do
    write(meta, Jason.decode(data))
  end

  def write_to_pg(pid, timestamp, id, data) do
    Postgrex.query!(pid, "INSERT INTO journal (id, timestamp, data) VALUES($1, $2, $3)", [
      id,
      timestamp,
      data
    ])
  end
end
