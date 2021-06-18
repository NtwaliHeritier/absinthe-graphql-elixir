defmodule Blog.Articles.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Blog.Articles.Comment
  alias Blog.Accounts.User

  schema "posts" do
    field :content, :string
    field :title, :string
    has_many :comments, Comment
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :content, :user_id])
    |> validate_required([:title, :content, :user_id])
  end
end
