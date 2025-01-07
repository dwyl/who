defmodule AppWeb.AppLive do
  use AppWeb, :live_view

  @topic "live"
  @img "https://avatars.githubusercontent.com/u/"

  def mount(_session, _params, socket) do
    if connected?(socket) do
      AppWeb.Endpoint.subscribe(@topic) # subscribe to the channel
    end
    p = %{id: 183617417, login: "Alex",
      avatar_url: "#{@img}183617417", name: "Alexander",
      bio: "Love learning", created_at: "2015", company: "dwyl"}
    {:ok, assign(socket, %{data: p})}
  end

  def handle_event("inc", _value, socket) do
    dbg(socket.assigns)
    val = socket.assigns.data.id + 1
    p = %{id: val, login: "Alex #{val}", avatar_url: "#{@img}#{val}"}
    new_state = assign(socket, %{data: p})
    broadcast("inc", new_state.assigns)

    {:noreply, new_state}
  end

  def handle_event("dec", _, socket) do
    val = socket.assigns.data.id - 1
    p = %{id: val, login: "Alex", avatar_url: "#{@img}#{val}"}
    new_state = assign(socket, %{data: p})
    broadcast("dec", new_state.assigns)
    {:noreply, new_state}
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
    list = App.GitHub.org_user_list("ideaq")
    # Iterate through the list of people and fetch profiles from API
    list
    |> Stream.with_index
    |> Enum.map(fn {u, i} ->
      IO.inspect("- - - Enum.map u.login: #{i}: #{u.login}")
      data = App.User.get_user_from_api(u.login)
      data = AuthPlug.Helpers.strip_struct_metadata(data)
      new_state = assign(socket, %{data: data})
      Task.start(fn ->
        :timer.sleep(300 + 100 * i)
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
end
