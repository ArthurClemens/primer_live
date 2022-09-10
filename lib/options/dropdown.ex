defmodule PrimerLive.Options.DropdownItem do
  use Options

  @moduledoc false

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
    |> cast(attrs, [:class])
    |> cast_either_inner_block_or_divider(attrs, [:inner_block, :is_divider])
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

defmodule PrimerLive.Options.Dropdown.Classes do
  use Options

  @moduledoc false

  typed_embedded_schema do
    field(:toggle, :string)
    field(:caret, :string)
    field(:dropdown, :string)
    field(:header, :string)
    field(:menu, :string)
  end

  @impl Options
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [:toggle, :caret, :dropdown, :header, :menu])
  end
end

defmodule PrimerLive.Options.Dropdown do
  use Options

  alias PrimerLive.Options.Dropdown.Classes

  @moduledoc false

  typed_embedded_schema do
    # Slots
    field(:label, :any, virtual: true)
    field(:header, :any, virtual: true)
    field(:menu, :any, virtual: true)
    # Optional options
    field(:class, :string)
    field(:position, :string, default: "se")
    # Embedded options
    embeds_one(:classes, Classes)
  end

  @impl Options
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [
      :menu,
      :header,
      :class,
      :label,
      :position
    ])
    |> cast_embed_with_defaults(attrs, :classes, %{})
    |> validate_required([:menu, :label])
    |> validate_inclusion(:position, ["se", "ne", "e", "sw", "s", "w"])
  end
end
