defmodule PrimerLive do
  @moduledoc ~S'''
  PrimerLive is a collection of function components that implements [GitHub's Primer Design System](https://primer.style/). It is intended for usage in Phoenix LiveView pages and conventional (non-LiveView) views.

  ## Usage

  ### Setup

  - Edit `mix.exs` and add dependency `primer_live`
  - Run `mix.deps get`

  ### Usage in LiveView pages

  To use components, `use` module `PrimerLive`:

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

  ### Usage in regular views

  In view files, for example in `page_view.ex`, `use` module `PrimerLive`:

  ```
  defmodule MyAppWeb.PageView do
    use MyAppWeb, :view
    use PrimerLive
  end
  ```

  Then call the component on a page, for example in `templates/page/index.html.heex`:
  ```
  <.button>Click me</.button>
  ```

  ## List of components

  `PrimerLive.Component`

  '''

  defmacro __using__(_) do
    quote do
      import PrimerLive.Component
      import PrimerLive.Octicons
    end
  end
end
