defmodule Demo.AccountsTest do
  use Demo.DataCase

  alias Demo.Accounts

  describe "persons" do
    alias Demo.Accounts.Person

    import Demo.AccountsFixtures

    @invalid_attrs %{name: nil, age: nil}

    test "list_persons/0 returns all persons" do
      person = person_fixture()
      assert Accounts.list_persons() == [person]
    end

    test "get_person!/1 returns the person with given id" do
      person = person_fixture()
      assert Accounts.get_person!(person.id) == person
    end

    test "create_person/1 with valid data creates a person" do
      valid_attrs = %{name: "some name", age: 42}

      assert {:ok, %Person{} = person} = Accounts.create_person(valid_attrs)
      assert person.name == "some name"
      assert person.age == 42
    end

    test "create_person/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_person(@invalid_attrs)
    end

    test "update_person/2 with valid data updates the person" do
      person = person_fixture()
      update_attrs = %{name: "some updated name", age: 43}

      assert {:ok, %Person{} = person} = Accounts.update_person(person, update_attrs)
      assert person.name == "some updated name"
      assert person.age == 43
    end

    test "update_person/2 with invalid data returns error changeset" do
      person = person_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_person(person, @invalid_attrs)
      assert person == Accounts.get_person!(person.id)
    end

    test "delete_person/1 deletes the person" do
      person = person_fixture()
      assert {:ok, %Person{}} = Accounts.delete_person(person)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_person!(person.id) end
    end

    test "change_person/1 returns a person changeset" do
      person = person_fixture()
      assert %Ecto.Changeset{} = Accounts.change_person(person)
    end
  end
end
