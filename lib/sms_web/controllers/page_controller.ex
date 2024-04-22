defmodule SmsWeb.PageController do
  use SmsWeb, :controller
  alias Sms.Accounts

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def save(conn, params) do
    new_password = params["fname"] <> params["password"]
    hashed_password = Bcrypt.hash_pwd_salt(new_password)
    new_phone = String.to_integer(params["phone"])
    new_params = %{"fname" => params["fname"], "lname" => params["lname"], "sex" => params["sex"], "phone" => new_phone, "password" => hashed_password }
    Accounts.create_user(new_params)
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

  def login(conn, params) do
    IO.inspect(params)
    user = Accounts.get_users_by_name(params["fname"])
    IO.inspect(user)
    case user  do
      [] ->
      conn
      |> put_flash(:error, "User not found.")
      |> redirect(to: "/")
     users ->
        for user <- users do
       new_password = params["fname"] <> params["password"]
       if Bcrypt.verify_pass(new_password, user.password) do
        
        render(conn, "loggedin.html", user: user)
       else
        conn
        |> put_flash(:error, "INVALID LOGIN CREDENTIALS.")
        |> redirect(to: "/")
      end
      end
    end
    render(conn, "loggedin.html")
  end

end
