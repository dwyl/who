defmodule App.User do
  use Ecto.Schema
  alias App.{Repo}
  import Ecto.{Changeset, Query}
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

  # `user` map must include the `id` and `login` fields
  def get_user_from_api(user) do
    data = App.GitHub.user(user.login)
    # Not super happy about this crude error handling ... feel free to refactor.
    if Map.has_key?(data, :status) && data.status == "404" do
      # IO.inspect(" - - - - - - - - - - - - - - - - - #{user.login}")
      # dbg(user)
      # IO.inspect(" - - - - - - - - - - - - - - - - - - - - - - - ")
      {:ok, user} = dummy_data(user) |> create()

      user
    else
      {:ok, user} =
      map_github_user_fields_to_table(data)
      |> create()

      user
    end
  end

  # tidy data before insertion
  def map_github_user_fields_to_table(u) do
    Map.merge(u, %{
      avatar_url: String.split(u.avatar_url, "?") |> List.first,
      company: clean_company(u.company),
    })
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

  # def list_users do
  #   User
  #   |> limit(20)
  #   |> order_by(desc: :inserted_at)
  #   |> Repo.all()
  # end

  def list_users_avatars  do
    from(u in User, select: %{id: u.id})
    # |> limit(20)
    |> order_by(desc: :inserted_at)
    # |> distinct(true)
    |> Repo.all()
    # return a list of urls not a list of maps
    |> Enum.reduce([], fn u, acc ->
      [u.id | acc]
    end)
  end
end
