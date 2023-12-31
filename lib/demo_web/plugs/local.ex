defmodule DemoWeb.Plugs.Locale do
  import Plug.Conn

  @locales ["en", "fr", "de"]

  def init(default), do: default

  def call(%Plug.Conn{params: %{"locale" => loc}} = conn, _default) when loc in @locales do
    conn
    |> put_session(:locale, loc)
  end

  def call(conn, default) do
    conn
    |> put_session(:locale, default)
  end
end
