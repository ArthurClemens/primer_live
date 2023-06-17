defmodule PrimerLiveTest.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      PrimerLiveTestWeb.Telemetry,
      # Start the Ecto repository
      PrimerLiveTest.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: PrimerLiveTest.PubSub},
      # Start Finch
      {Finch, name: PrimerLiveTest.Finch},
      # Start the Endpoint (http/https)
      PrimerLiveTestWeb.Endpoint
      # Start a worker by calling: PrimerLiveTest.Worker.start_link(arg)
      # {PrimerLiveTest.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PrimerLiveTest.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PrimerLiveTestWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
