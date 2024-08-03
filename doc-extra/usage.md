# Usage

## Usage in LiveView pages

```
defmodule MyAppWeb.MyLiveView do
  use MyAppWeb, :live_view
  alias PrimerLive.Component, as: P

  def render(assigns) do
    ~H"""
    <P.button>Click me</P.button>
    """
  end

end
```

Or import with `use`:

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

In view files, for example in `page_view.ex`:

```
defmodule MyAppWeb.PageView do
  use MyAppWeb, :view
  alias PrimerLive.Component, as: P
end
```

Then call the component on a page, for example in `templates/page/index.html.heex`:

```
<P.button>Click me</P.button>
```

Or import with `use`:

```
defmodule MyAppWeb.PageView do
  use MyAppWeb, :view
  use PrimerLive
end
```

Call the component on a page:

```
<.button>Click me</.button>
```
