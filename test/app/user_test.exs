defmodule App.UserTest do
  use App.DataCase
  # alias App.User

  test "App.User.create/1" do
    user = %{
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
    assert {:ok, inserted_user} = App.User.create(user)
    assert inserted_user.name == user.name
  end

  test "get_user_from_api/1" do
    data = App.User.get_user_from_api("iteles") # |> dbg
    assert data.public_repos > 30
  end
end

%{
  organizations_url: "https://api.github.com/users/iteles/orgs",
  following: 80,
  login: "iteles",
  public_repos: 31,
  received_events_url: "https://api.github.com/users/iteles/received_events",
  bio: "Co-founder @dwyl \r\n",
  user_view_type: "public",
  company: "@dwyl",
  gravatar_id: "",
  twitter_username: nil,
  following_url: "https://api.github.com/users/iteles/following{/other_user}",
  created_at: "2013-04-17T21:10:06Z",
  followers: 400,
  site_admin: false,
  blog: "http://www.twitter.com/iteles",
  starred_url: "https://api.github.com/users/iteles/starred{/owner}{/repo}",
  public_gists: 0,
  hireable: true,
  gists_url: "https://api.github.com/users/iteles/gists{/gist_id}",
  events_url: "https://api.github.com/users/iteles/events{/privacy}",
  followers_url: "https://api.github.com/users/iteles/followers",
  node_id: "MDQ6VXNlcjQxODUzMjg=",
  url: "https://api.github.com/users/iteles",
  id: 4185328,
  name: "Ines Teles Correia",
  subscriptions_url: "https://api.github.com/users/iteles/subscriptions",
  html_url: "https://github.com/iteles",
  location: "London, UK",
  type: "User",
  avatar_url: "https://avatars.githubusercontent.com/u/4185328?v=4",
  email: nil,
  repos_url: "https://api.github.com/users/iteles/repos",
  updated_at: "2024-08-05T22:59:09Z"
}
