defmodule Covid19OrientationWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :covid19_orientation

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Covid19OrientationWeb.Router
end
