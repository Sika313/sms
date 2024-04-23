defmodule SmsWeb.Edit do
    use SmsWeb, :live_component
    alias Sms.Accounts

  def mount(_, _, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    user = Accounts.get_user!(assigns.id)
  ~H"""
    <div class="bg-grey-lighter min-h-screen flex flex-col">
                <div class="container max-w-sm mx-auto flex-1 flex flex-col items-center justify-center px-2">
                    <div class="bg-white px-6 py-8 rounded shadow-md text-black w-full">
                        <h1 class="mb-8 text-3xl text-center">Update</h1>
                        <form method="post" action="/edit">
                        <input
                            type="text"
                            class="block border border-grey-light w-full p-3 rounded mb-4"
                            name="fname"
                            placeholder={user.fname} />

                          <input
                            type="text"
                            class="block border border-grey-light w-full p-3 rounded mb-4"
                            name="lname"
                            placeholder={user.lname} />

                        <input
                            type="text"
                            class="block border border-grey-light w-full p-3 rounded mb-4"
                            name="sex"
                            placeholder={user.sex} />
                        <input
                            type="text"
                            class="block border border-grey-light w-full p-3 rounded mb-4"
                            name="phone"
                            placeholder={user.phone} />

                           <input type="hidden" name="_csrf_token" id="csrf" value={ Plug.CSRFProtection.get_csrf_token() } />
                            <input type="hidden" name="id" value={user.id} />
                        <button
                            type="submit"
                            class="w-full text-center py-3 rounded bg-blue-600 text-white hover:bg-green-dark focus:outline-none my-1"
                        >Update</button>
                        </form>

                    </div>


                </div>
            </div>
  """
  end
end
