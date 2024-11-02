defmodule PrimerLiveAssetsTest do
  @moduledoc false
  use ExUnit.Case

  test "priv/static files" do
    filenames = [
      "index.d.ts",
      "primer-live-scoped.css",
      "primer-live-scoped.min.css",
      "primer-live.cjs.js.map",
      "primer-live.cjs.js",
      "primer-live.css",
      "primer-live.esm.js.map",
      "primer-live.esm.js",
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
