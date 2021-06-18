defmodule BlogWeb.Schema do
  use Absinthe.Schema
  alias BlogWeb.Resolvers.{PostResolver, CommentResolver, UserResolver, SessionResolver}
  alias Blog.{Articles, Accounts}
  alias BlogAppWeb.Middleware.Authorize
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  query do
    @desc "List users"
    field :users, list_of(:user_type) do
      middleware(Authorize, "admin")
      resolve(&UserResolver.list_users/3)
    end

    @desc "List posts"
    field :posts, list_of(:post_type) do
      middleware(Authorize, :any)
      resolve(&PostResolver.list_posts/3)
    end
  end

  mutation do
    @desc "Register user"
    field :register_user, :session_type do
      arg(:input, non_null(:user_input_type))
      resolve(&UserResolver.register_user/3)
    end

    @desc "Login user"
    field :login_user, :session_type do
      arg(:input, non_null(:user_input_type))
      resolve(&SessionResolver.login/3)
    end

    @desc "Register post"
    field :register_post, :post_type do
      middleware(Authorize, :any)
      arg(:input, non_null(:post_input_type))
      resolve(&PostResolver.register_post/3)
    end

    @desc "Register comment"
    field :register_comment, :comment_type do
      middleware(Authorize, :any)
      arg(:input, non_null(:comment_input_type))
      resolve(&CommentResolver.register_comments/3)
    end
  end

  object :user_type do
    field :id, :id
    field :first_name, :string
    field :last_name, :string
    field :email, :string
  end

  object :session_type do
    field :token, :string
    field :user, :user_type
  end

  object :post_type do
    field :id, :id
    field :title, :string
    field :content, :string
    field :comments, list_of(:comment_type), resolve: dataloader(Article)
    field :user, :user_type, resolve: dataloader(Account)
  end

  object :comment_type do
    field :id, :id
    field :content, :string
    field :post, :post_type, resolve: dataloader(Article)
    field :user, :user_type, resolve: dataloader(Account)
  end

  input_object :user_input_type do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :password, :string
  end

  input_object :post_input_type do
    field :title, non_null(:string)
    field :content, non_null(:string)
  end

  input_object :comment_input_type do
    field :content, non_null(:string)
    field :post_id, non_null(:integer)
  end

  def context(ctx) do
    article_source = Articles.datasource()
    account_source = Accounts.datasource()
    loader = Dataloader.new()
             |> Dataloader.add_source(Article, article_source)
             |> Dataloader.add_source(Account, account_source)
    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
