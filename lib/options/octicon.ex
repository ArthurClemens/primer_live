defmodule PrimerLive.Options.Octicon do
  use Options

  @moduledoc """
  Options for component `PrimerLive.Components.octicon/1`.

  | **Name** | **Type** | **Validation** | **Default** | **Description**                                                                         |
  | -------- | -------- | -------------- | ----------- | --------------------------------------------------------------------------------------- |
  | `name`   | `string` | required       | -           | Icon name, e.g. "arrow-left-24". See [available icons](https://primer.style/octicons/). |
  | `class`  | `string` | -              | -           | Additional classname.                                                                   |
  """

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
