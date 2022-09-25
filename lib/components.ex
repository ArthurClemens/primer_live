defmodule PrimerLive.Components do
  use Phoenix.Component
  use Phoenix.HTML

  alias PrimerLive.Helpers.{SchemaHelpers, AttributeHelpers}
  alias PrimerLive.Options

  # ------------------------------------------------------------------------------------
  # dropdown
  # ------------------------------------------------------------------------------------

  @doc section: :menus

  @doc ~S"""
  Dropdown menu.

  [Examples](#dropdown/1-examples) • [AttributeHelpers](#dropdown/1-attributes) • [Reference](#dropdown/1-reference)

  Dropdowns are small context menus that can be used for navigation and actions. They are a simple alternative to select menus.

  A dropdown is composed with with `dropdown_item/1` elements.

  ```
  <.dropdown>
    dropdown_item elements
  </.dropdown>
  ```

  Full dropdown menu:

  ```
  <.dropdown>
    <.dropdown_item toggle>Menu</.dropdown_item>
    <.dropdown_item menu header_title="Header" position="e">
      <.dropdown_item option href="#url">Dropdown item 1</.dropdown_item>
      <.dropdown_item option href="#url">Dropdown item 2</.dropdown_item>
      <.dropdown_item divider />
      <.dropdown_item option href="#url">Dropdown item 3</.dropdown_item>
    </.dropdown_item>
  </.dropdown>
  ```

  See `dropdown_item/1` for more examples for dropdown elements.

  ## Examples

  _dropdown examples_

  Pass attribute `open` to show the menu initially open:

  ```
  <.dropdown open>
    ...
  </.dropdown>
  ```

  Open the menu from the outside:

  ```
  <.button phx-click={Phoenix.LiveView.JS.set_attribute({"open", "true"}, to: "#my-dropdown")}>
    Open menu
  </.button>

  <.dropdown id="my-dropdown"
    ...
  </.dropdown>
  ```

  ## AttributeHelpers

  _dropdown options_

  | **Name**      | **Type** | **Validation** | **Default** | **Description**                                    |
  | ------------- | -------- | -------------- | ----------- | -------------------------------------------------- |
  | `inner_block` | `slot`   | required       | -           | Dropdown content with `dropdown_item/1` elements . |
  | `class`       | `string` | -              | -           | Additional classname.                              |

  Additional HTML attributes are passed to the dropdown element.

  ## Reference

  [Primer/CSS Dropdown](https://primer.style/css/components/dropdown)

  """
  def dropdown(assigns) do
    with {:ok, assigns} <-
           SchemaHelpers.validate_options(assigns, Options.Dropdown, "dropdown") do
      render_dropdown(assigns)
    else
      message -> message
    end
  end

  defp render_dropdown(assigns) do
    class =
      AttributeHelpers.classnames([
        "dropdown",
        "details-reset",
        "details-overlay",
        "d-inline-block",
        assigns.class
      ])

    item_opts =
      AttributeHelpers.append_attributes(assigns.extra, [
        [class: class]
      ])

    ~H"""
    <details {item_opts}>
      <%= render_slot(@inner_block) %>
    </details>
    """
  end

  # ------------------------------------------------------------------------------------
  # dropdown_item
  # ------------------------------------------------------------------------------------

  @doc section: :menus

  @doc ~S'''
  Variable content element for `dropdown/1`.

  [Examples](#dropdown_item/1-examples) • [AttributeHelpers](#dropdown_item/1-attributes) • [Reference](#dropdown_item/1-reference)

  Dropdown elements are created with boolean options:

  ```
  <.dropdown_item toggle> ... </.dropdown_item>
  <.dropdown_item menu> ... </.dropdown_item>
  <.dropdown_item option> ... </.dropdown_item>
  <.dropdown_item divider> ... </.dropdown_item>
  ```

  ## Examples

  _dropdown_item examples_



  Place `option` elements inside `menu`:

  ```
  <.dropdown_item menu>
    <.dropdown_item option href="#url">Dropdown item 1</.dropdown_item>
    <.dropdown_item option href="#url">Dropdown item 2</.dropdown_item>
  </.dropdown_item>
  ```

  Create a divider:

  ```
  <.dropdown_item option href="#url">Dropdown item 1</.dropdown_item>
  <.dropdown_item option href="#url">Dropdown item 2</.dropdown_item>
  <.dropdown_item divider />
  <.dropdown_item option href="#url">Dropdown item 3</.dropdown_item>
  ```

  Custom toggle class (overriding the default class "btn"):

  ```
  <.dropdown_item toggle class="color-fg-muted p-2 d-inline">
    Menu
  </.dropdown_item>
  ```

  Using an icon instead of a toggle label:

  ```
  <.dropdown_item toggle>
    <.octicon name="alert-16" />
  </.dropdown_item>
  ```

  Add a menu header (will be placed above the menu options):

  ```
  <.dropdown_item menu header_title="Header">
   ...
  </.dropdown_item>
  ```

  Position of the menu relative to the dropdown toggle. Possible values are: "se", "ne", "e", "sw", "s", "w".

  ```
  <.dropdown_item menu position="e">
    ...
  </.dropdown_item>
  ```

  Pass a custom caret:

  ```
  <.dropdown_item toggle render_caret={&render_caret/1}>
    Menu
  </.dropdown_item>

  ...

  defp render_caret(assigns) do
    ~H"""
    <div class="my-dropdown-caret"></div>
    """
  end
  ```

  ## AttributeHelpers

  _dropdown_item options_

  | **Name**       | **Type**   | **Validation**            | **Default** | **Description**                                                                                         |
  | -------------- | ---------- | ------------------------- | ----------- | ------------------------------------------------------------------------------------------------------- |
  | `inner_block`  | `slot`     | required unless `divider` | -           | Dropdown menu item content. Ignored when using `is_divider`.                                            |
  | `toggle`       | `boolean`  | -                         | false       | Creates a toggle element (default with button appearance) using the inner_block as label.               |
  | `menu`         | `boolean`  | -                         | false       | Creates a menu element                                                                                  |
  | `option`       | `boolean`  | -                         | false       | Createa an option element.                                                                              |
  | `divider`      | `boolean`  | -                         | false       | Creates a divider element.                                                                              |
  | `header_title` | `string`   | -                         | -           | With `menu`. Creates a menu header with specified title.                                                |
  | `position`     | `string`   | -                         | "se"        | Position of the menu relative to the dropdown toggle. Possible values: "se", "ne", "e", "sw", "s", "w". |
  | `render_caret` | `function` | -                         | -           | Template render function that returns a custom template for the caret.                                  |
  | `class`        | `string`   | -                         | -           | Additional classname.                                                                                   |


  ## Reference

  [Primer/CSS Dropdown](https://primer.style/css/components/dropdown)

  '''

  def dropdown_item(assigns) do
    with {:ok, assigns} <-
           SchemaHelpers.validate_options(assigns, Options.DropdownItem, "dropdown_item") do
      render_dropdown_item(assigns)
    else
      message -> message
    end
  end

  defp render_dropdown_item(assigns) do
    classes = %{
      toggle:
        AttributeHelpers.classnames([
          # If a custom class is set, remove the default btn class
          if assigns.class do
            assigns.class
          else
            "btn"
          end
        ]),
      caret: "dropdown-caret",
      menu:
        AttributeHelpers.classnames([
          "dropdown-menu",
          "dropdown-menu-" <> assigns.position
        ]),
      option: "dropdown-item",
      divider: "dropdown-divider",
      header: "dropdown-header"
    }

    class =
      AttributeHelpers.classnames([
        cond do
          assigns.toggle -> classes.toggle
          assigns.menu -> classes.menu
          assigns.divider -> classes.divider
          assigns.option -> classes.option
          assigns.header_title -> classes.menu
          # ^ header class is used inside the menu div
          true -> nil
        end,
        assigns.class
      ])

    item_opts =
      AttributeHelpers.append_attributes(assigns.extra, [
        [class: class],
        assigns.toggle and [aria_haspopup: "true"],
        assigns.divider and [role: "separator"]
      ])

    ~H"""
    <%= if @toggle do %>
      <summary {item_opts}>
        <%= render_slot(@inner_block) %>
        <%= if @render_caret do %>
          <%= @render_caret.(assigns) %>
        <% else %>
          <div class={classes.caret}></div>
        <% end %>
      </summary>
    <% end %>
    <%= if @header_title do %>
      <div {item_opts}>
        <div class={classes.header}>
          <%= @header_title %>
        </div>
        <ul>
          <%= render_slot(@inner_block) %>
        </ul>
      </div>
    <% else %>
      <%= if @menu do %>
        <ul {item_opts}>
          <%= render_slot(@inner_block) %>
        </ul>
      <% end %>
    <% end %>
    <%= if @option do %>
      <li {item_opts}>
        <%= render_slot(@inner_block) %>
      </li>
    <% end %>
    <%= if @divider do %>
      <li {item_opts} />
    <% end %>
    """
  end
end
