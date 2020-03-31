defmodule Covid19Orientation.Data.StorePg do
  @moduledoc """
  Store data in PostgreSQL

  Test table:

  DROP TABLE IF EXISTS journal;
  CREATE TABLE journal (
      id VARCHAR,
      timestamp TIMESTAMP WITH TIME ZONE,
      data JSONB,
      date_created TIMESTAMP WITH TIME ZONE DEFAULT now()
  );

  """

  use Agent

  def start_link(_initial) do
    Agent.start_link(
        fn -> 
            {:ok, pid} = Postgrex.start_link(hostname: "localhost", username: "test", password: "test", database: "test")
            %{pg: pid}
        end, name: __MODULE__)
  end

  def write({timestamp, id}, data) do
    Agent.update(__MODULE__, fn(state) -> (write_to_pg(state.pg, timestamp, id, data); state) end)
  end

  def write_to_pg(pid, timestamp, id, data) do
    Postgrex.query!(pid, "INSERT INTO journal (id, timestamp, data) VALUES($1, $2, $3)", [id, timestamp, data])
  end

end
