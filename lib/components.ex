defmodule PrimerLive.Components do
  use Phoenix.Component
  use Phoenix.HTML

  alias PrimerLive.Helpers.{SchemaHelpers, Attributes, FormHelpers}
  alias PrimerLive.Options

  # ------------------------------------------------------------------------------------
  # text_input
  # ------------------------------------------------------------------------------------

  @doc section: :form

  @doc ~S"""
  Creates a text input field.

  Wrapper around `Phoenix.HTML.Form.text_input/3`, optionally wrapped inside a "form group".

  [Examples](#text_input/1-examples) • [Attributes](#text_input/1-attributes) • [Reference](#text_input/1-reference)

  ```
  <.text_input name="first_name" />
  ```

  ## Examples

  _text_input examples_

  Set the input type:

  ```
  <.text_input type="password" />
  ```

  Set the placeholder. By default, the value of the placeholder attribute is used to fill in the aria-label attribute:

  ```
  <.text_input placeholder="Enter your first name" />
  ```

  Insert the input within a form group using `form_group/1`. If no header text is added, the input label in the form group header is generated automatically:

  ```
  <.text_input form={:user} field={:first_name} form_group />
  ```

  Insert the input within a form group with a customized heading:

  ```
  <.text_input form={:user} field={:first_name} form_group={%{header: "Enter your first name"}} />
  ```

  Using the input with form data:

  ```
  <.form let={f} for={@changeset} phx-change="validate" phx-submit="save">
    <.text_input form={f} field={:first_name} form_group />
    <.text_input form={f} field={:last_name} form_group />
  </.form>
  ```

  With a form changeset, write a custom error message:

  ```
  <.text_input form={f} field={:first_name} form_group get_validation_message={
    fn changeset ->
      if !changeset.valid?, do: "Please enter your first name"
    end
  }/>
  ```

  With a form changeset, write a custom success message:

  ```
  <.text_input form={f} field={:first_name} form_group get_validation_message={
    fn changeset ->
      if changeset.valid?, do: "Complete"
    end
  }/>
  ```

  ## Attributes

  _text_input options_

  | **Name**                  | **Type**                      | **Validation**                                                                                                                            | **Default** | **Description**                                                                                                                                                   |
  | ------------------------- | ----------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------| ----------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- |
  | `field`                   | `atom` or `string`            | required for `form_group`                                                                                                                 | -           | Field name.                                                                                                                                                       |
  | `form`                    | `Phoenix.HTML.Form` or `atom` | required for `form_group`                                                                                                                 | -           | Either a [Phoenix.HTML.Form](https://hexdocs.pm/phoenix_html/Phoenix.HTML.Form.html) or an atom.                                                                  |
  | `form_group`              | `boolean` or `map`            | -                                                                                                                                         | -           | Options for `form_group/1`. Passing these options, or just passing `true`, will create a "form group" element that wraps the label, the input and any help texts. |
  | `class`                   | `string`                      | -                                                                                                                                         | -           | Additional classname.                                                                                                                                             |
  | `is_contrast`             | `boolean`                     | -                                                                                                                                         | false       | Changes the background color to light gray.                                                                                                                       |
  | `is_full_width`           | `boolean`                     | -                                                                                                                                         | false       | Full width input.                                                                                                                                                 |
  | `is_hide_webkit_autofill` | `boolean`                     | -                                                                                                                                         | false       | Hide WebKit's contact info autofill icon.                                                                                                                         |
  | `is_large`                | `boolean`                     | -                                                                                                                                         | false       | Larger text size.                                                                                                                                                 |
  | `is_small`                | `boolean`                     | -                                                                                                                                         | false       | Smaller input with smaller text size.                                                                                                                             |
  | `is_short`                | `boolean`                     | -                                                                                                                                         | false       | Within a form group. Creates an input with a reduced width.                                                                                                       |
  | `type`                    | `string`                      | "color", "date", "datetime-local", "email", "file", "hidden", "number", "password", "range", "search", "telephone", "text", "time", "url" | "text"      | Text input type.                                                                                                                                                  |
  | `get_validation_message`  | `fun changeset -> string`     | -                                                                                                                                         | -           | Function to write a custom error message. The function receives for form's changeset data (type `Ecto.Changeset`) and returns a string for error message.         |

  Additional HTML attributes are passed to the input element.

  ## Reference

  [Primer/CSS Forms](https://primer.style/css/components/forms)

  """

  def text_input(assigns) do
    with {:ok, assigns} <-
           SchemaHelpers.validate_options(assigns, Options.TextInput, "text_input") do
      render_text_input(assigns)
    else
      message -> message
    end
  end

  defp render_text_input(assigns) do
    %{form: form, field: field} = assigns

    validation_data = FormHelpers.validation_data(form, field, assigns.get_validation_message)
    %{validation_message_id: validation_message_id} = validation_data

    input_type = Options.TextInput.input_type(assigns.type)

    class =
      Attributes.classnames([
        "form-control",
        assigns.class,
        assigns.is_contrast and "input-contrast",
        assigns.is_hide_webkit_autofill and "input-hide-webkit-autofill",
        assigns.is_large and "input-lg",
        assigns.is_small and "input-sm",
        assigns.is_short and "short",
        assigns.is_full_width and "input-block"
      ])

    input_opts =
      Attributes.append_attributes(assigns.extra, [
        [class: class],
        # If aria_label is not set, use the value of placeholder (if any):
        is_nil(assigns.extra[:aria_label]) and [aria_label: assigns.extra[:placeholder]],
        not is_nil(validation_message_id) and [aria_describedby: validation_message_id]
      ])

    input = apply(Phoenix.HTML.Form, input_type, [form, field, input_opts])
    is_form_group = !!assigns.form_group

    case is_form_group do
      true ->
        form_group_opts = assigns.form_group |> Map.from_struct()

        ~H"""
        <.form_group {form_group_opts} validation_data={validation_data}>
          <%= input %>
        </.form_group>
        """

      false ->
        ~H"""
        <%= input %>
        """
    end
  end

  # ------------------------------------------------------------------------------------
  # textarea
  # ------------------------------------------------------------------------------------

  @doc section: :form

  @doc ~S"""
  Creates a textarea.

  ```
  <.textarea name="first_name" />
  ```

  ## Attributes

  Options for textarea are the same as options for `text_input/1`.

  Additional HTML attributes are passed to the textarea element.

  ## Reference

  [Primer/CSS Forms](https://primer.style/css/components/forms)

  """

  def textarea(assigns) do
    assigns = assigns |> assign(type: "textarea")

    with {:ok, assigns} <- SchemaHelpers.validate_options(assigns, Options.TextInput, "textarea") do
      render_text_input(assigns)
    else
      message -> message
    end
  end

  # ------------------------------------------------------------------------------------
  # form_group
  # ------------------------------------------------------------------------------------

  @doc section: :form

  @doc ~S"""
  Creates a form group wrapper around an input field.

  Used internally: see `text_input/1`.

  """

  def form_group(assigns) do
    with {:ok, assigns} <-
           SchemaHelpers.validate_options(assigns, Options.FormGroup, "form_group") do
      render_form_group(assigns)
    else
      message -> message
    end
  end

  defp render_form_group(assigns) do
    %{form: form, field: field, validation_data: validation_data} = assigns

    %{
      is_error: is_error,
      message: message,
      has_message: has_message,
      validation_message_id: validation_message_id
    } = validation_data

    classes = %{
      form_group:
        Attributes.classnames([
          "form-group",
          assigns.class,
          assigns.classes.form_group,
          if has_message do
            if is_error do
              "errored"
            else
              "successed"
            end
          end
        ]),
      header:
        Attributes.classnames([
          "form-group-header",
          assigns.classes.header
        ]),
      body:
        Attributes.classnames([
          "form-group-body",
          assigns.classes.body
        ]),
      note:
        Attributes.classnames([
          "note",
          assigns.classes.note,
          if is_error do
            "error"
          else
            "success"
          end
        ])
    }

    ~H"""
    <div class={classes.form_group} {@extra}>
      <div class={classes.header}>
        <%= if assigns.header do %>
          <%= label(form, field, assigns.header) %>
        <% else %>
          <%= label(form, field) %>
        <% end %>
      </div>
      <div class={classes.body}>
        <%= if @inner_block do %>
          <%= render_slot(@inner_block) %>
        <% end %>
      </div>
      <%= if not is_nil(message) do %>
        <p class={classes.note} id={validation_message_id}>
          <%= message %>
        </p>
      <% end %>
    </div>
    """
  end

  # ------------------------------------------------------------------------------------
  # button
  # ------------------------------------------------------------------------------------

  @doc section: :buttons

  @doc ~S"""
  Creates a button.

  [Examples](#button/1-examples) • [Attributes](#button/1-attributes) • [Reference](#button/1-reference)

  ```
  <.button>Click me</.button>
  ```

  ## Examples

  _button examples_

  Primary button:

  ```
  <.button is_primary>Sign in</.button>
  ```

  Small  button:

  ```
  <.button is_small>Edit</.button>
  ```

  Selected  button:

  ```
  <.button is_selected>Unread</.button>
  ```

  Button with icon:
  ```
  <.button is_primary>
    <.octicon name="download-16" />
    <span>Clone</span>
    <span class="dropdown-caret"></span>
  </.button>
  ```

  Icon-only  button:
  ```
  <.button is_icon_only aria-label="Desktop">
    <.octicon name="device-desktop-16" />
  </.button>
  ```

  Use `button_group/1` to create a group of buttons
  ```
  <.button_group>
    <.button_group_item>Button 1</.button_group_item>
    <.button_group_item>Button 2</.button_group_item>
    <.button_group_item>Button 3</.button_group_item>
  </.button_group>
  ```

  ## Attributes

  _button options_

  | **Name**          | **Type**  | **Validation**       | **Default** | **Description**                                                                                                                            |
  | ----------------- | --------- | -------------------- | ----------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
  | `inner_block`     | `slot`    | required             | -           | Button content.                                                                                                                            |
  | `type`            | `string`  | "button" or "submit" | "button"    | Button type.                                                                                                                               |
  | `class`           | `string`  | -                    | -           | Additional classname.                                                                                                                      |
  | `is_block`        | `boolean` | -                    | false       | Creates a full-width button. Equivalent to adding "btn-block" class.                                                                       |
  | `is_close_button` | `boolean` | -                    | false       | Use when enclosing icon "x-16". This setting removes the default padding. Equivalent to using class "close-button" instead of "btn".       |
  | `is_danger`       | `boolean` | -                    | false       | Creates a red button. Equivalent to adding "btn-danger" class.                                                                             |
  | `is_disabled`     | `boolean` | -                    | false       | Adds attribute `aria-disabled="true"`.                                                                                                     |
  | `is_icon_only`    | `boolean` | -                    | false       | Creates an icon button without a label. Add `is_danger` to create a danger icon. Equivalent to using class "btn-octicon" instead of "btn". |
  | `is_invisible`    | `boolean` | -                    | false       | Create a button that looks like a link, maintaining the paddings of a regular button. Equivalent to adding "btn-invisible" class.          |
  | `is_large`        | `boolean` | -                    | false       | Creates a large button. Equivalent to adding "btn-large" class.                                                                            |
  | `is_link`         | `boolean` | -                    | false       | Create a button that looks like a link. Equivalent to adding "btn-link" class (and removing "btn" class).                                  |
  | `is_outline`      | `boolean` | -                    | false       | Creates a large button. Equivalent to adding "btn-outline" class.                                                                          |
  | `is_primary`      | `boolean` | -                    | false       | Creates a primary colored button. Equivalent to adding "btn-primary" class.                                                                |
  | `is_selected`     | `boolean` | -                    | false       | Adds attribute `aria-selected="true"`.                                                                                                     |
  | `is_small`        | `boolean` | -                    | false       | Creates a small button. Equivalent to adding "btn-sm" class.                                                                               |

  Additional HTML attributes are passed to the button element.

  ## Reference

  [Primer/CSS Buttons](https://primer.style/css/components/buttons)

  """

  def button(assigns) do
    with {:ok, assigns} <- SchemaHelpers.validate_options(assigns, Options.Button, "button") do
      render_button(assigns)
    else
      message -> message
    end
  end

  defp render_button(assigns) do
    class =
      Attributes.classnames([
        !assigns.is_link and !assigns.is_icon_only and !assigns.is_close_button and "btn",
        assigns.class,
        assigns.is_link and "btn-link",
        assigns.is_icon_only and "btn-octicon",
        assigns.is_danger and
          if assigns.is_icon_only do
            "btn-octicon-danger"
          else
            "btn-danger"
          end,
        assigns.is_large and "btn-large",
        assigns.is_primary and "btn-primary",
        assigns.is_outline and "btn-outline",
        assigns.is_small and "btn-sm",
        assigns.is_block and "btn-block",
        assigns.is_invisible and "btn-invisible",
        assigns.is_close_button and "close-button"
      ])

    aria_attributes =
      Attributes.get_aria_attributes(
        is_selected: assigns.is_selected,
        is_disabled: assigns.is_disabled
      )

    ~H"""
    <button class={class} type={@type} {@extra} {aria_attributes}>
      <%= render_slot(@inner_block) %>
    </button>
    """
  end

  # ------------------------------------------------------------------------------------
  # button_group
  # ------------------------------------------------------------------------------------

  @doc section: :buttons

  @doc ~S"""
  Creates a group of buttons.

  A button_group is composed with `button_group_item/1` elements

  ```
  <.button_group>
    button_group_item elements
  </.button_group>
  ```

  ## Examples

  Use the button wrapper component `button_group_item/1` to automatically apply the correct classes to the buttons.

  ```
  <.button_group>
    <.button_group_item>Button 1</.button_group_item>
    <.button_group_item is_selected>Button 2</.button_group_item>
    <.button_group_item is_danger>Button 3</.button_group_item>
  </.button_group>
  ```

  ## Attributes

  | **Name**      | **Type** | **Validation** | **Default** | **Description**       |
  | ------------- | -------- | -------------- | ----------- | --------------------- |
  | `inner_block` | `slot`   | required       | -           | Button group content. |
  | `class`       | `string` | -              | -           | Additional classname. |

  Additional HTML attributes are passed to the button group element.

  ## Reference

  [Primer/CSS Button groups](https://primer.style/css/components/buttons#button-groups)

  """

  def button_group(assigns) do
    with {:ok, assigns} <-
           SchemaHelpers.validate_options(assigns, Options.ButtonGroup, "button_group") do
      render_button_group(assigns)
    else
      message -> message
    end
  end

  defp render_button_group(assigns) do
    class =
      Attributes.classnames([
        "BtnGroup",
        assigns.class
      ])

    ~H"""
    <div class={class} {@extra}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  # ------------------------------------------------------------------------------------
  # button_group_item
  # ------------------------------------------------------------------------------------

  @doc section: :buttons

  @doc ~S"""
  Wrapper for a button inside a `button_group/1`.

  ## Attributes

  Equal to `button/1` options.

  ## Reference

  [Primer/CSS Button groups](https://primer.style/css/components/buttons#button-groups)

  """
  def button_group_item(assigns) do
    with {:ok, assigns} <-
           SchemaHelpers.validate_options(assigns, Options.Button, "button_group_item") do
      render_button_group_item(assigns)
    else
      message -> message
    end
  end

  defp render_button_group_item(assigns) do
    assigns =
      assigns
      |> assign(
        :class,
        Attributes.classnames([
          "BtnGroup-item",
          assigns.class
        ])
      )

    button(assigns)
  end

  # ------------------------------------------------------------------------------------
  # dropdown
  # ------------------------------------------------------------------------------------

  @doc section: :menus

  @doc ~S"""
  Dropdown menu.

  [Examples](#dropdown/1-examples) • [Attributes](#dropdown/1-attributes) • [Reference](#dropdown/1-reference)

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

  ## Attributes

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
      Attributes.classnames([
        "dropdown",
        "details-reset",
        "details-overlay",
        "d-inline-block",
        assigns.class
      ])

    item_opts =
      Attributes.append_attributes(assigns.extra, [
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

  [Examples](#dropdown_item/1-examples) • [Attributes](#dropdown_item/1-attributes) • [Reference](#dropdown_item/1-reference)

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

  ## Attributes

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
        Attributes.classnames([
          # If a custom class is set, remove the default btn class
          if assigns.class do
            assigns.class
          else
            "btn"
          end
        ]),
      caret: "dropdown-caret",
      menu:
        Attributes.classnames([
          "dropdown-menu",
          "dropdown-menu-" <> assigns.position
        ]),
      option: "dropdown-item",
      divider: "dropdown-divider",
      header: "dropdown-header"
    }

    class =
      Attributes.classnames([
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
      Attributes.append_attributes(assigns.extra, [
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

  # ------------------------------------------------------------------------------------
  # pagination
  # ------------------------------------------------------------------------------------

  @doc section: :pagination

  @doc ~S"""
  Creates a control to navigate search results.

  [Examples](#pagination/1-examples) • [Attributes](#pagination/1-attributes) • [Reference](#pagination/1-reference)

  ```
  <.pagination
    page_count={@page_count}
    current_page={@current_page}
    link_path={fn page_num -> "/page/#{page_num}" end}
  />
  ```

  ## Features

  - Configure the page number ranges for siblings and both ends
  - Optionally disable page number display (minimal UI)
  - Custom labels
  - Custom classnames for all elements

  ## Examples

  _pagination examples_

  Simplified paginations, showing Next / Previous buttons:

  ```
  <.pagination
    ...
    is_numbered="false"
  />
  ```

  Configure the number of sibling and boundary page numbers to show:

  ```
  <.pagination
    ...
    sibling_count="1"
    boundary_count="1"
  />
  ```

  Provide custom labels:

  ```
  <.pagination
    ...
    labels={
      %{
        next_page: "Nächste Seite",
        previous_page: "Vorherige Seite"
      }
    }
  />
  ```

  ## Attributes

  _pagination options_

  | **Name**         | **Type**                | **Validation** | **Default** | **Description**                                                                                                                                 |
  | ---------------- | ----------------------- | -------------- | ----------- | ----------------------------------------------------------------------------------------------------------------------------------------------- |
  | `page_count`     | `integer`               | `>= 0`         | -           | Result page count.                                                                                                                              |
  | `current_page`   | `integer`               | `>= 1`         | -           | Current page.                                                                                                                                   |
  | `link_path`      | `(page_number) -> path` | `>= 1`         | -           | Function that returns a path for the given page number. The link builder uses `live_redirect`. Extra options can be passed with `link_options`. |
  | `boundary_count` | `integer`               | `1..3`         | `2`         | Number of page links at both ends.                                                                                                              |
  | `sibling_count`  | `integer`               | `1..5`         | `2`         | How many page links to show on each side of the current page.                                                                                   |
  | `is_numbered`    | `boolean`               |                | `true`      | Showing page numbers.                                                                                                                           |
  | `class`          | `string`                |                | -           | Additional classname for the main component. For more control, use `classes`.                                                                   |
  | `classes`        | `map`                   |                | -           | Map of classnames. Any provided value will be appended to the default classnames. See [Class options](#pagination/1-class-options).                                    |
  | `labels`         | `map`                   |                | -           | Map of textual labels. See [Label options](#pagination/1-label-options).                                                                                               |
  | `link_options`   | `map`                   |                | -           | Map of link options. See [Link options](#pagination/1-link-options).                                                                                                  |

  Additional HTML attributes are passed to the outer HTML element.

  ### Class options

  Options for `classes` in `pagination/1`

  | **Classname**          | **Description**                           |
  | ---------------------- | ----------------------------------------- |
  | `pagination_container` | `nav` element that contains `navigation`. |
  | `pagination`           | Main element.                             |
  | `previous_page`        | Previous page link (enabled or disabled). |
  | `next_page`            | Next page link (enabled or disabled).     |
  | `page`                 | Page number link (not the seleced page).  |
  | `gap`                  | Gap element.                              |

  ### Label options

  Options for `labels` in `pagination/1`

  | **Label**                  | **Default**        |
  | -------------------------- | ------------------ |
  | `aria_label_container`     | Navigation         |
  | `aria_label_next_page`     | Next page          |
  | `aria_label_page`          | Page {page_number} |
  | `aria_label_previous_page` | Previous page      |
  | `gap`                      | …                  |
  | `next_page`                | Next               |
  | `previous_page`            | Previous           |


  ### Link options

  Options for `link_options` in `pagination/1`

  | **Name**  | **Type**  | **Validation** | **Default** | **Description**    |
  | --------- | --------- | -------------- | ----------- | ------------------ |
  | `replace` | `boolean` | -              | false       | Result page count. |


  ### Reference

  [Primer/CSS Pagination](https://primer.style/css/components/pagination)

  """

  def pagination(assigns) do
    with {:ok, assigns} <-
           SchemaHelpers.validate_options(assigns, Options.Pagination, "pagination") do
      # Don't render pagination if page count is 0 or 1
      case assigns.page_count < 2 do
        true -> render_empty(assigns)
        false -> render_pagination(assigns)
      end
    else
      message -> message
    end
  end

  defp render_empty(assigns) do
    ~H"""

    """
  end

  defp render_pagination(assigns) do
    %{
      current_page: current_page,
      page_count: page_count,
      boundary_count: boundary_count,
      sibling_count: sibling_count
    } = assigns

    has_previous_page = current_page > 1
    has_next_page = current_page < page_count
    show_numbers = assigns.is_numbered && page_count > 1
    show_prev_next = page_count > 1

    classes = %{
      pagination_container:
        Attributes.classnames([
          "paginate-container",
          assigns.class,
          assigns.classes.pagination_container
        ]),
      pagination:
        Attributes.classnames([
          "pagination",
          assigns.classes.pagination
        ]),
      previous_page:
        Attributes.classnames([
          "previous_page",
          assigns.classes.previous_page
        ]),
      next_page:
        Attributes.classnames([
          "next_page",
          assigns.classes.next_page
        ]),
      page:
        Attributes.classnames([
          assigns.classes.page
        ]),
      gap:
        Attributes.classnames([
          "gap",
          assigns.classes.gap
        ])
    }

    pagination_elements =
      get_pagination_numbers(
        page_count,
        current_page,
        boundary_count,
        sibling_count
      )

    ~H"""
    <nav class={classes.pagination_container} {@extra} aria-label={@labels.aria_label_container}>
      <div class={classes.pagination}>
        <%= if show_prev_next do %>
          <%= if has_previous_page do %>
            <.link
              navigate={@link_path.(current_page - 1)}
              class={classes.previous_page}
              rel="previous"
              aria_label={@labels.aria_label_previous_page}
              replace={@link_options.replace}
            >
              <%= @labels.previous_page %>
            </.link>
          <% else %>
            <span class={classes.previous_page} aria-disabled="true" phx-no-format><%= @labels.previous_page %></span>
          <% end %>
        <% end %>
        <%= if show_numbers do %>
          <%= for item <- pagination_elements do %>
            <%= if item === current_page do %>
              <em aria-current="page"><%= current_page %></em>
            <% else %>
              <%= if item == 0 do %>
                <span class={classes.gap} phx-no-format><%= @labels.gap %></span>
              <% else %>
                <.link
                  navigate={@link_path.(item)}
                  class={classes.page}
                  aria_label={
                    @labels.aria_label_page |> String.replace("{page_number}", to_string(item))
                  }
                  replace={@link_options.replace}
                >
                  <%= item %>
                </.link>
              <% end %>
            <% end %>
          <% end %>
        <% end %>
        <%= if show_prev_next do %>
          <%= if has_next_page do %>
            <.link
              navigate={@link_path.(current_page + 1)}
              class={classes.next_page}
              rel="next"
              aria_label={@labels.aria_label_next_page}
              replace={@link_options.replace}
            >
              <%= @labels.next_page %>
            </.link>
          <% else %>
            <span class={classes.next_page} aria-disabled="true" phx-no-format><%= @labels.next_page %></span>
          <% end %>
        <% end %>
      </div>
    </nav>
    """
  end

  # Get the list of page number elements
  @doc false

  def get_pagination_numbers(
        page_count,
        current_page,
        boundary_count,
        sibling_count
      )
      when page_count == 0,
      do:
        get_pagination_numbers(
          1,
          current_page,
          boundary_count,
          sibling_count
        )

  def get_pagination_numbers(
        page_count,
        current_page,
        boundary_count,
        sibling_count
      ) do
    list = 1..page_count

    # Insert a '0' divider when the page sequence is not sequential
    # But omit this when the total number of pages equals the boundary_count counts plus the gap item

    may_insert_gaps = page_count !== 0 && page_count > 2 * boundary_count + 1

    case may_insert_gaps do
      true -> insert_gaps(current_page, boundary_count, sibling_count, list)
      false -> list |> Enum.map(& &1)
    end
  end

  defp insert_gaps(current_page, boundary_count, sibling_count, list) do
    section_start = Enum.take(list, boundary_count)
    section_end = Enum.take(list, -boundary_count)

    section_middle_start = current_page - sibling_count
    section_middle_end = current_page + sibling_count

    section_middle =
      Enum.slice(
        list,
        section_middle_start..section_middle_end
      )

    # Join the parts, make sure the numbers a unique, and loop over the result to insert a '0' whenever
    # 2 adjacent number differ by more than 1
    # The result should be something like [1,2,0,5,6,7,8,9,0,99,100]

    (section_start ++ section_middle ++ section_end)
    |> MapSet.new()
    |> MapSet.to_list()
    |> Enum.reduce([], fn num, acc ->
      # Insert a '0' divider when the page sequence is not sequential
      previous_num =
        case Enum.count(acc) == 0 do
          true -> num
          false -> hd(acc)
        end

      acc =
        case num - previous_num > 1 do
          true -> [0 | acc]
          false -> acc
        end

      [num | acc]
    end)
    |> Enum.reverse()
  end

  # ------------------------------------------------------------------------------------
  # octicon
  # ------------------------------------------------------------------------------------

  @doc section: :icons

  @doc ~S"""
  Renders an icon from the set of GitHub icons, 512 including all size variations.

  See `PrimerLive.Octicons` for the complete list.

  [Examples](#octicon/1-examples) • [Attributes](#octicon/1-attributes) • [Reference](#octicon/1-reference)

  ```
  <.octicon name="comment-16" />
  ```

  ## Examples

  Pass the icon name with the size: icon "alert-fill" with size "12" becomes "alert-fill-12":

  ```
  <.octicon name="alert-fill-12" />
  ```

  Icon "pencil" with size 24:

  ```
  <.octicon name="pencil-24" />
  ```

  Custom class:

  ```
  <.octicon name="pencil-24" class="app-icon" />
  ```

  ## Attributes

  | **Name** | **Type** | **Validation** | **Default** | **Description**                                                                         |
  | -------- | -------- | -------------- | ----------- | --------------------------------------------------------------------------------------- |
  | `name`   | `string` | required       | -           | Icon name, e.g. "arrow-left-24". See [available icons](https://primer.style/octicons/). |
  | `class`  | `string` | -              | -           | Additional classname.                                                                   |

  Additional HTML attributes are passed to the SVG element.

  ### Reference

  - [List of Primer icons](https://primer.style/octicons/)
  - [Primer/Octicons Usage](https://primer.style/octicons/guidelines/usage)

  """
  def octicon(assigns) do
    with {:ok, assigns} <- SchemaHelpers.validate_options(assigns, Options.Octicon, "octicon") do
      icon_fn = PrimerLive.Octicons.name_to_function() |> Map.get(assigns.name)

      case is_function(icon_fn) do
        true -> render_octicon(icon_fn, assigns)
        false -> render_no_icon_error_message(assigns)
      end
    else
      message -> message
    end
  end

  defp render_octicon(icon_fn, assigns) do
    %{
      class: class
    } = assigns

    assigns =
      assigns
      |> assign(
        :class,
        Attributes.classnames([
          "octicon",
          class
        ])
      )

    icon_fn.(assigns)
  end

  defp render_no_icon_error_message(assigns) do
    ~H"""
    <SchemaHelpers.error_message component_name="octicon">
      <p>name <%= @name %> does not exist</p>
    </SchemaHelpers.error_message>
    """
  end
end
