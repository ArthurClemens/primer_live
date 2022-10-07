defmodule PrimerLive.Component do
  use Phoenix.Component
  use Phoenix.HTML

  alias PrimerLive.Helpers.{AttributeHelpers, FormHelpers, SchemaHelpers, ComponentHelpers}

  # ------------------------------------------------------------------------------------
  # text_input
  # ------------------------------------------------------------------------------------

  @doc section: :forms

  @doc ~S"""
  Creates a text input field.

  Wrapper around `Phoenix.HTML.Form.text_input/3`, optionally wrapped itself inside a "form group" to add a field label and validation.

  [Examples](#text_input/1-examples) • [Attributes](#text_input/1-attributes) • [Reference](#text_input/1-reference)

  ```
  <.text_input name="first_name" />
  ```

  ## Examples

  Set the input type:

  ```
  <.text_input type="password" />
  ```

  Set the placeholder. By default, the value of the placeholder attribute is used to fill in the aria-label attribute:

  ```
  <.text_input placeholder="Enter your first name" />
  ```

  Using the input with form data:

  ```
  <.form let={f} for={@changeset} phx-change="validate" phx-submit="save">
    <.text_input form={f} field={:first_name} is_group />
    <.text_input form={f} field={:last_name} is_group />
  </.form>
  ```

  Insert the input within a form group using `is_group`. This will insert the input inside a form group with a default generated label and field validation. To configure the form group, use the [`group` slot](#text_input/1-slots) instead.

  ```
  <.text_input form={:user} field={:first_name} is_group />
  ```

  Use a custom label by providing `label`:

  ```
  <.text_input form={:user} field={:first_name}>
    <:group label="Some label" />
  </.text_input>
  ```

  Add markup to the label with attribute `:let` to get the label tag:

  ```
  <.text_input form={:user} field={:first_name}>
    <:group label="Some label" :let={field}>
      <h2><%= field.label %></h2>
    </:group>
  </.text_input>
  ```

  This generates:

  ```
  <h2><label for="user_first_name">Some label</label></h2>
  ```

  Field data passed to `:let` also contains the `field_state`:

  ```
  <.text_input form={:user} field={:first_name}>
    <:group :let={field} label="Some label">
      <h2>
        <%= if !field.field_state.valid? do %>
          <div>Please correct your input</div>
        <% end %>

        <%= field.label %>
      </h2>
    </:group>
  </.text_input>
  ```

  With a form changeset, write a custom error message:

  ```
  <.text_input form={f} field={:first_name}>
    <:group validation_message={
      fn field_state ->
        if !field_state.valid?, do: "Please enter your first name"
      end
    }>
    </:group>
  </.text_input>
  ```

  With a form changeset, write a custom success message:

  ```
  <.text_input form={f} field={:first_name}>
    <:group validation_message={
      fn field_state ->
        if changeset.valid?, do: "Complete"
      end
    }>
    </:group>
  </.text_input>
  ```

  [INSERT LVATTRDOCS]

  ## :let

  ```
  <:group :let={field} />
  ```

  Yields a map with fields:
  - `label` - Generated label from `Phoenix.HTML.Form.label/2`
  - `field_state` - `PrimerLive.FieldState` struct

  ## Reference

  [Primer/CSS Forms](https://primer.style/css/components/forms)

  ## Status

  Feature complete.

  """

  attr :field, :any, doc: "Field name (atom or string)."

  attr :form, :any,
    doc:
      "Either a [Phoenix.HTML.Form](https://hexdocs.pm/phoenix_html/Phoenix.HTML.Form.html) or an atom."

  attr(:class, :string, default: nil, doc: "Additional classname.")

  attr(:classes, :map,
    default: %{
      group: nil,
      header: nil,
      body: nil,
      label: nil,
      input: nil,
      note: nil
    },
    doc: """
    Additional classnames for form group elements.

    Any provided value will be appended to the default classname.

    Default map:
    ```
    %{
      group: "",  # Form group element
      header: "", # Header element containing the input label
      body: "",   # Input wrapper
      label: "",  # Input label
      input: "",  # Input element
      note: ""    # Validation message container
    }
    ```
    """
  )

  attr(:type, :string, default: "text", doc: "Text input type.")
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
    doc: "Within a `group` slot. Creates an input with a reduced width."
  )

  attr(:is_group, :boolean,
    default: false,
    doc: """
    Inserts the input inside a form group and creates a default field label.

    To configure the form group and label, see [slot `group`](#text_input/1-slots).
    """
  )

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the input (or if applicable, the form group) element.
    """
  )

  slot :group,
    doc: """
    Insert the input inside a form group.

    Yields: see [:let](#text_input/1-let).

    """ do
    attr(:label, :string,
      doc: """
      Group label. Will be wrapped inside a `<label>` tag. This label tag is provided by attribute `:let` and can be integrated in other HTML markup.

      The examples below assume form `:user` and field `:first_name`.

      Without an `inner_block`, the generated label will be used:
      ```
      <:group label="Some label" />
      ```

      This generates:
      ```
      <label for="user_first_name">Some label</label>
      ```

      With an `inner_block`, `field` data can be retrieved from attribute `:let`:
      ```
      <:group
        label="Some label"
        :let={field}
      >
        <h2><%= field.label %></h2>
      </:group>
      ```

      This generates:
      ```
      <h2><label for="user_first_name">Some label</label></h2>
      ```

      To conditionally change the header dependent on field state, use `field_state`, `PrimerLive.FieldState` struct:
      ```
      <:group :let={field} label="Some label">
        <h2>
          <%= if !field.field_state.valid? do %>
            <div>Please correct your input</div>
          <% end %>

          <%= field.label %>
        </h2>
      </:group>
      ```

      """
    )

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
  end

  def text_input(assigns) do
    with true <- validate_is_form(assigns),
         true <- validate_is_short_with_form_group(assigns) do
      render_text_input(assigns)
    else
      {:error, reason} ->
        ~H"""
        <%= reason %>
        """
    end
  end

  defp render_text_input(assigns) do
    assigns =
      assigns
      |> assign(
        :class,
        AttributeHelpers.classnames([
          "form-control",
          assigns.is_contrast and "input-contrast",
          assigns.is_hide_webkit_autofill and "input-hide-webkit-autofill",
          assigns.is_large and "input-lg",
          assigns.is_small and "input-sm",
          assigns.is_short and "short",
          assigns.is_full_width and "input-block",
          assigns.class
        ])
      )

    render_form_group(assigns)
  end

  defp render_form_group(assigns) do
    type = assigns.type
    input_type = FormHelpers.input_type_as_atom(type)
    form = assigns[:form]
    field = assigns[:field]
    rest = assigns.rest

    # Get the first group slot, if any
    group_slot = if assigns[:group] && assigns[:group] !== [], do: hd(assigns[:group]), else: []

    # Get the field state from the group slot attributes
    field_state = FormHelpers.field_state(form, field, group_slot[:validation_message])
    %{message: message, message_id: message_id, valid?: valid?} = field_state

    has_group_slot = group_slot !== []
    has_group = assigns.is_group || has_group_slot

    initial_input_attrs = if has_group, do: [], else: rest

    input_attributes =
      AttributeHelpers.append_attributes(initial_input_attrs, [
        [class: [assigns.class, assigns.classes[:input]]],
        # If aria_label is not set, use the value of placeholder (if any):
        is_nil(rest[:aria_label]) and [aria_label: rest[:placeholder]],
        not is_nil(message_id) and [aria_describedby: message_id]
      ])

    input = apply(Phoenix.HTML.Form, input_type, [form, field, input_attributes])

    case has_group do
      false ->
        ~H"""
        <%= input %>
        """

      true ->
        classes = %{
          group:
            AttributeHelpers.classnames([
              "form-group",
              if !is_nil(message) do
                if valid? do
                  "successed"
                else
                  "errored"
                end
              end,
              group_slot[:class],
              assigns.classes[:group]
            ]),
          header:
            AttributeHelpers.classnames([
              "form-group-header",
              assigns.classes[:header]
            ]),
          label:
            AttributeHelpers.classnames([
              assigns.classes[:label]
            ]),
          input:
            AttributeHelpers.classnames([
              assigns.classes[:input]
            ]),
          body:
            AttributeHelpers.classnames([
              "form-group-body",
              assigns.classes[:body]
            ]),
          note:
            AttributeHelpers.classnames([
              "note",
              if valid? do
                "success"
              else
                "error"
              end,
              assigns.classes[:note]
            ])
        }

        # If label is supplied, wrap it inside a label
        # else use the default generated label
        header_label =
          if group_slot[:label] do
            label(form, field, group_slot[:label], class: classes.label)
          else
            label(form, field, class: classes.label)
          end

        # Data accessible by :let
        field = %{
          label: header_label,
          field_state: field_state
        }

        group_attributes =
          AttributeHelpers.append_attributes(rest, [
            [class: classes.group]
          ])

        ~H"""
        <div {group_attributes}>
          <div class={classes.header}>
            <%= render_slot(group_slot, field) |> ComponentHelpers.maybe_slot_content() || header_label %>
          </div>
          <div class={classes.body}>
            <%= input %>
          </div>
          <%= if not is_nil(message) do %>
            <p class={classes.note} id={message_id}>
              <%= message %>
            </p>
          <% end %>
        </div>
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

  # Validates that attribute `is_short` coexists with `group` slot.
  # Allowed values:
  # - nil
  # - any truthy value if group is also present
  defp validate_is_short_with_form_group(assigns) do
    is_short = assigns[:is_short]
    group = assigns[:group]
    is_group = assigns[:is_group]
    has_group = is_group || (!!group && group !== [])

    cond do
      !is_short -> true
      !!is_short && has_group -> true
      true -> {:error, "attr is_short: must be used in combination with a group slot"}
    end
  end

  # ------------------------------------------------------------------------------------
  # textarea
  # ------------------------------------------------------------------------------------

  @doc section: :forms

  @doc ~S"""
  Creates a textarea.

  ```
  <.textarea name="comments" />
  ```

  ## Attributes

  Use `text_input/1` attributes.

  ## Reference

  [Primer/CSS Forms](https://primer.style/css/components/forms)

  """

  def textarea(assigns) do
    assigns = assigns |> assign(:type, "textarea")
    text_input(assigns)
  end

  # ------------------------------------------------------------------------------------
  # alert
  # ------------------------------------------------------------------------------------

  @doc section: :alerts

  @doc ~S"""
  Creates an alert message.

  [Examples](#alert/1-examples) • [Attributes](#alert/1-attributes) • [Reference](#alert/1-reference)

  ```
  <.alert>
    Flash message goes here.
  </.alert>
  ```

  ## Examples

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

  To add an extra bottom margin to a stack of alerts, wrap the alerts in `alert_messages/1`.

  [INSERT LVATTRDOCS]

  ## Reference

  [Primer/CSS Alerts](https://primer.style/css/components/alerts/)

  ## Status

  To do:
  - Flash (page) banner

  """

  attr(:class, :string, doc: "Additional classname.")
  attr(:is_error, :boolean, default: false, doc: "Sets the color to \"error\".")
  attr(:is_success, :boolean, default: false, doc: "Sets the color to \"success\".")
  attr(:is_warning, :boolean, default: false, doc: "Sets the color to \"warning\".")

  attr(:is_full, :boolean,
    default: false,
    doc: "Renders the alert full width, with border and border radius removed."
  )

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the outer element.
    """
  )

  slot(:inner_block, required: true, doc: "Alert content.")

  def alert(assigns) do
    class =
      AttributeHelpers.classnames([
        "flash",
        assigns.is_error and "flash-error",
        assigns.is_success and "flash-success",
        assigns.is_warning and "flash-warn",
        assigns.is_full and "flash-full",
        assigns[:class]
      ])

    ~H"""
    <div class={class} {@rest}>
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

  [Attributes](#alert_messages/1-attributes) • [Reference](#alert_messages/1-reference)

  ```
  <.alert_messages>
    <.alert is_success>
      Message 1
    </.alert>
    <.alert class="mt-4">
      Message 2
    </.alert>
  </.alert_messages>
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

  def alert_messages(assigns) do
    class =
      AttributeHelpers.classnames([
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

  [Examples](#layout/1-examples) • [Attributes](#layout/1-attributes) • [Reference](#layout/1-reference)

  ```
  <.layout>
    <:main>
      Main content
    </:main>
    <:sidebar>
      Sidebar content
    </:sidebar>
  </.layout>
  ```

  ## Examples

  The position of the sidebar is set by CSS (and can be changed with attribute `is_sidebar_position_end`).

  To place the sidebar at the right:

  ```
  <.layout is_sidebar_position_end>
    <:main>
      Main content
    </:main>
    <:sidebar>
      Sidebar content
    </:sidebar>
  </.layout>
  ```

  When using a divider, use attribute `is_divided` to make the divider element visible.

  Extra divider modifiers for vertical layout (on small screens):

  - `is_divided` creates a 1px border between main and sidebar
  - `is_divided` with `is_flow_row_hidden` hides the divider
  - `is_divided` with `is_flow_row_shallow` shows a filled 8px divider


  ```
  <.layout is_divided>
    <:main>
      Main content
    </:main>
    <:divider></:divider>
    <:sidebar>
      Sidebar content
    </:sidebar>
  </.layout>
  ```

  The modifiers `is_centered_xx` create a wrapper around `main` to center its content up to a maximum width.
  Use with `.container-xx` classes to restrict the size of the content:

  ```
  <.layout is_centered_md>
    <:main>
      <div class="container-md">
        Centered md
      </div>
    </:main>
    <:sidebar>
      Sidebar content
    </:sidebar>
  </.layout>
  ```

  Layouts can be nested.

  Nested layout, example 1:

  ```
  <.layout>
    <:main>
      <.layout is_sidebar_position_end is_narrow_sidebar>
        <:main>
          Main content
        </:main>
        <:sidebar>
          Metadata sidebar
        </:sidebar>
      </.layout>
    </:main>
    <:sidebar>
      Default sidebar
    </:sidebar>
  </.layout>
  ```

  Nested layout, example 2:

  ```
  <.layout>
    <:main>
      <.layout is_sidebar_position_end is_flow_row_until_lg is_narrow_sidebar>
        <:main>
          Main content
        </:main>
        <:sidebar>
          Metadata sidebar
        </:sidebar>
      </.layout>
    </:main>
    <:sidebar>
      Default sidebar
    </:sidebar>
  </.layout>
  ```

  [INSERT LVATTRDOCS]

  ## Reference

  [Primer/CSS Layout](https://primer.style/css/components/layout/)

  ## Status

  Feature complete.

  """

  attr(:class, :string, doc: "Additional classname.")

  attr(:classes, :map,
    default: %{
      layout: nil,
      main: nil,
      main_center_wrapper: nil,
      sidebar: nil,
      divider: nil
    },
    doc: """
    Additional classnames for layout elements.

      Any provided value will be appended to the default classname.

      Default map:
      ```
      %{
        layout: "",               # Layout wrapper
        main: "",                 # Main element
        main_center_wrapper: "",  # Wrapper for displaying content centered
        sidebar: "",              # Sidebar element
        divider: "",              # Divider element
      }
      ```
    """
  )

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

  def layout(assigns) do
    classes = %{
      layout:
        AttributeHelpers.classnames([
          "Layout",
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
          assigns.is_flow_row_until_lg and "Layout--flowRow-until-lg",
          assigns.classes[:layout],
          assigns[:class]
        ]),
      main:
        AttributeHelpers.classnames([
          "Layout-main",
          assigns.classes[:main]
        ]),
      main_center_wrapper:
        AttributeHelpers.classnames([
          assigns.is_centered_md and "Layout-main-centered-md",
          assigns.is_centered_lg and "Layout-main-centered-lg",
          assigns.is_centered_xl and "Layout-main-centered-xl",
          assigns.classes[:main_center_wrapper]
        ]),
      sidebar:
        AttributeHelpers.classnames([
          "Layout-sidebar",
          assigns.classes[:sidebar]
        ]),
      divider:
        AttributeHelpers.classnames([
          "Layout-divider",
          assigns.is_flow_row_shallow and "Layout-divider--flowRow-shallow",
          assigns.is_flow_row_hidden and "Layout-divider--flowRow-hidden",
          assigns.classes[:divider]
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
            |> AttributeHelpers.as_integer(default_slot_order[key])

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

  @doc section: :box

  @doc ~S"""
  Creates a content container.

  [Examples](#box/1-examples) • [Attributes](#box/1-attributes) • [Reference](#box/1-reference)

  A `box` is a container with rounded corners, a white background, and a light gray border.
  By default, there are no other styles, such as padding; however, these can be introduced
  with utility classes as needed.

  ```
  <.box>
    Content
  </.box>
  ```

  Slots allow for the creation of alternative styles and layouts.

  ```
  <.box>
    <:header>Header</:header>
    <:body>Body</:body>
    <:row>Row</:row>
    <:footer>Footer</:footer>
  </.box>
  ```

  ## Examples

  Row themes:

  ```
  <.box>
    <:row is_gray>Row</:row>
    <:row is_hover_gray>Row</:row>
    <:row is_yellow>Row</:row>
    <:row is_hover_blue>Row</:row>
    <:row is_blue>Row</:row>
  </.box>
  ```

  Box theme - "danger box":

  ```
  <.box is_danger>
    <:row>Row</:row>
    <:row>Row</:row>
  </.box>
  ```

  Header theme - blue header:

  ```
  <.box>
    <:header is_blue>Blue header</:header>
  </.box>
  ```

  Render a row for each search result:

  ```
  <.box>
    <:row :for={result <- @results}>
      <%= result %>
    </:row>
  </.box>
  ```

  Conditionally show an alert:

  ```
   <.box>
    <.alert :if={@show_alert}>Alert message</.alert>
    <:body>
      Body
    </:body>
  </.box>
  ```

  Header title. Slot `header` can be omitted:

  ```
  <.box>
    <:header_title>
      Title
    </:header_title>
    Content
  </.box>
  ```

  Header with a button, using both `header` and `header_title` slots. The title will be inserted as first header element:

  ```
  <.box>
    <:header class="d-flex flex-items-center">
      <.button is_primary is_smmall>
        Button
      </.button>
    </:header>
    <:header_title class="flex-auto">
      Title
    </:header_title>
    <:body>
      Rest
    </:body>
  </.box>
  ```

  Header with icon button:

  ```
  <.box>
    <:header class="d-flex flex-justify-between flex-items-start">
      <.button is_close_button aria-label="Close" class="flex-shrink-0 pl-4">
        <.octicon name="x-16" />
      </.button>
    </:header>
    <:header_title>
      A very long title that wraps onto multiple lines without overlapping or wrapping underneath the icon to it's right
    </:header_title>
    <:body>Content</:body>
  </.box>
  ```

  Links can be placed inside rows. Use `:let` to get access to the `classes.link` class. With `Phoenix.Component.link/1`:

  ```
  <.box>
    <:row :let={classes}>
      <.link href="/" class={classes.link}>Home</.link>
    </:row>
  </.box>
  ```

  [INSERT LVATTRDOCS]

  ## :let

  ```
  <:item :let={classes} />
  ```

  Yields a `classes` map, containing the merged values of default classnames, plus any value supplied to the `classes` component attribute.

  ```
  <.box classes={%{ link: "link-x" }}>
    <:row :let={classes}>
      <.link href="/" class={["my-link", classes.link]}>Home</.link>
    </:row>
  </.box>
  ```

  Results in:

  ```
  <div class="Box">
    <div class="Box-row">
      <a href="/" class="my-link Box-row-link link-x">Home</a>
    </div>
  </div>
  ```

  ## Reference

  [Primer/CSS Box](https://primer.style/css/components/box/)

  ## Status

  Feature complete.

  """

  attr(:class, :string, doc: "Additional classname.")

  attr(:classes, :map,
    default: %{
      box: nil,
      header: nil,
      row: nil,
      body: nil,
      footer: nil,
      header_title: nil,
      link: nil
    },
    doc: """
    Additional classnames for layout elements.

      Any provided value will be appended to the default classname.

      Default map:
      ```
      %{
        box: "",          # Box element
        header: "",       # Box header row element
        row: "",          # Box content row element
        body: "",         # Content element
        footer: "",       # Footer row element
        header_title: "", # Title element within a header row
        link: "",         # Class for links
      }
      ```
    """
  )

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

  def box(assigns) do
    # Create a zip data structure from header and header_title slots, making sure the lists have equal counts
    assigns =
      assigns
      |> assign(
        :header_slots,
        Enum.zip(AttributeHelpers.pad_lists(assigns.header, assigns.header_title, []))
      )

    classes = %{
      box:
        AttributeHelpers.classnames([
          "Box",
          assigns.is_blue and "Box--blue",
          assigns.is_border_dashed and "border-dashed",
          assigns.is_condensed and "Box--condensed",
          assigns.is_danger and "Box--danger",
          assigns.is_spacious and "Box--spacious",
          assigns.classes[:box],
          assigns[:class]
        ]),
      header: fn slot ->
        AttributeHelpers.classnames([
          "Box-header",
          slot[:is_blue] && "Box-header--blue",
          assigns.classes[:header],
          slot[:class]
        ])
      end,
      row: fn slot ->
        AttributeHelpers.classnames([
          "Box-row",
          slot[:is_blue] && "Box-row--blue",
          slot[:is_focus_blue] && "Box-row--focus-blue",
          slot[:is_focus_gray] && "Box-row--focus-gray",
          slot[:is_gray] && "Box-row--gray",
          slot[:is_hover_blue] && "Box-row--hover-blue",
          slot[:is_hover_gray] && "Box-row--hover-gray",
          slot[:is_navigation_focus] && "navigation-focus",
          slot[:is_yellow] && "Box-row--yellow",
          slot[:is_unread] && "Box-row--unread",
          assigns.classes[:row],
          slot[:class]
        ])
      end,
      body: fn slot ->
        AttributeHelpers.classnames([
          "Box-body",
          assigns.classes[:body],
          slot[:class]
        ])
      end,
      footer: fn slot ->
        AttributeHelpers.classnames([
          "Box-footer",
          assigns.classes[:footer],
          slot[:class]
        ])
      end,
      header_title: fn slot ->
        AttributeHelpers.classnames([
          "Box-title",
          assigns.classes[:header_title],
          slot[:class]
        ])
      end,
      link: AttributeHelpers.classnames(["Box-row-link", assigns.classes[:link]])
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
          <%= render_slot(slot, classes) %>
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
  # header
  # ------------------------------------------------------------------------------------

  @doc section: :header

  @doc ~S"""
  Creates a navigational header, to be placed at the top of the page.

  ```
  <.header>
    <:item>Item 1</:item>
    <:item>Item 2</:item>
    <:item>Item 3</:item>
  </.header>
  ```

  ## Examples

  Stretch an item with attribute `is_full`:

  ```
   <:item is_full>Stretched item</:item>
  ```

  A space can also be generated with an "empty" item:

  ```
  <:item is_full />
  ```

  Links can be placed inside items. Use `:let` to get access to the `classes.link` class. With `Phoenix.Component.link/1`:

  ```
  <:item :let={classes}>
    <.link href="/" class={classes.link}>Regular anchor link</.link>
  </:item>
  <:item :let={classes}>
    <.link navigate={Routes.page_path(@socket, :index)} class={[classes.link, "underline"]}>Home</.link>
  </:item>
  ```

  Inputs can be placed in the same way, using `:let` to get access to the `classes.input` class:

  ```
  <:item :let={classes}>
    <.text_input form={:user} field={:first_name} type="search" class={classes.input} />
  </:item>
  ```

  [INSERT LVATTRDOCS]

  ## :let

  ```
  <:item :let={classes} />
  ```

  Yields a `classes` map, containing the merged values of default classnames, plus any value supplied to the `classes` component attribute.

  ```
  <.header classes={%{ link: "link-x" }}>
    <:item :let={classes}>
      <.link href="/" class={["my-link", classes.link]}>Home</.link>
    </:item>
  </.header>
  ```

  Results in:

  ```
  <div class="Header">
    <div class="Header-item">
      <a href="/" class="my-link Header-link link-x">Home</a>
    </div>
  </div>
  ```

  ## Reference

  [Primer/CSS Header](https://primer.style/css/components/header/)

  ## Status

  Feature complete.

  """

  attr(:class, :string, doc: "Additional classname.")

  attr :classes, :map,
    default: %{
      header: nil,
      item: nil,
      link: nil
    },
    doc: """
    Additional classnames for header elements.

    Any provided value will be appended to the default classname.

    Default map:
    ```
    %{
      header: "", # The wrapping element
      item: "",   # Header item element
      link: "",   # Link inside an item
      input: "",  # Input element inside an item
    }
    ```
    """

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the outer element.
    """
  )

  slot :item,
    doc: """
    Header item.
    """ do
    attr :is_full, :string, doc: "Stretches the item to maximum."

    attr(:rest, :global,
      doc: """
      Additional HTML attributes added to the item element.
      """
    )
  end

  def header(assigns) do
    classes = %{
      header:
        AttributeHelpers.classnames([
          "Header",
          assigns.classes[:header],
          assigns[:class]
        ]),
      # item: # Set in item_attributes/1
      link:
        AttributeHelpers.classnames([
          "Header-link",
          assigns.classes[:link]
        ]),
      input:
        AttributeHelpers.classnames([
          "Header-input",
          assigns.classes[:input]
        ])
    }

    item_attributes = fn item ->
      # Don't pass item attributes to the HTML
      item_rest =
        assigns_to_attributes(item, [
          :is_full,
          :class
        ])

      item_class =
        AttributeHelpers.classnames([
          "Header-item",
          item[:is_full] && "Header-item--full",
          assigns.classes[:item],
          item[:class]
        ])

      item_classes = Map.put(classes, :item, item_class)

      {item_rest, item_class, item_classes}
    end

    render_item = fn item ->
      {item_rest, item_class, item_classes} = item_attributes.(item)

      ~H"""
      <div class={item_class} {item_rest}>
        <%= if not is_nil(item.inner_block) do %>
          <%= render_slot(item, item_classes) %>
        <% end %>
      </div>
      """
    end

    ~H"""
    <div class={classes.header} {@rest}>
      <%= for item <- @item do %>
        <%= render_item.(item) %>
      <% end %>
    </div>
    """
  end

  # ------------------------------------------------------------------------------------
  # dropdown
  # ------------------------------------------------------------------------------------

  @doc section: :dropdown

  @doc ~S"""
  Creates a dropdown menu.

  Dropdowns are small context menus that can be used for navigation and actions. They are a simple alternative to [select menus](`select_menu/1`).

  [Examples](#dropdown/1-examples) • [Attributes](#dropdown/1-attributes) • [Reference](#dropdown/1-reference)

  Menu items are rendered as link elements, created with `Phoenix.Component.link/1`, and any attribute passed to the `item` slot is passed to the link.

  ```
  <.dropdown>
    <:toggle>Menu</:toggle>
    <:item href="#url">Item 1</:item>
    <:item href="#url">Item 2</:item>
  </.dropdown>
  ```

  ## Examples

  Link navigation options:

  ```
  <:item href="#url">Item 1</:item>
  <:item navigate={Routes.page_path(@socket, :index)} class="underline">Item 2</:item>
  <:item patch={Routes.page_path(@socket, :index, :details)}>Item 3</:item>
  ```

  Add a menu title by passing `title` to the `menu` slot:

  ```
  <.dropdown>
    <:toggle>Menu</:toggle>
    <:menu title="Menu title" />
    ...
  </.dropdown>
  ```

  Change the position of the menu relative to the dropdown toggle:

  ```
  <:menu position="e" />
  ```

  Create dividers with `item` slot attribute `is_divider`. A divider cannot have contents.

  ```
  <.dropdown>
    <:toggle>Menu</:toggle>
    ...
    <:item is_divider />
    ...
  </.dropdown>
  ```

  [INSERT LVATTRDOCS]

  ## Reference

  [Primer/CSS Dropdown](https://primer.style/css/components/dropdown/)

  ## Status

  Feature complete.

  """

  attr :class, :string, default: nil, doc: "Additional classname."

  attr :classes, :map,
    default: %{
      caret: nil,
      divider: nil,
      dropdown: nil,
      header: nil,
      item: nil,
      menu: nil,
      toggle: nil
    },
    doc: """
    Additional classnames for dropdown elements.

    Any provided value will be appended to the default classname, except for `toggle` that will override the default class \"btn\".

    Default map:
    ```
    %{
      caret: "",    # Arrow in toggle button
      divider: "",  # List divider item (li element)
      dropdown: "", # Dropdown wrapper
      header: "",   # Menu header
      item: "",     # Link item, placed inside li element
      menu: "",     # List container (ul element)
      toggle: ""    # Toggle (open) button
    }
    ```
    """

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the outer element.
    """
  )

  slot(:toggle,
    required: true,
    doc: """
    Creates a toggle element (default with button appearance) using the slot content as label.

    Any custom class will override the default class "btn".
    """
  )

  slot :menu,
    doc: """
    Creates a menu element.
    """ do
    attr(:title, :string,
      doc: """
      Creates a menu header with specified title.
      """
    )

    attr(:position, :string,
      doc: """
      Position of the menu relative to the dropdown toggle.

      Possible values: "se", "ne", "e", "sw", "s", "w".

      Default: "se".
      """
    )
  end

  slot :item,
    required: true,
    doc: """
    Menu item content.
    """ do
    attr(:is_divider, :boolean,
      doc: """
      Creates a divider element.
      """
    )

    attr(:href, :any,
      doc: """
      Link attribute. If used, the menu item will be created with `Phoenix.Component.link/1`, passing all other attributes to the link.
      """
    )

    attr(:patch, :string,
      doc: """
      Link attribute - same as `href`.
      """
    )

    attr(:navigate, :string,
      doc: """
      Link attribute - same as `href`.
      """
    )

    attr(:rest, :global,
      doc: """
      Additional HTML attributes added to the item element.
      """
    )
  end

  def dropdown(assigns) do
    # Get the first menu slot, if any
    menu_slot = if assigns[:menu] && assigns[:menu] !== [], do: hd(assigns[:menu]), else: []

    # Get the toggle menu slot, if any
    toggle_slot = if assigns.toggle && assigns.toggle !== [], do: hd(assigns.toggle), else: []

    menu_title = menu_slot[:title]
    menu_position = menu_slot[:position] || "se"

    classes = %{
      dropdown:
        AttributeHelpers.classnames([
          "dropdown",
          "details-reset",
          "details-overlay",
          "d-inline-block",
          assigns.classes[:dropdown],
          assigns.class
        ]),
      toggle:
        AttributeHelpers.classnames([
          # If a custom class is set, remove the default btn class
          if assigns.classes[:toggle] || toggle_slot[:class] do
            AttributeHelpers.classnames([
              assigns.classes[:toggle],
              toggle_slot[:class]
            ])
          else
            "btn"
          end
        ]),
      caret:
        AttributeHelpers.classnames([
          "dropdown-caret",
          assigns.classes[:caret]
        ]),
      menu:
        AttributeHelpers.classnames([
          "dropdown-menu",
          "dropdown-menu-" <> menu_position,
          assigns.classes[:menu]
        ]),
      item:
        AttributeHelpers.classnames([
          "dropdown-item"
          # assigns.classes[:item] is conditionally set in item_attributes/2
        ]),
      divider:
        AttributeHelpers.classnames([
          "dropdown-divider"
          # assigns.classes[:divider] is conditionally set in item_attributes/2
        ]),
      header:
        AttributeHelpers.classnames([
          "dropdown-header",
          assigns.classes[:header]
        ])
    }

    toggle_attributes =
      AttributeHelpers.append_attributes([], [
        [class: classes[:toggle]],
        [aria_haspopup: "true"]
      ])

    item_attributes = fn item, is_divider ->
      # Distinguish between link items and divider items:
      # - 'regular' item: is in fact a link element inside an li
      # - divider item: an li with "divider" class
      # For links, the li does not have to get a custom class (if necessary, it can be accessed by CSS selector)
      # So any custom class set on a regular item gets passed on to the link (li stays classless),
      # while a custom class set on a divider item is set on the li.

      # Don't pass item attributes to the HTML to prevent duplicates
      item_rest =
        assigns_to_attributes(item, [
          :is_divider,
          :class
        ])

      item_class =
        AttributeHelpers.classnames([
          is_divider && classes[:divider],
          is_divider && assigns.classes[:divider],
          not is_divider && classes[:item],
          not is_divider && assigns.classes[:item],
          item[:class]
        ])

      item_attributes =
        AttributeHelpers.append_attributes(item_rest, [
          [class: item_class],
          is_divider && [role: "separator"]
        ])

      item_attributes
    end

    render_item = fn item ->
      is_divider = !!item[:is_divider]
      item_attributes = item_attributes.(item, is_divider)

      ~H"""
      <%= if is_divider do %>
        <li {item_attributes} />
      <% else %>
        <li>
          <.link {item_attributes}>
            <%= render_slot(item) %>
          </.link>
        </li>
      <% end %>
      """
    end

    render_menu = fn menu_attributes ->
      ~H"""
      <ul {menu_attributes}>
        <%= for item <- @item do %>
          <%= render_item.(item) %>
        <% end %>
      </ul>
      """
    end

    menu_attributes =
      AttributeHelpers.append_attributes([], [
        [class: classes[:menu]]
      ])

    ~H"""
    <details class={classes.dropdown} {@rest}>
      <summary {toggle_attributes}>
        <%= render_slot(toggle_slot) %>
        <div class={classes.caret}></div>
      </summary>
      <%= if not is_nil(menu_title) do %>
        <div {menu_attributes}>
          <div class={classes.header}>
            <%= menu_title %>
          </div>
          <%= render_menu.([]) %>
        </div>
      <% else %>
        <%= render_menu.(menu_attributes) %>
      <% end %>
    </details>
    """
  end

  # ------------------------------------------------------------------------------------
  # select_menu
  # ------------------------------------------------------------------------------------

  @doc section: :select_menu

  @doc ~S"""
  Creates a select menu.

  [Examples](#select_menu/1-examples) • [Attributes](#select_menu/1-attributes) • [Reference](#select_menu/1-reference)

  ```
  <.select_menu>
    <:toggle>Menu</:toggle>
    <:item>Item 1</:item>
    <:item>Item 2</:item>
    <:item>Item 3</:item>
  </.select_menu>
  ```

  ## Examples

  By default, items are turned into `<button>` elements. Pass a link attribute (`href`, `navigate` or `patch`) to change it automatically to a `Phoenix.Component.link/1`:

  ```
  <:item href="#url">Item 1</:item>
  <:item navigate={Routes.page_path(@socket, :index)} class="underline">Item 2</:item>
  <:item patch={Routes.page_path(@socket, :index, :details)}>Item 3</:item>
  ```

  Add dividers, with or without content:

  ```
  <.select_menu>
    <:toggle>Menu</:toggle>
    <:item>Item 1</:item>
    <:item is_divider />
    <:item>Item 2</:item>
    <:item is_divider>Divider content</:item>
    <:item>Item 3</:item>
  </.select_menu>
  ```

  Selected state. When any item is selected, all other items will line up nicely:

  ```
  <.select_menu>
    <:toggle>Menu</:toggle>
    <:item is_selected>Selected</:item>
    <:item>Not selected</:item>
  </.select_menu>
  ```

  Add a menu title. The title is placed in a header row with a close button. The click target for the button is based on the `id` attribute (generated automatically if not supplied).

  ```
  <.select_menu id="this-id-is-optional">
    <:toggle>Menu</:toggle>
    <:menu title="Title" />
    <:item>Item 1</:item>
    <:item>Item 2</:item>
    <:item>Item 3</:item>
  </.select_menu>
  ```

  Add a footer:

  ```
  <.select_menu>
    <:toggle>Menu</:toggle>
    <:item>Item 1</:item>
    <:item>Item 2</:item>
    <:item>Item 3</:item>
    <:footer>Footer</:footer>
  </.select_menu>
  ```

  Pass attribute `open` to show the menu initially open:

  ```
  <.select_menu open>
    ...
  </.select_menu>
  ```

  [INSERT LVATTRDOCS]

  ## Reference

  [Primer/CSS Select menu](https://primer.style/css/components/select-menu/)

  ## Status

  To do:
  - Tabs slot

  """

  attr :is_right_aligned, :boolean, default: false, doc: "Aligns the menu to the right."
  attr :is_borderless, :boolean, default: false, doc: "Removes the borders between list items."

  attr :classes, :map,
    default: %{
      blankslate: nil,
      divider: nil,
      filter: nil,
      footer: nil,
      header_close_button: nil,
      header: nil,
      item: nil,
      loading: nil,
      menu_container: nil,
      menu_list: nil,
      menu_title: nil,
      menu: nil,
      message: nil,
      toggle: nil
    },
    doc: """
    Additional classnames for select menu elements.

    Any provided value will be appended to the default classname, except for `toggle` that will override the default class \"btn\".

    Default map:
    ```
    %{
      blankslate: "",          # Blankslate content element.
      divider: "",             # Divider item element.
      filter: "",              # Filter content element
      footer: "",              # Footer element.
      header_close_button: "", # Close button in the header.
      header: "",              # Header element.
      item: "",                # Item element.
      loading: "",             # Loading content element.
      menu_container: "",      # Menu container (called "modal" at PrimerCSS).
      menu_list: "",           # Menu list container.
      menu_title: "",          # Menu title.
      menu: "",                # Menu element
      message: "",             # Message element.
      toggle: "",              # Toggle element. Any value will override the default class "btn".
    }
    ```
    """

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the outer element.
    """
  )

  slot(:toggle,
    required: true,
    doc: """
    Creates a toggle element (default with button appearance) using the slot content as label.

    Any custom class will override the default class "btn".
    """
  )

  slot :menu,
    doc: """
    Creates a menu element.
    """ do
    attr(:title, :string,
      doc: """
      Creates a menu header with specified title.
      """
    )
  end

  slot(:filter,
    doc: """
    Filter slot to insert a `text_input/1` that will drive a custom filter function.
    """
  )

  slot(:footer,
    doc: """
    Footer content.
    """
  )

  slot(:message,
    doc: """
    Message container. Use utility classes to further style the message.

    Example:
    ```
    <:message class="color-bg-danger color-fg-danger">Message</:message>
    ```
    """
  )

  slot(:loading,
    doc: """
    Slot to show a loading animation.

    Example:
    ```
    <:loading><.octicon name="copilot-48" class="anim-pulse" /></:loading>
    ```
    """
  )

  slot(:blankslate,
    doc: """
    Slot to show blankslate content.
    """
  )

  slot :item,
    doc: """
    Menu item content.
    """ do
    attr(:is_selected, :boolean,
      doc: """
      Shows the selected state with a checkmark.
      """
    )

    attr(:is_disabled, :boolean,
      doc: """
      Creates a disabled state.
      """
    )

    attr(:is_divider, :boolean,
      doc: """
      Creates a divider. The divider may have content, for example a label "More options".
      """
    )

    attr(:selected_octicon_name, :boolean,
      doc: """
      The icon name for the selected state, for example "check-circle-fill-16".

      Default "check-16".
      """
    )

    attr(:href, :any,
      doc: """
      Link attribute. If used, the menu item will be created with `Phoenix.Component.link/1`, passing all other attributes to the link.
      """
    )

    attr(:patch, :string,
      doc: """
      Link attribute - same as `href`.
      """
    )

    attr(:navigate, :string,
      doc: """
      Link attribute - same as `href`.
      """
    )

    attr(:rest, :global,
      doc: """
      Additional HTML attributes added to the item element.
      """
    )
  end

  def select_menu(assigns) do
    assigns_classes =
      Map.merge(
        %{
          blankslate: nil,
          divider: nil,
          filter: nil,
          footer: nil,
          header_close_button: nil,
          header: nil,
          item: nil,
          loading: nil,
          menu_container: nil,
          menu_list: nil,
          menu_title: nil,
          menu: nil,
          message: nil,
          toggle: nil
        },
        assigns.classes
      )

    # Get the first menu slot, if any
    menu_slot = if assigns[:menu] && assigns[:menu] !== [], do: hd(assigns[:menu]), else: []

    # Get the toggle menu slot, if any
    toggle_slot = if assigns.toggle && assigns.toggle !== [], do: hd(assigns.toggle), else: []

    # Collect all attributes inside "rest"
    item_slots =
      assigns.item
      |> Enum.map(
        &Map.put(
          &1,
          :rest,
          assigns_to_attributes(&1, [
            :is_divider,
            :class,
            :disabled
          ])
        )
      )

    is_any_item_selected = item_slots |> Enum.any?(& &1[:is_selected])
    menu_title = menu_slot[:title]
    has_header = !!menu_title

    classes = %{
      select_menu:
        AttributeHelpers.classnames([
          "details-reset",
          "details-overlay",
          assigns[:class]
        ]),
      toggle:
        AttributeHelpers.classnames([
          assigns_classes.toggle || toggle_slot[:class] || "btn"
        ]),
      menu:
        AttributeHelpers.classnames([
          "SelectMenu",
          assigns.is_right_aligned and "right-0",
          not is_nil(assigns[:filter]) and "SelectMenu--hasFilter",
          assigns_classes.menu
        ]),
      menu_container:
        AttributeHelpers.classnames([
          "SelectMenu-modal",
          assigns_classes.menu_container
        ]),
      menu_list:
        AttributeHelpers.classnames([
          "SelectMenu-list",
          assigns.is_borderless and "SelectMenu-list--borderless",
          assigns_classes.menu_list
        ]),
      header:
        AttributeHelpers.classnames([
          "SelectMenu-header",
          assigns_classes.header
        ]),
      menu_title:
        AttributeHelpers.classnames([
          "SelectMenu-title",
          assigns_classes.menu_title
        ]),
      header_close_button:
        AttributeHelpers.classnames([
          "SelectMenu-closeButton",
          assigns_classes.header_close_button
        ]),
      filter:
        AttributeHelpers.classnames([
          "SelectMenu-filter",
          assigns_classes.filter
        ]),
      item:
        AttributeHelpers.classnames([
          "SelectMenu-item",
          assigns_classes.item
        ]),
      divider:
        AttributeHelpers.classnames([
          "SelectMenu-divider",
          assigns_classes.divider
        ]),
      footer:
        AttributeHelpers.classnames([
          "SelectMenu-footer",
          assigns_classes.footer
        ]),
      message:
        AttributeHelpers.classnames([
          "SelectMenu-message",
          assigns_classes.message
        ]),
      loading:
        AttributeHelpers.classnames([
          "SelectMenu-loading",
          assigns_classes.loading
        ]),
      blankslate:
        AttributeHelpers.classnames([
          "SelectMenu-blankslate",
          assigns_classes.blankslate
        ])
    }

    toggle_attributes =
      AttributeHelpers.append_attributes([], [
        [class: classes.toggle],
        [aria_haspopup: "true"]
      ])

    item_attributes = fn item ->
      is_selected = item[:is_selected]
      is_disabled = item[:is_disabled]
      is_link = AttributeHelpers.is_link?(item)

      # Don't pass item attributes to the HTML
      item_rest =
        assigns_to_attributes(item.rest, [
          :is_disabled,
          :is_selected,
          :is_divider,
          :selected_octicon_name
        ])

      AttributeHelpers.append_attributes(item_rest, [
        [class: AttributeHelpers.classnames([classes.item, item[:class]])],
        !is_selected && [role: "menuitem"],
        is_selected && [role: "menuitemcheckbox", aria_checked: "true"],
        is_link && is_disabled && [aria_disabled: "true"],
        !is_link && is_disabled && [disabled: "true"]
      ])
    end

    divider_attributes = fn item ->
      AttributeHelpers.append_attributes(item.rest, [
        [class: AttributeHelpers.classnames([classes.divider, item[:class]])],
        !!item.inner_block && [role: "separator"]
      ])
    end

    # Use an id as close button target
    menu_id =
      case has_header do
        true ->
          assigns.rest[:id] || AttributeHelpers.random_string()

        false ->
          nil
      end

    select_menu_opts =
      AttributeHelpers.append_attributes(assigns.rest, [
        [class: classes.select_menu],
        # Add the menu id when we will show a header with close button
        not is_nil(menu_id) and [data_menu_id: menu_id]
      ])

    render_item = fn item ->
      is_link = AttributeHelpers.is_link?(item)
      is_divider = !!item[:is_divider]
      is_divider_content = is_divider && !!item.inner_block
      is_button = !is_link && !is_divider
      selected_octicon_name = item[:selected_octicon_name] || "check-16"

      ~H"""
      <%= if is_divider do %>
        <%= if is_divider_content do %>
          <div {divider_attributes.(item)}>
            <%= render_slot(item) %>
          </div>
        <% else %>
          <hr {divider_attributes.(item)} />
        <% end %>
      <% end %>
      <%= if is_button do %>
        <button {item_attributes.(item)}>
          <%= if is_any_item_selected do %>
            <.octicon name={selected_octicon_name} class="SelectMenu-icon SelectMenu-icon--check" />
          <% end %>
          <%= render_slot(item) %>
        </button>
      <% end %>
      <%= if is_link do %>
        <.link {item_attributes.(item)}>
          <%= if is_any_item_selected do %>
            <.octicon name={selected_octicon_name} class="SelectMenu-icon SelectMenu-icon--check" />
          <% end %>
          <%= render_slot(item) %>
        </.link>
      <% end %>
      """
    end

    ~H"""
    <details {select_menu_opts}>
      <summary {toggle_attributes}>
        <%= render_slot(toggle_slot) %>
      </summary>
      <div class={classes.menu}>
        <div class={classes.menu_container}>
          <%= if not is_nil(menu_title) do %>
            <header class={classes.header}>
              <h3 class={classes.menu_title}><%= menu_title %></h3>
              <button
                class={classes.header_close_button}
                type="button"
                phx-click={
                  Phoenix.LiveView.JS.remove_attribute("open",
                    to: "[data-menu-id=#{menu_id}]"
                  )
                }
              >
                <.octicon name="x-16" />
              </button>
            </header>
          <% end %>
          <%= if @filter && @filter !== [] do %>
            <div class={classes.filter}>
              <%= render_slot(@filter) %>
            </div>
          <% end %>
          <%= if @message do %>
            <%= for message <- @message do %>
              <div class={AttributeHelpers.classnames([classes.message, message[:class]])}>
                <%= render_slot(message) %>
              </div>
            <% end %>
          <% end %>
          <%= if @loading do %>
            <%= for loading <- @loading do %>
              <div class={AttributeHelpers.classnames([classes.loading, loading[:class]])}>
                <%= render_slot(loading) %>
              </div>
            <% end %>
          <% end %>
          <div class={classes.menu_list}>
            <%= if @blankslate do %>
              <%= for blankslate <- @blankslate do %>
                <div class={AttributeHelpers.classnames([classes.blankslate, blankslate[:class]])}>
                  <%= render_slot(blankslate) %>
                </div>
              <% end %>
            <% end %>

            <%= for item <- item_slots do %>
              <%= render_item.(item) %>
            <% end %>
          </div>
          <%= if @footer do %>
            <%= for footer <- @footer do %>
              <div class={AttributeHelpers.classnames([classes.footer, footer[:class]])}>
                <%= render_slot(footer) %>
              </div>
            <% end %>
          <% end %>
        </div>
      </div>
    </details>
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

  Use `button_group/1` to create a group of buttons:

  ```
  <.button_group>
    <.button_group_item>Button 1</.button_group_item>
    <.button_group_item>Button 2</.button_group_item>
    <.button_group_item>Button 3</.button_group_item>
  </.button_group>
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

  def button(assigns) do
    assigns =
      assigns
      |> assign(:type, if(assigns.is_submit, do: "submit", else: "button"))

    class =
      AttributeHelpers.classnames([
        !assigns.is_link and !assigns.is_icon_only and !assigns.is_close_button and "btn",
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
        assigns.is_close_button and "close-button",
        assigns[:class]
      ])

    aria_attributes =
      AttributeHelpers.get_aria_attributes(
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
  # button_group
  # ------------------------------------------------------------------------------------

  @doc section: :buttons

  @doc ~S"""
  Creates a group of buttons.

  [Examples](#button_group/1-examples) • [Attributes](#button_group/1-attributes) • [Reference](#button_group/1-reference)

  ```
  <.button_group>
    <:button>Button 1</:button>
    <:button>Button 2</:button>
    <:button>Button 3</:button>
  </.button_group>
  ```

  ## Examples

  Use button slots while passing button attributes to create the button row:

  ```
  <.button_group>
    <:button>Button 1</:button>
    <:button is_selected>Button 2</:button>
    <:button is_danger>Button 3</:button>
    <:button class="my-button">Button 4</:button>
  </.button_group>
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
    doc: "Button. Use `button/1` attributes to configure the button appearance and behaviour."
  )

  def button_group(assigns) do
    classes = %{
      button_group:
        AttributeHelpers.classnames([
          "BtnGroup",
          assigns[:class]
        ]),
      button: fn slot ->
        AttributeHelpers.classnames([
          "BtnGroup-item",
          slot[:class]
        ])
      end
    }

    ~H"""
    <div class={classes.button_group} {@rest}>
      <%= for slot <- @button do %>
        <.button {slot} class={classes.button.(slot)}>
          <%= render_slot(slot) %>
        </.button>
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

  [Examples](#pagination/1-examples) • [Attributes](#pagination/1-attributes) • [Reference](#pagination/1-reference)

  ```
  <.pagination
    page_count={@page_count}
    current_page={@current_page}
    link_path={fn page_num -> "/page/#{page_num}" end}
  />
  ```

  ## Features

  - Configure the page number ranges for siblings and sides
  - Optionally disable page number display (minimal UI)
  - Custom labels
  - Custom classnames for all elements

  If pages in the center (controlled by `sibling_count`) collide with pages near the sides (controlled by `side_count`), the center section will be pushed away from the side.

  ## Examples

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
    sibling_count="1"  # default: 2
    side_count="2"     # default 1
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

  [INSERT LVATTRDOCS]

  ### Reference

  [Primer/CSS Pagination](https://primer.style/css/components/pagination/)

  ## Status

  Feature complete.

  """

  attr :page_count, :integer, required: true, doc: "Result page count."
  attr :current_page, :integer, required: true, doc: "Current page number."

  attr :link_path, :any,
    required: true,
    doc: """
    Function that returns a path for the given page number. The link builder uses `Phoenix.Component.link/1` with attribute `navigate`. Extra options can be passed with `link_options`.

    Function signature: `(page_number) -> path`
    """

  attr :side_count, :integer, default: 1, doc: "Number of page links at both ends."

  attr :sibling_count, :integer,
    default: 2,
    doc: "Number of page links at each side of the current page number element."

  attr :is_numbered, :boolean, default: true, doc: "Showing page numbers."
  attr :class, :string, doc: "Additional classname."

  attr :classes, :map,
    default: %{
      gap: nil,
      pagination_container: nil,
      pagination: nil,
      previous_page: nil,
      next_page: nil,
      page: nil
    },
    doc: """
    Additional classnames for pagination elements. Any provided value will be appended to the default classname.

    Default map:
    ```
    %{
      gap: "",
      pagination_container: "",
      pagination: "",
      previous_page: "",
      next_page: "",
      page: ""
    }
    ```
    """

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

  def pagination(assigns) do
    assigns =
      assigns
      |> assign(:page_count, AttributeHelpers.as_integer(assigns.page_count) |> max(0))
      |> assign(
        :current_page,
        AttributeHelpers.as_integer(assigns.current_page) |> max(1)
      )
      |> assign(
        :side_count,
        AttributeHelpers.as_integer(assigns.side_count) |> AttributeHelpers.minmax(1, 3)
      )
      |> assign(
        :sibling_count,
        AttributeHelpers.as_integer(assigns.sibling_count) |> AttributeHelpers.minmax(1, 5)
      )
      |> assign(
        :is_numbered,
        AttributeHelpers.as_boolean(assigns.is_numbered)
      )
      |> assign(
        :labels,
        Map.merge(@default_pagination_labels, assigns.labels)
      )

    %{
      page_count: page_count,
      current_page: current_page,
      side_count: side_count,
      sibling_count: sibling_count
    } = assigns

    has_previous_page = current_page > 1
    has_next_page = current_page < page_count
    show_numbers = assigns.is_numbered && page_count > 1
    show_prev_next = page_count > 1

    classes = %{
      pagination_container:
        AttributeHelpers.classnames([
          "paginate-container",
          assigns[:classes][:pagination_container],
          assigns[:class]
        ]),
      pagination:
        AttributeHelpers.classnames([
          "pagination",
          assigns[:classes][:pagination]
        ]),
      previous_page:
        AttributeHelpers.classnames([
          "previous_page",
          assigns[:classes][:previous_page]
        ]),
      next_page:
        AttributeHelpers.classnames([
          "next_page",
          assigns[:classes][:next_page]
        ]),
      page:
        AttributeHelpers.classnames([
          assigns[:classes][:page]
        ]),
      gap:
        AttributeHelpers.classnames([
          "gap",
          assigns[:classes][:gap]
        ])
    }

    pagination_elements =
      get_pagination_numbers(
        page_count,
        current_page,
        side_count,
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

  def get_pagination_numbers(
        page_count,
        current_page,
        side_count,
        sibling_count
      )
      when page_count == 0,
      do:
        get_pagination_numbers(
          1,
          current_page,
          side_count,
          sibling_count
        )

  def get_pagination_numbers(
        page_count,
        current_page,
        side_count,
        sibling_count
      ) do
    list = 1..page_count

    # Insert a '0' divider when the page sequence is not sequential
    # But omit this when the total number of pages equals the side_count counts plus the gap item

    may_insert_gaps = page_count !== 0 && page_count > 2 * side_count + 1

    case may_insert_gaps do
      true -> insert_gaps(page_count, current_page, side_count, sibling_count, list)
      false -> list |> Enum.map(& &1)
    end
  end

  defp insert_gaps(page_count, current_page, side_count, sibling_count, list) do
    # Prevent overlap of the island with the sides
    # Define a virtual page number that must lay between the boundaries “side + sibling” on both ends
    # then calculate the island
    virtual_page =
      limit(
        current_page,
        side_count + sibling_count + 1,
        page_count - (side_count + sibling_count)
      )

    # Subtract 1 because we are dealing here with array indices
    island_start = virtual_page - sibling_count - 1
    island_end = virtual_page + sibling_count - 1

    island_range =
      Enum.slice(
        list,
        island_start..island_end
      )

    # Join the parts, make sure the numbers a unique, and loop over the result to insert a '0' whenever
    # 2 adjacent number differ by more than 1
    # The result should be something like [1,2,0,5,6,7,8,9,0,99,100]

    side_start_range = Enum.take(list, side_count)
    side_end_range = Enum.take(list, -side_count)

    (side_start_range ++ island_range ++ side_end_range)
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

  defp limit(num, lower_bound, upper_bound) do
    min(max(num, lower_bound), upper_bound)
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

  def octicon(assigns) do
    assigns =
      assigns
      |> assign(
        :class,
        AttributeHelpers.classnames([
          "octicon",
          assigns[:class]
        ])
      )

    icon = PrimerLive.Octicons.octicons(assigns) |> Map.get(assigns[:name])

    ~H"""
    <%= if icon do %>
      <%= icon %>
    <% else %>
      Icon with name <%= @name %> does not exist.
    <% end %>
    """
  end

  # ------------------------------------------------------------------------------------
  # label
  # ------------------------------------------------------------------------------------

  @doc section: :labels

  @doc ~S"""
  Creates a label element.

  Labels add metadata or indicate status of items and navigational elements.

  [Examples](#label/1-examples) • [Attributes](#label/1-attributes) • [Reference](#label/1-reference)

  ```
  <.label>Label</.label>
  ```

  When using `label` alongside `Phoenix.HTML.Form.label/2`, use a prefix, for example:

  ```
  use PrimerLive
  alias PrimerLive.Component, as: P
  ...
  <P.label>Label</P.label>
  ```

  ## Examples

  Create a colored label:

  ```
  <.label is_success>Label</.label>
  ```

  Create a larger label:

  ```
  <.label is_large>Label</.label>
  ```

  Create an inline label:

  ```
  <p>Lorem Ipsum is simply <.label is_inline>dummy text</.label> of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text.</p>
  ```

  [INSERT LVATTRDOCS]

  ## Reference

  [Primer/CSS Labels](https://primer.style/css/components/labels)

  ## Status

  Feature complete.

  """

  attr :class, :string, doc: "Additional classname."

  attr :is_primary, :boolean,
    default: false,
    doc: """
    Creates a label with a stronger border.
    """

  attr :is_secondary, :boolean,
    default: false,
    doc: """
    Creates a label with a subtler text color.
    """

  attr :is_accent, :boolean,
    default: false,
    doc: """
    Accent color.
    """

  attr :is_success, :boolean,
    default: false,
    doc: """
    Success color.
    """

  attr :is_attention, :boolean,
    default: false,
    doc: """
    Attention color.
    """

  attr :is_severe, :boolean,
    default: false,
    doc: """
    Severe color.
    """

  attr :is_danger, :boolean,
    default: false,
    doc: """
    Danger color.
    """

  attr :is_open, :boolean,
    default: false,
    doc: """
    Open color.
    """

  attr :is_closed, :boolean,
    default: false,
    doc: """
    Closed color.
    """

  attr :is_done, :boolean,
    default: false,
    doc: """
    Done color.
    """

  attr :is_sponsors, :boolean,
    default: false,
    doc: """
    Sponsors color.
    """

  attr :is_large, :boolean,
    default: false,
    doc: """
    Larger label.
    """

  attr :is_inline, :boolean,
    default: false,
    doc: """
    For use in running text. Adapts line height and font size to text.
    """

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the label.
    """
  )

  slot(:inner_block, required: true, doc: "Label content.")

  def label(assigns) do
    class =
      AttributeHelpers.classnames([
        "Label",
        assigns.is_primary and "Label--primary",
        assigns.is_secondary and "Label--secondary",
        assigns.is_accent and "Label--accent",
        assigns.is_success and "Label--success",
        assigns.is_attention and "Label--attention",
        assigns.is_severe and "Label--severe",
        assigns.is_danger and "Label--danger",
        assigns.is_open and "Label--open",
        assigns.is_closed and "Label--closed",
        assigns.is_done and "Label--done",
        assigns.is_sponsors and "Label--sponsors",
        assigns.is_large and "Label--large",
        assigns.is_inline and "Label--inline",
        assigns[:class]
      ])

    # Keep this as a single line to preserve whitespace in the rendered HTML
    ~H"""
    <span class={class} {@rest}><%= render_slot(@inner_block) %></span>
    """
  end

  # ------------------------------------------------------------------------------------
  # issue_label
  # ------------------------------------------------------------------------------------

  @doc section: :labels

  @doc ~S"""
  Issue labels are used for adding labels to issues and pull requests. They also come with emoji support.

  And issue label is basically labels without a border. It expects background and foreground colors.

  [Examples](#issue_label/1-examples) • [Attributes](#issue_label/1-attributes) • [Reference](#issue_label/1-reference)

  ```
  <.issue_label>Label</.issue_label>
  ```

  ## Examples

  Add colors:

  ```
  <.issue_label color-bg-accent-emphasis color-fg-on-emphasis>Label</.issue_label>
  ```

  Larger label:

  ```
  <.issue_label is_big>Label</.issue_label>
  ```

  [INSERT LVATTRDOCS]

  ## Reference

  [Primer/CSS Labels](https://primer.style/css/components/labels)

  ## Status

  Feature complete.

  """

  attr :class, :string, doc: "Additional classname."

  attr :is_big, :boolean,
    default: false,
    doc: """
    Larger issue label.
    """

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the label.
    """
  )

  slot(:inner_block, required: true, doc: "Label content.")

  def issue_label(assigns) do
    class =
      AttributeHelpers.classnames([
        "IssueLabel",
        assigns.is_big and "IssueLabel--big",
        assigns[:class]
      ])

    # Keep this as a single line to preserve whitespace in the rendered HTML
    ~H"""
    <span class={class} {@rest}><%= render_slot(@inner_block) %></span>
    """
  end

  # ------------------------------------------------------------------------------------
  # state_label
  # ------------------------------------------------------------------------------------

  @doc section: :labels

  @doc ~S"""
  Shows an item's status.

  State labels are larger and styled with bolded text. Attribute settings allows to apply colors.

  [Examples](#state_label/1-examples) • [Attributes](#state_label/1-attributes) • [Reference](#state_label/1-reference)

  ```
  <.state_label>Label</.state_label>
  ```

  ## Examples

  Set a state (applying a background color):

  ```
  <.state_label is_open>Label</.state_label>
  ```

  Smaller label:

  ```
  <.state_label is_small>Label</.state_label>
  ```

  With an icon:

  ```
  <.state_label is_open><.octicon name="git-pull-request-16" />Label</.state_label>
  ```

  [INSERT LVATTRDOCS]

  ## Reference

  [Primer/CSS Labels](https://primer.style/css/components/labels)

  ## Status

  Feature complete.

  """

  attr :class, :string, doc: "Additional classname."

  attr :is_draft, :boolean,
    default: false,
    doc: """
    Draft state color.
    """

  attr :is_open, :boolean,
    default: false,
    doc: """
    Open state color.
    """

  attr :is_merged, :boolean,
    default: false,
    doc: """
    Merged state color.
    """

  attr :is_closed, :boolean,
    default: false,
    doc: """
    Closed state color.
    """

  attr :is_small, :boolean,
    default: false,
    doc: """
    Smaller state label.
    """

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the label.
    """
  )

  slot(:inner_block, required: true, doc: "Label content.")

  def state_label(assigns) do
    class =
      AttributeHelpers.classnames([
        "State",
        assigns.is_draft and "State--draft",
        assigns.is_open and "State--open",
        assigns.is_merged and "State--merged",
        assigns.is_closed and "State--closed",
        assigns.is_small and "State--small",
        assigns[:class]
      ])

    # Keep this as a single line to preserve whitespace in the rendered HTML
    ~H"""
    <span class={class} {@rest}><%= render_slot(@inner_block) %></span>
    """
  end

  # ------------------------------------------------------------------------------------
  # counter
  # ------------------------------------------------------------------------------------

  @doc section: :labels

  @doc ~S"""
  Adds a count to navigational elements and buttons.

  [Examples](#counter/1-examples) • [Attributes](#counter/1-attributes) • [Reference](#counter/1-reference)

  ```
  <.counter>12</.counter>
  ```

  ## Examples

  Apply primary state:

  ```
  <.counter is_primary>12</.counter>
  ```

  With an icon:

  ```
  <.counter><.octicon name="comment-16" /> 1.5K</.counter>
  ```

  Add an emoji:

  ```
  <.counter>👍 2</.counter>
  ```

  [INSERT LVATTRDOCS]

  ## Reference

  [Primer/CSS Labels](https://primer.style/css/components/labels)

  ## Status

  Feature complete.

  """

  attr :class, :string, doc: "Additional classname."

  attr :is_primary, :boolean,
    default: false,
    doc: """
    Primary color.
    """

  attr :is_secondary, :boolean,
    default: false,
    doc: """
    Secondary color.
    """

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the label.
    """
  )

  slot(:inner_block, required: true, doc: "Label content.")

  def counter(assigns) do
    class =
      AttributeHelpers.classnames([
        "Counter",
        assigns.is_primary and "Counter--primary",
        assigns.is_secondary and "Counter--secondary",
        assigns[:class]
      ])

    # Keep this as a single line to preserve whitespace in the rendered HTML
    ~H"""
    <span class={class} {@rest}><%= render_slot(@inner_block) %></span>
    """
  end

  # ------------------------------------------------------------------------------------
  # subhead
  # ------------------------------------------------------------------------------------

  @doc section: :subhead

  @doc ~S"""
  Configurable and styled h2 heading.

  [Examples](#subhead/1-examples) • [Attributes](#subhead/1-attributes) • [Reference](#subhead/1-reference)

  ```
  </.subhead>Plain subhead</.subhead>
  ```

  ## Examples

  Add a top margin when separating sections on a settings page:

  ```
  </.subhead is_spacious>Subhead</.subhead>
  ```

  Create a danger zone heading:

  ```
  </.subhead is_danger>Plain subhead</.subhead>
  ```

  Add a description:

  ```
  <.subhead>
    Heading
    <:description>
      Description
    </:description>
  </.subhead>
  ```

  Add an action (button or link):

  ```
  <.subhead>
    Heading
    <:actions>
      <.button is_primary>Action</.button>
    </:actions>
  </.subhead>
  ```

  [INSERT LVATTRDOCS]

  ## Reference

  [Primer/CSS Subhead](https://primer.style/css/components/subhead)

  ## Status

  Feature complete.

  """

  attr(:class, :string, default: nil, doc: "Additional classname.")

  attr(:classes, :map,
    default: %{
      subhead: nil,
      heading: nil,
      description: nil,
      actions: nil
    },
    doc: """
    Additional classnames for subhead elements.

    Any provided value will be appended to the default classname.

    Default map:
    ```
    %{
      subhead: "",     # Subhead container
      heading: "",     # h2 heading
      description: "", # Description element
      actions: "",     # Actions section element
    }
    ```
    """
  )

  attr :is_spacious, :boolean,
    default: false,
    doc: """
    Add a top margin.
    """

  attr :is_danger, :boolean,
    default: false,
    doc: """
    Makes the text bold and red. This is useful for warning users.
    """

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the outer element.
    """
  )

  slot(:inner_block, required: true, doc: "Heading content.")
  slot(:description, doc: "Description content.")
  slot(:actions, doc: "Actions content.")

  def subhead(assigns) do
    classes = %{
      subhead:
        AttributeHelpers.classnames([
          "Subhead",
          assigns.is_spacious && "Subhead--spacious",
          assigns.classes[:subhead],
          assigns[:class]
        ]),
      heading:
        AttributeHelpers.classnames([
          "Subhead-heading",
          assigns.is_danger && "Subhead-heading--danger",
          assigns.classes[:heading]
        ]),
      description:
        AttributeHelpers.classnames([
          "Subhead-description",
          assigns.classes[:description]
        ]),
      actions:
        AttributeHelpers.classnames([
          "Subhead-actions",
          assigns.classes[:actions]
        ])
    }

    ~H"""
    <div class={classes.subhead} {@rest}>
      <h2 class={classes.heading}><%= render_slot(@inner_block) %></h2>
      <%= if @description do %>
        <%= for description <- @description do %>
          <div class={AttributeHelpers.classnames([classes.description, description[:class]])}>
            <%= render_slot(description) %>
          </div>
        <% end %>
      <% end %>
      <%= if @actions do %>
        <%= for action <- @actions do %>
          <div class={AttributeHelpers.classnames([classes.actions, action[:class]])}>
            <%= render_slot(action) %>
          </div>
        <% end %>
      <% end %>
    </div>
    """
  end

  # ------------------------------------------------------------------------------------
  # breadcrumb
  # ------------------------------------------------------------------------------------

  @doc section: :breadcrumbs

  @doc ~S"""
  Breadcrumb navigation to navigate a hierarchy of pages.

  [Examples](#breadcrumb/1-examples) • [Attributes](#breadcrumb/1-attributes) • [Reference](#breadcrumb/1-reference)

  All items are rendered as links. The last link will show a selected state.

  ```
  <.breadcrumb>
    <:item href="/home">Home</:item>
    <:item href="/account">Account</:item>
    <:item href="/account/history">History</:item>
  </.breadcrumb>
  ```

  ## Examples

  Link navigation options:

  ```
  <:item href="/home">Home</:item>
  <:item navigate={Routes.page_path(@socket, :index)}>Home</:item>
  <:item patch={Routes.page_path(@socket, :index, :details)}>Home</:item>
  ```

  [INSERT LVATTRDOCS]

  ## Reference

  [Primer/CSS Breadcrumbs](https://primer.style/css/components/breadcrumb)

  ## Status

  Feature complete.

  """

  attr(:class, :string, default: nil, doc: "Additional classname.")

  attr(:classes, :map,
    default: %{
      breadcrumb: nil,
      item: nil,
      selected_item: nil,
      link: nil
    },
    doc: """
    Additional classnames for breadcrumb elements.

    Any provided value will be appended to the default classname.

    Default map:
    ```
    %{
      breadcrumb: "",    # Breadcrumb container
      item: "",          # Breadcrumb item (li element)
      selected_item: "", # Selected breadcrumb item (li element)
      link: "",          # Link
    }
    ```
    """
  )

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the outer element.
    """
  )

  slot :item,
    required: true,
    doc: """
    Breadcrumb item content.
    """ do
    attr(:href, :any,
      doc: """
      Link attribute. If used, the link item will be created with `Phoenix.Component.link/1`, passing all other attributes to the link.
      """
    )

    attr(:patch, :string,
      doc: """
      Link attribute - same as `href`.
      """
    )

    attr(:navigate, :string,
      doc: """
      Link attribute - same as `href`.
      """
    )

    attr(:rest, :global,
      doc: """
      Additional HTML attributes added to the item element.
      """
    )
  end

  def breadcrumb(assigns) do
    # Mark the last item for specific rendering
    assign_items = assigns.item || []
    count = Enum.count(assign_items)
    items_data = assign_items |> Enum.with_index(fn elem, idx -> {elem, idx === count - 1} end)

    classes = %{
      breadcrumb:
        AttributeHelpers.classnames([
          "Breadcrumb",
          assigns.classes[:breadcrumb],
          assigns[:class]
        ]),
      item:
        AttributeHelpers.classnames([
          "breadcrumb-item",
          assigns.classes[:item]
        ]),
      selected_item:
        AttributeHelpers.classnames([
          "breadcrumb-item-selected",
          assigns.classes[:selected_item]
        ]),
      link: assigns.classes[:link]
    }

    item_attributes = fn is_last ->
      AttributeHelpers.append_attributes([], [
        [
          class:
            AttributeHelpers.classnames([
              classes.item,
              is_last && classes.selected_item
            ])
        ]
      ])
    end

    link_attributes = fn link ->
      link_rest =
        assigns_to_attributes(link, [
          :class
        ])

      AttributeHelpers.append_attributes(link_rest, [
        [
          class:
            AttributeHelpers.classnames([
              classes.link,
              link[:class]
            ])
        ]
      ])
    end

    ~H"""
    <div class={classes.breadcrumb} {@rest}>
      <%= if items_data !== [] do %>
        <ol>
          <%= for {item, is_last} <- items_data do %>
            <li {item_attributes.(is_last)}>
              <.link {link_attributes.(item)}>
                <%= render_slot(item) %>
              </.link>
            </li>
          <% end %>
        </ol>
      <% end %>
    </div>
    """
  end

  # ------------------------------------------------------------------------------------
  # as_link
  # ------------------------------------------------------------------------------------

  @doc section: :links

  @doc ~S"""
  Creates a consistent link-like appearance of actual links and spans inside links.

  The component name deviates from the PrimerCSS name `Link` to prevent a naming conflict with `Phoenix.Component.link/1`.

  [Examples](#as_link/1-examples) • [Attributes](#as_link/1-attributes) • [Reference](#as_link/1-reference)

  ```
  Some text with a <.as_link>link</.as_link>
  ```

  ## Examples

  Links are created using `Phoenix.Component.link/1` when navigation attributes are supplied:

  ```
  <.as_link href="/home">label</.as_link>
  <.as_link navigate="/home">label</.as_link>
  <.as_link patch="/home">label</.as_link>
  ```

  Turn a link blue only on hover:

  ```
  <.as_link href="/home" is_primary>link</.as_link>
  ```

  Give it a muted gray color:

  ```
  <.as_link href="/home" is_secondary>link</.as_link>
  ```

  Turn a link blue only on hover:

  ```
  <.as_link href="/home" is_primary>link</.as_link>
  ```

  Rmove the underline:

  ```
  <.as_link href="/home" is_no_underline>link</.as_link>
  ```

  Use `is_on_hover` to make any text color used with links to turn blue on hover.
  This is useful when you want only part of a link to turn blue on hover.
  We are using a nested `as_link` for this:

  ```
  <p>
    <.as_link href="#url" is_muted is_no_underline>
      A link with a partial <.as_link is_on_hover>hover link</.as_link>
    </.as_link>
  </p>
  ```

  Combine with color utility classes

  ```
  <p>
    <.as_link href="#url" is_primary class="text-bold">
      <.octicon name="flame-16" width="12" class="color-fg-danger" />
      Hot <span class="color-fg-muted">potato</span>
    </.as_link>
  </p>
  ```

  [INSERT LVATTRDOCS]

  ## Reference

  [Primer/CSS Links](https://primer.style/css/components/links)

  ## Status

  Feature complete.

  """

  attr(:class, :string, default: nil, doc: "Additional classname.")

  attr :is_primary, :boolean,
    default: false,
    doc: """
    Turns the link color to blue only on hover.
    """

  attr :is_secondary, :boolean,
    default: false,
    doc: """
    Turns the link color to blue only on hover, using a darker color.
    """

  attr :is_muted, :boolean,
    default: false,
    doc: """
    Turns the link to muted gray, also on hover.
    """

  attr :is_no_underline, :boolean,
    default: false,
    doc: """
    Removes the underline on hover.
    """

  attr :is_on_hover, :boolean,
    default: false,
    doc: """
    Makes any text color used with links to turn blue on hover. This is useful when you want only part of a link to turn blue on hover.
    """

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the link or span. Use `Phoenix.Component.link/1` attributes `href`, `navigate` or `patch` to create links.
    """
  )

  slot(:inner_block, required: true, doc: "Link content.")

  def as_link(assigns) do
    class =
      AttributeHelpers.classnames([
        "Link",
        assigns.is_primary and "Link--primary",
        assigns.is_secondary and "Link--secondary",
        assigns.is_no_underline and "no-underline",
        assigns.is_muted and "color-fg-muted",
        assigns.is_on_hover and "Link--onHover",
        assigns[:class]
      ])

    is_link = AttributeHelpers.is_link?(assigns.rest)

    ~H"""
    <%= if is_link do %>
      <.link class={class} {@rest}>
        <%= render_slot(@inner_block) %>
      </.link>
    <% else %>
      <span class={class} {@rest}><%= render_slot(@inner_block) %></span>
    <% end %>
    """
  end

  # ------------------------------------------------------------------------------------
  # avatar
  # ------------------------------------------------------------------------------------

  @doc section: :avatars

  @doc ~S"""
  User profile image.

  A simple wrapper function that returns an `img` element, styled square and rounded. For correct rendering, the input image must be square.

  [Examples](#avatar/1-examples) • [Attributes](#avatar/1-attributes) • [Reference](#avatar/1-reference)

  ```
  <.avatar src="user.jpg" />
  ```

  ## Examples

  Set the size (possible values: 1 - 8):

  ```
  <.avatar size="1" src="user.jpg" />
  ```

  Or set the size using regular `img` tags:

  ```
  <.avatar src="user.jpg" width="20" height="20" />
  ```

  [INSERT LVATTRDOCS]

  ## Reference

  [Primer/CSS Avatars](https://primer.style/css/components/avatars)

  ## Status

  Feature complete.

  """

  attr(:class, :string, default: nil, doc: "Additional classname.")

  attr :size, :integer,
    default: 3,
    doc: """
    Avatar size. Possible values: 1 - 8.

    Values translate to sizes:
    - 1: `16px`
    - 2: `20px`
    - 3: `24px` (default)
    - 4: `28px`
    - 5: `32px`
    - 6: `40px`
    - 7: `48px`
    - 8: `64px`
    """

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the `img` element.
    """
  )

  @avatar_default_size 3

  def avatar(assigns) do
    size =
      if assigns.rest[:width] || assigns.rest[:height] do
        nil
      else
        avatar_size_in_range(assigns.size)
      end

    class =
      AttributeHelpers.classnames([
        "avatar",
        size && "avatar-#{size}",
        assigns[:class]
      ])

    ~H"""
    <img class={class} {@rest} />
    """
  end

  defp avatar_size_in_range(size) when is_nil(size), do: @avatar_default_size

  defp avatar_size_in_range(size) when is_binary(size) do
    case Integer.parse(size) do
      {int, _} -> avatar_size_in_range(int)
      :error -> @avatar_default_size
    end
  end

  defp avatar_size_in_range(size) when size < 1, do: @avatar_default_size
  defp avatar_size_in_range(size) when size > 8, do: @avatar_default_size
  defp avatar_size_in_range(size), do: size
end
