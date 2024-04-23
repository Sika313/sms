defmodule SmsWeb.ListUser do
  use SmsWeb, :live_component
  alias Sms.Accounts

def mount(_, _, socket) do
  {:ok, socket}
end

def render(assigns) do
  users = Accounts.list_users()
~H"""
    <div class="flex justify-center mt-4">
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
    </div>
"""
end

end

