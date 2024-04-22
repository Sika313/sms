defmodule SmsWeb.ViewLive do
  use SmsWeb, :live_view
  alias SmsWeb.ViewUser
  alias SmsWeb.Edit
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
    users = Accounts.list_users()
    ~H"""

    <h1 class="my-20">THIS IS THE USERS'S PAGE</h1>
    <table class="w-[40vw] border-2 border-gray-400 m-10 ml-20">
    <tr>
    <th>Firstname</th> <th>Lastname</th> <th>Sex</th> <th>Phone number</th>
    </tr>
    <%= for user <- users do %>
    <tr>
    <td> <%= user.fname %> </td>
    <td> <%= user.lname %> </td>
    <td> <%= user.sex %> </td>
    <td> <%= user.phone %> </td>
    <td> <button phx-click="show"  value={user.id} class="bg-blue-500 hover:bg-blue-900 p-2 text-white rounded-md">View</button> </td>
    <td> <button phx-click="edit"  value={user.id} class="bg-blue-500 hover:bg-blue-900 p-2 text-white rounded-md">Edit</button> </td>
    <td> <button phx-click="delete"  value={user.id} class="bg-blue-500 hover:bg-blue-900 p-2 text-white rounded-md">Delete</button> </td>
    </tr>
    <% end %>
    </table>
    <%= if @show do %>
      <.show_modal>
        <%= live_component  ViewUser, id: @id %>
      </.show_modal>
    <% end %>

    <%= if @edit do %>
      <.edit_modal>
        <%= live_component  Edit, id: @id %>
      </.edit_modal>
    <% end %>

    <%= if @delete do %>
      <.user_modal>
      <.delete id={@id} />
      </.user_modal>
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
    socket = assign(socket, edit: false)
    {:noreply, socket}
  end

def handle_event("delete", u_id, socket) do
    socket = assign(socket, delete: true, id: u_id["value"])
    {:noreply, socket}
  end

end
