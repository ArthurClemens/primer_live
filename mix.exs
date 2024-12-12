defmodule PrimerLive.MixProject do
  use Mix.Project

  def project do
    [
      app: :primer_live,
      version: "0.9.1",
      elixir: "~> 1.17",
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

  defp elixirc_paths(:dev), do: ["lib", "lib_dev"]
  defp elixirc_paths(:test), do: ["lib", "test/support"]
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
      {:floki, "~> 0.36", only: :test, runtime: false},
      {:github_workflows_generator, "~> 0.1", only: :dev, runtime: false},
      {:jason, "~> 1.4"},
      {:mix_audit, "~> 2.1", only: [:dev, :test], runtime: false},
      {:phoenix_ecto, "~> 4.5", only: :test, runtime: false},
      {:phoenix_html_helpers, "~> 1.0"},
      {:phoenix_html, "~> 4.1"},
      {:phoenix_live_view, "~> 1.0"},
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
        "Drawer functions": &(&1[:section] == :drawer_functions),
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
        "Menu functions": &(&1[:section] == :menu_functions),
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
        "doc-extra/styling.md",
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
      # Testing
      #
      # Test with writing failing test results to test/assertion_failures:
      #    WRITE_FAILURES=1 mix test
      #    WRITE_FAILURES=1 mix test test/component_tests/select_test.exs
      #
      # To view the assertions:
      #    elixir scripts/elixir/assertions_viewer.exs
      #
      "test:accept": "cmd scripts/tests/accept_assertions.sh",
      "test:reject": "cmd scripts/tests/clean_assertion_failures.sh",
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
      doc: [
        "cmd rm -rf ./doc",
        "cmd mix docs"
      ],
      "assets.build": [
        # Pre-process CSS
        "cmd npm --prefix assets run pre-process-light-theme-css",
        # Cleanup built files
        "cmd rm -rf priv/static/*",
        # Build JS and CSS
        "cmd npm --prefix assets run build:types",
        "cmd npm --prefix assets run build -- --bundle --format=esm --sourcemap --outfile=../priv/static/primer-live.esm.js",
        "cmd npm --prefix assets run build -- --format=iife --target=es2016 --outfile=../priv/static/primer-live.js",
        "cmd npm --prefix assets run build -- --format=cjs --sourcemap --outfile=../priv/static/primer-live.cjs.js",
        "cmd npm --prefix assets run build -- --format=iife --target=es2016 --minify --outfile=../priv/static/primer-live.min.js",
        # Scoped CSS (discard JS later)
        "cmd SCOPED=1 npm --prefix assets run build -- --format=iife --target=es2016 --outfile=../priv/static/primer-live-scoped.js",
        "cmd SCOPED=1 npm --prefix assets run build -- --format=iife --target=es2016 --minify --outfile=../priv/static/primer-live-scoped.min.js",
        # Post-process scoped CSS
        "cmd npm --prefix assets run post-process-scoped-css -- --file=priv/static/primer-live-scoped.css --prettify=true",
        "cmd npm --prefix assets run post-process-scoped-css -- --file=priv/static/primer-live-scoped.min.css --prettify=false",
        # Clean up
        "cmd rm -rf priv/static/*.cjs.css*",
        "cmd rm -rf priv/static/*.esm.css*",
        "cmd rm -rf priv/static/*-scoped.js",
        "cmd rm -rf priv/static/*-scoped.min.js"
      ],
      # CI
      ci: [
        "deps.unlock --check-unused",
        "deps.audit",
        "hex.audit",
        "sobelow --config",
        "format --check-formatted",
        "credo --strict",
        # "dialyzer",
        "cmd MIX_ENV=test mix test"
      ]
    ]
  end
end
