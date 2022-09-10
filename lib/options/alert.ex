defmodule PrimerLive.Options.Alert do
  use Options

  @moduledoc false

  typed_embedded_schema do
    # Slots
    field(:inner_block, :any, virtual: true, enforce: true, null: false)
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
