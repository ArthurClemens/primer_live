# Installation

## 1. Add primer_live dependency

Add PrimerLive as a dependency in your Phoenix application's `mix.exs`

```
{:primer_live, "~> 0.8"}
```

Run `mix.deps get`

## 2. Mark PrimerLive resources as static

In <code>endpoint.ex</code>, create a new static plug entry:

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

## 4. Add the CSS link to the base HTML

<p>Add the import link to <code>root.html.heex</code>.</p>
<p>If you are using verified routes:</p>

```
<link phx-track-static rel="stylesheet" href={~p"/primer_live/primer-live.min.css"}>
```

Otherwise:

```
<link phx-track-static rel="stylesheet" href="/primer_live/primer-live.min.css">
```
