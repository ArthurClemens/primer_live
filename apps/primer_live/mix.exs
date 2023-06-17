defmodule PrimerLive.MixProject do
  use Mix.Project

  def project do
    [
      app: :primer_live,
      version: "0.4.0",
      homepage_url: "https://github.com/ArthurClemens/primer_live",
      description: description(),
      package: package(),
      aliases: aliases(),
      name: "PrimerLive",
      deps: deps(),
      docs: docs()
    ]
  end

  defp description() do
    "A collection of function components that implements GitHub's Primer Design System."
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
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:ecto_sql, "~> 3.9"},
      {:esbuild, "~> 0.7", only: :dev},
      {:ex_doc, "~> 0.29", only: :dev},
      {:phoenix_html, "~> 3.3"},
      {:phoenix_live_view, ">= 0.18.3"},
      {:jason, "~> 1.4"}
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
        "doc-extra/installation.md",
        "doc-extra/usage.md",
        "doc-extra/menus-and-dialogs.md",
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
                CHANGELOG* package.json)
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
        "cmd npm --prefix assets run build:types"
      ]
    ]
  end
end
