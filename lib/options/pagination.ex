defmodule PrimerLive.Options.Pagination.Classes do
  use Options

  @moduledoc false

  typed_embedded_schema do
    field(:gap, :string)
    field(:pagination_container, :string)
    field(:pagination, :string)
    field(:previous_page, :string)
    field(:next_page, :string)
    field(:page, :string)
  end

  @impl Options
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [:pagination_container, :pagination, :previous_page, :next_page, :page, :gap])
  end
end

defmodule PrimerLive.Options.Pagination.Labels do
  @moduledoc false

  use Options

  typed_embedded_schema do
    field(:aria_label_container, :string, default: "Navigation")
    field(:aria_label_next_page, :string, default: "Next page")
    field(:aria_label_page, :string, default: "Page {page_number}")
    field(:aria_label_previous_page, :string, default: "Previous page")
    field(:gap, :string, default: "…")
    field(:next_page, :string, default: "Next")
    field(:previous_page, :string, default: "Previous")
  end

  @impl Options
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [
      :aria_label_container,
      :aria_label_next_page,
      :aria_label_page,
      :aria_label_previous_page,
      :gap,
      :next_page,
      :previous_page
    ])
  end
end

defmodule PrimerLive.Options.Pagination.LinkOptions do
  @moduledoc false

  use Options

  typed_embedded_schema do
    field(:replace, :boolean, default: false)
  end

  @impl Options
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [:pagination_container, :pagination, :prev_next_link, :gap])
  end
end

defmodule PrimerLive.Options.Pagination do
  use Options

  alias PrimerLive.Options.Pagination.{Classes, Labels, LinkOptions}

  @moduledoc false

  typed_embedded_schema do
    # Mandatory options
    field(:page_count, :integer, enforce: true)
    field(:current_page, :integer, enforce: true)
    field(:link_path, :any, virtual: true, enforce: true)
    # Optional options
    field(:boundary_count, :integer, default: 2)
    field(:sibling_count, :integer, default: 2)
    field(:is_numbered, :boolean, default: true)
    field(:class, :string)
    # Embedded options
    embeds_one(:classes, Classes)
    embeds_one(:labels, Labels)
    embeds_one(:link_options, LinkOptions)
  end

  @impl Options
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [
      :class,
      :current_page,
      :boundary_count,
      :is_numbered,
      :link_path,
      :page_count,
      :sibling_count
    ])
    |> cast_embed_with_defaults(attrs, :classes, %{})
    |> cast_embed_with_defaults(attrs, :link_options, %LinkOptions{})
    |> cast_embed_with_defaults(attrs, :labels, %Labels{})
    |> validate_required([
      :current_page,
      :link_path,
      :page_count
    ])
    |> validate_number(:page_count, greater_than_or_equal_to: 0)
    |> validate_number(:current_page, greater_than_or_equal_to: 1)
    |> validate_number(:boundary_count, greater_than_or_equal_to: 1)
    |> validate_number(:boundary_count, less_than_or_equal_to: 3)
    |> validate_number(:sibling_count, greater_than_or_equal_to: 1)
    |> validate_number(:sibling_count, less_than_or_equal_to: 5)
  end
end
