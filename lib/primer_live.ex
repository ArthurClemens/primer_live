defmodule PrimerLive do
  @moduledoc ~S'''
  PrimerLive is a Phoenix LiveView component library that implements [GitHub's Primer Design System](https://primer.style/).

  ## Usage

  Add `primer_live` as dependency to your project.

  To use components, `use` module `PrimerLive`:

      defmodule MyApp.MyPage do
        use Phoenix.LiveComponent
        use PrimerLive

        def render(assigns) do
          ~H"""
          <.button></.button>
          """
        end

      end

  '''

  defmacro __using__(_) do
    quote do
      import PrimerLive.Components.{
        # ActionList,
        # Box,
        # Button,
        # Flash,
        # Form,
        # Icon,
        # Helpers,
        Pagination
      }
    end
  end
end
