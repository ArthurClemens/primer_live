# Installation

## Install primer_live

Add PrimerLive as a dependency in your Phoenix application's `mix.exs`

```
{:primer_live, "~> 0.4"}
```

Run `mix.deps get`

## CSS and JavaScript

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

<p>Add the import link to <code>root.html.heex</code>.</p>
<p>If you are using verified routes:</p>

```
<link phx-track-static rel="stylesheet" href={~p"/primer_live/primer-live.min.css"}>
```

Otherwise:

```
<link phx-track-static rel="stylesheet" href="/primer_live/primer-live.min.css">
```

<h4>CSS and JavaScript</h4>

<p>Add both import links to <code>root.html.heex</code>.</p>
<p>If you are using verified routes:</p>

```
<link phx-track-static rel="stylesheet" href={~p"/primer_live/primer-live.min.css"}>
<script defer phx-track-static type="text/javascript" src={~p"/primer_live/primer-live.min.js"}></script>
```

Otherwise:

```
<link phx-track-static rel="stylesheet" href="/primer_live/primer-live.min.css">
<script defer phx-track-static type="text/javascript" src="/primer_live/primer-live.min.js"></script>
```

<p>
  In <code>assets/js/app.js</code>, add global <code>Prompt</code>
  and <code>Theme</code>
  to the hooks:
</p>

```
let liveSocket = new LiveSocket("/live", Socket, {
  params: { _csrf_token: csrfToken },
  hooks: {
    Prompt: window.Prompt,
    Theme: window.Theme,
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
import { Prompt, Theme } from "primer-live";
```

<p>Also in <code>assets/js/app.js</code>, add <code>Prompt</code> and <code>Theme</code> to the hooks:</p>

```
let liveSocket = new LiveSocket("/live", Socket, {
  params: { _csrf_token: csrfToken },
  hooks: {
    Prompt,
    Theme,
    // existing hooks ...
  },
});
```