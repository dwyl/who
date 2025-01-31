defmodule App.UserTest do
  use App.DataCase
  alias App.User

  def user do
    %{
      avatar_url: "https://avatars.githubusercontent.com/u/4185328?v=4",
      bio: "Co-founder @dwyl",
      blog: "https://www.twitter.com/iteles",
      company: "@dwyl",
      created_at: "2013-04-17T21:10:06Z",
      email: nil,
      followers: 378,
      following: 79,
      hireable: true,
      html_url: "https://github.com/iteles",
      id: 4185328,
      location: "London, UK",
      login: "iteles",
      name: "Ines TC",
      organizations_url: "https://api.github.com/users/iteles/orgs",
      public_gists: 0,
      public_repos: 31
    }
  end

  test "App.User.create/1" do
    user = user()
    assert {:ok, inserted_user} = App.User.create(user)
    assert inserted_user.name == user.name
  end

  test "get_user_from_api/1" do
    data = App.User.get_user_from_api(%{login: "iteles"}) # |> dbg
    assert data.public_repos > 30
  end

  test "get_user_from_api/1 unhappy path (kittenking)" do
    # ref: https://github.com/dwyl/who/issues/216
    user = %{
      id: 53072918,
      type: "User",
      url: "https://api.github.com/users/kittenking",
      avatar_url: "https://avatars.githubusercontent.com/u/53072918?v=4",
      login: "kittenking",
      node_id: "MDQ6VXNlcjUzMDcyOTE4",
      user_view_type: "public",
      site_admin: false
    }
    data = App.User.get_user_from_api(user)
    assert data.id == user.id
  end

  test "list_users" do
    data = App.User.dummy_data(%{id: 42})
    assert data.company == "good"
  end

  test "list_incomplete_users/0 returns recent incomplete users" do
    dummy_data = App.User.dummy_data(%{id: 42})
    App.User.create_incomplete_user_no_overwrite(dummy_data)
    list = App.User.list_incomplete_users()
    assert length(list) > 0
    # dbg(list)
  end

  test "list_users_avatars/0" do
    user = user() |> User.map_github_user_fields_to_table()
    User.create(user)
    list = App.User.list_users_avatars()
    assert length(list) > 0
  end
end
