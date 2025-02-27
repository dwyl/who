defmodule App.Orgmember do
  use Ecto.Schema
  import Ecto.Changeset
  alias App.{Repo}
  alias __MODULE__

  schema "orgmembers" do
    field :stop, :utc_datetime
    field :org_id, :integer, primary_key: true
    field :user_id, :integer, primary_key: true

    timestamps()
  end

  @doc false
  def changeset(orgmember, attrs) do
    orgmember
    |> cast(attrs, [:org_id, :user_id, :stop])
    |> unique_constraint(:orgmembers_unique_constraint, name: :orgmembers_unique)
    |> validate_required([:org_id, :user_id])
  end

  @doc """
  Creates a `orgmember` record.
  """
  def create(attrs) do
    %Orgmember{}
    |> changeset(attrs)
    |> Repo.insert(on_conflict: :nothing, conflict_target: [:org_id, :user_id])
  end

  @doc """
  `get_orgs_for_user` gets the list of the orgs for a given user.
  expects the `%User` struct to have `id` and `login` fields.
  e.g: `%{id: 123, login: "al3x"}`
  """
  def get_orgs_for_user(user) do
    # Get the list of orgs a user belongs to (public)
    App.GitHub.user_orgs(user.login) # |> dbg()
    |> Enum.map(fn org ->
      {:ok, inserted_org} = App.Org.create(org)
      create(%{org_id: org.id, user_id: user.id})

      inserted_org
    end)
  end

  @doc """
  `get_users_for_org` gets list of `users` who are `public` members of an org
  """
  def get_users_for_org(org) do
    # Get the list of orgs a user belongs to (public)
    data = App.GitHub.org_user_list(org.login)
    if is_map(data) && Map.has_key?(data, :status) && data.status == 404 do

     []
    else
      data
      |> Enum.map(fn user ->
        App.User.create_incomplete_user_no_overwrite(user)
        # insert the orgmember record:
        create(%{org_id: org.id, user_id: user.id})

        user
      end)
    end
  end
end
