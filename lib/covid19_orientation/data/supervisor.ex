defmodule Covid19Orientation.Data.Supervisor do
  @moduledoc """
  Data supervisor.
  """

  use Supervisor
  alias Covid19Orientation.Data

  def start_link(_opts) do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @impl true
  def init(:ok) do
    children = [
      {Data.Store, [name: Data.Store]}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
