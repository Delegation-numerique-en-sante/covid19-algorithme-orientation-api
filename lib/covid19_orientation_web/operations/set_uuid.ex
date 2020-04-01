defmodule Covid19OrientationWeb.Operations.SetUUID do
  @moduledoc """
  Set orientation ID.
  """

  alias Covid19OrientationWeb.Schemas.Orientation

  @type orientation :: Orientation.t()

  @spec call(orientation) :: orientation

  def call(orientation = %Orientation{}) do
    %Orientation{orientation | uuid: uuid()}
  end

  defp uuid do
    UUID.uuid1()
  end
end
