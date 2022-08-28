defmodule PrimerLive.Options.ButtonGroup do
  use Options

  @moduledoc """
  Options for component `PrimerLive.Components.button_group/1`.

  | **Name** | **Type** | **Validation** | **Default**  | **Description** |
  | `inner_block*` | `element` |  | - | Button group child content. |
  | `class`   | `string` | - | - | Additional classname. |

  """
  typed_embedded_schema do
    field(:inner_block, :any, virtual: true)
    # Optional options
    field(:class, :string)
  end

  @impl Options
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [
      :class,
      :inner_block
    ])
    |> validate_required(:inner_block)
  end
end

defmodule PrimerLive.Options.ButtonGroupItem do
  use Options

  @moduledoc """
  Options for component `PrimerLive.Components.button_group_item/1`.

  | **Name** | **Type** | **Validation** | **Default**  | **Description** |
  | `class`   | `string` | - | - | Additional classname. |

  """
  typed_embedded_schema do
    field(:inner_block, :any, virtual: true)
    # Optional options
    field(:class, :string)
  end

  @impl Options
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [
      :class,
      :inner_block
    ])
    |> validate_required(:inner_block)
  end
end
