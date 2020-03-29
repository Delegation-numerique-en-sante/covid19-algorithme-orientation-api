defmodule Covid19Orientation.Data.Store do
  @moduledoc """
  Store and retrive data.
  """

  use GenServer

  @file_name "data.tab"
  @table_name :orientations

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, [{:file_name, @file_name}, {:table_name, @table_name}], opts)
  end

  def get(id, timestamp) do
    case GenServer.call(__MODULE__, {:get, {id, timestamp}}) do
      [] -> {:not_found}
      [{{_id, _timestamp}, orientation}] -> {:found, orientation}
    end
  end

  def set(orientation = %{id: id, timestamp: timestamp}) do
    GenServer.call(__MODULE__, {:set, {id, timestamp}, orientation})
    {:ok, orientation}
  end

  # GenServer callbacks

  def handle_call({:get, key}, _from, state) do
    %{table_name: table_name} = state
    result = :ets.lookup(table_name, key)
    {:reply, result, state}
  end

  def handle_call({:set, key, value}, _from, state) do
    %{table_name: table_name} = state
    true = :ets.insert(table_name, {key, value})
    {:reply, value, state}
  end

  def init(args) do
    [{:file_name, file_name}, {:table_name, table_name}] = args
    PersistentEts.new(table_name, file_name, [:named_table, :set, :public])
    {:ok, %{file_name: file_name, table_name: table_name}}
  end
end
