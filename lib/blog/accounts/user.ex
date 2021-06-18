defmodule Blog.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Blog.Articles.{Post, Comment}

  schema "users" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :password, :string
    field :role, :string, default: "user", null: false
    has_many :posts, Post
    has_many :comments, Comment

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email, :password])
    |> validate_required([:first_name, :last_name, :email, :password])
  end
end
