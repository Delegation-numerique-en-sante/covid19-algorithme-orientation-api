defmodule Covid19Questionnaire.Data.Exporter do
    alias Covid19Questionnaire.Data.{Export, Journal, Repo}
    import Ecto.Query

    @chunk_size 500

    def export(nil), do: :pass
    def export(false), do: :pass
    def export("false"), do: :pass
    def export(0), do: :pass

    def export(%Date{} = date) do
        str_date = Date.to_iso8601(date)
        conn = sftp_connection()

        source_stream =
            Stream.resource(
                fn -> 0 end,
                fn
                    :stop -> {:halt, :stop}
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
        
        target_filename = root_export <> str_date <> ".export.json"    
        part_filename = target_filename <> ".part"
        target_stream = SFTPClient.stream_file!(
            conn,
            part_filename
        )

        source_stream
        |> Stream.map(& Jason.encode!(%{date: &1.date, data: &1.data}) <> "\n")
        |> Stream.into(target_stream)
        |> Stream.run()

        SFTPClient.rename(conn, part_filename, target_filename)

        SFTPClient.disconnect(conn)
        Repo.insert(%Export{date: date})
    end

    def export(_) do
        min_date =
            case Repo.aggregate(Export, :min, :date) do
                nil ->
                    query = from j in Journal, select: min(fragment("date(?)", j.date))
                    Repo.one(query)
                min -> min
            end
            |> Date.add(1)

        max_date = Date.utc_today() |> Date.add(-1)

        date_range = Date.range(min_date, max_date)
        Enum.each(date_range, &export/1)
    end

    defp sftp_connection do
        SFTPClient.connect!(ftp_config)
    end

    defp ftp_config, do: Application.get_env(:covid19_questionnaire, __MODULE__)[:sftp]

    def query(date) do
        from j in Journal,
            where: fragment("date(?)", j.date) == ^date
    end

    defp root_export, do: Application.get_env(:covid19_questionnaire, __MODULE__)[:root_export]
end