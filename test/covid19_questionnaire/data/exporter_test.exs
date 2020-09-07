defmodule Covid19Questionnaire.Data.ExporterTest do
  use ExUnit.Case, async: false
  alias Covid19Questionnaire.Data.{Export, Exporter, Journal, Repo}

  setup do
    cleanup()
    on_exit(&cleanup/0)
  end

  describe "start_date" do
    test "when there is no previous export" do
      assert Exporter.start_date() == nil
    end

    test "when there is no previous export but there is a journal" do
      date = DateTime.utc_now() |> DateTime.add(60 * 60 * 24 * 3 * -1, :second)
      {:ok, {1, nil}} = Journal.create_many([%{date: date, data: %{}}])
      assert Exporter.start_date() == Exporter.yesterday() |> Date.add(-1)
    end

    test "when there is one previous export" do
      Repo.insert(%Export{date: Exporter.yesterday() |> Date.add(-1)})
      assert Exporter.start_date() == Exporter.yesterday()
      Repo.delete_all(Export)
    end

    test "when there is at least two previous exports" do
      Repo.insert(%Export{date: Exporter.yesterday() |> Date.add(-1)})
      Repo.insert(%Export{date: Exporter.yesterday() |> Date.add(-3)})
      assert Exporter.start_date() == Exporter.yesterday()
      Repo.delete_all(Export)
    end
  end

  defp cleanup do
    Repo.delete_all(Export)
    Repo.delete_all(Journal)
    :ok
  end
end
