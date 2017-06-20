defmodule Discuss.Web.AuthController do
    use Discuss.Web, :controller
    plug Ueberauth

    alias Discuss.User

    def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
        user_params = %{token: auth.credentials.token, 
                        email: auth.info.email,
                        provider: params["provider"]}
        case User.save(user_params) do
            {:ok, user} ->
                conn
                |> put_session(:user_id, user.id)
                |> put_flash(:info, "Welcome to Discuss")
                |> redirect(to: topic_path(conn, :index))
            {:error, _changeset} ->
                conn
                |> put_flash(:error, "Error")
                |> redirect(to: topic_path(conn, :index))
        end
    end

    def signout(conn, _params) do
        conn
        |> configure_session(drop: true)
        |> put_flash(:info, "Logged out")
        |> redirect(to: topic_path(conn, :index))
    end
end