defmodule App.Img do
  @moduledoc """
  Handles extracting color data from images.
  Uses: https://github.com/elixir-image/image
  """
  require Logger
  :inets.start()
  :ssl.start()
  @hex "0123456789ABCDEF"

  @doc """
  Retrieve raw image data from a URL.
  https://stackoverflow.com/questions/30267943/elixir-download-image-from-url
  """
  def get_raw_image_data(imgurl) do
    {:ok, resp} = :httpc.request(:get, {imgurl, []}, [], [body_format: :binary])
    {{_, 200, ~c"OK"}, _headers, body} = resp

    body
  end

  @doc """
  Returns the predominant color for an image.
  https://hexdocs.pm/image/Image.html#dominant_color/2
  """
  def extract_color(img_data) do
    {:ok, [r, g, b]} =
      Image.open!(img_data)
      |> Image.dominant_color()

    rgb_to_hex(r, g, b)
  end

  def get_avatar_color(avatar_url) do
    get_raw_image_data(avatar_url) |> extract_color()
  end

  # functions borrowed from:
  # https://github.com/nelsonic/colors/blob/master/colors.html#L96
  def rgb_to_hex(r, g, b) do
    "#{to_hex(r)}#{to_hex(g)}#{to_hex(b)}"
  end

  # No error/bounds checking as values come from `Image.dominant_color/1`
  def to_hex(n) do
    mod = Integer.mod(n, 16)
    rounded = trunc(Float.ceil((n - mod) / 16))
    "#{String.at(@hex, rounded)}#{String.at(@hex, mod)}"
  end
end
