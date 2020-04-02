defmodule Covid19Orientation.Data.Store do
  @moduledoc """
  Store data in PostgreSQL.
  """

  use GenServer

  alias Covid19Orientation.Data.{Journal, Repo}
  alias Ecto.Adapters.SQL

  @tick_interval 1000
  @chunk_size 100

  def write({date, uuid}, orientation = %{}) do
    data = %{
      data: %{orientation | date: date, uuid: uuid}
    }

    GenServer.cast(__MODULE__, {:write, %{date: date, uuid: uuid, data: data}})
    data
  end

  def read(date) do
    select(date)
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
  def handle_cast({:write, element}, [to_write: to_write]) when length(to_write) < @chunk_size do
    new_state = [to_write: [element | to_write]]

    {:noreply, new_state}
  end

  @impl true
  def handle_cast({:write, element}, [to_write: to_write]) do
    insert_many([element | to_write])

    {:noreply, [to_write: []]}
  end

  @impl true
  def handle_info(:tick, [to_write: to_write]) do
    insert_many(to_write)

    tick()
    {:noreply, [to_write: []]}
  end

  #
  # Private functions
  #
  defp tick, do: Process.send_after(__MODULE__, :tick, @tick_interval)

  defp select("" <> date) do
    date
    |> DateTime.from_iso8601()
    |> case do
      {:ok, utc, _} -> select(utc)
      {:error, error} -> {:error, error}
    end
  end

  defp select(date) do
    Repo
    |> SQL.query!("SELECT data FROM journal WHERE date = $1", [date])
    |> Map.get(:rows)
    |> Enum.find(&([_data] = &1))
  end

  defp insert_many(journals) do
    Repo.insert_all(
      Journal,
      journals
    )
  end
end
