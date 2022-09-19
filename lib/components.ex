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
end
