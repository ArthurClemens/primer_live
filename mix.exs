defmodule PrimerLive.MixProject do
  use Mix.Project

  def project do
    [
      app: :primer_live,
      version: "0.6.4",
      homepage_url: "https://github.com/ArthurClemens/primer_live",
      description: description(),
      package: package(),
      aliases: aliases(),
      name: "PrimerLive",
      deps: deps(),
      docs: docs(),
      consolidate_protocols: Mix.env() != :test
    ]
  end

  defp description() do
    "An implementation of GitHub's Primer Design System for Phoenix LiveView."
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ash_phoenix, "~> 1.2", only: :test, runtime: false},
      {:ash, "~> 2.15", only: :test, runtime: false},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:ecto_sql, "~> 3.10", only: :test, runtime: false},
      {:ecto, "~> 3.10", runtime: false},
      {:esbuild, "~> 0.8", only: :dev},
      {:ex_doc, "~> 0.31", only: :dev},
      {:jason, "~> 1.4"},
      {:phoenix_ecto, "~> 4.4", only: :test, runtime: false},
      {:phoenix_html, "~> 3.3"},
      {:phoenix_live_view, "~> 0.19"}
    ]
  end

  defp docs do
    [
      main: "PrimerLive",
      groups_for_functions: [
        Alerts: &(&1[:section] == :alerts),
        Avatars: &(&1[:section] == :avatars),
        Blankslate: &(&1[:section] == :blankslate),
        Box: &(&1[:section] == :box),
        "Branch name": &(&1[:section] == :branch_name),
        Breadcrumbs: &(&1[:section] == :breadcrumbs),
        Buttons: &(&1[:section] == :buttons),
        Dialog: &(&1[:section] == :dialog),
        Drawer: &(&1[:section] == :drawer),
        "Styled HTML": &(&1[:section] == :styled_html),
        Forms: &(&1[:section] == :forms),
        Header: &(&1[:section] == :header),
        Icons: &(&1[:section] == :icons),
        Labels: &(&1[:section] == :labels),
        Layout: &(&1[:section] == :layout),
        Links: &(&1[:section] == :links),
        Loaders: &(&1[:section] == :loaders),
        Markdown: &(&1[:section] == :markdown),
        Menus: &(&1[:section] == :menus),
        Navigation: &(&1[:section] == :navigation),
        Pagination: &(&1[:section] == :pagination),
        Popover: &(&1[:section] == :popover),
        Progress: &(&1[:section] == :progress),
        Subhead: &(&1[:section] == :subhead),
        Theme: &(&1[:section] == :theme),
        Timeline: &(&1[:section] == :timeline),
        Toasts: &(&1[:section] == :toasts),
        Tooltips: &(&1[:section] == :tooltips),
        Truncate: &(&1[:section] == :truncate)
      ],
      extras: [
        "doc-extra/overview.md",
        "doc-extra/installation.md",
        "doc-extra/usage.md",
        "doc-extra/menus-and-dialogs.md",
        "CHANGELOG.md",
        "LICENSE.md"
      ]
    ]
  end

  defp package do
    [
      maintainers: ["Arthur Clemens"],
      licenses: ["MIT"],
      links: %{
        GitHub: "https://github.com/ArthurClemens/primer_live"
      },
      files:
        ~w(lib .formatter.exs mix.exs README* LICENSE* priv/octicon_builder/build.exs priv/static
                CHANGELOG* package.json),
      exclude_patterns: ["lib/helpers/test_helpers", "priv/octicon_builder"]
    ]
  end

  defp aliases do
    [
      setup: ["deps.get", "cmd --cd assets npm install --legacy-peer-deps"],
      "assets.build": [
        "cmd npm --prefix assets run build:clear -- ../priv/static/*",
        "cmd npm --prefix assets run build -- --format=esm --sourcemap --outfile=../priv/static/primer-live.esm.js",
        "cmd npm --prefix assets run build -- --format=cjs --sourcemap --outfile=../priv/static/primer-live.cjs.js",
        "cmd npm --prefix assets run build -- --format=iife --target=es2016 --outfile=../priv/static/primer-live.js",
        "cmd npm --prefix assets run build -- --format=iife --target=es2016 --minify --outfile=../priv/static/primer-live.min.js",
        # Prompt only
        "cmd npm --prefix assets run build -- --format=esm --sourcemap --outfile=../priv/static/primer-live-prompt.esm.js",
        "cmd npm --prefix assets run build -- --format=cjs --sourcemap --outfile=../priv/static/primer-live-prompt.cjs.js",
        "cmd npm --prefix assets run build -- --format=iife --target=es2016 --outfile=../priv/static/primer-live-prompt.js",
        "cmd npm --prefix assets run build -- --format=iife --target=es2016 --minify --outfile=../priv/static/primer-live-prompt.min.js",
        "cmd npm --prefix assets run build:types"
      ]
    ]
  end
end
