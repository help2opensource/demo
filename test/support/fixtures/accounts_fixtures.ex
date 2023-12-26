defmodule Demo.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Demo.Accounts` context.
  """

  @doc """
  Generate a person.
  """
  def person_fixture(attrs \\ %{}) do
    {:ok, person} =
      attrs
      |> Enum.into(%{
        age: 42,
        name: "some name"
      })
      |> Demo.Accounts.create_person()

    person
  end
end
