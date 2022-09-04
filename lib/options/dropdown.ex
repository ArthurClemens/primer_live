defmodule PrimerLive.Options.DropdownItem do
  use Options

  @moduledoc """
  Options for component `PrimerLive.Components.dropdown_item/1`.

  | **Name**      | **Type**  | **Validation**               | **Default** | **Description**                                                |
  | ------------- | --------- | ---------------------------- | ----------- | -------------------------------------------------------------- |
  | `inner_block` | `slot`    | required unless `is_divider` | -           | Dropdown menu item content. Ignored when using `is_divider`.   |
  | `class`       | `string`  | -                            | -           | Additional classname.                                          |
  | `is_divider`  | `boolean` | -                            | false       | Creates a divider.                                             |
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

defmodule PrimerLive.Options.Dropdown.Classes do
  use Options

  @moduledoc """
  Options for `classes` in `PrimerLive.Options.Dropdown`.

  | **Classname** | **Description**                                                  |
  | ------------- | ---------------------------------------------------------------- |
  | `button`      | Button element. Any value will override the default class "btn". |
  | `caret`       | Dropdown caret element.                                          |
  | `dropdown`    | Dropdown element.                                                |
  | `menu`        | Menu element.                                                    |
  | `header`      | Menu header element.                                             |
  """

  typed_embedded_schema do
    field(:button, :string)
    field(:caret, :string)
    field(:dropdown, :string)
    field(:header, :string)
    field(:menu, :string)
  end

  @impl Options
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [:button, :caret, :dropdown, :header, :menu])
  end
end

defmodule PrimerLive.Options.Dropdown do
  use Options

  alias PrimerLive.Options.Dropdown.Classes

  @moduledoc """
  Options for component `PrimerLive.Components.dropdown/1`.

  | **Name**   | **Type** | **Validation** | **Default** | **Description**                                                                                                              |
  | ---------- | -------- | -------------- | ----------- | ---------------------------------------------------------------------------------------------------------------------------- |
  | `menu`     | `slot`   | required       | -           | Dropdown menu content.                                                                                                       |
  | `label`    | `slot`   | required       | -           | Dropdown button label. May contain text or an icon.                                                                          |
  | `header`   | `slot`   | -              | -           | Menu header.                                                                                                                 |
  | `class`    | `string` | -              | -           | Additional classname.                                                                                                        |
  | `classes`  | `map`    | -              | -           | Map of classnames. Any provided value will be appended to the default classnames. See `PrimerLive.Options.Dropdown.Classes`. |
  | `position` | `string` | -              | "se"        | Position of the menu relative to the dropdown button. Possible values: "se", "ne", "e", "sw", "s", "w".                      |
  """
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
