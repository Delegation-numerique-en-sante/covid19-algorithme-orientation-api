defmodule Covid19QuestionnaireWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :covid19_questionnaire
  alias Covid19QuestionnaireWeb.Plugs.Connive

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug RemoteIp
  plug Connive
  plug Covid19QuestionnaireWeb.Router
end
