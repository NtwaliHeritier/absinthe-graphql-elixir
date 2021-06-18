defmodule BlogWeb.Resolvers.UserResolver do
  alias Blog.Accounts
  alias Blog.Guardian

  def list_users(_,_,_) do
    {:ok, Accounts.list_users()}
  end

  def register_user(_,%{input: input}, _) do
    {:ok, user} = Accounts.create_user(input)
    with {:ok, token, _} <- Guardian.encode_and_sign(user) do
      {:ok, %{token: token, user: user}}
    end
  end
end
