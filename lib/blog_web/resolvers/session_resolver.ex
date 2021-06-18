defmodule BlogWeb.Resolvers.SessionResolver do
  alias Blog.Session
  alias Blog.Guardian

  def login(_,%{iput: input},_) do
    with {:ok, user} <- Session.authenticate(input),
          {:ok, token, _} <- Guardian.encode_and_sign(user)
    do
      {:ok, %{token: token, user: user}}
    end
  end
end
