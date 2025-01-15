defmodule AppWeb.AppLive do
  use AppWeb, :live_view

  @topic "live"
  @img "https://avatars.githubusercontent.com/u/"

  def mount(_session, _params, socket) do
    if connected?(socket) do
      AppWeb.Endpoint.subscribe(@topic) # subscribe to the channel
    end
    p = %{id: 183617417, login: "Alex",
      avatar_url: "#{@img}128895421", name: "Alexander the Greatest",
      bio: "Love learning how to code with my crew of cool cats!",
      created_at: "2010-02-02T08:44:49Z", company: "dwyl"}
    {:ok, assign(socket, %{data: p})}
  end

  def handle_event("sync", _value, socket) do
    sync(socket)

    {:noreply, socket}
  end

  def handle_event("update", _value, socket) do
    {:noreply, socket}
  end

  # update `data` by broadcasting it as the profiles are crawled:
  def sync(socket) do
    list = App.GitHub.org_user_list("dwyl")
    # Iterate through the list of people and fetch profiles from API
    Stream.with_index(list)
    |> Enum.map(fn {u, index} ->
      # IO.inspect("- - - Enum.map u.login: #{index}: #{u.login}")
      data = App.User.get_user_from_api(u)
      data = AuthPlug.Helpers.strip_struct_metadata(data)
      new_state = assign(socket, %{data: data})
      Task.start(fn ->
        :timer.sleep(300 + 100 * index)
        AppWeb.Endpoint.broadcast(@topic, "update", new_state.assigns)
      end)
    end)

    {:noreply, socket}
  end

  def handle_info(msg, socket) do
    {:noreply, assign(socket, data: msg.payload.data)}
  end

  def broadcast(msg, assigns) do
    AppWeb.Endpoint.broadcast_from(self(), @topic, msg, assigns)
  end

  # Template Helper Functions
  def short_date(date) do
    String.split(date, "T") |> List.first
  end

  def truncate_bio(bio) do
    Useful.truncate(bio, 29, " ...")
  end
end
