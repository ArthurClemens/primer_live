defmodule PrimerLive.Options.LayoutItem do
  use Options

  import Ecto.Changeset

  alias PrimerLive.Helpers.SchemaHelpers

  @moduledoc false

  typed_embedded_schema do
    # Slots
    field(:inner_block, :any, virtual: true)
    field(:divider, :boolean, default: false)
    field(:main, :boolean, default: false)
    field(:sidebar, :boolean, default: false)
    # Optional options
    field(:class, :string)
    field(:is_centered_lg, :boolean, default: false)
    field(:is_centered_md, :boolean, default: false)
    field(:is_centered_xl, :boolean, default: false)
    field(:is_flow_row_hidden, :boolean, default: false)
    field(:is_flow_row_shallow, :boolean, default: false)
  end

  @impl Options
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [
      :class,
      :divider,
      :inner_block,
      :is_centered_lg,
      :is_centered_md,
      :is_centered_xl,
      :is_flow_row_hidden,
      :is_flow_row_shallow,
      :main,
      :sidebar
    ])
    |> validate_require_inner_block_unless_divider(attrs)
    |> SchemaHelpers.validate_require_true_values(attrs, :is_centered_lg, :main)
    |> SchemaHelpers.validate_require_true_values(attrs, :is_centered_md, :main)
    |> SchemaHelpers.validate_require_true_values(attrs, :is_centered_xl, :main)
    |> SchemaHelpers.validate_require_true_values(attrs, :is_flow_row_hidden, :divider)
    |> SchemaHelpers.validate_require_true_values(attrs, :is_flow_row_shallow, :divider)
  end

  defp validate_require_inner_block_unless_divider(changeset, attrs) do
    changeset
    |> SchemaHelpers.validate_cond(
      attrs,
      :inner_block,
      fn value ->
        cond do
          is_nil(value) -> !is_nil(attrs[:divider])
          true -> true
        end
      end,
      "can't be empty"
    )
  end
end

defmodule PrimerLive.Options.Layout do
  use Options

  @moduledoc false

  typed_embedded_schema do
    # Slots
    field(:inner_block, :any, virtual: true, enforce: true, null: false)
    # Optional options
    field(:class, :string)
    field(:is_divided, :boolean, default: false)
    field(:is_narrow_sidebar, :boolean, default: false)
    field(:is_wide_sidebar, :boolean, default: false)
    field(:is_gutter_none, :boolean, default: false)
    field(:is_gutter_condensed, :boolean, default: false)
    field(:is_gutter_spacious, :boolean, default: false)
    field(:is_sidebar_position_start, :boolean, default: false)
    field(:is_sidebar_position_end, :boolean, default: false)
    field(:is_sidebar_position_flow_row_start, :boolean, default: false)
    field(:is_sidebar_position_flow_row_end, :boolean, default: false)
    field(:is_sidebar_position_flow_row_none, :boolean, default: false)
    field(:is_flow_row_until_md, :boolean, default: false)
    field(:is_flow_row_until_lg, :boolean, default: false)
  end

  @impl Options
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [
      :class,
      :inner_block,
      :is_divided,
      :is_flow_row_until_lg,
      :is_flow_row_until_md,
      :is_gutter_condensed,
      :is_gutter_none,
      :is_gutter_spacious,
      :is_narrow_sidebar,
      :is_sidebar_position_end,
      :is_sidebar_position_flow_row_end,
      :is_sidebar_position_flow_row_none,
      :is_sidebar_position_flow_row_start,
      :is_sidebar_position_start,
      :is_wide_sidebar
    ])
    |> validate_required(:inner_block)
  end
end
