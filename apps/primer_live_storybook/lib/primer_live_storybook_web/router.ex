defmodule PrimerLiveStorybookWeb.Router do
  use PrimerLiveStorybookWeb, :router
  alias PrimerLiveStorybookWeb.NavigationTopicHelpers

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:put_root_layout, {PrimerLiveStorybookWeb.Layouts, :root})
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
    plug(:fetch_session)
  end

  scope "/", PrimerLiveStorybookWeb do
    pipe_through(:browser)

    get("/", PageController, :home)
    live("/button", ButtonLive, :show)
    live("/action_list", ActionListLive)
  end

  # Other scopes may use custom stacks.
  scope "/api", PrimerLiveStorybookWeb do
    pipe_through(:api)

    post(PrimerLive.Theme.session_route(), SessionController, :set)

    post(
      NavigationTopicHelpers.navigation_topic_state_route(),
      SessionController,
      :set_navigation_topic_state
    )
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:primer_live_storybook, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through(:browser)

      live_dashboard("/dashboard", metrics: PrimerLiveStorybookWeb.Telemetry)
      forward("/mailbox", Plug.Swoosh.MailboxPreview)
    end
  end
end
