defmodule PhoenixGuardian.AuthorizationController do
  use PhoenixGuardian.Web, :controller

  alias PhoenixGuardian.Repo

  def index(conn, _params, current_user, _claims) do
    render conn, "index.html", current_user: current_user, authorizations: authorizations(current_user)
  end

  defp authorizations(user) do
    user = user |> Repo.preload(:authorizations)
    user.authorizations
  end
end
