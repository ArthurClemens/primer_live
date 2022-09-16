defmodule PrimerLive.Options.DropdownItem do
  use Options

  alias PrimerLive.Helpers.SchemaHelpers

  @moduledoc false

  typed_embedded_schema do
    # Slots
    field(:inner_block, :any, virtual: true)
    field(:toggle, :boolean, default: false)
    field(:menu, :boolean, default: false)
    field(:option, :boolean, default: false)
    field(:divider, :boolean, default: false)
    # Other options
    field(:class, :string)
    field(:position, :string, default: "se")
    field(:header_title, :string)
    field(:render_caret, :any, virtual: true)
  end

  @impl Options
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [
      :class,
      :toggle,
      :option,
      :menu,
      :position,
      :header_title,
      :render_caret
    ])
    |> SchemaHelpers.cast_either(attrs, :inner_block, :divider)
    |> SchemaHelpers.validate_copresence(attrs, :position, :menu)
    |> SchemaHelpers.validate_copresence(attrs, :header_title, :menu)
    |> SchemaHelpers.validate_copresence(attrs, :render_caret, :toggle)
    |> SchemaHelpers.validate_one_of_present(attrs, [:toggle, :menu, :option, :divider])
    |> validate_inclusion(:position, ["se", "ne", "e", "sw", "s", "w"])
  end
end

defmodule PrimerLive.Options.Dropdown do
  use Options

  @moduledoc false

  typed_embedded_schema do
    # Slots
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
    |> validate_required([:inner_block])
  end
end
