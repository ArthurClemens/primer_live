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

  <p>Add PrimerLive as a dependency in your Phoenix application's <code>mix.exs</code></p>

  ```
  {:primer_live, "~> 0.2"}
  ```

  <p>Run <code>mix.deps get</code></p>

  ### Add CSS and JavaScript dependencies

  <p>You can either serve the dependencies as static resources, or use <code>npm</code> to bundle all assets.</p>
  <p>
    If you plan to use menus, dialogs, or drawers in your project, you will need to include JavaScript dependencies. If not, you may skip the JavaScript imports and hooks.
  </p>

  <h3>
    Option A: Serve the dependencies as static resources
  </h3>

  <p>Create a new static plug entry to <code>endpoint.ex</code>:</p>

  ```
  # PrimerLive resources
  plug Plug.Static, at: "/primer_live", from: "deps/primer_live/priv/static"
  ```


  <h4>CSS only</h4>

  <p>Add to <code>root.html.heex</code>:</p>

  ```
  <link phx-track-static rel="stylesheet" href={Routes.static_path(@conn, "/primer_live/primer-live.min.css")}/>
  ```

  <h4>CSS and JavaScript</h4>

  <p>Add to <code>root.html.heex</code>:</p>

  ```
  <link phx-track-static rel="stylesheet" href={Routes.static_path(@conn, "/primer_live/primer-live.min.css")}/>
  <script defer phx-track-static type="text/javascript" src={Routes.static_path(@conn, "/primer_live/primer-live.min.js")}></script>
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
      Prompt: window.Prompt,
      Session: window.Session,
      // existing hooks ...
    },
  });
  ```

  <h3>
    Option B: Adding dependencies using npm
  </h3>

  <p>This process will bundle all of the app's dependencies together with PrimerLive assets into <code>app.js</code> and <code>app.css</code> inside <code>priv/static/assets</code>.</p>

  <p>Add npm library <code>primer-live</code> to your <code>assets/package.json</code>. For a regular project, do:</p>
  ```
  {
    "dependencies": {
      "primer-live": "file:../deps/primer_live"
    }
  }
  ```

  <p>If you're adding <code>primer-live</code> to an umbrella project, change the paths accordingly:</p>

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

  <p>If you had previously installed <code>primer-live</code> and want to get the latest JavaScript, then force an install with:</p>

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


  ## Usage in LiveView pages

  <p>To use components, <code>use</code> module <code>PrimerLive</code>:</p>

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

  <p>In view files, for example in <code>page_view.ex</code>, <code>use</code> module <code>PrimerLive</code>:</p>

  ```
  defmodule MyAppWeb.PageView do
    use MyAppWeb, :view
    use PrimerLive
  end
  ```

  <p>Then call the component on a page, for example in <code>templates/page/index.html.heex</code>:</p>
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
