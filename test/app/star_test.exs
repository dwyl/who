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
end
