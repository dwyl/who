defmodule App.Org do
  alias App.{Repo}
  use Ecto.Schema
  import Ecto.{Changeset, Query}
  require Logger
  alias __MODULE__

  schema "orgs" do
    field :avatar_url, :string
    field :blog, :string
    field :company, :string
    field :created_at, :string
    field :description, :string
    field :followers, :integer
    field :hex, :string
    field :location, :string
    field :login, :string #, primary_key: true
    field :name, :string
    field :public_repos, :integer
    field :show, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(org, attrs) do
    org
    |> cast(attrs, [:id, :login, :avatar_url, :hex, :description, :name,
      :company, :created_at, :public_repos, :location, :followers, :show])
    # |> validate_required([:id, :login, :avatar_url])
    # |> unique_constraint(:login, name: :org_login_unique)
  end

  @doc """
  Creates an `org`.
  """
  def create(attrs) do
    %Org{}
    |> changeset(attrs)
    |> Repo.insert(on_conflict: :replace_all, conflict_target: [:id]) # upsert
  end

  def get_org_by_login(login) do
    from(o in Org, where: o.login == ^login)
    |> Repo.one()
  end

  # `org` map must include the `id` and `login` fields
  def get_org_from_api(org) do
    data = App.GitHub.org(org.login)
    # Not super happy about this crude error handling ... feel free to refactor.
    if Map.has_key?(data, :status) && data.status == "404" do
      update_org_created(org)
    else
      create_org_with_hex(data)
    end
  end

  def create_org_with_hex(data) do
    {:ok, org} =
      App.User.map_github_fields_to_table(data)
      |> Map.put(:hex, App.Img.get_avatar_color(data.avatar_url))
      |> create()

    org
  end

  @doc """
  `list_incomplete_orgs/0` returns a list of incomplete orgs. Why...?
  An `org` returned by `App.Orgmember.get_orgs_for_user/1` it is incomplete.
  Therefore we need to back-fill the data by selecting and querying.
  """
  # When an org is returned by `App.Orgmember.get_orgs_for_user/1` it is incomplete
  # Therefore we need to back-fill the data by selecting and querying
  # SELECT COUNT(*) FROM orgs WHERE created_at IS NULL
  def list_incomplete_orgs do
    from(o in Org,
      select: %{login: o.login, id: o.id},
      where: is_nil(o.created_at)
    )
    |> limit(5)
    |> order_by(desc: :inserted_at)
    |> Repo.all()
  end

  def backfill do
    list_incomplete_orgs()
    |> Enum.each(fn org ->
      get_org_from_api(org)
      App.Orgmember.get_users_for_org(org)
      App.Follow.get_followers_from_api(org.login, true)
    end)
  end

  @doc """
  `update_org_created/1` updates the `created_at` date to Now
  so that we don't keep requesting the data from GitHub.
  """
  def update_org_created(org) do
    org = get_or_create_org(org)
    {:ok, org_updated} =
      Ecto.Changeset.change(org, %{created_at: now()})
    |> App.Repo.update()

    # return the org that was updated:
    org_updated
  end

  @doc """
  `now/0` returns a `NaiveDateTime` as a `String` in format: 2025-02-25 07:29:10
  """
  def now do
    NaiveDateTime.utc_now()
    |> NaiveDateTime.to_string()
    |> String.split(".")
    |> List.first()
  end

  # def strip_struct_metadata(struct) do
  #   struct
  #   |> Map.delete(:__meta__)
  #   |> Map.delete(:__struct__)
  # end


  def get_or_create_org(org) do
    org_data = get_org_by_login(org.login)
    if is_nil(org_data) do
      # dbg(org)
      {:ok, org_data} =
        create(Map.merge(org, %{id: :rand.uniform(1_000_000_000_000)}))

      org_data
    else
      org_data
    end
  end
end
