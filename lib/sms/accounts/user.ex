defmodule Sms.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :fname, :string
    field :lname, :string
    field :password, :string
    field :phone, :integer
    field :sex, :string
    field :status, :string, default: "active"

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:fname, :lname, :sex, :phone, :password, :status])
    |> validate_required([:fname, :lname, :sex, :phone, :password, :status])
  end
end
