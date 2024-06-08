defmodule App.OrgTest do
  use App.DataCase

  test "App.Org.create/1" do
    org = %{
      avatar_url: "https://avatars.githubusercontent.com/u/4185328?v=4",
      blog: "https://blog.dwyl.com",
      company: "@dwyl",
      created_at: "2013-04-17T21:10:06Z",
      description: "the dwyl org",
      followers: 378,
      location: "London, UK",
      login: "dwyl",
      name: "dwyl",
      public_repos: 31
    }
    assert {:ok, inserted_org} = App.Org.create(org)
    assert inserted_org.name == org.name
  end
end
