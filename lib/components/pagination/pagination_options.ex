defmodule PrimerLive.Components.Pagination.Options.Classes do
  use ComponentSchema

  @moduledoc """
  Schema for `PrimerLive.Components.Pagination.Options`, option `classes`.

  | **Classname** | **Description** |
  | `pagination_container` | `nav` element that contains `navigation`. |
  | `pagination` | The main control. |
  | `previous_page` | Previous page link (enabled or disabled). |
  | `next_page` | Next page link (enabled or disabled). |
  | `page` | Page number link (not the seleced page). |
  | `gap` | Gap element. |
  """

  typed_embedded_schema do
    field(:gap, :string)
    field(:pagination_container, :string)
    field(:pagination, :string)
    field(:previous_page, :string)
    field(:next_page, :string)
    field(:page, :string)
  end

  @impl ComponentSchema
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [:pagination_container, :pagination, :previous_page, :next_page, :page, :gap])
  end
end

defmodule PrimerLive.Components.Pagination.Options.Labels do
  @moduledoc """
  Schema for Pagination options, option `labels`.

  | **Label** | **Default** |
  | `aria_label_container` | Navigation |
  | `aria_label_next_page` | Next page |
  | `aria_label_page` | Page {page_number} |
  | `aria_label_previous_page` | Previous page |
  | `gap` | … |
  | `next_page` | Next |
  | `previous_page` | Previous |
  """

  use ComponentSchema

  typed_embedded_schema do
    field(:aria_label_container, :string, default: "Navigation")
    field(:aria_label_next_page, :string, default: "Next page")
    field(:aria_label_page, :string, default: "Page {page_number}")
    field(:aria_label_previous_page, :string, default: "Previous page")
    field(:gap, :string, default: "…")
    field(:next_page, :string, default: "Next")
    field(:previous_page, :string, default: "Previous")
  end

  @impl ComponentSchema
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

defmodule PrimerLive.Components.Pagination.Options.LinkOptions do
  @moduledoc """
  Schema for `PrimerLive.Components.Pagination.Options`, option `link_options`.


  | **Name**    | **Type**  | **Validation** | **Default**  | **Description** |
  | `replace`   | `boolean` |  | false | Result page count. |
  """

  use ComponentSchema

  typed_embedded_schema do
    field(:replace, :boolean, default: false)
  end

  @impl ComponentSchema
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [:pagination_container, :pagination, :prev_next_link, :gap])
  end
end

defmodule PrimerLive.Components.Pagination.Options do
  use ComponentSchema

  alias PrimerLive.Components.Pagination.Options.{Classes, Labels, LinkOptions}

  @moduledoc """
  Schema for `PrimerLive.Components.Pagination.pagination/1` options.

  | **Name**          | **Type** | **Validation** | **Default**  | **Description** |
  | `page_count*`   | `integer` | `>= 0` | - | Result page count. |
  | `current_page*` | `integer` | `>= 1` | - | Current page. |
  | `link_path*`    | `(page_number) -> path` | `>= 1` | - | Function that returns a path for the given page number. The link builder uses `live_redirect`. Extra options can be passed with `link_options`. |
  | `far_end_page_link_count` | `integer` | `1..3` | `2` | Number of page links at both ends. |
  | `surrounding_page_link_count` | `integer` | `1..5` | `2` | How many page links to show on each side of the current page. |
  | `is_numbered` | `boolean` |  | `true` | Showing page numbers. |
  | `class` | `string` |  | - | Additional classname for the main component. For more control, use `classes`. |
  | `classes` | `map` |  | - | Map of classnames. Any provided value will be appended to the default classnames. See `PrimerLive.Components.Pagination.Options.Classes`. |
  | `labels` | `map` |  | - | Map of textual labels. See `PrimerLive.Components.Pagination.Options.Labels`. |
  | `link_options` | `map` |  | - | Map of link options. See `PrimerLive.Components.Pagination.Options.LinkOptions`. |

  """

  typed_embedded_schema do
    # Mandatory options
    field(:page_count, :integer, enforce: true)
    field(:current_page, :integer, enforce: true)
    field(:link_path, :any, virtual: true, enforce: true)
    # Optional options
    field(:far_end_page_link_count, :integer, default: 2)
    field(:surrounding_page_link_count, :integer, default: 2)
    field(:is_numbered, :boolean, default: true)
    field(:class, :string)
    # Embedded options
    embeds_one(:classes, Classes)
    embeds_one(:labels, Labels)
    embeds_one(:link_options, LinkOptions)
  end

  @impl ComponentSchema
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [
      :class,
      :current_page,
      :far_end_page_link_count,
      :is_numbered,
      :link_path,
      :page_count,
      :surrounding_page_link_count
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
    |> validate_number(:far_end_page_link_count, greater_than_or_equal_to: 1)
    |> validate_number(:far_end_page_link_count, less_than_or_equal_to: 3)
    |> validate_number(:surrounding_page_link_count, greater_than_or_equal_to: 1)
    |> validate_number(:surrounding_page_link_count, less_than_or_equal_to: 5)
  end
end
