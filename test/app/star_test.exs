defmodule App.StarTest do
  use App.DataCase

  test "App.Star.create/1" do
    star = %{
      repo_id: 42,
      user_id: 73
    }
    assert {:ok, inserted_star} = App.Star.create(star)
    assert inserted_star.repo_id == star.repo_id
  end

  test "App.Star.get_stargazers_for_repo/2 " do
    owner = "ideaq"
    App.Repository.get_org_repos(owner)
    repo = "image-uploads"
    list = App.Star.get_stargazers_for_repo(owner, repo)
    star = Enum.filter(list, fn(s) -> s.user_id == 194_400 end) |> List.first

    assert star.user_id == 194_400
    assert star.repo_id == 35_713_694
  end
end
