defmodule PrimerLive.Options.BoxRow do
  use Options

  @moduledoc """
  Options for the box row element (passed in the box' `:inner_block` slot) in `PrimerLive.Options.Box`.

  | **Name** | **Type** | **Validation** | **Default**  | **Description** |
  | `inner_block` | `slot` | required | - | Row content. |
  | `class`   | `string` | - | - | Additional classname. |
  | `is_blue` | `boolean` | - | false | Blue row theme. |
  | `is_yellow` | `boolean` | - | false | Yellow row theme. |
  | `is_gray` | `boolean` | - | false | Gray row theme. |
  | `is_focus_blue` | `boolean` | - | false | Changes to blue row theme on focus. |
  | `is_focus_gray` | `boolean` | - | false | Changes to gray row theme on focus. |
  | `is_hover_blue` | `boolean` | - | false | Changes to blue row theme on hover. |
  | `is_hover_gray` | `boolean` | - | false | Changes to gray row theme on hover. |
  | `is_navigation_focus` | `boolean` | - | false | Combine with a theme color to highlight the row when using keyboard commands. |
  | `is_unread` | `boolean` | - | false | Apply a blue vertical line highlight for indicating a row contains unread items. |

  """

  typed_embedded_schema do
    field(:inner_block, :any, virtual: true)
    field(:class, :string)
    field(:is_blue, :boolean, default: false)
    field(:is_focus_blue, :boolean, default: false)
    field(:is_focus_gray, :boolean, default: false)
    field(:is_gray, :boolean, default: false)
    field(:is_hover_blue, :boolean, default: false)
    field(:is_hover_gray, :boolean, default: false)
    field(:is_navigation_focus, :boolean, default: false)
    field(:is_unread, :boolean, default: false)
    field(:is_yellow, :boolean, default: false)
  end

  @impl Options
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(
      attrs,
      [
        :class,
        :inner_block,
        :is_blue,
        :is_focus_blue,
        :is_focus_gray,
        :is_gray,
        :is_hover_blue,
        :is_hover_gray,
        :is_navigation_focus,
        :is_unread,
        :is_yellow
      ]
    )
    |> validate_required(:inner_block)
  end
end

defmodule PrimerLive.Options.Box.Classes do
  use Options

  @moduledoc """
  Options for `classes` in `PrimerLive.Options.Box`.

  | **Classname** | **Description** |
  | `box` | The box element class. |
  | `header` | Header class. |
  | `body` | Body class. |
  | `footer` | Footer class. |
  | `title` | Title class. |
  """

  typed_embedded_schema do
    field(:box, :string)
    field(:header, :string)
    field(:body, :string)
    field(:footer, :string)
    field(:title, :string)
  end

  @impl Options
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [:box, :header, :body, :footer, :title])
  end
end

defmodule PrimerLive.Options.Box do
  use Options

  alias PrimerLive.Options.Box.{Classes}

  @moduledoc """
  Options for component `PrimerLive.Components.box/1`.

  | **Name** | **Type** | **Validation** | **Default**  | **Description** |
  | `inner_block` | `slot` | required | - | Box content, for example `PrimerLive.Options.BoxRow`. |
  | `class`   | `string` | - | - | Additional classname. |
  | `classes` | `map` | - | - | Map of classnames. Any provided value will be appended to the default classnames. See `PrimerLive.Options.Box.Classes`. |
  | `header`   | `slot` | - | - | Header element. |
  | `body`   | `slot` | - | - | Body element. |
  | `footer`   | `slot` | - | - | Footer element. |
  | `title`   | `slot` | - | - | Title element. |
  | `alert`   | `slot` | - | - | Alert element. This will be placed between the header and the body (if any). |
  | `is_blue`   | `boolean` | - | false | Creates a blue box theme. |
  | `is_blue_header`   | `boolean` | - | false | Changes the header border and background to blue. |
  | `is_danger`   | `boolean` | - | false | Creates a danger color box theme. |
  | `is_border_dashed`   | `boolean` | - | false | Applies a dashed border to the box. |
  | `is_condensed`   | `boolean` | - | false | Condenses line-height and reduces the padding on the Y axis. |
  | `is_spacious`   | `boolean` | - | false | Increases padding and increases the title font size. |
  """
  typed_embedded_schema do
    # Slots
    field(:inner_block, :any, virtual: true)
    # Optional options
    field(:alert, :any, virtual: true)
    field(:body, :any, virtual: true)
    field(:class, :string)
    field(:footer, :any, virtual: true)
    field(:header, :any, virtual: true)
    field(:is_blue_header, :boolean, default: false)
    field(:is_blue, :boolean, default: false)
    field(:is_border_dashed, :boolean, default: false)
    field(:is_condensed, :boolean, default: false)
    field(:is_danger, :boolean, default: false)
    field(:is_spacious, :boolean, default: false)
    field(:title, :any, virtual: true)
    # Embedded options
    embeds_one(:classes, Classes)
  end

  @impl Options
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [
      :alert,
      :body,
      :class,
      :footer,
      :header,
      :inner_block,
      :is_blue_header,
      :is_blue,
      :is_border_dashed,
      :is_condensed,
      :is_danger,
      :is_spacious,
      :title
    ])
    |> cast_embed_with_defaults(attrs, :classes, %{})
    |> validate_required(:inner_block)
  end
end
