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
      {:phoenix_live_view, git: "https://github.com/phoenixframework/phoenix_live_view"},
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
      groups_for_modules: [
        "Component options": ~r/PrimerLive.Options/
      ],
      groups_for_functions: [
        Layout: &(&1[:section] == :layout),
        Forms: &(&1[:section] == :form),
        Buttons: &(&1[:section] == :buttons),
        Menus: &(&1[:section] == :menus),
        Alerts: &(&1[:section] == :alerts),
        Icons: &(&1[:section] == :icons),
        Pagination: &(&1[:section] == :pagination)
      ],
      nest_modules_by_prefix: [
        PrimerLive.Options
      ],
      extras: [
        "LICENSE.md"
      ]
    ]
  end
end
