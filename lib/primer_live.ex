defmodule PrimerLive do
  @moduledoc ~S'''

  <p>
    PrimerLive components can be used in <a href="https://github.com/phoenixframework/phoenix_live_view" target="_blank">Phoenix LiveView pages</a> and regular (non-LiveView) views in Phoenix applications.
  </p>

  <p>
    The Primer Design System provides a strong base for creating data driven applications such as rich CRUD applications with interactive forms.
  </p>

  <p>
    Since this implementation closely adheres to the <a href="https://primer.style/css/" target="_blank">Primer CSS documentation</a>, extending components with <a href="https://primer.style/css/utilities" target="blank">Primer's utility classes</a> should be simple.
  </p>

  ## Demo

  [PrimerLive Storybook](https://primer-live.org)

  ## Component documentation

  See [Components](`PrimerLive.Component`)

  ## Installation

  See [Installation](doc-extra/installation.md)

  ## Usage

  See [Usage](doc-extra/usage.md)

  ## Source code

  [PrimerLive at GitHub](https://github.com/ArthurClemens/primer_live)

  '''

  defmacro __using__(_) do
    quote do
      import PrimerLive.Component
      import PrimerLive.Octicons
      alias PrimerLive.Theme
    end
  end
end
