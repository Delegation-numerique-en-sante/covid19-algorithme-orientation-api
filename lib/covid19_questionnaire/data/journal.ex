defmodule Covid19Questionnaire.Data.Journal do
  @moduledoc false

  use Ecto.Schema

  schema "journal" do
    field(:date, :utc_datetime_usec)
    field(:uuid, :string)
    field(:data, :map)
  end
end
