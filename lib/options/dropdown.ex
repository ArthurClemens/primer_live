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
    field(:header_label, :string)
    field(:caret, :any, virtual: true)
  end

  @impl Options
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [:class, :toggle, :option, :divider, :menu, :position, :header_label, :caret])
    |> cast_either_inner_block_or_divider(attrs, [:inner_block, :divider])
    |> SchemaHelpers.validate_require_true_values(attrs, :position, :menu)
    |> SchemaHelpers.validate_require_true_values(attrs, :header_label, :menu)
    |> SchemaHelpers.validate_require_true_values(attrs, :caret, :toggle)
    |> validate_either(attrs, [:toggle, :menu, :option, :divider])
    |> validate_inclusion(:position, ["se", "ne", "e", "sw", "s", "w"])
  end

  defp cast_either_inner_block_or_divider(changeset, attrs, keys) do
    case not is_nil(attrs[:divider]) do
      true ->
        # With is_divider: remove inner_block (no content possible)
        changeset |> cast(attrs, keys |> List.delete(:inner_block))

      false ->
        # Without divider: inner_block is required
        changeset
        |> cast(attrs, keys)
        |> validate_required(:inner_block)
    end
  end

  defp validate_either(changeset, attrs, keys) do
    attr_keys = Map.keys(attrs)

    in_list_count =
      keys
      |> Enum.reduce(0, fn key, acc ->
        case Enum.member?(attr_keys, key) do
          true -> acc + 1
          false -> acc
        end
      end)

    case in_list_count == 0 do
      true ->
        add_error(
          changeset,
          :dropdown_item,
          "must contain one attribute from these options: #{keys |> Enum.join(", ")}"
        )

      false ->
        changeset
    end
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
