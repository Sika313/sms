defmodule Sms.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :fname, :string
      add :lname, :string
      add :sex, :string
      add :phone, :integer
      add :password, :string
      add :status, :string

      timestamps()
    end
  end
end
