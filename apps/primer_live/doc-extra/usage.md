# Usage

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
