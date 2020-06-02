defmodule Covid19Questionnaire.Data.Export do
  @moduledoc false

  use Ecto.Schema
  alias Covid19Questionnaire.Data.Repo

  schema "export" do
    field(:date, :date)
  end
end
