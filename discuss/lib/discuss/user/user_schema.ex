defmodule Discuss.User.Schema.User do
    use Discuss.Schema
    
    schema "users" do
        field :email, :string
        field :provider, :string
        field :token, :string
        has_many :topics, Discuss.Topic.Schema.Topic
    end

    def changeset(schema, params \\ %{}) do
        schema
        |> cast(params, [:email, :provider, :token])
        |> validate_required([:email, :provider, :token])
    end
end