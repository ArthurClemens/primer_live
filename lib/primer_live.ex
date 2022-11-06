defmodule PrimerLive do
  @moduledoc ~S'''
  PrimerLive is a collection of function components that implements [GitHub's Primer Design System](https://primer.style/). It is intended for usage in Phoenix LiveView pages and regular (non-LiveView) views.

  ## Versioning

  Dependencies:
  - [primer-live](https://www.npmjs.com/package/primer-live): `0.1.6`
    - Includes:
      - [@primer/css](https://www.npmjs.com/package/@primer/css): `20.5.1`
      - [dialogic-js](https://www.npmjs.com/package/dialogic-js): `0.2.8`

  Included libraries:
  - [Octicons](https://primer.style/octicons/): `17.9.0`



  ## Installation

  ### Install dependencies

  - Edit `mix.exs` and add dependency `primer_live`
  - Run `mix.deps get`

  ### Set up JavaScript / CSS

  Install [primer-live](https://www.npmjs.com/package/primer-live)

  Inside your assets folder, do:

  ```bash
  npm install primer-live --save
  ```

  Add to your `app.js`:

  ```js
  import { Prompt } from "primer-live";
  import "primer-live/primer-live.css";
  ```

  In `app.js`, add `Prompt` to the hooks:

  ```js
  let liveSocket = new LiveSocket("/live", Socket, {
    params: { _csrf_token: csrfToken },
    hooks: {
      Prompt,
      // existing hooks ...
    },
  });
  ```

  ## Usage in LiveView pages

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

  ## Usage in regular views

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
