defmodule Covid19QuestionnaireWeb.Plugs.Connive do
  @moduledoc """
  Establishes a secret bond with the proxy.
  """

  import Plug.Conn
  use PlugAttack
  alias Covid19QuestionnaireWeb.Endpoint
  alias Covid19QuestionnaireWeb.Schemas.Error

  @config Application.fetch_env!(:covid19_questionnaire, __MODULE__)

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
    |> send_resp(
      407,
      Jason.encode!(%{
        error: %Error{
          code: 407,
          info: "Use proxy",
          action: "Please use the proxy available at #{Endpoint.url()}."
        }
      })
    )
    |> halt()
  end

  defp whitelist(%{remote_ip: remote_ip}) do
    [{:whitelist, whitelist}] = @config
    Enum.map(whitelist, &{&1, remote_ip})
  end

  defp contains?({cidr, remote_ip}) do
    cidr
    |> InetCidr.parse()
    |> InetCidr.contains?(remote_ip)
  end
end
