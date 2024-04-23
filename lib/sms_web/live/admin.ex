defmodule SmsWeb.AdminLive do
  use SmsWeb, :live_view
  import LvDemoWeb.LiveHelpers
  import Phoenix.LiveView
  
  def mount(_params, _session, socket) do
   {:ok, socket}
  end

  def render(assigns) do
    ~H"""
      <div class="flex flex-col">
      <h1 class="mt-4">THIS IS THE ADMIN'S PAGE</h1>
      
      <img src='/images/admin.png' alt="Failed to load image" class="w-40 h-40 rounded-full" />
      <a href="/view"><button class="bg-blue-900 hover:bg-blue-500 transition duration-500 py-2 px-4 text-white">View users</button></a>
      </div>
      
    """
  end

end
