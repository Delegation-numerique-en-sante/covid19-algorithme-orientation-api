defmodule Covid19OrientationWeb.Operations.PopulateConclusion do
  @moduledoc """
  Populate conclusion.
  """

  alias Covid19OrientationWeb.Schemas.{Conclusion, Orientation}

  @type orientation :: Orientation.t()
  @type code :: String.t()

  @spec call(orientation, code) :: orientation

  def call(orientation = %Orientation{}, code) do
    %Orientation{
      orientation
      | conclusion: %Conclusion{code: code}
    }
  end
end
