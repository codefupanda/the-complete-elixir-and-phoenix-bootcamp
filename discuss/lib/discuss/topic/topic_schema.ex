defmodule Discuss.Topic.Schema.Topic do
    use Discuss.Schema

    schema "topics" do
        field :title, :string
    end

    def changeset(schema, params \\ %{}) do
        schema
        |> cast(params, [:title])
        |> validate_required([:title])
    end
end