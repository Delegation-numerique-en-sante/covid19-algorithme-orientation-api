defmodule Covid19Questionnaire.Data.Store do
  @moduledoc """
  Store data in PostgreSQL.
  """

  use GenServer
  alias Covid19Questionnaire.Data.Journal

  @tick_interval 1000
  @chunk_size 100

  def write({date, token}, questionnaire = %{metadata: metadata}) do
    duration = DateTime.diff(date, token.date)
    metadata = %{metadata | date: date, duration: duration}
    questionnaire = %{questionnaire | token: token, metadata: metadata}
    data = %{data: questionnaire}

    GenServer.cast(__MODULE__, {:write, %{date: date, data: data}})
    {:ok, data}
  end

  def tick_interval, do: @tick_interval

  #
  # GenServer Part
  #

  def start_link(_) do
    GenServer.start_link(__MODULE__, [to_write: []], name: __MODULE__)
  end

  @impl true
  def init(_) do
    tick()
    {:ok, [to_write: []]}
  end

  @impl true
  def handle_cast({:write, element}, to_write: to_write) when length(to_write) < @chunk_size do
    new_state = [to_write: [element | to_write]]

    {:noreply, new_state}
  end

  @impl true
  def handle_cast({:write, element}, to_write: to_write) do
    spawn(fn -> Journal.create_many([element | to_write]) end)

    {:noreply, [to_write: []]}
  end

  @impl true
  def handle_info(:tick, to_write: to_write) do
    spawn(fn -> Journal.create_many(to_write) end)

    tick()
    {:noreply, [to_write: []]}
  end

  #
  # Private functions
  #
  defp tick, do: Process.send_after(__MODULE__, :tick, @tick_interval)
end
