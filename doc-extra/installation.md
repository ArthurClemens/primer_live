# Installation

## 1. Add primer_live dependency

Add PrimerLive as a dependency in your Phoenix application's `mix.exs`

```
{:primer_live, "~> 0.9"}
```

Run `mix.deps get`.

## 2. Mark PrimerLive resources as static

In `endpoint.ex`, create a new Static Plug entry:

```
# PrimerLive resources
plug(Plug.Static,
  at: "/primer_live",
  from: {:primer_live, "priv/static"}
)
```

## 3. Update VerifiedRoutes config (optional)

In `<app>_web.ex`, change the `Phoenix.VerifiedRoutes` configuration to include the `primer_live` directory:

```
def static_paths, do: ~w(assets fonts images favicon.png robots.txt primer_live)
```

## 4. Add the CSS and JavaScript to the base HTML

Add the import link to `root.html.heex`.

If you are using verified routes:

```
<link phx-track-static rel="stylesheet" href={~p"/primer_live/primer-live.min.css"}>
<script defer phx-track-static type="text/javascript" src={~p"/primer_live/primer-live.min.js"}></script>
```

Otherwise:

```
<link phx-track-static rel="stylesheet" href="/primer_live/primer-live.min.css">
<script defer phx-track-static type="text/javascript" src={"/primer_live/primer-live.min.js"}></script>
```

### Scoped CSS

The relatively new `@scope` rule enables localized CSS. In practical terms, it allows multiple CSS libraries to coexist within a single codebase without causing style conflicts. For example, use Tailwind components in one section of the page, and use PrimerLive components in another section.

Browser support for the @scope rule is still limited. For more details, see [Can I use: @scope rule](https://caniuse.com/css-cascade-scope). If you're using PrimerLive in a controlled environment where users have access to the latest browsers, you may consider experimenting with this feature.

To use PrimerLive CSS with CSS scope:
- Change the CSS import to `primer-live-scoped.min.css` (or `primer-live-scoped.css`).
- Create a container with class `primer-live` (not the `html` element) where you will be using PrimerLive components.

Example:
```
<html>
  <body>
    <section>Some content</section>
    <section class="primer-live">PrimerLive components</section>
  </body>
</html>
```

## 5. Add the Prompt hook

In `assets/js/app.js`, add global `Prompt` to the hooks:

```
let liveSocket = new LiveSocket("/live", Socket, {
  params: { _csrf_token: csrfToken },
  hooks: {
    Prompt: window.Prompt,
    // existing hooks ...
  },
});
```
