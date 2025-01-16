defmodule AppWeb.AppLiveTest do
  use AppWeb.ConnCase
  import Phoenix.LiveViewTest
  alias AppWeb.AppLive

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "sync"
  end

  test "default profile", %{conn: conn} do
    {:ok, _view, html} = live(conn, "/")
    assert html =~ "Alexander the Greatest"
  end

  test "trigger sync", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")
    assert render_hook(view, :sync, %{org: "ideaq"})
      =~ "Love learning how to code"
  end

  describe "template helper functions" do
    test "short_date/1 shortens the date received from GitHub" do
      assert AppLive.short_date("2010-02-02T08:44:49Z") == "2010-02-02"
    end

    test "truncate_bio/1 truncates the bio to 29 chars" do
      bio = "It was a bright cold day in April, and the clocks were striking 13"
      assert AppLive.truncate_bio(bio) == "It was a bright cold day in ..."
    end

    test "avatar/1 prepares the avatar_url for displaying face wall" do
      assert AppLive.avatar(1) ==
        "https://avatars.githubusercontent.com/u/1?s=30"
    end
  end
end
