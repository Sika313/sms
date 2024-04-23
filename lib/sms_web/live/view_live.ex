defmodule SmsWeb.MyViewLive do
  use SmsWeb, :live_view
  alias SmsWeb.ViewUser
  alias SmsWeb.Edit
  alias SmsWeb.ListUser
  import SmsWeb.Delete
  import LvDemoWeb.LiveHelpers
  import Phoenix.LiveView
  alias Sms.Accounts

  def mount(_params, _session, socket) do
    socket = assign(socket,
    show: false, edit: false, delete: false, id: "1",
    users: Accounts.list_users())
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <%= live_component ListUser %>

    <%= if @show do %>
      <.edit_modal>
        <%= live_component  ViewUser, id: @id %>
      </.edit_modal>
    <% end %>

    <%= if @edit do %>
      <.edit_modal>
        <%= live_component  Edit, id: @id %>
      </.edit_modal>
    <% end %>

    <%= if @delete do %>
      <.edit_modal>
      <.delete id={@id} />
      </.edit_modal>
    <% end %>

    """
  end

  def handle_event("show", u_id, socket) do
    socket = assign(socket, show: true, id: u_id["value"])
    {:noreply, socket}
  end
  def handle_event("show_modal_close", _, socket) do
    socket = assign(socket, show: false)
    {:noreply, socket}
  end

  def handle_event("edit", u_id, socket) do
    socket = assign(socket, edit: true, id: u_id["value"])
    {:noreply, socket}
  end

def handle_event("edit_modal_close", _, socket) do
    socket = assign(socket, show: false, edit: false, delete: false)
    {:noreply, socket}
  end

def handle_event("delete", u_id, socket) do
    socket = assign(socket, delete: true, id: u_id["value"])
    {:noreply, socket}
  end

end
