defmodule Covid19QuestionnaireWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :covid19_questionnaire

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Covid19QuestionnaireWeb.Router
end
