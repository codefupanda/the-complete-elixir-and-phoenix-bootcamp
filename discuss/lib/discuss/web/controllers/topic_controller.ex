defmodule Discuss.Web.TopicController do
    use Discuss.Web, :controller
    alias Discuss.Topic

    plug Discuss.Web.Plug.RequireUser 
            when action in [:new, :create, :edit, :update, :delete]
    plug :check_topic_owner
            when action in [:update, :edit, :delete]

    def index(conn, _params) do
        topics = Topic.findAll()
        render conn, "index.html", topics: topics
    end

    def new(conn, _params) do
        changeset = Topic.changeset
        render conn, "new.html", changeset: changeset
    end

    def create(conn, %{"topic" => topic} = _params) do
        case Topic.save(conn.assigns.user, topic) do
            {:ok, _topic} -> conn
                            |> put_flash(:info, "Topic created successfully")
                            |> redirect(to: topic_path(conn, :index))
            {:error, changeset} -> render conn, "new.html", changeset: changeset
        end
    end

    def edit(conn, %{"id" => id} = _params) do
        topic = Topic.get(id)
        changeset = Topic.changeset(topic)

        render conn, "edit.html", changeset: changeset, topic: topic
    end

    def update(conn, %{"topic" => topic, "id" => strId} = _params) do
        {id, _} = Integer.parse(strId)
        case Topic.update(id, topic) do
            {:ok, _topic} -> conn
                            |> put_flash(:info, "Topic updated successfully")
                            |> redirect(to: topic_path(conn, :index))
            {:error, changeset} -> 
                topic = Topic.get(id)
                render conn, "edit.html", changeset: changeset, topic: topic
        end
    end

    def delete(conn, %{"id" => strId} = _params) do
        {id, _} = Integer.parse(strId)
        Topic.delete(id)
        conn
        |> put_flash(:info, "Deleted")
        |> redirect(to: topic_path(conn, :index))
    end

    def check_topic_owner(conn, _params) do
        %{params: %{"id" => topic_id}} = conn
        topic = Topic.get(topic_id)

        if topic == nil || topic.user_id != conn.assigns.user.id do
            conn
            |> put_flash(:error, "Not your topic")
            |> redirect(to: topic_path(conn, :index))
            |> halt()
        else 
            conn
        end
    end
end