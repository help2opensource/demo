defmodule Demo.MenusFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Demo.Menus` context.
  """

  @doc """
  Generate a menu.
  """
  def menu_fixture(attrs \\ %{}) do
    {:ok, menu} =
      attrs
      |> Enum.into(%{
        category: "some category",
        code: "some code",
        name: "some name"
      })
      |> Demo.Menus.create_menu()

    menu
  end
end
