defmodule BlogWeb.Dataloader do
  alias Blog.{Accounts, Articles}
  @behaviour Plug

  def init(opts) do
    opts
  end

  def call(conn, _) do
    Absinthe.Plug.put_options(conn, context: context(conn))
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
