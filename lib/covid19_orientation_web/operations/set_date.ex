defmodule Covid19OrientationWeb.Operations.SetDate do
  @moduledoc """
  Set orientation timestamp.
  """

  alias Covid19OrientationWeb.Schemas.Orientation

  @type orientation :: Orientation.t()

  @spec call(orientation) :: orientation

  def call(orientation = %Orientation{}) do
    %Orientation{orientation | date: date()}
  end

  defp date do
    DateTime.utc_now()
  end
end
