defmodule PrimerLive do
  @moduledoc ~S"""

  An implementation of GitHub's [Primer Design System](https://primer.style/design) for Phoenix LiveView and regular (non-LiveView) views in Phoenix applications.

  PrimerLive provides a strong base for creating data driven applications such as rich CRUD applications with interactive forms that integrate with Phoenix Forms, Ash Forms and Ecto Changesets.

  Menus and dialogs allow for in-page viewing and editing of data, without leaving the current page. Alternatively, menus and dialogs can be invoked when visiting a specific route.

  Components (and their inner elements) can be styled with custom CSS, or by passing pre-made utility classes.

  Right-to-left languages are supported.

  ## Documentation

  - [Installation](doc-extra/installation.md)
  - [Usage](doc-extra/usage.md)
  - [Components](`PrimerLive.Component`)

  ## Further reading

  - [Styling](doc-extra/styling.md)
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
