defmodule PrimerLive do
  @moduledoc ~S'''
  `use PrimerLive` convenience macro.

  ```
  defmodule MyAppWeb.MyLiveView do
    use MyAppWeb, :live_view
    use PrimerLive

    def render(assigns) do
      ~H"""
      <.button>Click me</.button>
      """
    end

  end
  ```
  '''

  defmacro __using__(_) do
    quote do
      import PrimerLive.Component
      import PrimerLive.Octicons
      alias PrimerLive.Theme
    end
  end
end
