defmodule PrimerLive.TestComponents do
  use Phoenix.Component
  use Phoenix.HTML

  alias PrimerLive.Helpers.{Attributes, FormHelpers, SchemaHelpers}

  # ------------------------------------------------------------------------------------
  # form_group
  # ------------------------------------------------------------------------------------

  @doc section: :form

  @doc ~S"""
  Creates a form group wrapper around an input field.

  Used internally: see `test_text_input/1`.
  """

  attr(:class, :string, doc: "Additional classname.")

  attr :classes, :map,
    default: %{
      form_group: "",
      header: "",
      body: "",
      note: ""
    },
    doc: """
    Additional classnames for form group elements.

    Any provided value will be appended to the default classname.
    """

  attr :field, :any, doc: "Field name (atom or string)."
  attr :header_title, :string, doc: "Header title."

  attr(:validation_message, :any,
    doc: """
    Function to write a custom validation message (in case of error or success).

    The function receives a `PrimerLive.FieldState` struct and returns a validation message.

    A validation message is shown:
    - If form is a `Phoenix.HTML.Form`, containing a `changeset`
    - And either:
      - `changeset.action` is `:validate`
      - `validation_message` returns a string

    Function signature: `fun field_state -> string | nil`.

    Example error message:

    ```
    fn field_state ->
      if !field_state.valid?, do: "Please enter your first name"
    end
    ```

    Example success message, only shown when `changeset.action` is `:validate`:

    ```
    fn field_state ->
      if field_state.valid? && field_state.changeset.action == :validate, do: "Is available"
    end
    ```
    """
  )

  attr :form, :any,
    doc:
      "Either a [Phoenix.HTML.Form](https://hexdocs.pm/phoenix_html/Phoenix.HTML.Form.html) or an atom."

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the outer element.
    """
  )

  attr(:header, :any, doc: "Custom header slot (passed as attribute from an input component).")

  slot(:inner_block, doc: "Body content.")

  def test_form_group(assigns) do
    form = assigns[:form]
    field = assigns[:field]

    %{
      valid?: valid?,
      message: message,
      message_id: message_id
    } = FormHelpers.field_state(form, field, assigns[:validation_message])

    classes = %{
      form_group:
        Attributes.classnames([
          "form-group",
          assigns[:class],
          assigns[:classes][:form_group],
          if !is_nil(message) do
            if valid? do
              "successed"
            else
              "errored"
            end
          end
        ]),
      header:
        Attributes.classnames([
          "form-group-header",
          assigns[:classes][:header]
        ]),
      body:
        Attributes.classnames([
          "form-group-body",
          assigns[:classes][:body]
        ]),
      note:
        Attributes.classnames([
          "note",
          assigns[:classes][:note],
          if valid? do
            "success"
          else
            "error"
          end
        ])
    }

    ~H"""
    <div class={classes.form_group} {@rest}>
      <div class={classes.header}>
        <%= if @header && @header !== [] do %>
          <%= render_slot(@header) %>
        <% else %>
          <%= if @header_title do %>
            <%= label(form, field, @header_title) %>
          <% else %>
            <%= label(form, field) %>
          <% end %>
        <% end %>
      </div>
      <div class={classes.body}>
        <%= if @inner_block do %>
          <%= render_slot(@inner_block) %>
        <% end %>
      </div>
      <%= if not is_nil(message) do %>
        <p class={classes.note} id={message_id}>
          <%= message %>
        </p>
      <% end %>
    </div>
    """
  end

  # ------------------------------------------------------------------------------------
  # text_input
  # ------------------------------------------------------------------------------------

  @doc section: :form

  @doc ~S"""
  Creates a text input field.

  Wrapper around `Phoenix.HTML.Form.text_input/3`, optionally wrapped itself inside a "form group".

  [Examples](#test_text_input/1-examples) • [Attributes](#test_text_input/1-attributes) • [Reference](#test_text_input/1-reference)

  ```
  <.test_text_input name="first_name" />
  ```

  ## Examples

  Set the input type:

  ```
  <.test_text_input type="password" />
  ```

  Set the placeholder. By default, the value of the placeholder attribute is used to fill in the aria-label attribute:

  ```
  <.test_text_input placeholder="Enter your first name" />
  ```

  Further customise the heading with a `:header` slot (this will also create a form group):

  ```
  <.test_text_input form={:user} field={:first_name}>
    <:header>
      <h2>First name</h2>
    </:header>
  </.test_text_input>
  ```

  Insert the input within a form group using `test_form_group/1`. If no header text is added, the input label in the form group header is generated automatically:

  ```
  <.test_text_input form={:user} field={:first_name} form_group />
  ```

  Insert the input within a form group with a customized header title:

  ```
  <.test_text_input form={:user} field={:first_name} form_group={
    %{header_title: "Enter your first name"}
  } />
  ```

  Using the input with form data:

  ```
  <.form let={f} for={@changeset} phx-change="validate" phx-submit="save">
    <.test_text_input form={f} field={:first_name} form_group />
    <.test_text_input form={f} field={:last_name} form_group />
  </.form>
  ```

  With a form changeset, write a custom error message:

  ```
  <.test_text_input form={f} field={:first_name} form_group=%{validation_message:
    fn changeset ->
      if !changeset.valid?, do: "Please enter your first name"
    end
  }} />
  ```

  With a form changeset, write a custom success message:

  ```
  <.test_text_input form={f} field={:first_name} form_group={%{validation_message:
    fn changeset ->
      if changeset.valid?, do: "Complete"
    end
  }} />
  ```

  [INSERT LVATTRDOCS]

  ## Reference

  [Primer/CSS Forms](https://primer.style/css/components/forms)

  ## Status

  Feature complete.

  """

  attr :field, :any, doc: "Field name (atom or string)."

  attr :form, :any,
    doc:
      "Either a [Phoenix.HTML.Form](https://hexdocs.pm/phoenix_html/Phoenix.HTML.Form.html) or an atom."

  attr :form_group, :any,
    default: false,
    doc: """
    Options for `test_form_group/1`.

    Passing these options, or just passing `true`, will create a `test_form_group/1` element that wraps the label, the input and any help texts.

    Examples:

    Wrap the input inside a form group:
    ```
    form_group
    ```

    Set form group attributes:
    ```
    form_group={
      %{
        header_title: "First name",
        class: "my-group",
        validation_message: fn field_state ->
          if !field_state.valid?, do: "Please enter your first name"
        end
      }
    }
    ```
    """

  attr(:class, :string, doc: "Additional classname.")
  attr(:type, :string, doc: "Text input type.")
  attr(:is_contrast, :boolean, default: false, doc: "Changes the background color to light gray.")
  attr(:is_full_width, :boolean, default: false, doc: "Full width input.")

  attr(:is_hide_webkit_autofill, :boolean,
    default: false,
    doc: "Hide WebKit's contact info autofill icon."
  )

  attr(:is_large, :boolean, default: false, doc: "Larger text size.")
  attr(:is_small, :boolean, default: false, doc: "Smaller input with smaller text size.")

  attr(:is_short, :boolean,
    default: false,
    doc: "Within a `test_form_group/1`. Creates an input with a reduced width."
  )

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the input (or if applicable, the form group) element.
    """
  )

  slot(:header,
    doc:
      "Custom header slot for when you require more HTML than just a text title. If present, a `test_form_group/1` will be created to wrap the header and input."
  )

  def test_text_input(assigns) do
    with true <- validate_is_form(assigns),
         true <- validate_is_short_with_form_group(assigns),
         assigns <- set_form_group_defaults(assigns) do
      render_test_text_input(assigns)
    else
      {:error, reason} ->
        ~H"""
        <%= reason %>
        """
    end
  end

  # Validates attribute `form`.
  # Allowed values:
  # - nil
  # - atom
  # - Phoenix.HTML.Form
  defp validate_is_form(assigns) do
    value = assigns[:form]

    cond do
      is_nil(value) -> true
      is_atom(value) -> true
      SchemaHelpers.is_phoenix_form(value) -> true
      true -> {:error, "attr form: invalid value"}
    end
  end

  # Validates that attribute `is_short` coexists with `form_group`.
  # Allowed values:
  # - nil
  # - any truthy value if form_group is also present
  defp validate_is_short_with_form_group(assigns) do
    is_short = assigns[:is_short]
    form_group = assigns[:form_group]

    cond do
      !is_short -> true
      !!is_short && !!form_group -> true
      true -> {:error, "attr is_short: must be used with form_group"}
    end
  end

  # If form_group is true, change it to default struct
  defp set_form_group_defaults(assigns) do
    form_group = assigns[:form_group]
    header = assigns[:header]
    is_header = header !== []

    default_value = %{
      form: assigns[:form],
      field: assigns[:field],
      header: if(is_header, do: header, else: nil),
      header_title: nil,
      inner_block: nil
    }

    cond do
      is_map(form_group) ->
        assigns
        |> assign(:form_group, Map.merge(default_value, form_group))

      is_header || (is_boolean(form_group) && !!form_group) ->
        assigns
        |> assign(:form_group, default_value)

      true ->
        assigns
    end
  end

  defp render_test_text_input(assigns) do
    form = assigns[:form]
    field = assigns[:field]
    type = assigns[:type]
    form_group = assigns[:form_group] || []
    header = assigns[:header]

    # Get field_state from form_group attr so that we can get the message_id, required for aria_describedby
    %{message_id: message_id} =
      FormHelpers.field_state(form, field, form_group[:validation_message])

    input_type = FormHelpers.input_type_as_atom(type)

    class =
      Attributes.classnames([
        "form-control",
        assigns[:class],
        assigns.is_contrast and "input-contrast",
        assigns.is_hide_webkit_autofill and "input-hide-webkit-autofill",
        assigns.is_large and "input-lg",
        assigns.is_small and "input-sm",
        assigns.is_short and "short",
        assigns.is_full_width and "input-block"
      ])

    input_opts =
      Attributes.append_attributes(assigns.rest, [
        [class: class],
        # If aria_label is not set, use the value of placeholder (if any):
        is_nil(assigns.rest[:aria_label]) and [aria_label: assigns.rest[:placeholder]],
        not is_nil(message_id) and [aria_describedby: message_id]
      ])

    input = apply(Phoenix.HTML.Form, input_type, [form, field, input_opts])
    wrap_in_form_groun = (!!form_group && form_group !== []) || (!!header && header !== [])

    ~H"""
    <%= if wrap_in_form_groun do %>
      <.test_form_group {form_group}>
        <%= input %>
      </.test_form_group>
    <% else %>
      <%= input %>
    <% end %>
    """
  end

  # ------------------------------------------------------------------------------------
  # textarea
  # ------------------------------------------------------------------------------------

  @doc section: :form

  @doc ~S"""
  Creates a textarea.

  ```
  <.test_textarea name="comments" />
  ```

  ## Attributes

  Options for textarea are the same as options for `test_text_input/1`.

  Additional HTML attributes are passed to the textarea element.

  ## Reference

  [Primer/CSS Forms](https://primer.style/css/components/forms)

  """

  def test_textarea(assigns) do
    assigns = assigns |> assign(type: "textarea")
    test_text_input(assigns)
  end

  # ------------------------------------------------------------------------------------
  # alert
  # ------------------------------------------------------------------------------------

  @doc section: :alerts

  @doc ~S"""
  Creates an alert message.

  [Examples](#test_alert/1-examples) • [Attributes](#test_alert/1-attributes) • [Reference](#test_alert/1-reference)

  ```
  <.test_alert>
    Flash message goes here.
  </.test_alert>
  ```

  ## Examples

  Success color:

  ```
  <.test_alert is_success>
    You're done!
  </.test_alert>
  ```

  Multiline message:

  ```
  <.test_alert is_success>
    <p>You're done!</p>
    <p>You may close this message</p>
  </.test_alert>
  ```

  To add an extra bottom margin to a stack of alerts, wrap the alerts in `test_alert_messages/1`.

  [INSERT LVATTRDOCS]

  ## Reference

  [Primer/CSS Alerts](https://primer.style/css/components/alerts/)

  ## Status

  Feature complete.

  """

  attr(:class, :string, doc: "Additional classname.")
  attr(:is_error, :boolean, default: false, doc: "Sets the color to \"error\".")
  attr(:is_success, :boolean, default: false, doc: "Sets the color to \"success\".")
  attr(:is_warning, :boolean, default: false, doc: "Sets the color to \"warning\".")

  attr(:is_full, :boolean,
    default: false,
    doc: "Renders the test_alert full width, with border and border radius removed."
  )

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the outer element.
    """
  )

  slot(:inner_block, required: true, doc: "Alert content.")

  def test_alert(assigns) do
    class =
      Attributes.classnames([
        "flash",
        assigns[:class],
        assigns.is_error and "flash-error",
        assigns.is_success and "flash-success",
        assigns.is_warning and "flash-warn",
        assigns.is_full and "flash-full"
      ])

    ~H"""
    <div class={class} {@rest}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  # ------------------------------------------------------------------------------------
  # test_alert_messages
  # ------------------------------------------------------------------------------------

  @doc section: :alerts

  @doc ~S"""
  Wrapper to render a vertical stack of `test_alert/1` messages with spacing in between.

  [Attributes](#test_alert_messages/1-attributes) • [Reference](#test_alert_messages/1-reference)

  ```
  <.test_alert_messages>
    <.test_alert is_success>
      Message 1
    </.test_alert>
    <.test_alert class="mt-4">
      Message 2
    </.test_alert>
  </.test_alert_messages>
  Rest of content
  ```

  [INSERT LVATTRDOCS]

  ## Reference

  [Primer/CSS Alerts](https://primer.style/css/components/alerts/)

  ## Status

  Feature complete.

  """

  attr(:class, :string, doc: "Additional classname.")

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the outer element.
    """
  )

  slot(:inner_block, required: true, doc: "Alert messages content.")

  def test_alert_messages(assigns) do
    class =
      Attributes.classnames([
        "flash-messages",
        assigns[:class]
      ])

    ~H"""
    <div class={class} {@rest}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  # ------------------------------------------------------------------------------------
  # layout
  # ------------------------------------------------------------------------------------

  @doc section: :layout

  @doc ~S"""
  Creates a responsive-friendly page layout with 2 columns.

  [Examples](#test_layout/1-examples) • [Attributes](#test_layout/1-attributes) • [Reference](#test_layout/1-reference)

  ```
  <.test_layout>
    <:main>
      Main content
    </:main>
    <:sidebar>
      Sidebar content
    </:sidebar>
  </.test_layout>
  ```

  ## Examples

  The position of the sidebar is set by CSS (and can be changed with attribute `is_sidebar_position_end`).

  To place the sidebar at the right:

  ```
  <.test_layout is_sidebar_position_end>
    <:main>
      Main content
    </:main>
    <:sidebar>
      Sidebar content
    </:sidebar>
  </.test_layout>
  ```

  When using a divider, use attribute `is_divided` to make the divider element visible.

  Extra divider modifiers for vertical layout (on small screens):

  - `is_divided` creates a 1px border between main and sidebar
  - `is_divided` with `is_flow_row_hidden` hides the divider
  - `is_divided` with `is_flow_row_shallow` shows a filled 8px divider


  ```
  <.test_layout is_divided>
    <:main>
      Main content
    </:main>
    <:divider></:divider>
    <:sidebar>
      Sidebar content
    </:sidebar>
  </.test_layout>
  ```

  The modifiers `is_centered_xx` create a wrapper around `main` to center its content up to a maximum width.
  Use with `.container-xx` classes to restrict the size of the content:

  ```
  <.test_layout is_centered_md>
    <:main>
      <div class="container-md">
        Centered md
      </div>
    </:main>
    <:sidebar>
      Sidebar content
    </:sidebar>
  </.test_layout>
  ```

  Layouts can be nested.

  Nested layout, example 1:

  ```
  <.test_layout>
    <:main>
      <.test_layout is_sidebar_position_end is_narrow_sidebar>
        <:main>
          Main content
        </:main>
        <:sidebar>
          Metadata sidebar
        </:sidebar>
      </.test_layout>
    </:main>
    <:sidebar>
      Default sidebar
    </:sidebar>
  </.test_layout>
  ```

  Nested layout, example 2:

  ```
  <.test_layout>
    <:main>
      <.test_layout is_sidebar_position_end is_flow_row_until_lg is_narrow_sidebar>
        <:main>
          Main content
        </:main>
        <:sidebar>
          Metadata sidebar
        </:sidebar>
      </.test_layout>
    </:main>
    <:sidebar>
      Default sidebar
    </:sidebar>
  </.test_layout>
  ```

  [INSERT LVATTRDOCS]

  ## Reference

  [Primer/CSS Layout](https://primer.style/css/components/layout/)

  ## Status

  Feature complete.

  """

  attr(:class, :string, doc: "Additional classname.")

  attr(:is_divided, :boolean,
    default: false,
    doc:
      "Use `is_divided` in conjunction with the `layout_item/1` element with attribute `divider` to show a divider between the main content and the sidebar. Creates a 1px line between main and sidebar."
  )

  attr(:is_narrow_sidebar, :boolean,
    default: false,
    doc: "Smaller sidebar size. Widths: md: 240px, lg: 256px."
  )

  attr(:is_wide_sidebar, :boolean,
    default: false,
    doc: "Wider sidebar size. Widths: md: 296px, lg: 320px, xl: 344px."
  )

  attr(:is_gutter_none, :boolean, default: false, doc: "Changes the gutter size to 0px.")
  attr(:is_gutter_condensed, :boolean, default: false, doc: "Changes the gutter size to 16px.")

  attr(:is_gutter_spacious, :boolean,
    default: false,
    doc: "Changes the gutter sizes to: md: 16px, lg: 32px, xl: 40px."
  )

  attr(:is_sidebar_position_start, :boolean,
    default: false,
    doc: "Places the sidebar at the start (commonly at the left) (default)."
  )

  attr(:is_sidebar_position_end, :boolean,
    default: false,
    doc: "Places the sidebar at the end (commonly at the right)."
  )

  attr(:is_sidebar_position_flow_row_start, :boolean,
    default: false,
    doc: "When stacked, render the sidebar first (default)."
  )

  attr(:is_sidebar_position_flow_row_end, :boolean,
    default: false,
    doc: "When stacked, render the sidebar last."
  )

  attr(:is_sidebar_position_flow_row_none, :boolean,
    default: false,
    doc: "When stacked, hide the sidebar."
  )

  attr(:is_flow_row_until_md, :boolean, default: false, doc: "Stacks when container is md.")
  attr(:is_flow_row_until_lg, :boolean, default: false, doc: "Stacks when container is lg.")

  attr(:is_centered_lg, :boolean,
    default: false,
    doc: "Creates a wrapper around `main` to keep its content centered up to max width \"lg\"."
  )

  attr(:is_centered_md, :boolean,
    default: false,
    doc: "Creates a wrapper around `main` to keep its content centered up to max width \"md\"."
  )

  attr(:is_centered_xl, :boolean,
    default: false,
    doc: "Creates a wrapper around `main` to keep its content centered up to max width \"xl\"."
  )

  attr(:is_flow_row_hidden, :boolean,
    default: false,
    doc: "On a small screen (up to 544px). Hides the horizontal divider."
  )

  attr(:is_flow_row_shallow, :boolean,
    default: false,
    doc: "On a small screen (up to 544px). Creates a filled 8px horizontal divider."
  )

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the outer element.
    """
  )

  slot :main,
    doc:
      "Creates a main element. Default gutter sizes: md: 16px, lg: 24px (change with `is_gutter_none`, `is_gutter_condensed` and `is_gutter_spacious`). Stacks when container is `sm` (change with `is_flow_row_until_md` and `is_flow_row_until_lg`)." do
    attr(:order, :integer,
      doc:
        "Markup order, defines in what order the slot is rendered in HTML. Keyboard navigation follows the markup order. Decide carefully how the focus order should be be by deciding whether main or sidebar comes first in code. The markup order won't affect the visual position. Possible values: 1 or 2; default value: 2."
    )
  end

  slot(:divider,
    doc:
      "Creates a divider element. The divider will only be shown with option `is_divided`. Creates a line between the main and sidebar elements - horizontal when the elements are stacked and vertical when they are shown side by side."
  )

  slot :sidebar,
    doc:
      "Creates a sidebar element. Widths: md: 256px, lg: 296px (change with `is_narrow_sidebar` and `is_wide_sidebar`)." do
    attr :order, :integer, doc: "See `main` slot. Default value: 1."
  end

  def test_layout(assigns) do
    classes = %{
      layout:
        Attributes.classnames([
          "Layout",
          assigns[:class],
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
        ]),
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

    default_slot_order = %{
      sidebar: 1,
      main: 2
    }

    sortable_slots = [
      main: assigns.main,
      sidebar: assigns.sidebar
    ]

    sorted_slots =
      sortable_slots
      # Remove empty slots
      |> Enum.filter(fn {_key, slot_list} -> slot_list !== [] end)
      # Translate user input to an order number (integer) and sort by order number
      |> Enum.sort_by(
        fn {key, slot_list} ->
          order =
            slot_list
            |> Enum.at(0)
            |> Map.get(:order)
            |> Attributes.as_integer(default_slot_order[key])

          order
        end,
        :asc
      )

    # Insert the divider slot if it can be inserted between 2 slots
    slots =
      case Enum.count(sorted_slots) == 2 do
        true -> List.insert_at(sorted_slots, 1, {:divider, assigns.divider})
        false -> sorted_slots
      end

    ~H"""
    <div class={classes.layout} {@rest}>
      <%= for {key, slot} <- slots do %>
        <%= if key == :main && slot !== [] do %>
          <%= if @is_centered_md || @is_centered_lg || @is_centered_xl do %>
            <div class={classes.main}>
              <div class={classes.main_center_wrapper}>
                <%= render_slot(slot) %>
              </div>
            </div>
          <% else %>
            <div class={classes.main}>
              <%= render_slot(slot) %>
            </div>
          <% end %>
        <% end %>
        <%= if key == :divider && slot !== [] do %>
          <div class={classes.divider}>
            <%= render_slot(slot) %>
          </div>
        <% end %>
        <%= if key == :sidebar && slot !== [] do %>
          <div class={classes.sidebar}>
            <%= render_slot(@sidebar) %>
          </div>
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

  [Examples](#test_box/1-examples) • [Attributes](#test_box/1-attributes) • [Reference](#test_box/1-reference)

  A `box` is a container with rounded corners, a white background, and a light gray border.
  By default, there are no other styles, such as padding; however, these can be introduced
  with utility classes as needed.

  ```
  <.test_box>
    Content
  </.test_box>
  ```

  Slots allow for the creation of alternative styles and layouts.

  ```
  <.test_box>
    <:header>Header</:header>
    <:body>Body</:body>
    <:row>Row</:row>
    <:footer>Footer</:footer>
  </.test_box>
  ```

  ## Examples

  Row themes:

  ```
  <.test_box>
    <:row is_gray>Row</:row>
    <:row is_hover_gray>Row</:row>
    <:row is_yellow>Row</:row>
    <:row is_hover_blue>Row</:row>
    <:row is_blue>Row</:row>
  </.test_box>
  ```

  Box theme - "danger box":

  ```
  <.test_box is_danger>
    <:row>Row</:row>
    <:row>Row</:row>
  </.test_box>
  ```

  Header theme - blue header:

  ```
  <.box>
    <:header is_blue>Blue header</:header>
  </.box>
  ```

  Render a row for each search result:

  ```
  <.test_box>
    <:row :for={result <- @results}>
      <%= result %>
    </:row>
  </.test_box>
  ```

  Conditionally show an alert:

  ```
   <.test_box>
    <.alert :if={@show_alert}>Alert message</.alert>
    <:body>
      Body
    </:body>
  </.test_box>
  ```

  Header title. Slot `header` can be omitted:

  ```
  <.test_box>
    <:header_title>
      Title
    </:header_title>
    Content
  </.test_box>
  ```

  Header with a button, using both `header` and `header_title` slots. The title will be inserted as first header element:

  ```
  <.test_box>
    <:header class="d-flex flex-items-center">
      <.test_button is_primary is_smmall>
        Button
      </.test_button>
    </:header>
    <:header_title class="flex-auto">
      Title
    </:header_title>
    <:body>
      Rest
    </:body>
  </.test_box>
  ```

  Header with icon button:

  ```
  <.test_box>
    <:header class="d-flex flex-justify-between flex-items-start">
      <.test_button is_close_button aria-label="Close" class="flex-shrink-0 pl-4">
        <.octicon name="x-16" />
      </.test_button>
    </:header>
    <:header_title>
      A very long title that wraps onto multiple lines without overlapping or wrapping underneath the icon to it's right
    </:header_title>
    <:body>Content</:body>
  </.test_box>
  ```

  [INSERT LVATTRDOCS]

  ## Reference

  [Primer/CSS Box](https://primer.style/css/components/box/)

  ## Status

  Feature complete.

  """

  attr(:class, :string, doc: "Additional classname.")

  attr(:is_blue, :boolean,
    default: false,
    doc: "Creates a blue box theme."
  )

  attr(:is_danger, :boolean,
    default: false,
    doc: "Creates a danger color box theme. Only works with slots `row` and `body`."
  )

  attr(:is_border_dashed, :boolean,
    default: false,
    doc: "Applies a dashed border to the box."
  )

  attr(:is_condensed, :boolean,
    default: false,
    doc: "Condenses line-height and reduces the padding on the Y axis."
  )

  attr(:is_spacious, :boolean,
    default: false,
    doc: "Increases padding and increases the title font size."
  )

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the outer element.
    """
  )

  slot :header,
    doc: "Creates a header row element." do
    attr :class, :string, doc: "Additional classname."
    attr :is_blue, :boolean, doc: "Change the header border and background to blue."
  end

  slot :header_title,
    doc:
      "Creates a title within the header. If no header slot is passed, the header title will be wrapped inside a header element." do
    attr :class, :string, doc: "Additional classname."
  end

  slot :row,
    doc: "Creates a content row element." do
    attr :class, :string, doc: "Additional classname."
    attr :is_blue, :boolean, doc: "Blue row theme."
    attr :is_gray, :boolean, doc: "Gray row theme."
    attr :is_yellow, :boolean, doc: "Yellow row theme."
    attr :is_hover_blue, :boolean, doc: "Changes to blue row theme on hover."
    attr :is_hover_gray, :boolean, doc: "Changes to gray row theme on hover."
    attr :is_focus_blue, :boolean, doc: "Changes to blue row theme on focus."
    attr :is_focus_gray, :boolean, doc: "Changes to gray row theme on focus."

    attr :is_navigation_focus, :boolean,
      doc: "Combine with a theme color to highlight the row when using keyboard commands."

    attr :is_unread, :boolean,
      doc: "Apply a blue vertical line highlight for indicating a row contains unread items."

    attr :is_link, :boolean, doc: "Use with link attributes such as \"href\" to generate a link."

    attr(:rest, :global,
      doc: """
      Additional HTML attributes added to the row element.
      """
    )
  end

  slot :body,
    doc: "Creates a body element." do
    attr :class, :string, doc: "Additional classname."
  end

  slot :footer,
    doc: "Creates a footer row element." do
    attr :class, :string, doc: "Additional classname."
  end

  def test_box(assigns) do
    assigns =
      assigns
      |> assign(
        :header_slots,
        Enum.zip(Attributes.pad_lists(assigns.header, assigns.header_title, []))
      )

    classes = %{
      box:
        Attributes.classnames([
          "Box",
          assigns[:class],
          assigns.is_blue and "Box--blue",
          assigns.is_border_dashed and "border-dashed",
          assigns.is_condensed and "Box--condensed",
          assigns.is_danger and "Box--danger",
          assigns.is_spacious and "Box--spacious"
        ]),
      header: fn slot ->
        Attributes.classnames([
          "Box-header",
          slot[:class],
          slot[:is_blue] && "Box-header--blue"
        ])
      end,
      row: fn slot ->
        Attributes.classnames([
          "Box-row",
          slot[:class],
          slot[:is_blue] && "Box-row--blue",
          slot[:is_focus_blue] && "Box-row--focus-blue",
          slot[:is_focus_gray] && "Box-row--focus-gray",
          slot[:is_gray] && "Box-row--gray",
          slot[:is_hover_blue] && "Box-row--hover-blue",
          slot[:is_hover_gray] && "Box-row--hover-gray",
          slot[:is_navigation_focus] && "navigation-focus",
          slot[:is_yellow] && "Box-row--yellow",
          slot[:is_unread] && "Box-row--unread"
        ])
      end,
      body: fn slot ->
        Attributes.classnames([
          "Box-body",
          slot[:class]
        ])
      end,
      footer: fn slot ->
        Attributes.classnames([
          "Box-footer",
          slot[:class]
        ])
      end,
      header_title: fn slot ->
        Attributes.classnames([
          "Box-title",
          slot[:class]
        ])
      end,
      link: "Box-row-link"
    }

    attributes = %{
      link: fn slot ->
        Attributes.append_attributes(
          assigns_to_attributes(slot, [
            :class,
            :is_blue,
            :is_focus_blue,
            :is_focus_gray,
            :is_gray,
            :is_hover_blue,
            :is_hover_gray,
            :is_link,
            :is_navigation_focus,
            :is_unread,
            :is_yellow
          ]),
          [
            [
              class:
                Attributes.classnames([
                  classes.link
                ])
            ]
          ]
        )
      end
    }

    render_header = fn data ->
      ~H"""
      <%= for {slot, header_slot} <- data do %>
        <div class={classes.header.(slot)}>
          <%= if header_slot && header_slot !== [] do %>
            <h3 class={classes.header_title.(header_slot)}>
              <%= render_slot(header_slot) %>
            </h3>
          <% end %>
          <%= if slot && slot !== [] do %>
            <%= render_slot(slot) %>
          <% end %>
        </div>
      <% end %>
      """
    end

    render_row = fn slots ->
      ~H"""
      <%= for slot <- slots do %>
        <div class={classes.row.(slot)}>
          <%= if slot[:is_link] do %>
            <a {attributes.link.(slot)}><%= render_slot(slot) %></a>
          <% else %>
            <%= render_slot(slot) %>
          <% end %>
        </div>
      <% end %>
      """
    end

    render_body = fn slots ->
      ~H"""
      <%= for slot <- slots do %>
        <div class={classes.body.(slot)}>
          <%= render_slot(slot) %>
        </div>
      <% end %>
      """
    end

    render_footer = fn slots ->
      ~H"""
      <%= for slot <- slots do %>
        <div class={classes.footer.(slot)}>
          <%= render_slot(slot) %>
        </div>
      <% end %>
      """
    end

    ~H"""
    <div class={classes.box} {@rest}>
      <%= if @header_slots && @header_slots !== [] do %>
        <%= render_header.(@header_slots) %>
      <% end %>
      <%= render_slot(@inner_block) %>
      <%= if @body && @body !== [] do %>
        <%= render_body.(@body) %>
      <% end %>
      <%= if @row && @row !== [] do %>
        <%= render_row.(@row) %>
      <% end %>
      <%= if @footer && @footer !== [] do %>
        <%= render_footer.(@footer) %>
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

  [Examples](#test_button/1-examples) • [Attributes](#test_button/1-attributes) • [Reference](#test_button/1-reference)

  ```
  <.test_button>Click me</.test_button>
  ```

  ## Examples

  _button examples_

  Primary button:

  ```
  <.test_button is_primary>Sign in</.test_button>
  ```

  Small  button:

  ```
  <.test_button is_small>Edit</.test_button>
  ```

  Selected  button:

  ```
  <.test_button is_selected>Unread</.test_button>
  ```

  Button with icon:
  ```
  <.test_button is_primary>
    <.octicon name="download-16" />
    <span>Clone</span>
    <span class="dropdown-caret"></span>
  </.test_button>
  ```

  Icon-only  button:
  ```
  <.test_button is_icon_only aria-label="Desktop">
    <.octicon name="device-desktop-16" />
  </.test_button>
  ```

  Use `test_button_group/1` to create a group of buttons:

  ```
  <.test_button_group>
    <.button_group_item>Button 1</.button_group_item>
    <.button_group_item>Button 2</.button_group_item>
    <.button_group_item>Button 3</.button_group_item>
  </.test_button_group>
  ```

  [INSERT LVATTRDOCS]

  ## Reference

  [Primer/CSS Buttons](https://primer.style/css/components/buttons/)

  ## Status

  Feature complete.

  """

  attr :class, :string, doc: "Additional classname."
  attr :is_full_width, :boolean, default: false, doc: "Creates a full-width button."

  attr :is_close_button, :boolean,
    default: false,
    doc: "Use when enclosing icon \"x-16\". This setting removes the default padding."

  attr :is_danger, :boolean, default: false, doc: "Creates a red button."
  attr :is_disabled, :boolean, default: false, doc: "Creates a disabled button."

  attr :is_icon_only, :boolean,
    default: false,
    doc: "Creates an icon button without a label. Add `is_danger` to create a danger icon."

  attr :is_invisible, :boolean,
    default: false,
    doc: "Create a button that looks like a link, maintaining the paddings of a regular button."

  attr :is_large, :boolean, default: false, doc: "Creates a large button."
  attr :is_link, :boolean, default: false, doc: "Create a button that looks like a link."
  attr :is_outline, :boolean, default: false, doc: "Creates an outline button."
  attr :is_primary, :boolean, default: false, doc: "Creates a primary colored button."
  attr :is_selected, :boolean, default: false, doc: "Creates a selected button."
  attr :is_small, :boolean, default: false, doc: "Creates a small button."
  attr :is_submit, :boolean, default: false, doc: "Creates a button with type=\"submit\"."

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the button element.
    """
  )

  slot(:inner_block, required: true, doc: "Button content.")

  def test_button(assigns) do
    assigns =
      assigns
      |> assign(:type, if(assigns.is_submit, do: "submit", else: "button"))

    class =
      Attributes.classnames([
        !assigns.is_link and !assigns.is_icon_only and !assigns.is_close_button and "btn",
        assigns[:class],
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
        assigns.is_full_width and "btn-block",
        assigns.is_invisible and "btn-invisible",
        assigns.is_close_button and "close-button"
      ])

    aria_attributes =
      Attributes.get_aria_attributes(
        is_selected: assigns.is_selected,
        is_disabled: assigns.is_disabled
      )

    ~H"""
    <button class={class} type={@type} {@rest} {aria_attributes}>
      <%= render_slot(@inner_block) %>
    </button>
    """
  end

  # ------------------------------------------------------------------------------------
  # test_button_group
  # ------------------------------------------------------------------------------------

  @doc section: :buttons

  @doc ~S"""
  Creates a group of buttons.

  [Examples](#test_button_group/1-examples) • [Attributes](#test_button_group/1-attributes) • [Reference](#test_button_group/1-reference)

  ```
  <.test_button_group>
    <:button>Button 1</:button>
    <:button>Button 2</:button>
    <:button>Button 3</:button>
  </.test_button_group>
  ```

  ## Examples

  Use button slots while passing button attributes to create the button row:

  ```
  <.test_button_group>
    <:button>Button 1</:button>
    <:button is_selected>Button 2</:button>
    <:button is_danger>Button 3</:button>
    <:button class="my-button">Button 4</:button>
  </.test_button_group>
  ```

  [INSERT LVATTRDOCS]

  ## Reference

  [Primer/CSS Button groups](https://primer.style/css/components/buttons#button-groups)

  ## Status

  Feature complete.

  """

  attr :class, :string, doc: "Additional classname."

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the outer element.
    """
  )

  slot(:button,
    required: true,
    doc:
      "Button. Use `test_button/1` attributes to configure the button appearance and behaviour."
  )

  def test_button_group(assigns) do
    classes = %{
      button_group:
        Attributes.classnames([
          "BtnGroup",
          assigns[:class]
        ]),
      button: fn slot ->
        Attributes.classnames([
          "BtnGroup-item",
          slot[:class]
        ])
      end
    }

    ~H"""
    <div class={classes.button_group} {@rest}>
      <%= for slot <- @button do %>
        <.test_button {slot} class={classes.button.(slot)}>
          <%= render_slot(slot) %>
        </.test_button>
      <% end %>
    </div>
    """
  end

  # ------------------------------------------------------------------------------------
  # pagination
  # ------------------------------------------------------------------------------------

  @doc section: :pagination

  @doc ~S"""
  Creates a control to navigate search results.

  [Examples](#test_pagination/1-examples) • [Attributes](#test_pagination/1-attributes) • [Reference](#test_pagination/1-reference)

  ```
  <.test_pagination
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

  Simplified paginations, showing Next / Previous buttons:

  ```
  <.test_pagination
    ...
    is_numbered="false"
  />
  ```

  Configure the number of sibling and boundary page numbers to show:

  ```
  <.test_pagination
    ...
    sibling_count="1"
    boundary_count="1"
  />
  ```

  Provide custom labels:

  ```
  <.test_pagination
    ...
    labels={
      %{
        next_page: "Nächste Seite",
        previous_page: "Vorherige Seite"
      }
    }
  />
  ```

  [INSERT LVATTRDOCS]

  ### Reference

  [Primer/CSS Pagination](https://primer.style/css/components/pagination/)

  ## Status

  - CSS: feature complete.
  - React behaviour not yet implemented: "The algorithm tries to minimize the amount the component shrinks and grows as the user changes pages; for this reason, if any of the pages in the margin (controlled via marginPageCount) intersect with pages in the center (controlled by surroundingPageCount), the center section will be shifted away from the margin."

  """

  attr :page_count, :integer, required: true, doc: "Result page count."
  attr :current_page, :integer, required: true, doc: "Current page number."

  attr :link_path, :any,
    required: true,
    doc:
      "Function that returns a path for the given page number. The link builder uses `live_redirect`. Extra options can be passed with `link_options`. Function signature: `(page_number) -> path`"

  attr :boundary_count, :integer, default: 2, doc: "Number of page links at both ends."

  attr :sibling_count, :integer,
    default: 2,
    doc: "Number of page links at each side of the current page number element."

  attr :is_numbered, :boolean, default: true, doc: "Showing page numbers."
  attr :class, :string, doc: "Additional classname."

  attr :classes, :map,
    default: %{
      gap: "",
      pagination_container: "",
      pagination: "",
      previous_page: "",
      next_page: "",
      page: ""
    },
    doc:
      "Additional classnames for pagination elements. Any provided value will be appended to the default classname."

  @default_pagination_labels %{
    aria_label_container: "Navigation",
    aria_label_next_page: "Next page",
    aria_label_page: "Page {page_number}",
    aria_label_previous_page: "Previous page",
    gap: "…",
    next_page: "Next",
    previous_page: "Previous"
  }

  attr :labels, :map,
    default: @default_pagination_labels,
    doc: "Textual labels. Any provided value will override the default text."

  @default_pagination_link_options %{
    replace: false
  }

  attr :link_options, :map, default: @default_pagination_link_options, doc: "Link options."

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the outer element.
    """
  )

  def test_pagination(assigns) do
    assigns =
      assigns
      |> assign(:page_count, Attributes.as_integer(assigns.page_count) |> max(0))
      |> assign(
        :current_page,
        Attributes.as_integer(assigns.current_page) |> max(1)
      )
      |> assign(
        :boundary_count,
        Attributes.as_integer(assigns.boundary_count) |> Attributes.minmax(1, 3)
      )
      |> assign(
        :sibling_count,
        Attributes.as_integer(assigns.sibling_count) |> Attributes.minmax(1, 5)
      )
      |> assign(
        :is_numbered,
        Attributes.as_boolean(assigns.is_numbered)
      )
      |> assign(
        :labels,
        Map.merge(@default_pagination_labels, assigns.labels)
      )

    %{
      page_count: page_count,
      current_page: current_page,
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
          assigns[:class],
          assigns[:classes][:pagination_container]
        ]),
      pagination:
        Attributes.classnames([
          "pagination",
          assigns[:classes][:pagination]
        ]),
      previous_page:
        Attributes.classnames([
          "previous_page",
          assigns[:classes][:previous_page]
        ]),
      next_page:
        Attributes.classnames([
          "next_page",
          assigns[:classes][:next_page]
        ]),
      page:
        Attributes.classnames([
          assigns[:classes][:page]
        ]),
      gap:
        Attributes.classnames([
          "gap",
          assigns[:classes][:gap]
        ])
    }

    pagination_elements =
      test_get_pagination_numbers(
        page_count,
        current_page,
        boundary_count,
        sibling_count
      )

    ~H"""
    <%= if @page_count > 1 do %>
      <nav class={classes.pagination_container} {@rest} aria-label={@labels.aria_label_container}>
        <div class={classes.pagination}>
          <%= if show_prev_next do %>
            <%= if has_previous_page do %>
              <.link
                navigate={@link_path.(current_page - 1)}
                class={classes.previous_page}
                rel="previous"
                aria-label={@labels.aria_label_previous_page}
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
                    aria-label={
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
                aria-label={@labels.aria_label_next_page}
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
    <% end %>
    """
  end

  # Get the list of page number elements
  @doc false

  def test_get_pagination_numbers(
        page_count,
        current_page,
        boundary_count,
        sibling_count
      )
      when page_count == 0,
      do:
        test_get_pagination_numbers(
          1,
          current_page,
          boundary_count,
          sibling_count
        )

  def test_get_pagination_numbers(
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

  [Examples](#test_octicon/1-examples) • [Attributes](#test_octicon/1-attributes) • [Reference](#test_octicon/1-reference)

  ```
  <.test_octicon name="comment-16" />
  ```

  ## Examples

  Pass the icon name with the size: icon "alert-fill" with size "12" becomes "alert-fill-12":

  ```
  <.test_octicon name="alert-fill-12" />
  ```

  Icon "pencil" with size 24:

  ```
  <.test_octicon name="pencil-24" />
  ```

  Custom class:

  ```
  <.test_octicon name="pencil-24" class="app-icon" />
  ```

  [INSERT LVATTRDOCS]

  ### Reference

  - [List of Primer icons](https://primer.style/octicons/)
  - [Primer/Octicons Usage](https://primer.style/octicons/guidelines/usage)

  ## Status

  Feature complete.

  """

  attr :name, :string,
    required: true,
    doc:
      "Icon name, e.g. \"arrow-left-24\". See [available icons](https://primer.style/octicons/)."

  attr :class, :string, doc: "Additional classname."

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the icon svg element.
    """
  )

  def test_octicon(assigns) do
    icon_fn = PrimerLive.Octicons.name_to_function() |> Map.get(assigns.name)

    case is_function(icon_fn) do
      true ->
        render_octicon(icon_fn, assigns)

      false ->
        ~H"""
        Icon with name <%= @name %> does not exist.
        """
    end
  end

  defp render_octicon(icon_fn, assigns) do
    assigns =
      assigns
      |> assign(
        :class,
        Attributes.classnames([
          "octicon",
          assigns[:class]
        ])
      )

    icon_fn.(assigns)
  end
end
