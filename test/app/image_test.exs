defmodule App.ImgTest do
  use ExUnit.Case
  alias App.Img

  test "App.Img.get_raw_image_data/1" do
    url = "https://avatars.githubusercontent.com/u/4185328"
    img_data = Img.get_raw_image_data(url) # |> dbg
    assert is_binary(img_data)
  end

  test "App.Img.extract_color/1 retrieves color" do
    url = "https://avatars.githubusercontent.com/u/4185328"
    img_data = Img.get_raw_image_data(url)
    assert Img.extract_color(img_data) == "F8F8F8"

    url2 = "https://avatars.githubusercontent.com/u/194400"
    img_data2 = Img.get_raw_image_data(url2)
    assert Img.extract_color(img_data2) == "F80818"
  end

  test "App.Img.get_avatar_color/1 gets the hex color for avatar" do
    avatar_url = "https://avatars.githubusercontent.com/u/4185328"
    assert Img.get_avatar_color(avatar_url) == "F8F8F8"
  end

  test "to_hex/1 returns the hex value of an integer" do
    assert Img.to_hex(42) == "2A"
  end

  test "rgb_to_hex/1 returns the hex of an RGB color" do
    # https://www.colorhexa.com/2bf0cf
    assert Img.rgb_to_hex(43, 240, 207) == "2BF0CF"
  end
end
