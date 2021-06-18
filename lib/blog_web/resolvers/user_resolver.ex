defmodule BlogWeb.Resolvers.UserResolver do
  alias Blog.Accounts

  def list_users(_,_,_) do
    {:ok, Accounts.list_users()}
  end

  def register_user(_,%{input: input}, _) do
    Accounts.create_user(input)
  end
end
