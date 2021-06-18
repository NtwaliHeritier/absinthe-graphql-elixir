defmodule BlogWeb.Resolvers.PostResolver do
  alias Blog.Articles

  def list_posts(_,_,_) do
    {:ok, Articles.list_posts()}
  end

  def register_post(_,%{input: input},_) do
    Articles.create_post(input)
  end
end
