defmodule Discuss.Web.TopicController do
    use Discuss.Web, :controller

    alias Discuss.Topic

    def new(conn, _params) do
        changeset = Topic.changeset
        render conn, "new.html", changeset: changeset
    end

    def create(conn, %{"topic" => topic} = _params) do
        Topic.save(topic)
        #TODO: Send success
        new(conn, %{})
    end
end