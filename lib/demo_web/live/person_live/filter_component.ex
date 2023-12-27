defmodule DemoWeb.PersonLive.FilterComponent do
  use DemoWeb, :live_component

  alias DemoWeb.Forms.FilterForm

  def render(assigns) do
    ~H"""
    <div id="table-filter">
    <.simple_form
        :let={f}
        for={@changeset}
        id="person-form-search"
        phx-target={@myself}
        as="filter"
        phx-submit="search"
      >
       <.input field={{f, :name}} type="text" name="name" value={@changeset.data.name} label="name" />
       <.input field={{f, :age}} type="number" name="age" value={@changeset.data.age} label="age" />
        <:actions>
          <.button phx-disable-with="Search...">Search</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  def update(assigns, socket) do
    {:ok, assign_changeset(assigns, socket)}
  end

  def handle_event("search", filter, socket) do

    case FilterForm.parse(filter) do
      {:error, changeset} ->

        {:noreply, assign(socket, :changeset, changeset)}

      {:ok, opts} ->
          send(self(), {:update, opts})
          {:noreply, socket}
    end
  end

  defp assign_changeset(%{filter: filter}, socket) do
    assign(socket, :changeset, FilterForm.change_values(filter))
  end
end
