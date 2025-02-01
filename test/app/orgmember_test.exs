defmodule App.OrgMemberTest do
  use App.DataCase

  test "App.Orgmember.create/1" do
    org_id = 11_708_465
    user_id = 4_185_328
    assert {:ok, orgmember} =
      App.Orgmember.create(%{org_id: org_id, user_id: user_id})
    assert orgmember.user_id == user_id
    assert orgmember.org_id == org_id
  end

  test "Chain Github.user_orgs/1 |> Orgmember.create" do
    username = "iteles"
    user = App.GitHub.user(username)
    orgs = App.GitHub.user_orgs(username)
    list = Enum.map(orgs, fn org ->
      {:ok, orgmemb} = App.Orgmember.create(%{org_id: org.id, user_id: user.id})

      orgmemb
    end)
    assert length(list) == length(orgs)
  end

  test "Orgmember.get_orgs_for_user/1" do
    user = %{id: 4_185_328, login: "iteles"}
    orgs = App.Orgmember.get_orgs_for_user(user)
    [org | _ ] = Enum.filter(orgs, fn org ->
      org.login == "dwyl"
    end)

    assert org.id == 11_708_465
  end

  test "Orgmember.get_users_for_org/1" do
    org = %{id: 6_831_072, login: "ideaq"}
    users = App.Orgmember.get_users_for_org(org)
    assert length(users) > 3
  end
end
