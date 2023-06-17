defmodule WebSock.MixProject do
  use Mix.Project

  def project do
    [
      app: :websock,
      version: "0.5.2",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      dialyzer: dialyzer(),
      name: "WebSock",
      description: "A specification for WebSocket connections",
      source_url: "https://github.com/phoenixframework/websock",
      package: [
        files: ["lib", "test", "mix.exs", "README*", "LICENSE*"],
        maintainers: ["Mat Trudel"],
        licenses: ["MIT"],
        links: %{"GitHub" => "https://github.com/phoenixframework/websock"}
      ]
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev, :test], runtime: false},
      {:credo, "~> 1.0", only: [:dev, :test], runtime: false}
    ]
  end

  defp dialyzer do
    [plt_core_path: "priv/plts", plt_file: {:no_warn, "priv/plts/dialyzer.plt"}]
  end
end
