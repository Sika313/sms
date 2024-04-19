defmodule Sms.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Sms.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        fname: "some fname",
        lname: "some lname",
        password: "some password",
        phone: 42,
        sex: "some sex",
        status: "some status"
      })
      |> Sms.Accounts.create_user()

    user
  end
end
