defmodule PrimerLive.Options.Button do
  use Options

  @moduledoc """
  Options for component `PrimerLive.Components.button/1`.

  | **Name** | **Type** | **Validation** | **Default**  | **Description** |
  | `inner_block*` | `slot` |  | - | Button content. |
  | `type`   | `string` | "button" or "submit" | "button" | Button type. |
  | `class`   | `string` | - | - | Additional classname. |
  | `is_block` | `boolean` | - | false | Creates a full-width button. Equivalent to adding "btn-block" class. |
  | `is_close_button` | `boolean` | - | false | Use when enclosing icon "x-16". This setting removes the default padding. Equivalent to using class "close-button" instead of "btn". |
  | `is_danger` | `boolean` | - | false | Creates a red button. Equivalent to adding "btn-danger" class. |
  | `is_disabled` | `boolean` | - | false | Adds attribute `aria-disabled="true"`. |
  | `is_icon_only` | `boolean` | - | false | Creates an icon button without a label. Add `is_danger` to create a danger icon. Equivalent to using class "btn-octicon" instead of "btn". |
  | `is_invisible` | `boolean` | - | false | Create a button that looks like a link, maintaining the paddings of a regular button. Equivalent to adding "btn-invisible" class. |
  | `is_large` | `boolean` | - | false | Creates a large button. Equivalent to adding "btn-large" class. |
  | `is_link` | `boolean` | - | false | Create a button that looks like a link. Equivalent to adding "btn-link" class (and removing "btn" class). |
  | `is_outline` | `boolean` | - | false | Creates a large button. Equivalent to adding "btn-outline" class. |
  | `is_primary` | `boolean` | - | false | Creates a primary colored button. Equivalent to adding "btn-primary" class. |
  | `is_selected` | `boolean` | - | false | Adds attribute `aria-selected="true"`. |
  | `is_small` | `boolean` | - | false | Creates a small button. Equivalent to adding "btn-sm" class. |

  """
  typed_embedded_schema do
    field(:inner_block, :any, virtual: true)
    # Optional options
    field(:class, :string)
    field(:is_block, :boolean, default: false)
    field(:is_close_button, :boolean, default: false)
    field(:is_danger, :boolean, default: false)
    field(:is_disabled, :boolean, default: false)
    field(:is_invisible, :boolean, default: false)
    field(:is_icon_only, :boolean, default: false)
    field(:is_large, :boolean, default: false)
    field(:is_link, :boolean, default: false)
    field(:is_outline, :boolean, default: false)
    field(:is_primary, :boolean, default: false)
    field(:is_selected, :boolean, default: false)
    field(:is_small, :boolean, default: false)
    field(:type, :string, default: "button")
  end

  @impl Options
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [
      :class,
      :inner_block,
      :is_block,
      :is_close_button,
      :is_danger,
      :is_disabled,
      :is_icon_only,
      :is_invisible,
      :is_large,
      :is_link,
      :is_outline,
      :is_primary,
      :is_selected,
      :is_small,
      :type
    ])
    |> validate_required(:inner_block)
    |> validate_inclusion(:type, [
      "button",
      "submit"
    ])
  end
end
