defmodule App.ImageTest do
  use ExUnit.Case
  alias App.Image

  test "App.Image.get_raw_image_data/1" do
    url = "https://avatars.githubusercontent.com/u/4185328"
    img_data = Image.get_raw_image_data(url) # |> dbg
    assert is_binary(img_data)
  end

  test "App.Image.extract_color/1 retrieves color" do
    url = "https://avatars.githubusercontent.com/u/4185328"
    img_data = Image.get_raw_image_data(url)
    Image.extract_color(img_data)

  end
end
