defmodule Covid19OrientationWeb.Operations.SetTimestamp do
  @moduledoc """
  Set orientation timestamp.
  """

  alias Covid19OrientationWeb.Schemas.Orientation

  @type orientation :: Orientation.t()

  @spec call(orientation) :: orientation

  def call(orientation = %Orientation{}) do
    %Orientation{orientation | timestamp: timestamp()}
  end

  defp timestamp do
    DateTime.utc_now() |> DateTime.to_string()
  end
end
