defmodule App.ReqlogTest do
  use App.DataCase

  test "App.Reqlog.create/1" do
    owner = "dwyl"
    reponame = "mvp"
    record = %{
      created_at: "2014-03-02T13:20:04Z",
      req: "repository",
      param: "#{owner}/#{reponame}"
    }
    assert {:ok, inserted} = App.Reqlog.create(record)
    assert inserted.req == record.req
  end

  test "App.Reqlog.log/2" do
    owner = "dwyl"
    reponame = "mvp"

    assert {:ok, inserted} = App.Reqlog.log("repo", "#{owner}/#{reponame}")
    assert inserted.req == "repo"
    assert inserted.param == "#{owner}/#{reponame}"
  end

  test "App.Reqlog.req_count_last_hour/0" do
    assert {:ok, _} = App.Reqlog.log("repo", "dwyl/any")
    count = App.Reqlog.req_count_last_hour()
    assert count > 0
  end
end
