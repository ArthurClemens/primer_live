defmodule PrimerLive.Options.ButtonGroup do
  use Options

  @moduledoc false

  typed_embedded_schema do
    # Slots
    field(:inner_block, :any, virtual: true, enforce: true, null: false)
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
