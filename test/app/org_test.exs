defmodule App.OrgTest do
  use App.DataCase


  test "App.Org.create/1" do
    org = %{
      id: 123,
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

  test "get_org_from_api/1 retrieves and inserts the org into DB" do
    org = App.Org.get_org_from_api(%{login: "dwyl"})
    assert org.id == 11_708_465
    assert org.followers > 650 # https://github.com/orgs/dwyl/followers
    assert org.hex == "48B8A8" # https://www.colorhexa.com/48b8a8
  end

  test "get_org_from_api/1 -> 404 (unhappy path)" do
    data = %{login: "superlongnamepleasedontregister"}
    org = App.Org.get_org_from_api(data)
    assert org.login == data.login
  end

  test "App.Org.list_incomplete_orgs" do
    {:ok, org} = App.Org.create(%{
      id: 123,
      avatar_url: "https://avatars.githubusercontent.com/u/4185328?v=4",
      login: "dwyl"
    })
    list = App.Org.list_incomplete_orgs()
    assert length(list) > 0
    o = Enum.filter(list, fn o -> o.login == org.login end) |> List.first
    assert o.login == org.login
  end

  test "App.Org.backfill" do
    {:ok, org} = App.Org.create(%{
      id: 6_831_072,
      avatar_url: "https://avatars.githubusercontent.com/u/6831072",
      login: "ideaq"
    })
    App.Org.backfill()
    updated_org = App.Org.get_org(org.login)
    assert updated_org.hex == "F8F8F8"
    assert updated_org.description == "a Q of Ideas"
    assert updated_org.created_at == "2014-03-02T13:18:11Z"
  end
end
