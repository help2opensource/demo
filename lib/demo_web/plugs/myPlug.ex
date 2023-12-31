defmodule DemoWeb.Plugs.MyPlug do
  import Plug.Conn

  def init(default), do: default

  def call(conn, _opts) do
    # Do some processing or fetch data
    data_to_pass = "Hello from the Plug!"

    # Assign the data to the connection
    conn
    |> put_session(:my_data, data_to_pass)
    |> put_session(:name, "zhao zengjian")
  end
end
