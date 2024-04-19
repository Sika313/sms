defmodule SmsWeb.SignupLive do
  use SmsWeb, :live_view
  import SmsWeb.Signup
  import LvDemoWeb.LiveHelpers
  import Phoenix.LiveView


  def mount(_params, _session, socket) do
    socket = assign(socket, show: false)
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
          <.modal>
          <.signup />
          </.modal>

    """
  end

  def handle_event("show", _, socket) do
    socket = assign(socket, show: true)
    {:noreply, socket}
  end

  def handle_params(_unsigned_params, _uri, socket) do
    {:noreply, socket}
  end

end
