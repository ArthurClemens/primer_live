defmodule PrimerLive.Options.Alert do
  use Options

  @moduledoc """
  Options for component `PrimerLive.Components.alert/1`.

  | **Name** | **Type** | **Validation** | **Default**  | **Description** |
  | `inner_block*` | `slot` |  | - | Alert content. |
  | `class`   | `string` | - | - | Additional classname. |
  | `is_error`   | `boolean` | - | false | Sets the color to "error". |
  | `is_success`   | `boolean` | - | false | Sets the color to "success". |
  | `is_warning`   | `boolean` | - | false | Sets the color to "warning". |
  | `is_full`   | `boolean` | - | false | Renders the alert full width, with border and border radius removed. |

  """
  typed_embedded_schema do
    field(:inner_block, :any, virtual: true)
    # Optional options
    field(:class, :string)
    field(:is_error, :boolean, default: false)
    field(:is_full, :boolean, default: false)
    field(:is_success, :boolean, default: false)
    field(:is_warning, :boolean, default: false)
  end

  @impl Options
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [
      :class,
      :inner_block,
      :is_error,
      :is_full,
      :is_success,
      :is_warning
    ])
    |> validate_required(:inner_block)
  end
end

defmodule PrimerLive.Options.AlertMessages do
  use Options

  @moduledoc """
  Options for component `PrimerLive.Components.alert_messages/1`.

  | **Name** | **Type** | **Validation** | **Default**  | **Description** |
  | `inner_block*` | `slot` |  | - | Alert messages content. |
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
