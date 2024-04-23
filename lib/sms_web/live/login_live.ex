defmodule SmsWeb.MyLoginLive do
  use SmsWeb, :live_view
  alias SmsWeb.LoginComponent
  alias Sms.Accounts
  import LvDemoWeb.LiveHelpers
  import Phoenix.LiveView


  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""

        <.login_modal>
        <div>
          <main>
           <p class="bg-red-500 text-red-900 text-bold" role="alert"><%= live_flash(@flash, :info) %></p>
           <p class="bg-red-500 text-red-900 text-bold" role="alert"><%= live_flash(@flash, :error) %></p>
          </main>
            <.live_component module={LoginComponent} id="1" />
        </div>
          </.login_modal>


    """
  end

  def handle_event("show", _, socket) do
    socket = assign(socket, show: true)
    {:noreply, socket}
  end


def handle_event("submit", %{"fname" => fname, "password" => password}, socket) do
    users = Accounts.get_users_by_name(fname)
    new_password = fname <> password
    IO.inspect(users)
    case users  do

      [] ->
            IO.inspect("USER NOT FOUND.")
            socket =
            socket
            |> put_flash(:error, "USER NOT FOUND.")
            {:noreply, socket}
      users ->
            [user] = users
            IO.inspect(user, label: "IS THIS GOING TO WORK.")
                if Bcrypt.verify_pass(new_password, user.password) do
                    if user.account_type == "ordinary" do
                      IO.inspect("ORDINARY USER")
                        {:noreply, push_redirect(socket, to: "/ordinary")}
                    else
                      if user.account_type == "admin" do
                        IO.inspect("ADMIN USER.")
                        {:noreply, push_redirect(socket, to: "/admin")}
                       end
                    end                    
                else
                    socket =
                    socket
                    |> put_flash(:error, "INVALID CRIDENTIALS")
                    {:noreply, socket}

                    end


    end
          
  end


end
