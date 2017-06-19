defmodule Discuss.Topic do
    alias Discuss.Topic.Schema.Topic, as: TopicSchema

    def findAll() do
        Discuss.Repo.all(TopicSchema)
    end 

    def get(id) do
        Discuss.Repo.get(TopicSchema, id)
    end

    def save(params) do
        %TopicSchema{}
        |> TopicSchema.changeset(params)
        |> Discuss.Repo.insert
    end

    def update(id, params) do
        %TopicSchema{id: id}
        |> TopicSchema.changeset(params)
        |> Discuss.Repo.update
    end

    def delete(id) do
        TopicSchema
        |> Discuss.Repo.get!(id)
        |> Discuss.Repo.delete!
    end

    def changeset() do
        TopicSchema.changeset(%TopicSchema{})
    end

    def changeset(topic) do
        TopicSchema.changeset(topic)
    end
end