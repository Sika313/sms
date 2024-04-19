defmodule SmsWeb.Delete do
    use Phoenix.LiveComponent
    alias Sms.Accounts
  def delete(assigns) do
    id = String.to_integer(assigns.id)
    user = Accounts.get_user!(id)
  ~H"""
  <!-- component -->
    <div class="bg-grey-lighter min-h-screen flex flex-col">
                <div class="container max-w-sm mx-auto flex-1 flex flex-col items-center justify-center px-2">
                    <div class="bg-white px-6 py-8 rounded shadow-md text-black w-full">
                        <h1 class="mb-8 text-3xl text-center">Are you sure you want to delete your account?</h1>
                        <form method="post" action="/delete">

                            <input type="hidden" name="_csrf_token" id="csrf" value={ Plug.CSRFProtection.get_csrf_token() } />
                            <input type="hidden" name="id" value={user.id} />
                        <button
                            type="submit"
                            class="w-full text-center py-3 rounded bg-blue-600 text-white hover:bg-green-dark focus:outline-none my-1"
                        >Delete</button>
                        </form>

                    </div>

                </div>
            </div>
  """
  end
end
