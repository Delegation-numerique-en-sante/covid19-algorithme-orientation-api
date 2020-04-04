defmodule Covid19QuestionnaireWeb.ErrorView do
  def render("500.json", conn) do
    %{errors: [conn[:assigns]]}
  end
end
