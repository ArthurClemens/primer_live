defmodule PrimerLive.Options.Dropdown.Menu.Item do
  use Options

  @moduledoc """
  Options for component `PrimerLive.Components.dropdown_menu/1`.

  | **Name** | **Type** | **Validation** | **Default**  | **Description** |
  | `inner_block` | `slot` |  | - | Dropdown menu item content. Leave out when using `is_divider`. |
  | `class`   | `string` | - | - | Additional classname. |
  | `is_divider`   | `boolean` | - | false | Creates a divider. |
  """

  typed_embedded_schema do
    # Slots
    field(:inner_block, :any, virtual: true)
    # Other options
    field(:class, :string)
    field(:is_divider, :boolean, default: false)
  end

  @impl Options
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast_either_inner_block_or_divider(attrs, [:inner_block, :class, :is_divider])
  end

  defp cast_either_inner_block_or_divider(changeset, attrs, keys) do
    case not is_nil(attrs[:is_divider]) do
      true ->
        # With is_divider: remove inner_block (no content possible)
        changeset |> cast(attrs, keys |> List.delete(:inner_block))

      false ->
        # Without is_divider: inner_block is required
        changeset
        |> cast(attrs, keys)
        |> validate_required(:inner_block)
    end
  end
end

defmodule PrimerLive.Options.Dropdown.Menu.Classes do
  use Options

  @moduledoc """
  Options for `classes` in `PrimerLive.Options.Dropdown`.

  | **Classname** | **Description** |
  | `menu` | The menu class. |
  | `header` | Header class. |
  """

  typed_embedded_schema do
    field(:menu, :string)
    field(:header, :string)
  end

  @impl Options
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [:menu, :header])
  end
end

defmodule PrimerLive.Options.Dropdown.Menu do
  use Options

  @moduledoc """
  Options for `menu` in `PrimerLive.Options.Dropdown`.

  | **Name** | **Type** | **Validation** | **Default**  | **Description** |
  | `inner_block` | `slot` |  | - | Dropdown menu content. |
  | `header` | `slot` |  | - | Menu header content. |
  | `class`   | `string` | - | - | Additional classname. |
  | `classes`   | `string` | - | - | Map of classnames. Any provided value will be appended to the default classnames. See `PrimerLive.Options.Dropdown.Menu.Classes`. |
  | `position`   | `string` | - | "se" | Position of the menu relative to the dropdown button. Possible values: "se", "ne", "e", "sw", "s", "w". |
  """

  typed_embedded_schema do
    # Optional options
    field(:inner_block, :any, virtual: true)
    field(:header, :any, virtual: true)
    # Other options
    field(:class, :string)
    field(:position, :string, default: "se")
    # Embedded options
    embeds_one(:classes, PrimerLive.Options.Dropdown.Menu.Classes)
  end

  @impl Options
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [:inner_block, :class, :position, :header])
    |> cast_embed_with_defaults(attrs, :classes, %{})
    |> validate_required(:inner_block)
    |> validate_inclusion(:position, ["se", "ne", "e", "sw", "s", "w"])
  end
end

defmodule PrimerLive.Options.Dropdown.Classes do
  use Options

  @moduledoc """
  Options for `classes` in `PrimerLive.Options.Dropdown`.

  | **Classname** | **Description** |
  | `dropdown` | The dropdown element class. |
  | `button` | Button class. Any value will override the default class "btn". |
  | `caret` | Dropdown caret class. |
  """

  typed_embedded_schema do
    field(:dropdown, :string)
    field(:button, :string)
    field(:caret, :string)
  end

  @impl Options
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [:dropdown, :button, :menu, :caret])
  end
end

defmodule PrimerLive.Options.Dropdown do
  use Options

  alias PrimerLive.Options.Dropdown.{Classes}

  @moduledoc """
  Options for component `PrimerLive.Components.dropdown/1`.

  | **Name** | **Type** | **Validation** | **Default**  | **Description** |
  | `label*` | `slot` |  | - | Dropdown button label. May contain text or an icon. |
  | `inner_block` | `slot` |  | - | Dropdown menu content. |
  | `class`   | `string` | - | - | Additional classname. |
  | `classes` | `map` |  | - | Map of classnames. Any provided value will be appended to the default classnames. See `PrimerLive.Options.Dropdown.Classes`. |

  """
  typed_embedded_schema do
    # Slots
    field(:inner_block, :any, virtual: true)
    field(:label, :any, virtual: true)
    # Optional options
    field(:class, :string)
    # Embedded options
    embeds_one(:classes, Classes)
  end

  @impl Options
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [
      :inner_block,
      :class,
      :label
    ])
    |> cast_embed_with_defaults(attrs, :classes, %{})
    |> validate_required([:label, :inner_block])
  end
end
