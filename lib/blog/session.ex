defmodule Blog.Session do
  alias Blog.Repo
  alias Blog.Accounts.User

  def authenticate(arg) do
    user = Repo.get_by!(User, email: arg.email)
    case verify_password(user, arg) do
      true -> {:ok, user}
      _ -> :error
    end
  end

  defp verify_password(user, arg) do
    case user do
      nil ->
        false
       user ->
        user.password == arg.password
    end
  end
end
