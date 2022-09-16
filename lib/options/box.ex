defmodule PrimerLive.Options.BoxItem do
  use Options

  alias PrimerLive.Helpers.SchemaHelpers

  @moduledoc false

  typed_embedded_schema do
    # Slots
    field(:inner_block, :any, virtual: true, enforce: true, null: false)
    field(:body, :boolean, default: false)
    field(:footer, :boolean, default: false)
    field(:header, :boolean, default: false)
    field(:row, :boolean, default: false)
    field(:title, :boolean, default: false)
    # Optional options
    field(:class, :string)
    field(:is_blue, :boolean, default: false)
    field(:is_focus_blue, :boolean, default: false)
    field(:is_focus_gray, :boolean, default: false)
    field(:is_gray, :boolean, default: false)
    field(:is_hover_blue, :boolean, default: false)
    field(:is_hover_gray, :boolean, default: false)
    field(:is_link, :boolean, default: false)
    field(:is_navigation_focus, :boolean, default: false)
    field(:is_unread, :boolean, default: false)
    field(:is_yellow, :boolean, default: false)
  end

  @impl Options
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [
      :body,
      :class,
      :footer,
      :header,
      :inner_block,
      :is_blue,
      :is_focus_blue,
      :is_focus_gray,
      :is_gray,
      :is_hover_blue,
      :is_hover_gray,
      :is_link,
      :is_navigation_focus,
      :is_unread,
      :is_yellow,
      :row,
      :title
    ])
    |> validate_required([:inner_block])
    |> SchemaHelpers.validate_copresence(attrs, :is_link, :row)
  end
end

defmodule PrimerLive.Options.Box do
  use Options

  @moduledoc false

  typed_embedded_schema do
    # Slots
    field(:inner_block, :any, virtual: true, enforce: true, null: false)
    # Optional options
    field(:class, :string)
    field(:is_blue, :boolean, default: false)
    field(:is_border_dashed, :boolean, default: false)
    field(:is_condensed, :boolean, default: false)
    field(:is_danger, :boolean, default: false)
    field(:is_spacious, :boolean, default: false)
  end

  @impl Options
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [
      :class,
      :inner_block,
      :is_blue,
      :is_border_dashed,
      :is_condensed,
      :is_danger,
      :is_spacious
    ])
    |> validate_required(:inner_block)
  end
end
