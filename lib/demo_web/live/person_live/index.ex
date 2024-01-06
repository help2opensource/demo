defmodule DemoWeb.PersonLive.Index do
  use DemoWeb, :live_view

  alias Demo.Accounts
  alias Demo.Accounts.Person

  alias DemoWeb.Forms.SortingForm
  alias DemoWeb.Forms.FilterForm
  alias DemoWeb.Forms.PaginationForm


  def on_mount(:default, _params, session, socket) do
       dbg session
       dbg socket
      {:cont, socket}
  end

  on_mount {DemoWeb.UserAuth, :mount_current_user}
  on_mount __MODULE__



  @impl true
  def mount(_params, session, socket) do

    dbg session
    dbg socket

   #{:ok, stream(socket, :persons, Accounts.list_persons_with_total_count(params))}
   {:ok, stream(socket, :persons, [])}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Person")
    |> assign(:person, Accounts.get_person!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Person")
    |> assign(:person, %Person{})
  end

  defp apply_action(socket, :index, params) do
    socket
    |> parse_params(params)
    |> assign(:page_title, "Listing Persons")
    |> assign_persons()
  end

  @impl true
  def handle_info({DemoWeb.PersonLive.FormComponent, {:saved, person}}, socket) do
    {:noreply, stream_insert(socket, :persons, person)}
  end

  @impl true
  def handle_info({:update, opts}, socket) do
    params = merge_and_sanitize_params(socket, opts)
    {:noreply, push_navigate(socket, to: ~p"/persons?#{params}", replace: true)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    person = Accounts.get_person!(id)
    {:ok, _} = Accounts.delete_person(person)

    {:noreply, stream_delete(socket, :persons, person)}
  end

  # Add this function:
  defp parse_params(socket, params) do
    with {:ok, sorting_opts} <- SortingForm.parse(params),
         {:ok, filter_opts} <- FilterForm.parse(params),
         {:ok, pagination_opts} <- PaginationForm.parse(params) do
      socket
      |> assign_sorting(sorting_opts)
      |> assign_filter(filter_opts)
      |> assign_pagination(pagination_opts)
    else
      _error ->
        socket
        |> assign_sorting()
        |> assign_filter()
        |> assign_pagination()
    end
  end

  # Add this function:
  defp assign_sorting(socket, overrides \\ %{}) do
    opts = Map.merge(SortingForm.default_values(), overrides)
    assign(socket, :sorting, opts)
  end

  defp assign_filter(socket, overrides \\ %{}) do
    assign(socket, :filter, FilterForm.default_values(overrides))
  end

  defp assign_pagination(socket, overrides \\ %{}) do
    assign(socket, :pagination, PaginationForm.default_values(overrides))
  end

  # Update assign_persons/1 like this:
  defp assign_persons(socket) do
    params = merge_and_sanitize_params(socket)
    %{persons: persons, total_count: total_count} = Accounts.list_persons_with_total_count(params)
    socket
    |> stream(:persons, persons)
    |> assign_total_count(total_count)
  end

  # Update merge_and_sanitize_params/2 like this:
  defp merge_and_sanitize_params(socket, overrides \\ %{}) do
    %{sorting: sorting, filter: filter, pagination: pagination} = socket.assigns

    %{}
    |> Map.merge(sorting)
    |> Map.merge(filter)
    |> Map.merge(pagination)
    |> Map.merge(overrides)
    |> Map.drop([:total_count])
    |> Enum.reject(fn {_key, value} -> is_nil(value) end)
    |> Map.new()
  end

  # Add this function:
  defp assign_total_count(socket, total_count) do
    update(socket, :pagination, fn pagination ->
      %{
        pagination
        | total_count: total_count
      }
    end)
  end
end
