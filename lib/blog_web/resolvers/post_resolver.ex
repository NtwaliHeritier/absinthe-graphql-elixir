defmodule BlogWeb.Resolvers.PostResolver do
  alias Blog.Articles
  alias BlogWeb.ChangesetErrors

  def list_posts(_,_,_) do
    {:ok, Articles.list_posts()}
  end

  def register_post(_,%{input: input},%{context: %{current_user: user}}) do
    post_params = Map.merge(input, %{user_id: user.id})
    case Articles.create_post(post_params) do
      {:error, changeset} ->
        {:error, message: "Post not created", details: ChangesetErrors.error_details(changeset)}
      {:ok, post} -> {:ok, post}
    end
  end
end
