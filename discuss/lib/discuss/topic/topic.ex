defmodule Discuss.Topic do
    alias Discuss.Topic.Schema.Topic, as: TopicSchema

   def changeset() do
       TopicSchema.changeset(%TopicSchema{})
   end

   def save(params) do
       %TopicSchema{}
       |> TopicSchema.changeset(params)
       |> Discuss.Repo.insert
   end
end