defmodule Discuss.User do

    alias Discuss.User.Schema.User, as: UserSchema
    alias Discuss.Repo

    def get(user_id) do
        Repo.get(UserSchema, user_id)
    end

    def save(user_params) do
        %UserSchema{}
        |> UserSchema.changeset(user_params)
        |> insert_or_update
    end

    def insert_or_update(changeset) do
        case Repo.get_by(UserSchema, email: changeset.changes.email) do
           nil -> Repo.insert changeset
           user -> {:ok, user} 
        end
    end
end