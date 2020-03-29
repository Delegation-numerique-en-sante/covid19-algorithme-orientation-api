defmodule Covid19Orientation.Data.Store do
  @moduledoc """
  Store and retrive data.
  """

  use GenServer

  @ets_table_name :orientations
  @log_limit 1_000_000_000

  def start_link(opts \\ []) do
    GenServer.start_link(
      __MODULE__,
      [
        {:ets_table_name, @ets_table_name},
        {:log_limit, @log_limit}
      ],
      opts
    )
  end

  def get(timestamp) do
    case GenServer.call(__MODULE__, {:get, timestamp}) do
      [] -> {:not_found}
      [{_timestamp, orientation}] -> {:found, orientation}
    end
  end

  def set(orientation) do
    GenServer.call(__MODULE__, {:set, timestamp(), orientation})
    {:ok, timestamp}
  end

  defp timestamp do
    :os.system_time(:millisecond)
  end

  # GenServer callbacks

  def handle_call({:get, key}, _from, state) do
    %{ets_table_name: ets_table_name} = state
    result = :ets.lookup(ets_table_name, key)
    {:reply, result, state}
  end

  def handle_call({:set, key, value}, _from, state) do
    %{ets_table_name: ets_table_name} = state
    true = :ets.insert(ets_table_name, {key, value})
    {:reply, value, state}
  end

  def init(args) do
    [{:ets_table_name, ets_table_name}, {:log_limit, log_limit}] = args
    :ets.new(ets_table_name, [:named_table, :set, :public])
    {:ok, %{log_limit: log_limit, ets_table_name: ets_table_name}}
  end
end
