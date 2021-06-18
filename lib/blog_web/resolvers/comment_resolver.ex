defmodule BlogWeb.Resolvers.CommentResolver do
  alias Blog.Articles

  def register_comments(_,%{input: input},%{context: %{current_user: user}}) do
    comment_params = Map.merge(input, %{user_id: user.id})
    Articles.create_comment(comment_params)
  end
end
