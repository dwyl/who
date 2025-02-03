defmodule App.ContribTest do
  use ExUnit.Case, async: true
  use App.DataCase

  test "App.Contrib.create/1" do
    contrib = %{
      repo_id: 42,
      user_id: 73,
      count: 420
    }
    assert {:ok, inserted_contrib} = App.Contrib.create(contrib)
    assert inserted_contrib.user_id == contrib.user_id

    # Upsert with new count:
    new_contrib = %{contrib | count: 765}
    assert {:ok, updated_contrib} = App.Contrib.create(new_contrib)
    assert updated_contrib.count == 765
  end

  test "get_contribs_from_api(fullname)" do
    assert length(App.Contrib.get_contribs_from_api("dwyl/start-here")) > 10
  end
end
