defmodule App.Image do
  @moduledoc """
  Handles extracting color data from images.
  Uses: https://github.com/elixir-image/image
  """
  require Logger
  :inets.start()
  :ssl.start()

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
    "blue"
  end
end
