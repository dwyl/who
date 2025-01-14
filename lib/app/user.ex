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
    |> validate_required([:id, :login, :avatar_url])
  end

  @doc """
  Creates a `user`.
  """
  def create(attrs) do
    %User{}
    |> changeset(attrs)
    |> Repo.insert(on_conflict: :replace_all, conflict_target: [:id])
  end

  def get_user_from_api(username) do


    # case App.GitHub.user(user.login) do
    #   {:ok, data} ->
    #     cols = res.columns
    #     [first_row | _] = res.rows
    #     [new_id, validation_token, auth_token, success, message] = first_row
    #     {:ok, %RegistrationResult{
    #       success: success,
    #       message: message,
    #       new_id: new_id,
    #       authentication_token: auth_token,
    #       validation_token: validation_token
    #   }}

    #   {:error, err} ->

    # end

    {:ok, data} = App.GitHub.user(username)
    |> dbg()
    |> map_github_user_fields_to_table()
    |> create()

    data
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
      company: clean_company(u.company),
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

  def clean_company(company) do
    # avoid `String.replace(nil, "@", "", [])` error
    if company == nil do
      ""
    else
      String.replace(company, "@", "")
    end
  end

  # create function that returns dummy user data
  def dummy_data(u \\ %{}) do
    Map.merge(%{
      id: :rand.uniform(1_000_000_000) + 1_000_000_000,
      avatar_url: "https://avatars.githubusercontent.com/u/10137",
      bio: "",
      blog: "",
      company: "good",
      created_at: "",
      email: "",
      followers: 0,
      following: 0,
      hireable: false,
      location: "",
      login: "al3x",
      name: "Lex",
      public_repos: 0,
      two_factor_authentication: false
    }, u)
  end
end
