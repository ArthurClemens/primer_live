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

  ## Source code

  [PrimerLive at GitHub](https://github.com/ArthurClemens/primer_live)

  ## Installation

  ### Install primer_live

  Add PrimerLive as a dependency in your Phoenix application's `mix.exs`

  ```
  {:primer_live, "~> 0.2.2"}
  ```

  Run `mix.deps get`

  ### Add CSS and JavaScript dependencies

  <p>You can either use `npm`, or add the dependencies to the HTML file.</p>
  <p>
    If you plan to use menus, dialogs, or drawers in your project, you will need to include JavaScript dependencies. If not, you may skip the JavaScript imports and hooks.
  </p>

  <h3>
    Option A: Adding dependencies using npm
  </h3>

  Add npm library `primer-live` to your `assets/package.json`. For a regular project, do:
  ```
  {
    "dependencies": {
      "primer-live": "file:../deps/primer_live"
    }
  }
  ```

  If you're adding `primer-live` to an umbrella project, change the paths accordingly:

  ```
  {
    "dependencies": {
      "primer-live": "file:../../../deps/primer_live"
    }
  }
  ```

  Now run the next command from your web app root:

  ```
  npm install --prefix assets
  ```

  If you had previously installed `primer-live` and want to get the latest JavaScript, then force an install with:

  ```
  npm install --force primer-live --prefix assets
  ```

  <p>
    To ensure that the assets are installed before your application has started, and before it has been deployed, add &quot;npm install&quot; to the setup and deploy scripts in <code class="inline">mix.exs</code>.
  </p>

  <p>For example:</p>

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

  <p>Run <code class="inline">mix setup</code> to install the npm dependencies.</p>

  <p>Add to <code>assets/js/app.js</code>:</p>

  ```
  import "primer-live/primer-live.min.css";
  import { Prompt, Session } from "primer-live";
  ```

  <p>Also in <code>assets/js/app.js</code>, add <code>Prompt</code> and <code>Session</code> to the hooks:</p>

  ```
  let liveSocket = new LiveSocket("/live", Socket, {
    params: { _csrf_token: csrfToken },
    hooks: {
      Prompt,
      Session,
      // existing hooks ...
    },
  });
  ```

  <h3>
    Option B: Adding dependencies to the HTML file
  </h3>

  <p>Load the dependencies from a content delivery service such as unpkg.</p>

  <h4>CSS only</h4>

  <p>Add to <code>root.html.heex</code>:</p>

  ```
  <link rel="stylesheet" href="https://unpkg.com/primer-live/priv/static/primer-live.min.css" media="all">
  ```

  <h4>CSS and JavaScript</h4>

  <p>Add to <code>root.html.heex</code>:</p>

  ```
  <link rel="stylesheet" href="https://unpkg.com/primer-live/priv/static/primer-live.min.css" media="all">
  <script src="https://unpkg.com/primer-live/priv/static/primer-live.min.js"></script>
  ```

  <p>
    In <code>assets/js/app.js</code>, add global <code>Prompt</code>
    and <code>Session</code>
    to the hooks:
  </p>

  ```
  let liveSocket = new LiveSocket("/live", Socket, {
    params: { _csrf_token: csrfToken },
    hooks: {
      Prompt,
      Session,
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
      alias PrimerLive.Theme
    end
  end
end
