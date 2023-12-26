defmodule DemoWeb.PersonLive.FormComponent.FilterComponent do
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
       <.input field={{f, :name}} type="text" label="name" />
       <.input field={{f, :age}} type="number" label="age" />
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

  def handle_event("search", %{"filter" => filter}, socket) do

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
