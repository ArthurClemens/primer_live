defmodule PrimerLive.Options.Button do
  use Options

  @moduledoc false

  typed_embedded_schema do
    # Slots
    field(:inner_block, :any, virtual: true, enforce: true, null: false)
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
