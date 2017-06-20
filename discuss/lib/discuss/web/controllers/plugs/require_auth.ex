defmodule Discuss.Web.Plug.RequireUser do

   import Plug.Conn
   import Phoenix.Controller
   import Discuss.Web.Router.Helpers

   def init(_params) do
       :ok
   end

   def call(conn, _params) do
       if conn.assigns[:user] do
           conn
       else
           conn
           |> put_flash(:error, "Loggin please")
           |> redirect(to: topic_path(conn, :index))
           |> halt()
       end
   end
end
