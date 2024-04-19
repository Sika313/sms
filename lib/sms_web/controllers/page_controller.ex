defmodule SmsWeb.PageController do
  use SmsWeb, :controller
  alias Sms.Accounts

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def save(conn, params) do
    Accounts.create_user(params)
    conn
    |>put_flash(:info, "User created successfully.")
    |>redirect(to: "/")
  end

  def edit(conn, params) do
    IO.inspect(params)
    user = Accounts.get_user!(params["id"])
    edited = Enum.filter(params, fn {key, val} -> val !== "" && key !== "_csrf_token" && key !== "id" end)
    |> Enum.into(%{})
    Accounts.update_user(user, edited)
    conn
    |>put_flash(:info, "User edited successfully.")
    |>redirect(to: "/view")
  end

  def delete(conn, params) do
    user = Accounts.get_user!(params["id"])
    updated = %{"status" => "delete"}
    Accounts.update_user(user, updated)
    conn
    |>put_flash(:info, "User deleted successfully.")
    |>redirect(to: "/view")
  end

end
