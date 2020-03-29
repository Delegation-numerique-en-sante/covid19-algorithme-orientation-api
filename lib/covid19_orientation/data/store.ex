defmodule Covid19Orientation.Data.Store do
  @moduledoc """
  Store and retrive data.
  """

  use Nebulex.Cache, otp_app: :nebulex, adapter: NebulexRedisAdapter

  def write({timestamp, id}, data) do
    set("#{timestamp}:#{id}", data)
  end

  def read({timestamp, id}) do
    get("#{timestamp}:#{id}")
  end
end
