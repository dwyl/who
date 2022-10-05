defmodule App.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :avatar_url, :string
    field :bio, :string
    field :blog, :string
    field :company, :string
    field :created_at, :string
    field :email, :string
    field :followers, :integer
    field :following, :integer
    field :location, :string
    field :login, :string
    field :name, :string
    field :two_factor_authentication, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:login, :avatar_url, :name, :company, :bio, :blog, :location, :email, :created_at, :two_factor_authentication, :followers, :following])
    |> validate_required([:login, :avatar_url, :name, :company, :bio, :blog, :location, :email, :created_at, :two_factor_authentication, :followers, :following])
  end
end
