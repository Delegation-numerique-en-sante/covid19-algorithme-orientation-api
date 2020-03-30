defmodule Covid19OrientationWeb.Operations.SetId do
  @moduledoc """
  Set orientation ID.
  """

  alias Covid19OrientationWeb.Schemas.Orientation

  @type orientation :: Orientation.t()

  @spec call(orientation) :: orientation

  def call(orientation = %Orientation{}) do
    %Orientation{orientation | id: id()}
  end

  defp id do
    UUID.uuid4()
  end
end
