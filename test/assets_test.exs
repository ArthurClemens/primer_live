defmodule PrimerLiveAssetsTest do
  use ExUnit.Case

  test "priv/static files" do
    filenames = [
      "index.d.ts",
      "primer-live.cjs.js",
      "primer-live.cjs.js.map",
      "primer-live.css",
      "primer-live.esm.js",
      "primer-live.esm.js.map",
      "primer-live.js",
      "primer-live.min.css",
      "primer-live.min.js",
      "primer-live-prompt.cjs.js",
      "primer-live-prompt.cjs.js.map",
      "primer-live-prompt.css",
      "primer-live-prompt.esm.js",
      "primer-live-prompt.esm.js.map",
      "primer-live-prompt.js",
      "primer-live-prompt.min.css",
      "primer-live-prompt.min.js"
    ]

    filenames
    |> Enum.each(fn filename ->
      assert File.exists?("priv/static/#{filename}")
    end)
  end
end
