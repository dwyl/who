defmodule App.UserTest do
  use App.DataCase

  test "App.User.create/1" do
    user = %{
      avatar_url: "https://avatars.githubusercontent.com/u/4185328?v=4",
      bio: "Co-founder @dwyl",
      blog: "http://www.twitter.com/iteles",
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
    assert {:ok, _res} = App.User.create(user)
  end
end