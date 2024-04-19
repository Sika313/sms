defmodule SmsWeb.ViewUser do
    use Phoenix.LiveComponent
    alias Sms.Accounts
  def view_user(assigns) do
    id = String.to_integer(assigns.id)
    user = Accounts.get_user!(id)
  ~H"""
    <p> User ID: <%= user.id %> </p>
    <p> First name: <%= user.fname %> </p>
    <p> Last name: <%= user.lname %> </p>
    <p> Gender: <%= user.sex %> </p>
    <p> Phone number: <%= user.phone %> </p>

  """
  end
end
