defmodule PrimerLive.MixProject do
  use Mix.Project

  def project do
    [
      app: :primer_live,
      name: "PrimerLive",
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs()
    ]
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
      {:phoenix_live_view, "~> 0.18"},
      {:phoenix_html, "~> 3.0"},
      {:typed_ecto_schema, "~> 0.4.1"},
      {:ecto_sql, "~> 3.6"},
      {:jason, "~> 1.0"},
      {:ex_doc, "~> 0.28.5", only: :dev},
      {:earmark, "~> 1.4", only: :dev},
      {:dialyxir, "~> 1.2", only: :dev, runtime: false}
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
        Dropdown: &(&1[:section] == :dropdown),
        Forms: &(&1[:section] == :forms),
        Header: &(&1[:section] == :header),
        Icons: &(&1[:section] == :icons),
        Labels: &(&1[:section] == :labels),
        Layout: &(&1[:section] == :layout),
        Links: &(&1[:section] == :links),
        Loaders: &(&1[:section] == :loaders),
        Markdown: &(&1[:section] == :markdown),
        Navigation: &(&1[:section] == :navigation),
        Pagination: &(&1[:section] == :pagination),
        Popover: &(&1[:section] == :popover),
        Progress: &(&1[:section] == :progress),
        "Select menu": &(&1[:section] == :select_menu),
        Subhead: &(&1[:section] == :subhead),
        Timeline: &(&1[:section] == :timeline),
        Toasts: &(&1[:section] == :toasts),
        Tooltips: &(&1[:section] == :tooltips),
        Truncate: &(&1[:section] == :truncate)
      ],
      extras: [
        "LICENSE.md"
      ]
    ]
  end
end
