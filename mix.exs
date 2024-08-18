defmodule PrimerLive.MixProject do
  use Mix.Project

  def project do
    [
      app: :primer_live,
      version: "0.7.2",
      homepage_url: "https://github.com/ArthurClemens/primer_live",
      elixirc_paths: elixirc_paths(Mix.env()),
      description: description(),
      package: package(),
      aliases: aliases(),
      name: "PrimerLive",
      deps: deps(),
      docs: docs(),
      consolidate_protocols: Mix.env() != :test
    ]
  end

  defp elixirc_paths(:dev), do: ["lib", "lib_target"]
  defp elixirc_paths(_), do: ["lib"]

  defp description do
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
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:ecto_sql, "~> 3.10", only: :test, runtime: false},
      {:ecto, "~> 3.10", runtime: false},
      {:esbuild, "~> 0.8", only: [:dev, :test]},
      {:ex_doc, "~> 0.34", only: :dev},
      {:jason, "~> 1.4"},
      {:phoenix_ecto, "~> 4.5", only: :test, runtime: false},
      {:phoenix_html, "~> 4.1"},
      {:phoenix_html_helpers, "~> 1.0"},
      {:phoenix_live_view, "~> 0.20"},
      {:sobelow, "~> 0.13", only: [:dev, :test], runtime: false}
    ]
  end

  defp docs do
    [
      main: "PrimerLive",
      groups_for_docs: [
        Alerts: &(&1[:section] == :alerts),
        Avatars: &(&1[:section] == :avatars),
        Blankslate: &(&1[:section] == :blankslate),
        Box: &(&1[:section] == :box),
        "Branch name": &(&1[:section] == :branch_name),
        Breadcrumbs: &(&1[:section] == :breadcrumbs),
        Buttons: &(&1[:section] == :buttons),
        Dialog: &(&1[:section] == :dialog),
        "Dialog functions": &(&1[:section] == :dialog_functions),
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
      # Quality check
      qa: [
        "deps.clean --unlock --unused",
        "format",
        "format --check-formatted",
        "compile",
        "sobelow --config",
        "credo --strict",
        "docs"
      ],
      "assets.build": [
        "cmd rm -rf priv/static/*",
        "cmd npm --prefix assets run build -- --outfile=../priv/static/primer-live.js",
        "cmd npm --prefix assets run build -- --minify --outfile=../priv/static/primer-live.min.js",
        "cmd rm -rf priv/static/*.js"
      ]
    ]
  end
end
