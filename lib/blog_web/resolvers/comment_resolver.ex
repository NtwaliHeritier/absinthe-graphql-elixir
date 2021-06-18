defmodule BlogWeb.Resolvers.CommentResolver do
  alias Blog.Articles

  def register_comments(_,%{input: input},_) do
    Articles.create_comment(input)
  end
end
