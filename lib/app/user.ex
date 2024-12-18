defmodule App.User do
  use Ecto.Schema
  alias App.{Repo}
  import Ecto.Changeset
  require Logger
  alias __MODULE__

  schema "users" do
    field :avatar_url, :string
    field :bio, :string
    field :blog, :string
    field :company, :string
    field :created_at, :string
    field :email, :string
    field :followers, :integer
    field :following, :integer
    field :hireable, :boolean, default: false
    field :location, :string
    field :login, :string
    field :name, :string
    field :public_repos, :integer
    field :two_factor_authentication, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:id, :login, :avatar_url, :name, :company, :bio, :blog, :location, :email, :created_at, :hireable, :two_factor_authentication, :public_repos, :followers, :following])
    |> validate_required([:id, :login, :avatar_url, :name, :created_at, :followers, :following])
  end

  @doc """
  Creates a `user`.
  """
  def create(attrs) do
    %User{}
    |> changeset(attrs)
    |> Repo.insert(on_conflict: :replace_all, conflict_target: [:id])
  end

  # Envar.require_env_file(".env")

  def get_org_members_from_api(org_name) do
    token = Envar.get("GH_PERSONAL_ACCESS_TOKEN")

    client = Tentacat.Client.new(%{access_token: token})
    {200, data, _res} = Tentacat.Organizations.Members.list(client, org_name)
    # dbg(data)
    Useful.atomize_map_keys(data)
  end

  def get_user_from_api(username) do
    token = Envar.get("GH_PERSONAL_ACCESS_TOKEN")
    client = Tentacat.Client.new(%{access_token: token})
    {200, data, _res} = Tentacat.Users.find(client, username)
    {:ok, entry} = Useful.atomize_map_keys(data)
    |> dbg
    |> map_github_user_fields_to_table()
    |> create()

    entry
  end

  # Next: get list of org members
  # get user for each in the list
  # map data to our table
  # insert data

  def map_github_user_fields_to_table(u) do
    %{
      id: u.id,
      avatar_url: String.split(u.avatar_url, "?") |> List.first,
      bio: u.bio,
      blog: u.blog,
      company: String.replace(u.company, "@", ""),
      created_at: u.created_at,
      email: u.email,
      followers: u.followers,
      following: u.following,
      hireable: u.hireable,
      location: u.location,
      login: u.login,
      name: u.name,
      public_repos: u.public_repos,
      two_factor_authentication: false,
      updated_at: u.updated_at
    }
  end


end
