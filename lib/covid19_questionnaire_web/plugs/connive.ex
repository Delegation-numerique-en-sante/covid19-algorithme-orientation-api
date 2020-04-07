defmodule Covid19QuestionnaireWeb.Plugs.Connive do
  @moduledoc """
  Establishes a secret bond with the proxy.
  """

  import Plug.Conn
  use PlugAttack

  rule "connive", conn do
    conn
    |> whitelist()
    |> Enum.any?(&contains?/1)
    |> Kernel.!()
    |> block
  end

  def block_action(conn, _data, _opts) do
    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(407, "")
    |> halt()
  end

  defp whitelist(%{remote_ip: remote_ip}) do
    config()[:whitelist] |> Enum.map(&{&1, remote_ip})
  end

  defp contains?({cidr, remote_ip}) do
    cidr
    |> InetCidr.parse()
    |> InetCidr.contains?(remote_ip)
  end

  defp config do
    Application.fetch_env!(:covid19_questionnaire, __MODULE__)
  end
end
