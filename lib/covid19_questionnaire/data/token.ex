defmodule Covid19Questionnaire.Data.Token do
  @moduledoc false
  @endpoint Covid19QuestionnaireWeb.Endpoint
  @max_age 3600

  def create do
    now = DateTime.utc_now
    dt = DateTime.to_unix(now, :microsecond)
    {:ok, %{
        uuid: Phoenix.Token.encrypt(@endpoint, secret(), dt),
        date: now
      }
    }
  end

  def decrypt(token) do
    case Phoenix.Token.decrypt(@endpoint, secret(), token, max_age: @max_age) do
      {:ok, dt} ->
        DateTime.from_unix(dt, :microsecond)
      {:error, error} -> {:error, error}
    end
  end

  defp secret do
    :covid19_questionnaire
    |> Application.get_env(@endpoint)
    |> Keyword.get(:secret_key_base)
  end
end
