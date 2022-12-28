defmodule PrimerLive do
  @moduledoc ~S'''

  <p>
  PrimerLive is a collection of function components that implements <a href="https://primer.style/" target="_blank">GitHub's Primer Design System</a>. It is intended for usage in <a href="https://github.com/phoenixframework/phoenix_live_view" target="_blank">Phoenix LiveView pages</a> and regular (non-LiveView) views in Phoenix applications.
  </p>

  <p>
  Since this implementation closely adheres to the <a href="https://primer.style/css/" target="_blank">Primer CSS documentation</a>, extending components with <a href="https://primer.style/css/utilities" target="blank">Primer's utility classes</a> should be simple.
  </p>

  ## Source code

  [PrimerLive at GitHub](https://github.com/ArthurClemens/primer_live)

  ## Versioning

  Dependencies:
  - [primer-live (npm)](https://www.npmjs.com/package/primer-live)
    - Includes:
      - [@primer/css](https://www.npmjs.com/package/@primer/css)
      - [dialogic-js](https://www.npmjs.com/package/dialogic-js)

  Included libraries:
  - [Octicons](https://primer.style/octicons/): `17.9.0`


  ## Installation

  ### Install dependencies

  - Edit `mix.exs` and add dependency `primer_live`
  - Run `mix.deps get`

  ### Dependency setup for deploying

  To ensure that the assets are installed before your application has started, or before it has been deployed, add "npm install" to the scripts in `mix.exs`. For example:

  ```
  defp aliases do
    [
      setup: ["deps.get", "cmd npm --prefix assets install"],
      "assets.deploy": [
        "cmd npm --prefix assets install",
        "esbuild default --minify",
        "phx.digest"
      ]
    ]
  end
  ```

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
