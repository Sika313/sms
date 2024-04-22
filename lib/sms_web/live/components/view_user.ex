defmodule SmsWeb.ViewUser do
    use SmsWeb, :live_component
    alias Sms.Accounts

  def mount(_, _, socket) do
    {:ok, socket}
  end

  def render(assigns) do

  user = Accounts.get_user!(assigns.id)
  ~H"""
    <div class="flex justify-center">
      <div class="flex flex-col">
        <span>Firstname: <%= user.fname %></span>
        <span>Lastname: <%= user.lname %></span>
        <span>Sex: <%= user.sex %></span>
        <span>Phone number: <%= user.phone %></span>
      </div>
    </div>
  """
  end
end
