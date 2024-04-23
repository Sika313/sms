defmodule SmsWeb.OrdinaryLive do
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

      <img src='/images/ordinary.webp' alt="Failed to load image" class="w-40 h-40 rounded-full" />
      <h1>THIS IS THE ORDINARY USER'S PAGE</h1> 
    """
  end

end
