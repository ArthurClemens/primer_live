defmodule PrimerLive.Options.Layout.Classes do
  use Options

  @moduledoc """
  Options for `classes` in `PrimerLive.Options.Layout`.

  | **Classname**         | **Description**                         |
  | --------------------- | --------------------------------------- |
  | `layout`              | The layout container element.           |
  | `main`                | The main element.                       |
  | `divider`             | The divider element.                    |
  | `sidebar`             | The sidebar element.                    |
  | `main_center_wrapper` | The wrapper to created a centered main. |
  """

  typed_embedded_schema do
    field(:layout, :string)
    field(:main, :string)
    field(:divider, :string)
    field(:sidebar, :string)
    field(:main_center_wrapper, :string)
  end

  @impl Options
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [:layout, :main, :divider, :sidebar, :main_center_wrapper])
  end
end

defmodule PrimerLive.Options.Layout do
  use Options

  alias PrimerLive.Options.Layout.Classes

  @moduledoc """
  Options for component `PrimerLive.Components.layout/1`.

  | **Name**                             | **Type**  | **Validation** | **Default** | **Description**                                                                                                                                                                                                                       |
  | ------------------------------------ | --------- | -------------- | ----------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
  | `item name="main"`                   | `slot`    | -              | -           | Main element. Default gutter sizes: md: 16px, lg: 24px (change with `is_gutter_none`, `is_gutter_condensed` and `is_gutter_spacious`). Stacks when container is `sm` (change with `is_flow_row_until_md` and `is_flow_row_until_lg`). |
  | `item name="divider"`                | `slot`    | -              | -           | Divider element. The divider will only be shown with option `is_divided`. Creates a line between the main and sidebar elements - horizontal when the elements are stacked and vertical when they are shown side by side.              |
  | `item name="sidebar"`                | `slot`    | -              | -           | Sidebar element. Widths: md: 256px, lg: 296px (change with `is_narrow_sidebar` and `is_wide_sidebar`).                                                                                                                                |
  | `class`                              | `string`  | -              | -           | Additional classname for the main component. For more control, use `classes`.                                                                                                                                                         |
  | `classes`                            | `map`     | -              | -           | Map of classnames. Any provided value will be appended to the default classnames. See `PrimerLive.Options.Layout.Classes`.                                                                                                            |
  | `is_divided`                         | `boolean` | -              | false       | Use `is_divided` in conjunction with the `item name="divider"` slot to show a divider between the main content and the sidebar. Creates a 1px line between main and sidebar.                                                          |
  | `is_narrow_sidebar`                  | `boolean` | -              | false       | Smaller sidebar size. Widths: md: 240px, lg: 256px.                                                                                                                                                                                   |
  | `is_wide_sidebar`                    | `boolean` | -              | false       | Wider sidebar size. Widths: md: 296px, lg: 320px, xl: 344px.                                                                                                                                                                          |
  | `is_divider_flow_row_shallow`        | `boolean` | -              | false       | With slot `item name="divider"` and small screen (up to 544px). Creates a filled 8px horizontal divider.                                                                                                                              |
  | `is_divider_flow_row_hidden`         | `boolean` | -              | false       | With slot `item name="divider"` and small screen (up to 544px). Hides the horizontal divider.                                                                                                                                         |
  | `is_main_centered_md`                | `boolean` | -              | false       | Creates a wrapper around `main` to keep its content centered up to max width "md".                                                                                                                                                    |
  | `is_main_centered_lg`                | `boolean` | -              | false       | Creates a wrapper around `main` to keep its content centered up to max width "lg".                                                                                                                                                    |
  | `is_main_centered_xl`                | `boolean` | -              | false       | Creates a wrapper around `main` to keep its content centered up to max width "xl".                                                                                                                                                    |
  | `is_gutter_none`                     | `boolean` | -              | false       | Changes the gutter size to 0px.                                                                                                                                                                                                       |
  | `is_gutter_condensed`                | `boolean` | -              | false       | Changes the gutter size to 16px.                                                                                                                                                                                                      |
  | `is_gutter_spacious`                 | `boolean` | -              | false       | Changes the gutter sizes to: md: 16px, lg: 32px, xl: 40px.                                                                                                                                                                            |
  | `is_sidebar_position_start`          | `boolean` | -              | false       | Places the sidebar at the start (commonly at the left) (default).                                                                                                                                                                     |
  | `is_sidebar_position_end`            | `boolean` | -              | false       | Places the sidebar at the end (commonly at the right).                                                                                                                                                                                |
  | `is_sidebar_position_flow_row_start` | `boolean` | -              | false       | When stacked, render the sidebar first (default).                                                                                                                                                                                     |
  | `is_sidebar_position_flow_row_end`   | `boolean` | -              | false       | When stacked, render the sidebar last.                                                                                                                                                                                                |
  | `is_sidebar_position_flow_row_none`  | `boolean` | -              | false       | When stacked, hide the sidebar.                                                                                                                                                                                                       |
  | `is_flow_row_until_md`               | `boolean` | -              | false       | Stacks when container is md.                                                                                                                                                                                                          |
  | `is_flow_row_until_lg`               | `boolean` | -              | false       | Stacks when container is lg.                                                                                                                                                                                                          |
  """
  typed_embedded_schema do
    # Slots
    field(:item, :any, virtual: true)
    # Optional options
    field(:class, :string)
    field(:is_divided, :boolean, default: false)
    field(:is_narrow_sidebar, :boolean, default: false)
    field(:is_wide_sidebar, :boolean, default: false)
    field(:is_divider_flow_row_shallow, :boolean, default: false)
    field(:is_divider_flow_row_hidden, :boolean, default: false)
    field(:is_main_centered_lg, :boolean, default: false)
    field(:is_main_centered_md, :boolean, default: false)
    field(:is_main_centered_xl, :boolean, default: false)
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
    # Embedded options
    embeds_one(:classes, Classes)
  end

  @impl Options
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [
      :class,
      :is_divided,
      :is_divider_flow_row_hidden,
      :is_divider_flow_row_shallow,
      :is_flow_row_until_lg,
      :is_flow_row_until_md,
      :is_gutter_condensed,
      :is_gutter_none,
      :is_gutter_spacious,
      :is_main_centered_lg,
      :is_main_centered_md,
      :is_main_centered_xl,
      :is_narrow_sidebar,
      :is_sidebar_position_end,
      :is_sidebar_position_flow_row_end,
      :is_sidebar_position_flow_row_none,
      :is_sidebar_position_flow_row_start,
      :is_sidebar_position_start,
      :is_wide_sidebar,
      :item
    ])
    |> cast_embed_with_defaults(attrs, :classes, %{})
  end
end
