defmodule SmsWeb.LoginComponent do
  use SmsWeb, :live_component
  alias Sms.Accounts
  def mount(_, _, socket) do
    {:ok, socket}
  end

  def render(assigns) do
  ~H"""
       <div class="bg-grey-lighter min-h-screen flex flex-col">
       
                <div class="container max-w-sm mx-auto flex-1 flex flex-col items-center justify-center px-2">
                    <div class="bg-white px-6 py-8 rounded shadow-md text-black w-full">
                        <h1 class="mb-8 text-3xl text-center">Login</h1>
                        <form phx-submit="submit" >
                        <input
                            type="text"
                            class="block border border-grey-light w-full p-3 rounded mb-4"
                            name="fname"
                            placeholder="Firstname" />
                        <input
                            type="password"
                            class="block border border-grey-light w-full p-3 rounded mb-4"
                            name="password"
                            placeholder="Password" />

                            <input type="hidden" name="_csrf_token" id="csrf" value={ Plug.CSRFProtection.get_csrf_token() } />
                        <button
                            type="submit"
                            class="w-full text-center py-3 rounded bg-blue-600 text-white hover:bg-green-dark focus:outline-none my-1"
                        >Login</button>
                        </form>
                        <div class="text-center text-sm text-grey-dark mt-4">
                            By signing up, you agree to the
                            <a class="no-underline border-b border-grey-dark text-grey-dark" href="#">
                                Terms of Service
                            </a> and
                            <a class="no-underline border-b border-grey-dark text-grey-dark" href="#">
                                Privacy Policy
                            </a>
                        </div>
                    </div>

                    <div class="text-grey-dark mt-6">
                        Don't have an account?
                        <a class="no-underline border-b border-blue text-blue" href="/signup">
                            Signup
                        </a>.
                    </div>
                </div>
            </div>
  """
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
            IO.inspect(socket, label: "INPECTING SOCKET")
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
                    socket
                    |> put_flash(:error, "INVALID CRIDENTIALS")
                    {:noreply, socket}

                    end


    end
          
  end

end
