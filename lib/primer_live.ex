defmodule PrimerLive do
  @moduledoc ~S"""

  An implementation of GitHub's [Primer Design System](https://primer.style/design) for Phoenix LiveView.

  Primer Design provides a strong base for creating data driven applications such as rich CRUD applications with interactive forms.

  All PrimerLive components accept the `class` attribute for customisations (and often the `classes` struct to address inner elements). [Primer's utility classes](https://primer.style/design/foundations/css-utilities/getting-started) allow a wide range of customisations without having to write custom styles.

  PrimerLive components can be used in [Phoenix LiveView pages](https://github.com/phoenixframework/phoenix_live_view) and regular (non-LiveView) views in Phoenix applications.

  Forms created with [Ash Framework](https://www.ash-hq.org/) are supported.

  ## Documentation

  - [Installation](doc-extra/installation.md)
  - [Usage](doc-extra/usage.md)
  - [Components](`PrimerLive.Component`)
  - [Menus and dialogs](doc-extra/menus-and-dialogs.md)

  ## Resources

  - [PrimerLive Storybook and Demo](https://primer-live.org)
  - [Source code](https://github.com/ArthurClemens/primer_live)
  """

  defmacro __using__(_) do
    quote do
      import PrimerLive.Component
      import PrimerLive.Octicons
      import PrimerLive.StatefulConditionComponent
      alias PrimerLive.Theme
    end
  end
end
