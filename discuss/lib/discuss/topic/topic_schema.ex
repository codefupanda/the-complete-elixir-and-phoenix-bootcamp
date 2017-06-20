defmodule Discuss.Topic.Schema.Topic do
    use Discuss.Schema

    schema "topics" do
        field :title, :string
        belongs_to :user, Discuss.User.Schema.User
    end

    def changeset(schema, params \\ %{}) do
        schema
        |> cast(params, [:title])
        |> validate_required([:title])
    end

    def changeset_assoc(user, params) do
        user
        |> Ecto.build_assoc(:topics)
        |> changeset(params)
    end
end