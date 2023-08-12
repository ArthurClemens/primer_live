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
      "primer-live.min.js"
    ]

    filenames
    |> Enum.each(fn filename ->
      assert File.exists?("priv/static/#{filename}")
    end)
  end
end
