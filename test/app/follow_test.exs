defmodule App.FollowTest do
  use App.DataCase

  test "App.Follow.create/1" do
    follow = %{
      follower_id: 42,
      following_id: 73
    }
    assert {:ok, inserted_follow} = App.Follow.create(follow)
    assert inserted_follow.follower_id == follow.follower_id
  end

  test "App.Follow.create/1 is_org:true" do
    follow = %{
      follower_id: 42,
      following_id: 73,
      is_org: true
    }
    assert {:ok, inserted_follow} = App.Follow.create(follow)
    assert inserted_follow.follower_id == follow.follower_id
    assert inserted_follow.is_org == true
  end

  test "App.Follow.get_followers_from_api/2" do
    # Get followers for User:
    user_followers = App.Follow.get_followers_from_api("asntc")
    assert length(user_followers) > 5

    # Get followers for Org
    org_followers = App.Follow.get_followers_from_api("ideaq", true)
    assert length(org_followers) > 0
  end
end
