defmodule Discuss.Plug.ValidateUser do
    import Plug.Conn
    import Phoenix.Controller

    alias Discuss.Repo
    alias Discuss.User
    alias Discuss.Router.Helpers

    def init(_params) do
        :ok
    end

    def call(conn, _params) do
        user_id = get_session(conn, :user_id)
        assign(conn, :user, user_id && User.get(user_id))
    end
end