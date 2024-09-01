defmodule PrimerLive do
  @moduledoc ~S"""

  An implementation of GitHub's <a href="https://primer.style/design/" target="blank">Primer Design System</a> for Phoenix LiveView.

  Primer Design provides a strong base for creating data driven applications such as rich CRUD applications with interactive forms.

  All PrimerLive components accept the `class` attribute for customisations (and often the `classes` struct to address inner elements). <a href="https://primer.style/design/foundations/css-utilities/getting-started" target="blank">Primer's utility classes</a> allow a wide range of customisations without having to write custom styles.

  PrimerLive components can be used in <a href="https://github.com/phoenixframework/phoenix_live_view" target="_blank">Phoenix LiveView pages</a> and regular (non-LiveView) views in Phoenix applications.

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
