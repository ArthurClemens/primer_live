defmodule PrimerLive.Options.Octicon do
  use Options

  @moduledoc false

  typed_embedded_schema do
    # Mandatory options
    field(:name, :string, enforce: true)
    # Optional options
    field(:class, :string)
  end

  @impl Options
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [
      :name,
      :class
    ])
    |> validate_required([
      :name
    ])
  end
end
