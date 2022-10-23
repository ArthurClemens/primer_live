# PrimerLive

PrimerLive is a collection of function components that implements [GitHub's Primer Design System](https://primer.style/). It is intended for usage in Phoenix LiveView pages and conventional (non-LiveView) views.

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