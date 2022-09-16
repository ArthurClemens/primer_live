defmodule PrimerLive.Components do
  use Phoenix.Component
  use Phoenix.HTML

  alias PrimerLive.Helpers.{SchemaHelpers, Attributes, FormHelpers}
  alias PrimerLive.Options

  # ------------------------------------------------------------------------------------
  # alert
  # ------------------------------------------------------------------------------------

  @doc section: :alerts

  @doc ~S"""
  Creates an alert message.

  [Examples](#alert/1-examples) • [Options](#alert/1-options) • [Reference](#alert/1-reference)

  ```
  <.alert>
    Flash message goes here.
  </.alert>
  ```

  ## Examples

  _alert examples_

  Success color:

  ```
  <.alert is_success>
    You're done!
  </.alert>
  ```

  Multiline message:

  ```
  <.alert is_success>
    <p>You're done!</p>
    <p>You may close this message</p>
  </.alert>
  ```

  To render a vertical stack of alerts, wrap each with `alert_messages/1`.

  ## Options

  _alert options_

  | **Name**      | **Type**  | **Validation** | **Default** | **Description**                                                      |
  | ------------- | --------- | -------------- | ----------- | -------------------------------------------------------------------- |
  | `inner_block` | `slot`    | required       | -           | Alert content.                                                       |
  | `class`       | `string`  | -              | -           | Additional classname.                                                |
  | `is_error`    | `boolean` | -              | false       | Sets the color to "error".                                           |
  | `is_success`  | `boolean` | -              | false       | Sets the color to "success".                                         |
  | `is_warning`  | `boolean` | -              | false       | Sets the color to "warning".                                         |
  | `is_full`     | `boolean` | -              | false       | Renders the alert full width, with border and border radius removed. |

  Additional HTML attributes are passed to the alert element.

  ## Reference

  [Primer/CSS Alerts](https://primer.style/css/components/alerts)

  """
  def alert(assigns) do
    with {:ok, assigns} <- SchemaHelpers.validate_options(assigns, Options.Alert, "alert") do
      render_alert(assigns)
    else
      message -> message
    end
  end

  defp render_alert(assigns) do
    class =
      Attributes.classnames([
        "flash",
        assigns.class,
        assigns.is_error and "flash-error",
        assigns.is_success and "flash-success",
        assigns.is_warning and "flash-warn",
        assigns.is_full and "flash-full"
      ])

    ~H"""
    <div class={class} {@extra}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  # ------------------------------------------------------------------------------------
  # alert_messages
  # ------------------------------------------------------------------------------------

  @doc section: :alerts

  @doc ~S"""
  Wrapper to render a vertical stack of `alert/1` messages with spacing in between.

  [Options](#alert_messages/1-options) • [Reference](#alert_messages/1-reference)

  ```
  <.alert_messages>
    <.alert is_success>
      Message 1
    </.alert>
  </.alert_messages>

  <.alert_messages>
    <.alert>
      Message 2
    </.alert>
  </.alert_messages>
  ```

  ## Options

  _alert_messages options_

  | **Name**      | **Type** | **Validation** | **Default** | **Description**         |
  | ------------- | -------- | -------------- | ----------- | ----------------------- |
  | `inner_block` | `slot`   | required       | -           | Alert messages content. |
  | `class`       | `string` | -              | -           | Additional classname.   |

  Additional HTML attributes are passed to the alert messages element.

  ## Reference

  [Primer/CSS Alerts](https://primer.style/css/components/alerts)

  """

  def alert_messages(assigns) do
    with {:ok, assigns} <-
           SchemaHelpers.validate_options(assigns, Options.AlertMessages, "alert_messages") do
      render_alert_messages(assigns)
    else
      message -> message
    end
  end

  defp render_alert_messages(assigns) do
    class =
      Attributes.classnames([
        "flash-messages",
        assigns.class
      ])

    ~H"""
    <div class={class} {@extra}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  # ------------------------------------------------------------------------------------
  # text_input
  # ------------------------------------------------------------------------------------

  @doc section: :form

  @doc ~S"""
  Creates a text input field.

  Wrapper around `Phoenix.HTML.Form.text_input/3`, optionally wrapped inside a "form group".

  [Examples](#text_input/1-examples) • [Options](#text_input/1-options) • [Reference](#text_input/1-reference)

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

  ## Options

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

  ## Options

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
  # layout
  # ------------------------------------------------------------------------------------

  @doc section: :layout

  @doc ~S"""
  Creates a responsive-friendly page layout with 2 columns.

  [Examples](#layout/1-examples) • [Options](#layout/1-options) • [Reference](#layout/1-reference)

  A layout is composed with `layout_item/1` elements.

  ```
  <.layout>
    layout_item elements
  </.layout>
  ```

  ## Examples

  _layout examples_

  The position of the sidebar is set by CSS (and can be changed with attribute `is_sidebar_position_end`).
  In this example the sidebar is the last element, but (by default) will be placed at the start:

  ```
  <.layout>
    <.layout_item main>
      Main content
    </.layout_item>
    <.layout_item sidebar>
      Sidebar content
    </.layout_item>
  </.layout>
  ```

  From the Primer documentation:

  > Keyboard navigation follows the markup order. Decide carefully how the focus order should be be by deciding whether Layout-main or Layout-sidebar comes first in code. The code order won’t affect the visual position.


  Place the sidebar at the right:

  ```
  <.layout is_sidebar_position_end>
    <.layout_item main>
      Main content
    </.layout_item>
    <.layout_item sidebar>
      Sidebar content
    </.layout_item>
  </.layout>
  ```

  With a divider. Use `is_divided` in conjunction with the `layout_item/1` element with attribute `divider` to show a divider between the main content and the sidebar.

  ```
  <.layout is_divided>
    <.layout_item main>
      Main content
    </.layout_item>
    <.layout_item divider />
    <.layout_item sidebar>
      Sidebar content
    </.layout_item>
  </.layout>
  ```

  Nested layout, example 1:

  ```
  <.layout>
    <.layout_item main>
      <.layout is_sidebar_position_end is_narrow_sidebar>
        <.layout_item main>
          Main content
        </.layout_item>
        <.layout_item sidebar>
          Metadata sidebar
        </.layout_item>
      </.layout>
    </.layout_item>
    <.layout_item sidebar>
      Default sidebar
    </.layout_item>
  </.layout>
  ```

  Nested layout, example 2:

  ```
  <.layout>
    <.layout_item main>
      <.layout is_sidebar_position_end is_flow_row_until_lg is_narrow_sidebar>
        <.layout_item main>
          Main content
        </.layout_item>
        <.layout_item sidebar>
          Metadata sidebar
        </.layout_item>
      </.layout>
    </.layout_item>
    <.layout_item sidebar>
      Default sidebar
    </.layout_item>
  </.layout>
  ```

  ## Options

  _layout options_

  | **Name**                             | **Type**  | **Validation** | **Default** | **Description**                                                                                                                                                                                  |
  | ------------------------------------ | --------- | -------------- | ----------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
  | `inner_block`                        | `slot`    | required       | -           | Content.                                                                                                                                                                                         |
  | `class`                              | `string`  | -              | -           | Additional classname.                                                                                                                                                                            |
  | `is_divided`                         | `boolean` | -              | false       | Use `is_divided` in conjunction with the `layout_item/1` element with attribute `divider` to show a divider between the main content and the sidebar. Creates a 1px line between main and sidebar. |
  | `is_narrow_sidebar`                  | `boolean` | -              | false       | Smaller sidebar size. Widths: md: 240px, lg: 256px.                                                                                                                                              |
  | `is_wide_sidebar`                    | `boolean` | -              | false       | Wider sidebar size. Widths: md: 296px, lg: 320px, xl: 344px.                                                                                                                                     |
  | `is_gutter_none`                     | `boolean` | -              | false       | Changes the gutter size to 0px.                                                                                                                                                                  |
  | `is_gutter_condensed`                | `boolean` | -              | false       | Changes the gutter size to 16px.                                                                                                                                                                 |
  | `is_gutter_spacious`                 | `boolean` | -              | false       | Changes the gutter sizes to: md: 16px, lg: 32px, xl: 40px.                                                                                                                                       |
  | `is_sidebar_position_start`          | `boolean` | -              | false       | Places the sidebar at the start (commonly at the left) (default).                                                                                                                                |
  | `is_sidebar_position_end`            | `boolean` | -              | false       | Places the sidebar at the end (commonly at the right).                                                                                                                                           |
  | `is_sidebar_position_flow_row_start` | `boolean` | -              | false       | When stacked, render the sidebar first (default).                                                                                                                                                |
  | `is_sidebar_position_flow_row_end`   | `boolean` | -              | false       | When stacked, render the sidebar last.                                                                                                                                                           |
  | `is_sidebar_position_flow_row_none`  | `boolean` | -              | false       | When stacked, hide the sidebar.                                                                                                                                                                  |
  | `is_flow_row_until_md`               | `boolean` | -              | false       | Stacks when container is md.                                                                                                                                                                     |
  | `is_flow_row_until_lg`               | `boolean` | -              | false       | Stacks when container is lg.                                                                                                                                                                     |

  Additional HTML attributes are passed to the layout container element.

  ## Reference

  [Primer/CSS Layout](https://primer.style/css/components/layout)

  """

  def layout(assigns) do
    with {:ok, assigns} <- SchemaHelpers.validate_options(assigns, Options.Layout, "layout") do
      render_layout(assigns)
    else
      message -> message
    end
  end

  defp render_layout(assigns) do
    class =
      Attributes.classnames([
        "Layout",
        assigns.class,
        assigns.is_divided and "Layout--divided",
        assigns.is_narrow_sidebar and "Layout--sidebar-narrow",
        assigns.is_wide_sidebar and "Layout--sidebar-wide",
        assigns.is_gutter_none and "Layout--gutter-none",
        assigns.is_gutter_condensed and "Layout--gutter-condensed",
        assigns.is_gutter_spacious and "Layout--gutter-spacious",
        assigns.is_sidebar_position_start and "Layout--sidebarPosition-start",
        assigns.is_sidebar_position_end and "Layout--sidebarPosition-end",
        assigns.is_sidebar_position_flow_row_start and "Layout--sidebarPosition-flowRow-start",
        assigns.is_sidebar_position_flow_row_end and "Layout--sidebarPosition-flowRow-end",
        assigns.is_sidebar_position_flow_row_none and "Layout--sidebarPosition-flowRow-none",
        assigns.is_flow_row_until_md and "Layout--flowRow-until-md",
        assigns.is_flow_row_until_lg and "Layout--flowRow-until-lg"
      ])

    ~H"""
    <div class={class} {@extra}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  # ------------------------------------------------------------------------------------
  # layout_item
  # ------------------------------------------------------------------------------------

  @doc section: :layout

  @doc ~S"""
  Variable content element for `layout/1`.

  [Examples](#layout_item/1-examples) • [Options](#layout_item/1-options) • [Reference](#layout_item/1-reference)

  Main, divider and sidebar containers:

  ```
  <.layout_item main> Main content </.layout_item>
  <.layout_item divider />
  <.layout_item sidebar> Sidebar content </.layout_item>
  ```

  See `layout/1` for examples of nested layouts.

  ## Examples

  _layout_item examples_

  The modifiers `is_centered_xx` create a wrapper around `main` to center its content up to a maximum width.
  Use with `.container-xx` classes to restrict the size of the content:

  ```
  <.layout>
    <.layout_item main is_centered_md>
      <div class="container-md">
        Centered md
      </div>
    </.layout_item>
    <.layout_item sidebar>
      Default sidebar
    </.layout_item>
  </.layout>
  ```

  Show or hide the divider:

  - `.layout is_divided` without any `layout_item` modifier creates a 1px border between main and sidebar
  - `.layout is_divided` with `is_flow_row_hidden` hides the divider
  - `.layout is_divided` with `is_flow_row_shallow` shows a filled 8px divider

  ```
  <.layout is_divided>
    <.layout_item divider is_flow_row_shallow />
  </.layout>
  ```

  ## Options

  _layout_item options_

  | **Name**              | **Type**  | **Validation** | **Default** | **Description**                                                                                                                                                                                                                                 |
  | --------------------- | --------- | -------------- | ----------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
  | `inner_block`         | `slot`    | -              | -           | Content. Optional when using attribute `divider`.                                                                                                                                                                                               |
  | `class`               | `string`  | -              | -           | Additional classname.                                                                                                                                                                                                                           |
  | `main`                | `boolean` | -              | false       | Creates a main element. Default gutter sizes: md: 16px, lg: 24px (change with `is_gutter_none`, `is_gutter_condensed` and `is_gutter_spacious`). Stacks when container is `sm` (change with `is_flow_row_until_md` and `is_flow_row_until_lg`). |
  | `sidebar`             | `boolean` | -              | false       | Creates a sidebar element. Widths: md: 256px, lg: 296px (change with `is_narrow_sidebar` and `is_wide_sidebar`).                                                                                                                                |
  | `divider`             | `boolean` | -              | false       | Creates a divider element. The divider will only be shown with option `is_divided`. Creates a line between the main and sidebar elements - horizontal when the elements are stacked and vertical when they are shown side by side.              |
  | `is_centered_lg`      | `boolean` | -              | false       | With attribute `main`. Creates a wrapper around `main` to keep its content centered up to max width "lg".                                                                                                                                       |
  | `is_centered_md`      | `boolean` | -              | false       | With attribute `main`. Creates a wrapper around `main` to keep its content centered up to max width "md".                                                                                                                                       |
  | `is_centered_xl`      | `boolean` | -              | false       | With attribute `main`. Creates a wrapper around `main` to keep its content centered up to max width "xl".                                                                                                                                       |
  | `is_flow_row_hidden`  | `boolean` | -              | false       | With attribute `divider` and small screen (up to 544px). Hides the horizontal divider.                                                                                                                                                          |
  | `is_flow_row_shallow` | `boolean` | -              | false       | With attribute `divider` and small screen (up to 544px). Creates a filled 8px horizontal divider.                                                                                                                                               |

  Additional HTML attributes are passed to the layout_item element.

  ## Reference

  [Primer/CSS Layout](https://primer.style/css/components/layout)

  """

  def layout_item(assigns) do
    with {:ok, assigns} <-
           SchemaHelpers.validate_options(assigns, Options.LayoutItem, "layout_item") do
      render_layout_item(assigns)
    else
      message -> message
    end
  end

  defp render_layout_item(assigns) do
    classes = %{
      main: "Layout-main",
      main_center_wrapper:
        Attributes.classnames([
          assigns.is_centered_md and "Layout-main-centered-md",
          assigns.is_centered_lg and "Layout-main-centered-lg",
          assigns.is_centered_xl and "Layout-main-centered-xl"
        ]),
      sidebar: "Layout-sidebar",
      divider:
        Attributes.classnames([
          "Layout-divider",
          assigns.is_flow_row_shallow and "Layout-divider--flowRow-shallow",
          assigns.is_flow_row_hidden and "Layout-divider--flowRow-hidden"
        ])
    }

    class =
      Attributes.classnames([
        cond do
          assigns.main -> classes.main
          assigns.sidebar -> classes.sidebar
          assigns.divider -> classes.divider
          true -> nil
        end,
        assigns.class
      ])

    item_opts =
      Attributes.append_attributes(assigns.extra, [
        class !== "" && [class: class]
      ])

    ~H"""
    <div {item_opts}>
      <%= if @main do %>
        <%= if @is_centered_md || @is_centered_lg || @is_centered_xl do %>
          <div class={classes.main_center_wrapper}>
            <%= render_slot(@inner_block) %>
          </div>
        <% else %>
          <%= render_slot(@inner_block) %>
        <% end %>
      <% else %>
        <%= if @inner_block do %>
          <%= render_slot(@inner_block) %>
        <% end %>
      <% end %>
    </div>
    """
  end

  # ------------------------------------------------------------------------------------
  # box
  # ------------------------------------------------------------------------------------

  @doc section: :layout

  @doc ~S"""
  Creates a content container.

  [Examples](#box/1-examples) • [Options](#box/1-options) • [Reference](#box/1-reference)

  A `box` is a container with rounded corners, a white background, and a light gray border.
  By default, there are no other styles, such as padding; however, these can be introduced
  with utility classes as needed. `box_item/1` elements allow for the creation of alternative
  styles and layouts.

  A box is composed with with `box_item/1` elements.

  ```
  <.box>
    box_item elements
  </.box>
  ```

  ## Examples

  _box examples_

  Reduce padding:

  ```
  <.box is_condensed>
    <.box_item row>Row content</.box_item>
    <.box_item row>Row content</.box_item>
  </.box>
  ```

  Increase padding. Optionally increase the font size (in this example using the `f4` utiliti class):

  ```
  <.box is_spacious class="f4">
    <.box_item row>Row content</.box_item>
    <.box_item row>Row content</.box_item>
  </.box>
  ```

  Apply a blue box theme:

  ```
  <.box is_blue>
    Content
  </.box>
  ```

  Apply a danger theme.

  ```
  <.box is_danger>
    Content
  </.box>
  ```

  ## Options

  _box examples_

  | **Name**           | **Type**  | **Validation** | **Default** | **Description**                                                           |
  | ------------------ | --------- | -------------- | ----------- | ------------------------------------------------------------------------- |
  | `inner_block`      | `slot`    | required       | -           | Box content, for example `box_item/1`.                                    |
  | `class`            | `string`  | -              | -           | Additional classname.                                                     |
  | `is_blue`          | `boolean` | -              | false       | Creates a blue box theme.                                                 |
  | `is_danger`        | `boolean` | -              | false       | Creates a danger color box theme. Only works with either `row` or `body`. |
  | `is_border_dashed` | `boolean` | -              | false       | Applies a dashed border to the box.                                       |
  | `is_condensed`     | `boolean` | -              | false       | Condenses line-height and reduces the padding on the Y axis.              |
  | `is_spacious`      | `boolean` | -              | false       | Increases padding and increases the title font size.                      |

  Additional HTML attributes are passed to the box element.

  ## Reference

  [Primer/CSS Box](https://primer.style/css/components/box)

  """

  def box(assigns) do
    with {:ok, assigns} <- SchemaHelpers.validate_options(assigns, Options.Box, "box") do
      render_box(assigns)
    else
      message -> message
    end
  end

  defp render_box(assigns) do
    class =
      Attributes.classnames([
        "Box",
        assigns.class,
        assigns.is_blue and "Box--blue",
        assigns.is_border_dashed and "border-dashed",
        assigns.is_condensed and "Box--condensed",
        assigns.is_danger and "Box--danger",
        assigns.is_spacious and "Box--spacious"
      ])

    ~H"""
    <div class={class} {@extra}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  # ------------------------------------------------------------------------------------
  # box_item
  # ------------------------------------------------------------------------------------

  @doc section: :layout

  @doc ~S"""
  Variable content element for `box/1`.

  [Examples](#box_item/1-examples) • [Options](#box_item/1-options) • [Reference](#box_item/1-reference)

  Box elements are created with boolean options:

  ```
  <.box_item header> ... </.box_item>
  <.box_item title> ... </.box_item>
  <.box_item row> ... </.box_item>
  <.box_item body> ... </.box_item>
  <.box_item footer> ... </.box_item>
  ```

  ## Examples

  _box_item examples_

  Create a blue header:

  ```
  <.box>
    <.box_item header is_blue>Blue header</.box_item>
  </.box>
  ```

  Render search results:

  ```
  <.box>
    <%= for result <- @results do %>
      <.box_item row>
        {result.id}
      </.box_item>
    <% end %>
  </.box>
  ```

  Insert a conditional alert:

  ```
  <.box>
    <.box_item header>Header</.box_item>
    <%= if is_success != false do %>
      <.alert is_success is_full>
        <.octicon name="check-16" is_small /> Done!
      </.alert>
    <% end %>
     <.box_item body>Body</.box_item>
     <.box_item footer>Footer</.box_item>
  </.box>
  ```

  Blue row theme on hover:

  ```
  <.box_item row is_hover_blue>
    Content
  </.box_item>
  ```

  To highlight that the row contains unread items:

  ```
  <.box_item row is_unread>
    New content
  </.box_item>
  ```

  Row link - when you want a link to appear dark gray and blue on hover on desktop, and remain a blue link on mobile. This is useful to indicate links on mobile without having hover styles.

  ```
  <.box_item row is_link href="/home">
    Go to Home
  </.box_item>
  ```

  Box title:

  ```
  <.box>
    <.box_item header>
      <.box_item title>
        Title
      </.box_item>
    </.box_item>
  </.box>
  ```

  Box title with a button:

  ```
  <.box>
    <.box_item header class="d-flex flex-items-center">
      <.box_item title class="flex-auto">
        Title
      </.box_item>
      <.button is_primary is_smmall>
        Button
      </.button>
    </.box_item>
    <.box_item body>
      Rest
    </.box_item>
  </.box>
  ```

  ## Options

  _box_item options_

  | **Name**              | **Type**  | **Validation** | **Default** | **Description**                                                                                          |
  | --------------------- | --------- | -------------- | ----------- | -------------------------------------------------------------------------------------------------------- |
  | `inner_block`         | `slot`    | required       | -           | Content.                                                                                                 |
  | `header`              | `boolean` | -              | false       | Creates a header element.                                                                                |
  | `title`               | `boolean` | -              | false       | Creates a title element to be placed within a headder element.                                           |
  | `row`                 | `boolean` | -              | false       | Creates a row element.                                                                                   |
  | `body`                | `boolean` | -              | false       | Creates a body element.                                                                                  |
  | `footer`              | `boolean` | -              | false       | Creates a footer element.                                                                                |
  | `class`               | `string`  | -              | -           | Additional classname.                                                                                    |
  | `is_blue`             | `boolean` | -              | false       | Blue row theme.                                                                                          |
  | `is_focus_blue`       | `boolean` | -              | false       | Changes to blue row theme on focus.                                                                      |
  | `is_focus_gray`       | `boolean` | -              | false       | Changes to gray row theme on focus.                                                                      |
  | `is_gray`             | `boolean` | -              | false       | Gray row theme.                                                                                          |
  | `is_hover_blue`       | `boolean` | -              | false       | Changes to blue row theme on hover.                                                                      |
  | `is_hover_gray`       | `boolean` | -              | false       | Changes to gray row theme on hover.                                                                      |
  | `is_navigation_focus` | `boolean` | -              | false       | Combine with a theme color to highlight the row when using keyboard commands.                            |
  | `is_unread`           | `boolean` | -              | false       | Apply a blue vertical line highlight for indicating a row contains unread items.                         |
  | `is_yellow`           | `boolean` | -              | false       | Yellow row theme.                                                                                        |
  | `is_link`             | `boolean` | -              | false       | With attribute `row`. Use with link attributes such as "href" to creates a link with a "row link" class. |

  Additional HTML attributes are passed to the box_item element.

  ## Reference

  [Primer/CSS Box](https://primer.style/css/components/box)

  """

  def box_item(assigns) do
    with {:ok, assigns} <- SchemaHelpers.validate_options(assigns, Options.BoxItem, "box_item") do
      render_box_item(assigns)
    else
      message -> message
    end
  end

  defp render_box_item(assigns) do
    classes = %{
      header:
        Attributes.classnames([
          "Box-header",
          assigns.is_blue and "Box-header--blue"
        ]),
      body: "Box-body",
      footer: "Box-footer",
      title: "Box-title",
      row:
        Attributes.classnames([
          "Box-row",
          assigns.is_blue and "Box-row--blue",
          assigns.is_focus_blue and "Box-row--focus-blue",
          assigns.is_focus_gray and "Box-row--focus-gray",
          assigns.is_gray and "Box-row--gray",
          assigns.is_hover_blue and "Box-row--hover-blue",
          assigns.is_hover_gray and "Box-row--hover-gray",
          assigns.is_navigation_focus and "navigation-focus",
          assigns.is_yellow and "Box-row--yellow",
          assigns.is_unread and "Box-row--unread"
        ]),
      link: "Box-row-link"
    }

    class =
      Attributes.classnames([
        cond do
          assigns.header -> classes.header
          assigns.body -> classes.body
          assigns.footer -> classes.footer
          assigns.row -> classes.row
          assigns.title -> classes.title
          true -> nil
        end,
        assigns.class
      ])

    item_opts =
      Attributes.append_attributes(assigns.extra, [
        class !== "" && [class: class]
      ])

    title_opts = class !== "" && [class: class]

    link_row_opts =
      Attributes.append_attributes(assigns.extra, [
        [
          class:
            Attributes.classnames([
              classes.link,
              assigns.class
            ])
        ]
      ])

    ~H"""
    <%= if @title do %>
      <h3 {title_opts}>
        <%= render_slot(@inner_block) %>
      </h3>
    <% else %>
      <%= if @row and @is_link do %>
        <div class={classes.row}>
          <a {link_row_opts}><%= render_slot(@inner_block) %></a>
        </div>
      <% else %>
        <div {item_opts}>
          <%= render_slot(@inner_block) %>
        </div>
      <% end %>
    <% end %>
    """
  end

  # ------------------------------------------------------------------------------------
  # button
  # ------------------------------------------------------------------------------------

  @doc section: :buttons

  @doc ~S"""
  Creates a button.

  [Examples](#button/1-examples) • [Options](#button/1-options) • [Reference](#button/1-reference)

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

  ## Options

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

  ## Options

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

  ## Options

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

  [Examples](#dropdown/1-examples) • [Options](#dropdown/1-options) • [Reference](#dropdown/1-reference)

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

  ## Options

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

  [Examples](#dropdown_item/1-examples) • [Options](#dropdown_item/1-options) • [Reference](#dropdown_item/1-reference)

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

  ## Options

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

  [Examples](#pagination/1-examples) • [Options](#pagination/1-options) • [Reference](#pagination/1-reference)

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

  ## Options

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
            <%= live_redirect(@labels.previous_page,
              to: @link_path.(current_page - 1),
              class: classes.previous_page,
              rel: "previous",
              aria_label: @labels.aria_label_previous_page,
              replace: @link_options.replace
            ) %>
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
                <%= live_redirect(item,
                  to: @link_path.(item),
                  class: classes.page,
                  aria_label:
                    @labels.aria_label_page |> String.replace("{page_number}", to_string(item)),
                  replace: @link_options.replace
                ) %>
              <% end %>
            <% end %>
          <% end %>
        <% end %>
        <%= if show_prev_next do %>
          <%= if has_next_page do %>
            <%= live_redirect(@labels.next_page,
              to: @link_path.(current_page + 1),
              class: classes.next_page,
              rel: "next",
              aria_label: @labels.aria_label_next_page,
              replace: @link_options.replace
            ) %>
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

  [Examples](#octicon/1-examples) • [Options](#octicon/1-options) • [Reference](#octicon/1-reference)

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

  ## Options

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
