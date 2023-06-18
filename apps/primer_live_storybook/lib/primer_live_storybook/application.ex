defmodule PrimerLiveStorybook.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      PrimerLiveStorybookWeb.Telemetry,
      # Start the Ecto repository
      PrimerLiveStorybook.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: PrimerLiveStorybook.PubSub},
      # Start Finch
      {Finch, name: PrimerLiveStorybook.Finch},
      # Start the Endpoint (http/https)
      PrimerLiveStorybookWeb.Endpoint
      # Start a worker by calling: PrimerLiveStorybook.Worker.start_link(arg)
      # {PrimerLiveStorybook.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PrimerLiveStorybook.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PrimerLiveStorybookWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
