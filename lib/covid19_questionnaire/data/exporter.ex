defmodule Covid19Questionnaire.Data.Exporter do
  @moduledoc false
  alias Covid19Questionnaire.Data.{Export, Journal, Repo}
  import Ecto.Query

  @chunk_size 500
  @config Application.get_env(:covid19_questionnaire, __MODULE__)

  def export(date = %Date{}) do
    str_date = Date.to_iso8601(date)
    conn = connection()

    source_stream =
      Stream.resource(
        fn -> 0 end,
        fn
          :stop ->
            {:halt, :stop}

          offset ->
            rows = Repo.all(from(query(date), limit: ^@chunk_size, offset: ^offset))

            if Enum.count(rows) < @chunk_size do
              {rows, :stop}
            else
              {rows, offset + @chunk_size}
            end
        end,
        fn _ -> :ok end
      )

    target_filename = root_export() <> str_date <> ".export.json"
    part_filename = target_filename <> ".part"

    target_stream =
      SFTPClient.stream_file!(
        conn,
        part_filename
      )

    source_stream
    |> Stream.map(&(Jason.encode!(%{date: &1.date, data: &1.data}) <> "\n"))
    |> Stream.into(target_stream)
    |> Stream.run()

    SFTPClient.rename(conn, part_filename, target_filename)

    SFTPClient.disconnect(conn)
    Repo.insert(%Export{date: date})
  end

  def export do
    start_date()
    |> Date.range(yesterday())
    |> Enum.each(&export/1)
  end

  def query(date) do
    from(j in Journal,
      where: fragment("date(?)", j.date) == ^date
    )
  end

  # Helpers

  @doc """
  Next day of the last export.
  """
  @spec start_date :: nil | Date.t()
  def start_date do
    case last_export() do
      nil -> nil
      exp -> exp |> Date.add(1)
    end
  end

  @doc """
  Yesterday.
  """
  @spec yesterday :: Date.t()
  def yesterday do
    Date.utc_today() |> Date.add(-1)
  end

  # Private

  @spec last_export :: nil | Date.t()
  defp last_export do
    case Repo.aggregate(Export, :max, :date) do
      nil ->
        query = from(journal in Journal, select: min(fragment("date(?)", journal.date)))
        Repo.one(query)

      min ->
        min
    end
  end

  defp connection do
    SFTPClient.connect!(sftp())
  end

  defp sftp do
    @config[:sftp]
  end

  defp root_export do
    @config[:root_export]
  end
end
