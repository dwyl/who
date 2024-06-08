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
end
