defmodule PrimerLive.Component do
  use Phoenix.Component
  use Phoenix.HTML

  alias PrimerLive.Helpers.{AttributeHelpers, FormHelpers, SchemaHelpers, ComponentHelpers}

  # ------------------------------------------------------------------------------------
  # tabnav
  # ------------------------------------------------------------------------------------

  @doc section: :navigation

  @doc ~S"""
  Generates a tab navigation.

  [Examples](#tabnav/1-examples) • [Attributes](#tabnav/1-attributes) • [Slots](#tabnav/1-slots) • [Reference](#tabnav/1-reference)

  Tab items are either rendered as link element (when using attrs `href`, `navigate` or `patch`), or as button.

  ```
  <.tabnav aria_label="Topics navigation">
    <:item href="#url" is_selected>
      Link tab
    </:item>
    <:item>
      Button tab
    </:item>
  </.tabnav>
  ```

  ## Examples

  Tabs links are created with `Phoenix.Component.link/1`, and any attribute passed to the `item` slot is passed to the link. Link navigation options:

  ```
  <:item href="#url">Item 1</:item>
  <:item navigate={Routes.page_path(@socket, :index)} class="underline">Item 2</:item>
  <:item patch={Routes.page_path(@socket, :index, :details)}>Item 3</:item>
  ```

  Add other types of content, such as icons and counters:

  ```
  <.tabnav>
    <:item href="#url" is_selected>
      <.octicon name="comment-discussion-16" />
      <span>Conversation</span>
      <span class="Counter">2</span>
    </:item>
    <:item href="#url">
      <.octicon name="check-circle-16" />
      <span>Done</span>
      <span class="Counter">99</span>
    </:item>
  </.tabnav>
  ```

  Position additional content to the far end of the tabs.

  A button placed at the far end:

  ```
  <.tabnav>
    <:item href="#url" is_selected>
      One
    </:item>
    <:item href="#url">
      Two
    </:item>
    <:position_end>
      <a class="btn btn-sm" href="#url" role="button">Button</a>
    </:position_end>
  </.tabnav>
  ```

  Extra content (not a button) is styled using attribute `is_extra`:

  ```
  <.tabnav>
    <:item href="#url" is_selected>
      One
    </:item>
    <:item href="#url">
      Two
    </:item>
    <:position_end is_extra>
      Tabnav widget text here.
    </:position_end>
  </.tabnav>
  ```

  [INSERT LVATTRDOCS]

  ## Reference

  [Primer/CSS Navigation](https://primer.style/css/components/navigation)

  ## Status

  Feature complete.

  """

  attr(:class, :string, default: nil, doc: "Additional classname.")

  attr(:classes, :map,
    default: %{
      tabnav: nil,
      nav: nil,
      tab: nil,
      position_end: nil
    },
    doc: """
    Additional classnames for tabnav elements.

    Any provided value will be appended to the default classname.

    Default map:
    ```
    %{
      tabnav: "",       # Outer container
      nav: "",          # Nav element
      tab: "",          # Tab link element
      position_end: "", # Container for elements positions at the far end
    }
    ```
    """
  )

  attr(:aria_label, :string,
    default: nil,
    doc: "Adds attribute `aria-label` to the `nav` element."
  )

  slot :item,
    required: true,
    doc: """
    Tab item content: either a link or a button.

    Tab items are rendered as link element when using attrs `href`, `navigate` or `patch`, otherwise as button elemens. Tabs links are created with `Phoenix.Component.link/1`.
    """ do
    attr(:is_selected, :boolean,
      doc: """
      The currently selected item.
      """
    )

    attr(:href, :any,
      doc: """
      Link attribute. If used, the menu item will be created with `Phoenix.Component.link/1`, passing all other attributes to the link.
      """
    )

    attr(:patch, :string,
      doc: """
      Link attribute - see `href`.
      """
    )

    attr(:navigate, :string,
      doc: """
      Link attribute - see `href`.
      """
    )

    attr(:rest, :any,
      doc: """
      Additional HTML attributes added to the item element.
      """
    )
  end

  slot :position_end,
    doc: """
    Container for elements positions at the far end.
    """ do
    attr(:is_extra, :boolean,
      doc: """
      Adds styles to optimise additional bits of text and links.
      """
    )

    attr(:rest, :any,
      doc: """
      Additional HTML attributes added to the far end container.
      """
    )
  end

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the outer element.
    """
  )

  def tabnav(assigns) do
    classes = %{
      tabnav:
        AttributeHelpers.classnames([
          "tabnav",
          assigns.classes[:tabnav],
          assigns[:class]
        ]),
      nav:
        AttributeHelpers.classnames([
          "tabnav-tabs",
          assigns.classes[:nav]
        ]),
      tab: fn slot ->
        AttributeHelpers.classnames([
          "tabnav-tab",
          assigns.classes[:tab],
          slot[:class]
        ])
      end,
      position_end: fn slot ->
        AttributeHelpers.classnames([
          "float-right",
          assigns.classes[:position_end],
          slot[:is_extra] && "tabnav-extra",
          slot[:class]
        ])
      end
    }

    render_tab = fn slot ->
      is_link = AttributeHelpers.is_link?(slot)

      rest =
        assigns_to_attributes(slot, [
          :class,
          :is_selected
        ])

      attributes =
        AttributeHelpers.append_attributes(rest, [
          [class: classes.tab.(slot)],
          [role: "tab"],
          slot[:is_selected] && [aria_selected: "true"],
          slot[:is_selected] && [aria_current: "page"]
        ])

      assigns =
        assigns
        |> assign(:is_link, is_link)
        |> assign(:attributes, attributes)
        |> assign(:slot, slot)

      ~H"""
      <%= if @is_link do %>
        <Phoenix.Component.link {@attributes}>
          <%= render_slot(@slot) %>
        </Phoenix.Component.link>
      <% else %>
        <button {@attributes}>
          <%= render_slot(@slot) %>
        </button>
      <% end %>
      """
    end

    render_position_end = fn slot ->
      rest =
        assigns_to_attributes(slot, [
          :class,
          :is_extra
        ])

      attributes =
        AttributeHelpers.append_attributes(rest, [
          [class: classes.position_end.(slot)]
        ])

      assigns =
        assigns
        |> assign(:attributes, attributes)
        |> assign(:slot, slot)

      ~H"""
      <div {@attributes}><%= render_slot(@slot) %></div>
      """
    end

    nav_attributes =
      AttributeHelpers.append_attributes([], [
        [class: classes.nav],
        assigns[:aria_label] && [aria_label: assigns[:aria_label]]
      ])

    assigns =
      assigns
      |> assign(:classes, classes)
      |> assign(:render_tab, render_tab)
      |> assign(:render_position_end, render_position_end)
      |> assign(:nav_attributes, nav_attributes)

    ~H"""
    <div class={@classes.tabnav} {@rest}>
      <%= if @position_end && @position_end !== [] do %>
        <%= for slot <- @position_end do %>
          <%= @render_position_end.(slot) %>
        <% end %>
      <% end %>
      <%= if @item && @item !== [] do %>
        <nav {@nav_attributes}>
          <%= for slot <- @item do %>
            <%= @render_tab.(slot) %>
          <% end %>
        </nav>
      <% end %>
    </div>
    """
  end

  # ------------------------------------------------------------------------------------
  # underline_nav
  # ------------------------------------------------------------------------------------

  @doc section: :navigation

  @doc ~S"""
  Generates a tab navigation with minimal underlined selected state, typically used for navigation placed at the top of the page.

  [Examples](#underline_nav/1-examples) • [Attributes](#underline_nav/1-attributes) • [Slots](#underline_nav/1-slots) • [Reference](#underline_nav/1-reference)

  Tab items are either rendered as link element (when using attrs `href`, `navigate` or `patch`), or as button.

  ```
  <.underline_nav aria_label="Site navigation">
    <:item href="#url" is_selected>
      Link tab
    </:item>
    <:item>
      Button tab
    </:item>
  </.underline_nav>
  ```

  ## Examples

  Tabs links are created with `Phoenix.Component.link/1`, and any attribute passed to the `item` slot is passed to the link. Link navigation options:

  ```
  <:item href="#url">Item 1</:item>
  <:item navigate={Routes.page_path(@socket, :index)} class="underline">Item 2</:item>
  <:item patch={Routes.page_path(@socket, :index, :details)}>Item 3</:item>
  ```

  Add other types of content, such as icons and counters:

  ```
  <.underline_nav>
    <:item href="#url" is_selected>
      <.octicon name="comment-discussion-16" />
      <span>Conversation</span>
      <span class="Counter">2</span>
    </:item>
    <:item href="#url">
      <.octicon name="check-circle-16" />
      <span>Done</span>
      <span class="Counter">99</span>
    </:item>
  </.underline_nav>
  ```

  Position additional content to the far end of the tabs.

  A button placed at the far end:

  ```
  <.underline_nav>
    <:item href="#url" is_selected>
      One
    </:item>
    <:item href="#url">
      Two
    </:item>
    <:position_end>
      <a class="btn btn-sm" href="#url" role="button">Button</a>
    </:position_end>
  </.underline_nav>
  ```

  Use `is_container_width` in combination with container styles to make navigation fill the width of the container:

  ```
  <.underline_nav is_container_width classes={%{
      container: "container-sm"
    }}>
    <:item href="#url" is_selected>
      One
    </:item>
    <:item href="#url">
      Two
    </:item>
    <:position_end>
      <a class="btn btn-sm" href="#url" role="button">Button</a>
    </:position_end>
  </.underline_nav>
  ```

  [INSERT LVATTRDOCS]

  ## Reference

  [Primer/CSS Navigation](https://primer.style/css/components/navigation)

  ## Status

  Feature complete.

  """

  attr(:class, :string, default: nil, doc: "Additional classname.")

  attr(:classes, :map,
    default: %{
      underline_nav: nil,
      container: nil,
      body: nil,
      tab: nil,
      position_end: nil
    },
    doc: """
    Additional classnames for underline nav elements.

    Any provided value will be appended to the default classname.

    Default map:
    ```
    %{
      underline_nav: "", # Outer container (nav elemnent)
      container: "",     # Extra container wrapper when using attr is_container_width
      body: "",          # Tabs wrapper
      tab: "",           # Tab link element
      position_end: "",  # Container for elements positions at the far end
    }
    ```
    """
  )

  attr(:is_container_width, :boolean,
    default: false,
    doc: """
    Use in combination with container styles to make navigation fill the width of the container.

    For example:
    ```
    <.underline_nav is_container_width classes={%{
      container: "container-sm"
    }}>
      ...
    </.underline_nav>
    ```
    """
  )

  attr(:is_reversed, :boolean,
    default: false,
    doc: "In left-to-right views the navigation will be positioned at the right."
  )

  attr(:aria_label, :string,
    default: nil,
    doc: "Adds attribute `aria-label` to the outer element."
  )

  slot :item,
    required: true,
    doc: """
    Tab item content: either a link or a button.

    Tab items are rendered as link element when using attrs `href`, `navigate` or `patch`, otherwise as button elemens. Tabs links are created with `Phoenix.Component.link/1`.
    """ do
    attr(:is_selected, :boolean,
      doc: """
      The currently selected item.
      """
    )

    attr(:href, :any,
      doc: """
      Link attribute. If used, the menu item will be created with `Phoenix.Component.link/1`, passing all other attributes to the link.
      """
    )

    attr(:patch, :string,
      doc: """
      Link attribute - see `href`.
      """
    )

    attr(:navigate, :string,
      doc: """
      Link attribute - see `href`.
      """
    )

    attr(:rest, :any,
      doc: """
      Additional HTML attributes added to the item element.
      """
    )
  end

  slot :position_end,
    doc: """
    Container for elements positions at the far end.
    """ do
    attr(:rest, :any,
      doc: """
      Additional HTML attributes added to the far end container.
      """
    )
  end

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the outer element.
    """
  )

  def underline_nav(assigns) do
    classes = %{
      underline_nav:
        AttributeHelpers.classnames([
          "UnderlineNav",
          assigns.is_container_width and "UnderlineNav--full",
          assigns.is_reversed and "UnderlineNav--right",
          assigns.classes[:underline_nav],
          assigns[:class]
        ]),
      container:
        AttributeHelpers.classnames([
          "UnderlineNav-container",
          assigns.classes[:container]
        ]),
      body:
        AttributeHelpers.classnames([
          "UnderlineNav-body",
          assigns.classes[:body]
        ]),
      tab: fn slot ->
        AttributeHelpers.classnames([
          "UnderlineNav-item",
          assigns.classes[:tab],
          slot[:class]
        ])
      end,
      position_end: fn slot ->
        AttributeHelpers.classnames([
          "UnderlineNav-actions",
          assigns.classes[:position_end],
          slot[:class]
        ])
      end
    }

    body_attributes =
      AttributeHelpers.append_attributes([], [
        [class: classes.body],
        [role: "tablist"]
      ])

    render_tab = fn slot ->
      is_link = AttributeHelpers.is_link?(slot)

      rest =
        assigns_to_attributes(slot, [
          :class,
          :is_selected
        ])

      attributes =
        AttributeHelpers.append_attributes(rest, [
          [class: classes.tab.(slot)],
          [role: "tab"],
          slot[:is_selected] && [aria_selected: "true"],
          slot[:is_selected] && [aria_current: "page"]
        ])

      assigns =
        assigns
        |> assign(:is_link, is_link)
        |> assign(:attributes, attributes)
        |> assign(:slot, slot)

      ~H"""
      <%= if @is_link do %>
        <Phoenix.Component.link {@attributes}>
          <%= render_slot(@slot) %>
        </Phoenix.Component.link>
      <% else %>
        <button {@attributes}>
          <%= render_slot(@slot) %>
        </button>
      <% end %>
      """
    end

    render_position_end = fn slot ->
      rest =
        assigns_to_attributes(slot, [
          :class,
          :is_extra
        ])

      attributes =
        AttributeHelpers.append_attributes(rest, [
          [class: classes.position_end.(slot)]
        ])

      assigns =
        assigns
        |> assign(:attributes, attributes)
        |> assign(:slot, slot)

      ~H"""
      <div {@attributes}><%= render_slot(@slot) %></div>
      """
    end

    render_position_end_slots = fn slots ->
      assigns =
        assigns
        |> assign(:slots, slots)
        |> assign(:render_position_end, render_position_end)

      ~H"""
      <%= if @slots && @slots !== [] do %>
        <%= for slot <- @slots do %>
          <%= @render_position_end.(slot) %>
        <% end %>
      <% end %>
      """
    end

    render_items = fn slots ->
      assigns =
        assigns
        |> assign(:items, slots)
        |> assign(:body_attributes, body_attributes)
        |> assign(:render_tab, render_tab)
        |> assign(:render_position_end_slots, render_position_end_slots)

      ~H"""
      <%= if @is_reversed do %>
        <%= @render_position_end_slots.(@position_end) %>
      <% end %>
      <%= if @item && @items !== [] do %>
        <div {@body_attributes}>
          <%= for slot <- @item do %>
            <%= @render_tab.(slot) %>
          <% end %>
        </div>
      <% end %>
      <%= if not @is_reversed do %>
        <%= @render_position_end_slots.(@position_end) %>
      <% end %>
      """
    end

    assigns =
      assigns
      |> assign(:classes, classes)
      |> assign(:render_items, render_items)

    ~H"""
    <nav class={@classes.underline_nav} {@rest}>
      <%= if @is_container_width do %>
        <div class={@classes.container}>
          <%= @render_items.(@item) %>
        </div>
      <% else %>
        <%= @render_items.(@item) %>
      <% end %>
    </nav>
    """
  end

  # ------------------------------------------------------------------------------------
  # form_group
  # ------------------------------------------------------------------------------------

  @doc section: :forms

  @doc ~S"""
  Generates a form group: a wrapper around one or more inputs, with a heading and validation.

  [Examples](#form_group/1-examples) • [Attributes](#form_group/1-attributes) • [Slots](#form_group/1-slots) • [Reference](#form_group/1-reference)

  ```
  <.form_group field="first_name">
    <.text_input field="first_name" />
  </.form_group>
  ```

  ## Examples

  With a `Phoenix.HTML.Form`:

  ```
  <.form let={f} for={@changeset} phx-change="validate" phx-submit="save">
    <.form_group form={f} field={:first_name}>
      <.text_input
        form={f}
        field={:first_name}
        phx_debounce="blur"
        autocomplete="off"
      />
    </.form_group>
  </.form>
  ```

  Custom label:

  ```
  <.form_group form={f} field={:first_name} label="Enter your first name">
  ...
  </.form_group>
  ```

  Hide the label:

  ```
  <.form_group form={f} field={:first_name} is_hide_label>
  ...
  </.form_group>
  ```

  With checkboxes:

  ```
  <.form let={f} for={@changeset} phx-change="validate" phx-submit="save">
    <.form_group form={f} field={:role}>
      <.checkbox form={f} field={:role} checked_value="admin" />
      <.checkbox form={f} field={:role} checked_value="editor" />
    </.form_group>
  </.form>
  ```

  With radio buttons:

  ```
  <.form let={f} for={@changeset} phx-change="validate" phx-submit="save">
    <.form_group form={f} field={:role}>
      <.radio_button form={f} field={:work_experience} value="writing" />
      <.radio_button form={f} field={:work_experience} value="managing" />
    </.form_group>
  </.form>
  ```

  Custom validation error message:

  ```
  <.form let={f} for={@changeset} phx-change="validate" phx-submit="save">
    <.form_group form={f} field={:first_name} validation_message={
      fn field_state ->
        if !field_state.valid?, do: "Please enter your first name"
      end
    }>
      ...
    </.form_group>
  </.form>
  ```
  Custom validation success message:

  ```
  <.form let={f} for={@changeset} phx-change="validate" phx-submit="save">
    <.form_group form={f} field={:first_name} validation_message={
      fn field_state ->
        if field_state.valid?, do: "Available!"
      end
    }>
      ...
    </.form_group>
  </.form>
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

  attr(:label, :string,
    default: nil,
    doc: "Custom label. Note that a label is automatically generated when using `field`."
  )

  attr :is_hide_label, :boolean, default: false, doc: "Omits the label when using `field`."

  attr(:class, :string, default: nil, doc: "Additional classname.")

  attr(:classes, :map,
    default: %{
      group: nil,
      header: nil,
      body: nil,
      label: nil,
      validation_message: nil
    },
    doc: """
    Additional classnames for form group elements.

    Any provided value will be appended to the default classname.

    Default map:
    ```
    %{
      group: "",              # Form group element
      header: "",             # Header element containing the group label
      body: "",               # Input wrapper
      label: "",              # Form group label
      validation_message: "", # Validation message
    }
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

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the input element.
    """
  )

  slot(:inner_block, required: true, doc: "Form group content.")

  def form_group(assigns) do
    with true <- validate_is_form(assigns) do
      render_form_group(assigns)
    else
      {:error, reason} ->
        assigns =
          assigns
          |> assign(:reason, reason)

        ~H"""
        <%= @reason %>
        """
    end
  end

  defp render_form_group(assigns) do
    form = assigns[:form]
    field = assigns[:field]
    validation_message = assigns[:validation_message]
    rest = assigns[:rest]

    field_state = FormHelpers.field_state(form, field, validation_message)

    %{
      message_id: message_id,
      message: message,
      valid?: valid?
    } = field_state

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
          assigns[:class],
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
      validation_message: assigns.classes[:validation_message]
    }

    # If label is supplied, wrap it inside a label element
    # else use the default generated label

    header_label_attributes =
      AttributeHelpers.append_attributes([], [
        [class: assigns.classes.label],
        [for: assigns[:for] || Phoenix.HTML.Form.input_id(form, field)]
      ])

    header_label =
      cond do
        assigns.is_hide_label ->
          nil

        assigns[:label] ->
          Phoenix.HTML.Form.label(
            form,
            field,
            assigns[:label],
            header_label_attributes
          )

        true ->
          humanize_label = Phoenix.HTML.Form.humanize(field)

          case humanize_label === "Nil" do
            true -> nil
            false -> Phoenix.HTML.Form.label(form, field, header_label_attributes)
          end
      end

    has_header_label = header_label && header_label !== "Nil"

    group_attributes =
      AttributeHelpers.append_attributes(rest, [
        [class: classes.group]
      ])

    assigns =
      assigns
      |> assign(:classes, classes)
      |> assign(:group_attributes, group_attributes)
      |> assign(:has_header_label, has_header_label)
      |> assign(:header_label, header_label)
      |> assign(:message, message)
      |> assign(:message_id, message_id)
      |> assign(:valid?, valid?)
      |> assign(:validation_message_class, classes.validation_message)

    ~H"""
    <div {@group_attributes}>
      <%= if @has_header_label do %>
        <div class={@classes.header}>
          <%= @header_label %>
        </div>
      <% end %>
      <div class={@classes.body}>
        <%= render_slot(@inner_block) %>
        <.input_validation_message
          valid?={@valid?}
          message={@message}
          message_id={@message_id}
          class={@validation_message_class}
        />
      </div>
    </div>
    """
  end

  # ------------------------------------------------------------------------------------
  # input_validation_message
  #
  # Private comppnent
  # ------------------------------------------------------------------------------------

  attr(:message, :string, default: nil, doc: "Validation message.")
  attr(:message_id, :string, default: nil, doc: "Validation message ID.")
  attr(:valid?, :boolean, default: false, doc: "Valid state.")
  attr(:class, :string, default: nil, doc: "Classname.")

  defp input_validation_message(assigns) do
    class =
      AttributeHelpers.classnames([
        "note",
        if assigns.valid? do
          "success"
        else
          "error"
        end,
        assigns.class
      ])

    assigns =
      assigns
      |> assign(:class, class)

    ~H"""
    <%= if not is_nil(@message) do %>
      <p class={@class} id={@message_id}>
        <%= @message %>
      </p>
    <% end %>
    """
  end

  # Validates attribute `form`.
  # Allowed values:
  # - nil
  # - atom
  # - Phoenix.HTML.Form
  defp validate_is_form(assigns) do
    form = assigns[:form]

    cond do
      is_nil(form) -> true
      is_atom(form) -> true
      SchemaHelpers.is_phoenix_form(form) -> true
      true -> {:error, "attr form: invalid value"}
    end
  end

  # ------------------------------------------------------------------------------------
  # text_input
  # ------------------------------------------------------------------------------------

  @doc section: :forms

  @doc ~S"""
  Generates a text input field.

  Wrapper around `Phoenix.HTML.Form.text_input/3`, optionally wrapped itself inside a "form group" to add a field label and validation.

  [Examples](#text_input/1-examples) • [Attributes](#text_input/1-attributes) • [Slots](#text_input/1-slots) • [Reference](#text_input/1-reference)

  ```
  <.text_input field="first_name" />
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
    <.text_input form={f} field={:first_name} />
    <.text_input form={f} field={:last_name} />
  </.form>
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

  attr(:class, :string, default: nil, doc: "Additional classname.")

  attr(:type, :string, default: "text", doc: "Text input type.")

  attr(:is_contrast, :boolean, default: false, doc: "Changes the background color to light gray.")

  attr(:is_full_width, :boolean, default: false, doc: "Full width input.")

  attr(:is_hide_webkit_autofill, :boolean,
    default: false,
    doc: "Hide WebKit's contact info autofill icon."
  )

  attr(:is_large, :boolean, default: false, doc: "Larger text size.")

  attr(:is_small, :boolean, default: false, doc: "Smaller input with smaller text size.")

  attr(:is_short, :boolean, default: false, doc: "Generates an input with a reduced width.")

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the input element.
    """
  )

  def text_input(assigns) do
    with true <- validate_is_form(assigns) do
      render_text_input(assigns)
    else
      {:error, reason} ->
        assigns =
          assigns
          |> assign(:reason, reason)

        ~H"""
        <%= @reason %>
        """
    end
  end

  defp render_text_input(assigns) do
    form = assigns[:form]
    field = assigns[:field]

    class =
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

    %{
      message_id: message_id
    } = FormHelpers.field_state(form, field, nil)

    input_attributes =
      AttributeHelpers.append_attributes(assigns.rest, [
        [class: class],
        # If aria_label is not set, use the value of placeholder (if any):
        is_nil(assigns.rest[:aria_label]) and [aria_label: assigns.rest[:placeholder]],
        not is_nil(message_id) and [aria_describedby: message_id]
      ])

    assigns =
      assigns
      |> assign(
        :input,
        apply(Phoenix.HTML.Form, FormHelpers.text_input_type_as_atom(assigns.type), [
          form,
          field,
          input_attributes
        ])
      )

    ~H"""
    <%= @input %>
    """
  end

  # ------------------------------------------------------------------------------------
  # textarea
  # ------------------------------------------------------------------------------------

  @doc section: :forms

  @doc ~S"""
  Generates a textarea.

  ```
  <.textarea name="comments" />
  ```

  ## Attributes

  Use `text_input/1` attributes.

  ## Reference

  [Primer/CSS Forms](https://primer.style/css/components/forms)

  ## Status

  Feature complete.

  """

  def textarea(assigns) do
    assigns = assigns |> assign(:type, "textarea")
    text_input(assigns)
  end

  # ------------------------------------------------------------------------------------
  # select
  # ------------------------------------------------------------------------------------

  @doc section: :forms

  @doc ~S"""
  Generates a single or multiple select input.

  Wrapper around `Phoenix.HTML.Form.select/4` and `Phoenix.HTML.Form.multiple_select/4`.

  ```
  <.select name="age" options={25..35} />
  ```

  [Examples](#select/1-examples) • [Attributes](#select/1-attributes) • [Reference](#select/1-reference)

  ## Examples

  Options can contain:
  - A list:
    - `25..35`
    - `["male", "female", "won't say"]`
  - A keyword list:
    - `["Admin": "admin", "User": "user"]`
  - A nested keyword list with option attributes:
    - `[[key: "Admin", value: "admin", disabled: true], [key: "User", value: "user"]]`

  Create a small select input:

  ```
  <.select name="age" options={25..35} is_small />
  ```

  Set the selected item:

  ```
  <.select name="age" options={25..35} selected="30" />
  ```

  Add a prompt:

  ```
  <.select name="age" options={25..35} prompt="Choose your age" />
  ```

  Set attributes to the prompt option:

  ```
  <.select name="age" options={25..35} prompt={[key: "Choose your role", disabled: true]} />
  ```

  Create a multiple select with `is_multiple`.
  - Use `is_auto_height` to set the height of the select input to the number of options.
  - From the Phoenix documentation: Values are expected to be an Enumerable containing two-item tuples (like maps and keyword lists) or any Enumerable where the element will be used both as key and value for the generated select.
  - `selected` should contain a list of selected options.

  ```
  <.form let={f} for={@changeset} phx-change="validate" phx-submit="save">
    <.select
      form={f}
      field={:role}
      options={["Admin": "admin", "User": "user", "Editor": "editor"]}
      is_multiple
      is_auto_height
      selected={["user", "tester"]}
    />
  </.form>
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

  attr :options, :any, required: true, doc: "List, map or keyword list."

  attr :class, :string, doc: "Additional classname."

  attr(:is_multiple, :boolean,
    default: false,
    doc: """
    Creates a multiple select. Uses `Phoenix.HTML.Form.multiple_select/4`.

    From the Phoenix documentation:

    Values are expected to be an Enumerable containing two-item tuples (like maps and keyword lists) or any Enumerable where the element will be used both as key and value for the generated select.
    """
  )

  attr :is_small, :boolean, default: false, doc: "Creates a small input."

  attr :is_auto_height, :boolean,
    default: false,
    doc: "When using `is_multiple`: sets the size to the number of options."

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the select input.
    """
  )

  def select(assigns) do
    with true <- validate_is_form(assigns) do
      render_select(assigns)
    else
      {:error, reason} ->
        assigns =
          assigns
          |> assign(:reason, reason)

        ~H"""
        <%= @reason %>
        """
    end
  end

  defp render_select(assigns) do
    form = assigns[:form]
    field = assigns[:field]

    class =
      AttributeHelpers.classnames([
        "form-select",
        assigns.is_small and "select-sm",
        assigns[:class]
      ])

    input_opts =
      AttributeHelpers.append_attributes(assigns.rest, [
        [class: class],
        assigns.is_auto_height && [size: Enum.count(assigns.options)]
      ])

    input_fn =
      cond do
        assigns.is_multiple -> :multiple_select
        true -> :select
      end

    assigns =
      assigns
      |> assign(:form, form)
      |> assign(:field, field)
      |> assign(:input_fn, input_fn)
      |> assign(:input_opts, input_opts)

    ~H"""
    <%= apply(Phoenix.HTML.Form, @input_fn, [@form, @field, @options, @input_opts]) %>
    """
  end

  # ------------------------------------------------------------------------------------
  # checkbox
  # ------------------------------------------------------------------------------------

  @doc section: :forms

  @doc ~S"""
  Generates a checkbox.

  Wrapper around `Phoenix.HTML.Form.checkbox/3`.

  [Examples](#checkbox/1-examples) • [Attributes](#checkbox/1-attributes) • [Slots](#checkbox/1-slots) • [Reference](#checkbox/1-reference)

  ```
  <.checkbox name="available_for_hire" />
  ```

  ## Examples

  Set the checked state:

  ```
  <.checkbox name="available_for_hire" checked />
  ```

  Using the checkbox with form data. This will automatically create the checkbox label:

  ```
  <.form let={f} for={@changeset} phx-change="validate" phx-submit="save">
    <.checkbox form={f} field={:available_for_hire} />
  </.form>
  ```

  Pass a custom checkbox label with the `label` slot:

  ```
  <.checkbox form={:user} field={:available_for_hire}>
    <:label>Some label</:label>
  </.checkbox>
  ```

  Add emphasis to the label:

  ```
  <.checkbox name="available_for_hire" is_emphasised_label />
  ```

  Add a hint below the label:

  ```
  <.checkbox name="available_for_hire">
    <:label>Some label</:label>
    <:hint>
      Add your <strong>resume</strong> below
    </:hint>
  </.checkbox>
  ```

  Reveal extra details when the checkbox is checked:

  ```
  <.checkbox name="available_for_hire">
    <:label>Some label</:label>
    <:disclosure>
      <span class="d-block mb-1">Available hours per week</span>
      <input type="text" name="" class="form-control input-contrast" size="3" />
      <span class="text-small color-fg-muted pl-2">hours per week</span>
    </:disclosure>
  </.checkbox>
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

  attr(:is_emphasised_label, :boolean, default: false, doc: "Adds emphasis to the label.")

  attr(:class, :string, default: nil, doc: "Additional classname.")

  attr(:classes, :map,
    default: %{
      label: nil,
      input: nil,
      hint: nil,
      disclosure: nil
    },
    doc: """
    Additional classnames for checkbox elements.

    Any provided value will be appended to the default classname.

    Default map:
    ```
    %{
      label: "",       # Input label
      input: "",       # Checkbox input element
      hint: "",        # Hint message container
      disclosure: ""   # Disclosure container (inline)
    }
    ```
    """
  )

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the input element.
    """
  )

  slot :label,
    doc: """
    Custom checkbox label. Overides the derived label when using a `form` and `field`.
    """ do
    attr(:rest, :any,
      doc: """
      Additional HTML attributes added to the label element.
      """
    )
  end

  slot :hint,
    doc: """
    Adds text below the checkbox label. Enabled when a label is displayed.
    """ do
    attr(:rest, :any,
      doc: """
      Additional HTML attributes added to the hint element.
      """
    )
  end

  slot :disclosure,
    doc: """
    Extra label content to be revealed when the checkbox is checked. Enabled when a label is displayed.

    Note that the label element can only contain inline child elements.
    """ do
    attr(:rest, :any,
      doc: """
      Additional HTML attributes added to the disclosure wrapper element.
      """
    )
  end

  def checkbox(assigns) do
    with true <- validate_is_form(assigns) do
      render_checkbox(assigns)
    else
      {:error, reason} ->
        assigns =
          assigns
          |> assign(:reason, reason)

        ~H"""
        <%= @reason %>
        """
    end
  end

  defp render_checkbox(assigns) do
    form = assigns[:form]
    field = assigns[:field]

    # Remove type from rest, we'll set it on the input
    rest =
      assigns_to_attributes(assigns.rest, [
        :type
      ])

    assigns =
      assigns
      |> assign(:form, form)
      |> assign(:field, field)
      |> assign(:rest, rest)
      |> assign(:input_type, :checkbox)

    render_checkbox_input(assigns)
  end

  defp render_checkbox_input(assigns) do
    %{form: form, field: field, rest: rest} = assigns

    classes = %{
      container:
        AttributeHelpers.classnames([
          "form-checkbox",
          assigns.class
        ]),
      hint: fn slot ->
        AttributeHelpers.classnames([
          "note",
          assigns.classes[:hint],
          slot[:class]
        ])
      end,
      disclosure: fn slot ->
        AttributeHelpers.classnames([
          "form-checkbox-details",
          "text-normal",
          assigns.classes[:disclosure],
          slot[:class]
        ])
      end
    }

    disclosure_slot =
      if assigns[:disclosure] && assigns[:disclosure] !== [],
        do: hd(assigns[:disclosure]),
        else: []

    has_disclosure_slot = disclosure_slot !== []

    label_slot = if assigns[:label] && assigns[:label] !== [], do: hd(assigns[:label]), else: []
    has_label_slot = label_slot !== []
    value_for_derived_label = rest[:checked_value] || rest[:value]

    derived_label =
      case assigns.input_type do
        :checkbox -> Phoenix.HTML.Form.humanize(value_for_derived_label || field)
        :radio_button -> Phoenix.HTML.Form.humanize(assigns.value)
      end

    has_label = has_label_slot || derived_label !== "Nil"

    input_class =
      AttributeHelpers.classnames([
        if has_disclosure_slot do
          "form-checkbox-details-trigger"
        end,
        assigns.classes[:input]
      ])

    input_opts =
      AttributeHelpers.append_attributes(rest, [
        input_class && [class: input_class]
      ])

    input =
      case assigns.input_type do
        :checkbox ->
          Phoenix.HTML.Form.checkbox(form, field, input_opts)

        :radio_button ->
          Phoenix.HTML.Form.radio_button(form, field, assigns.value, input_opts)
      end

    label_class =
      AttributeHelpers.classnames([
        assigns.classes[:label],
        label_slot[:class]
      ])

    label_attributes =
      AttributeHelpers.append_attributes(
        assigns_to_attributes(label_slot, [
          :class
        ]),
        [
          label_class && [class: label_class],
          has_disclosure_slot && [aria_live: "polite"]
        ]
      )

    assigns =
      assigns
      |> assign(:input, input)
      |> assign(:classes, classes)
      |> assign(:has_label, has_label)
      |> assign(:label_slot, label_slot)
      |> assign(:label_attributes, label_attributes)
      |> assign(:derived_label, derived_label)
      |> assign(:has_disclosure_slot, has_disclosure_slot)

    render_hint = fn ->
      ~H"""
      <%= for slot <- @hint do %>
        <p class={@classes.hint.(slot)}>
          <%= render_slot(slot, @classes) %>
        </p>
      <% end %>
      """
    end

    render_disclosure = fn ->
      ~H"""
      <%= for slot <- @disclosure do %>
        <span class={@classes.disclosure.(slot)}>
          <%= render_slot(slot, @classes) %>
        </span>
      <% end %>
      """
    end

    label =
      case assigns.is_emphasised_label do
        true ->
          ~H"""
          <em class="highlight"><%= render_slot(@label_slot) || @derived_label %></em>
          """

        false ->
          ~H"""
          <%= render_slot(@label_slot) || @derived_label %>
          """
      end

    assigns =
      assigns
      |> assign(:label, label)
      |> assign(:render_hint, render_hint)
      |> assign(:render_disclosure, render_disclosure)

    ~H"""
    <%= if @has_label do %>
      <div class={@classes.container}>
        <label {@label_attributes}>
          <%= @input %>
          <%= @label %>
          <%= if @has_disclosure_slot do %>
            <%= @render_disclosure.() %>
          <% end %>
        </label>
        <%= if @hint && @hint !== [] do %>
          <%= @render_hint.() %>
        <% end %>
      </div>
    <% else %>
      <%= @input %>
    <% end %>
    """
  end

  # ------------------------------------------------------------------------------------
  # radio_button
  # ------------------------------------------------------------------------------------

  @doc section: :forms

  @doc ~S"""
  Generates a radio button.

  Wrapper around `Phoenix.HTML.Form.radio_button/4`.

  [Examples](#radio_button/1-examples) • [Attributes](#radio_button/1-attributes) • [Slots](#radio_button/1-slots) • [Reference](#radio_button/1-reference)

  ```
  <.radio_button name="role" value="admin" />
  <.radio_button name="role" value="editor" />
  ```

  ## Examples

  Set the checked state:

  ```
  <.radio_button name="role" value="admin" />
  <.radio_button name="role" value="editor" checked />
  ```

  Using the radio button with form data. This will automatically create the radio button label:

  ```
  <.form let={f} for={@changeset} phx-change="validate" phx-submit="save">
    <.radio_button form={f} field={:role} value="admin" />
    <.radio_button form={f} field={:role} value="editor" />
  </.form>
  ```

  Pass a custom radio button label with the `label` slot:

  ```
  <.radio_button form={:user} field={:role}>
    <:label>Some label</:label>
  </.radio_button>
  ```

  Add emphasis to the label:

  ```
  <.radio_button name="role" is_emphasised_label />
  ```

  Add a hint below the label:

  ```
  <.radio_button name="role">
    <:label>Some label</:label>
    <:hint>
      Add your <strong>resume</strong> below
    </:hint>
  </.radio_button>
  ```

  Reveal extra details when the radio button is checked:

  ```
  <.radio_button name="role">
    <:label>Some label</:label>
    <:disclosure>
      <span class="d-block mb-1">Available hours per week</span>
      <input type="text" name="" class="form-control input-contrast" size="3" />
      <span class="text-small color-fg-muted pl-2">hours per week</span>
    </:disclosure>
  </.radio_button>
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

  attr(:value, :string, default: nil, doc: "Input value.")

  attr(:is_emphasised_label, :boolean, default: false, doc: "Adds emphasis to the label.")

  attr(:class, :string, default: nil, doc: "Additional classname.")

  attr(:classes, :map,
    default: %{
      label: nil,
      input: nil,
      hint: nil,
      disclosure: nil
    },
    doc: """
    Additional classnames for radio button elements.

    Any provided value will be appended to the default classname.

    Default map:
    ```
    %{
      label: "",      # Input label
      input: "",      # Radio button input element
      hint: "",       # Hint message container
      disclosure: ""  # Disclosure container (inline)
    }
    ```
    """
  )

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the input element.
    """
  )

  slot :label,
    doc: """
    Custom radio button label. Overides the derived label when using a `form` and `field`.
    """ do
    attr(:rest, :any,
      doc: """
      Additional HTML attributes added to the label element.
      """
    )
  end

  slot :hint,
    doc: """
    Adds text below the radio button label. Enabled when a label is displayed.
    """ do
    attr(:rest, :any,
      doc: """
      Additional HTML attributes added to the hint element.
      """
    )
  end

  slot :disclosure,
    doc: """
    Extra label content to be revealed when the radio button is checked. Enabled when a label is displayed.

    Note that the label element can only contain inline child elements.
    """ do
    attr(:rest, :any,
      doc: """
      Additional HTML attributes added to the disclosure wrapper element.
      """
    )
  end

  def radio_button(assigns) do
    with true <- validate_is_form(assigns) do
      render_radio_button(assigns)
    else
      {:error, reason} ->
        assigns =
          assigns
          |> assign(:reason, reason)

        ~H"""
        <%= @reason %>
        """
    end
  end

  defp render_radio_button(assigns) do
    form = assigns[:form]
    field = assigns[:field]

    # Remove type from rest, we'll set it on the input
    rest =
      assigns_to_attributes(assigns.rest, [
        :type
      ])

    assigns =
      assigns
      |> assign(:form, form)
      |> assign(:field, field)
      |> assign(:rest, rest)
      |> assign(:input_type, :radio_button)

    render_checkbox_input(assigns)
  end

  # ------------------------------------------------------------------------------------
  # radio_group
  # ------------------------------------------------------------------------------------

  @doc section: :forms

  @doc ~S"""
  Groups radio buttons in a tab-like row.

  [Examples](#radio_group/1-examples) • [Attributes](#radio_group/1-attributes) • [Slots](#radio_group/1-slots) • [Reference](#radio_group/1-reference)

  Radio buttons are generated from the `radio_button` slot:

  ```
  <.radio_group>
    <:radio_button name="role" value="admin"></:radio_button>
    <:radio_button name="role" value="editor"></:radio_button>
  </.radio_group>
  ```

  ## Examples

  Using a `Phoenix.HTML.Form`, attributes `form` and `field` are passed from radio group to the radio buttons, and labels are generated automatically:

  ```
  <.form let={f} for={@changeset}>
    <.radio_group form={f} field={:role}>
      <:radio_button value="admin"></:radio_button>
      <:radio_button value="editor"></:radio_button>
    </.radio_group>
  </.form>
  ```

  Generates:

  ```
  <form method="post" errors="">
    <div class="radio-group">
      <input class="radio-input" id="demo_user_role_admin"
        name="demo_user[role]" type="radio" value="admin">
      <label class="radio-label" for="demo_user_role_admin">Admin</label>
      <input class="radio-input" id="demo_user_role_editor"
        name="demo_user[role]" type="radio" value="editor">
      <label class="radio-label" for="demo_user_role_editor">Editor</label>
    </div>
  </form>
  ```

  Use custom label with the `radio_button` slot `inner_block`:

  ```
  <.radio_group>
    <:radio_button name="role" value="admin">My role is Admin</:radio_button>
    <:radio_button name="role" value="editor">My role is Editor</:radio_button>
  </.radio_group>
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

  attr(:class, :string, default: nil, doc: "Additional classname.")

  attr(:classes, :map,
    default: %{
      radio_group: nil,
      label: nil,
      radio_input: nil
    },
    doc: """
    Additional classnames for radio group elements.

    Any provided value will be appended to the default classname.

    Default map:
    ```
    %{
      radio_group: "", # Wrapper
      label: "",       # Radio button label
      radio_input: "", # Radio button input
    }
    ```
    """
  )

  attr(:id_prefix, :string, default: nil, doc: "Attribute `id` prefix to create unique ids.")

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the wrapper element.
    """
  )

  slot :radio_button,
    doc: "Generates a radio button." do
    attr(:value, :string, doc: "Radio button value")
  end

  def radio_group(assigns) do
    with true <- validate_is_form(assigns) do
      render_radio_group(assigns)
    else
      {:error, reason} ->
        assigns =
          assigns
          |> assign(:reason, reason)

        ~H"""
        <%= @reason %>
        """
    end
  end

  defp render_radio_group(assigns) do
    form = assigns[:form]
    field = assigns[:field]

    classes = %{
      radio_group:
        AttributeHelpers.classnames([
          "radio-group",
          assigns.classes[:radio_group],
          assigns[:class]
        ]),
      label:
        AttributeHelpers.classnames([
          "radio-label",
          assigns.classes[:label]
        ]),
      radio_input:
        AttributeHelpers.classnames([
          "radio-input",
          assigns.classes[:radio_input]
        ])
    }

    render_radio_button = fn slot ->
      initial_opts =
        assigns_to_attributes(slot, [
          :inner_block,
          :__slot__,
          :value
        ])

      value = slot[:value]
      escaped_value = Phoenix.HTML.html_escape(value)
      id_prefix = if not is_nil(assigns.id_prefix), do: assigns.id_prefix <> "-", else: ""
      id = id_prefix <> Phoenix.HTML.Form.input_id(form, field, escaped_value)

      input_opts =
        AttributeHelpers.append_attributes(initial_opts, [
          [
            class:
              AttributeHelpers.classnames([
                classes.radio_input,
                slot[:class]
              ])
          ],
          [id: id]
        ])

      label_opts =
        AttributeHelpers.append_attributes([], [
          [
            class: classes.label
          ],
          [for: id]
        ])

      derived_label = Phoenix.HTML.Form.humanize(value)

      input = Phoenix.HTML.Form.radio_button(form, field, value, input_opts)

      assigns =
        assigns
        |> assign(:input, input)
        |> assign(:label_opts, label_opts)
        |> assign(:derived_label, derived_label)
        |> assign(:slot, slot)

      ~H"""
      <%= @input %>
      <label {@label_opts}>
        <%= render_slot(@slot) |> ComponentHelpers.maybe_slot_content() || @derived_label %>
      </label>
      """
    end

    assigns =
      assigns
      |> assign(:radio_group_class, classes.radio_group)
      |> assign(:render_radio_button, render_radio_button)

    ~H"""
    <div class={@radio_group_class} {@rest}>
      <%= for slot <- @radio_button do %>
        <%= @render_radio_button.(slot) %>
      <% end %>
    </div>
    """
  end

  # ------------------------------------------------------------------------------------
  # alert
  # ------------------------------------------------------------------------------------

  @doc section: :alerts

  @doc ~S"""
  Generates an alert message.

  [Examples](#alert/1-examples) • [Attributes](#alert/1-attributes) • [Slots](#alert/1-slots) • [Reference](#alert/1-reference)

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

    assigns =
      assigns
      |> assign(:class, class)

    ~H"""
    <div class={@class} {@rest}>
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

  [Attributes](#alert_messages/1-attributes) • [Slots](#alert_messages/1-slots) • [Reference](#alert_messages/1-reference)

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

    assigns =
      assigns
      |> assign(:class, class)

    ~H"""
    <div class={@class} {@rest}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  # ------------------------------------------------------------------------------------
  # layout
  # ------------------------------------------------------------------------------------

  @doc section: :layout

  @doc ~S"""
  Generates a responsive-friendly page layout with 2 columns.

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
      "Use `is_divided` in conjunction with the `layout_item/1` element with attribute `divider` to show a divider between the main content and the sidebar. Generates a 1px line between main and sidebar."
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
    doc: "Generates a wrapper around `main` to keep its content centered up to max width \"lg\"."
  )

  attr(:is_centered_md, :boolean,
    default: false,
    doc: "Generates a wrapper around `main` to keep its content centered up to max width \"md\"."
  )

  attr(:is_centered_xl, :boolean,
    default: false,
    doc: "Generates a wrapper around `main` to keep its content centered up to max width \"xl\"."
  )

  attr(:is_flow_row_hidden, :boolean,
    default: false,
    doc: "On a small screen (up to 544px). Hides the horizontal divider."
  )

  attr(:is_flow_row_shallow, :boolean,
    default: false,
    doc: "On a small screen (up to 544px). Generates a filled 8px horizontal divider."
  )

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the outer element.
    """
  )

  slot :main,
    doc:
      "Generates a main element. Default gutter sizes: md: 16px, lg: 24px (change with `is_gutter_none`, `is_gutter_condensed` and `is_gutter_spacious`). Stacks when container is `sm` (change with `is_flow_row_until_md` and `is_flow_row_until_lg`)." do
    attr(:order, :integer,
      doc:
        "Markup order, defines in what order the slot is rendered in HTML. Keyboard navigation follows the markup order. Decide carefully how the focus order should be be by deciding whether main or sidebar comes first in code. The markup order won't affect the visual position. Possible values: 1 or 2; default value: 2."
    )
  end

  slot(:divider,
    doc:
      "Generates a divider element. The divider will only be shown with option `is_divided`. Generates a line between the main and sidebar elements - horizontal when the elements are stacked and vertical when they are shown side by side."
  )

  slot :sidebar,
    doc:
      "Generates a sidebar element. Widths: md: 256px, lg: 296px (change with `is_narrow_sidebar` and `is_wide_sidebar`)." do
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

    assigns =
      assigns
      |> assign(:classes, classes)
      |> assign(:slots, slots)

    ~H"""
    <div class={@classes.layout} {@rest}>
      <%= for {key, slot} <- @slots do %>
        <%= if key == :main && slot !== [] do %>
          <%= if @is_centered_md || @is_centered_lg || @is_centered_xl do %>
            <div class={@classes.main}>
              <div class={@classes.main_center_wrapper}>
                <%= render_slot(slot) %>
              </div>
            </div>
          <% else %>
            <div class={@classes.main}>
              <%= render_slot(slot) %>
            </div>
          <% end %>
        <% end %>
        <%= if key == :divider && slot !== [] do %>
          <div class={@classes.divider}>
            <%= render_slot(slot) %>
          </div>
        <% end %>
        <%= if key == :sidebar && slot !== [] do %>
          <div class={@classes.sidebar}>
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
  Generates a content container.

  [Examples](#box/1-examples) • [Attributes](#box/1-attributes) • [Slots](#box/1-slots) • [Lets](#box/1-lets) • [Reference](#box/1-reference)

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

  Box can be used inside dialogs. To make the box content scrollable within the confined space of the dialog, use `is_scrollable`. This will make all inner content (`inner_block`, `body` and `rows`) scrollable between header and footer.

  To limit the height of the box, either:
  - Use class "Box--scrollable" to limit the height to `324px`
  - Add style "max-height"

  ```
  <.box is_scrollable class="Box--scrollable">
    <:header>Fixed header</:header>
    <:body>Scrollable body</:body>
    <:row>Scrollable row</:row>
    <:row>Scrollable row</:row>
    ...
    <:footer>Fixed footer</:footer>
  </.box>
  ```

  ```
  <.box is_scrollable style="max-height: 80vh">
    <:header>Fixed header</:header>
    <:body>Scrollable body</:body>
    <:row>Scrollable row</:row>
    <:row>Scrollable row</:row>
    ...
    <:footer>Fixed footer</:footer>
  </.box>
  ```

  [INSERT LVATTRDOCS]

  ## Lets

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
    doc: "Generates a blue box theme."
  )

  attr(:is_danger, :boolean,
    default: false,
    doc: "Generates a danger color box theme. Only works with slots `row` and `body`."
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

  attr(:is_scrollable, :boolean,
    default: false,
    doc: """
    Makes inner content (consistent of `inner_block`, `body` and `rows`) scrollable in a box with maximum height.
    """
  )

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the outer element.
    """
  )

  slot :header,
    doc: "Generates a header row element." do
    attr :class, :string, doc: "Additional classname."
    attr :is_blue, :boolean, doc: "Change the header border and background to blue."
  end

  slot :header_title,
    doc:
      "Generates a title within the header. If no header slot is passed, the header title will be wrapped inside a header element." do
    attr :class, :string, doc: "Additional classname."
  end

  slot :row,
    doc: "Generates a content row element." do
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

    attr(:rest, :any,
      doc: """
      Additional HTML attributes added to the row element.
      """
    )
  end

  slot :body,
    doc: "Generates a body element." do
    attr :class, :string, doc: "Additional classname."
  end

  slot :footer,
    doc: "Generates a footer row element." do
    attr :class, :string, doc: "Additional classname."
  end

  slot(:inner_block, required: true, doc: "Unstructured content.")

  def box(assigns) do
    classes = %{
      box:
        AttributeHelpers.classnames([
          "Box",
          assigns.is_blue and "Box--blue",
          assigns.is_border_dashed and "border-dashed",
          assigns.is_condensed and "Box--condensed",
          assigns.is_danger and "Box--danger",
          assigns.is_spacious and "Box--spacious",
          assigns.is_scrollable and "d-flex flex-column",
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

    assigns =
      assigns
      |> assign(:classes, classes)
      # Create a zip data structure from header and header_title slots, making sure the lists have equal counts:
      |> assign(
        :header_slots,
        Enum.zip(AttributeHelpers.pad_lists(assigns.header, assigns.header_title, []))
      )

    render_header = fn ->
      ~H"""
      <%= for {slot, header_slot} <- @header_slots do %>
        <div class={@classes.header.(slot)}>
          <%= if header_slot && header_slot !== [] do %>
            <h3 class={@classes.header_title.(header_slot)}>
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

    render_row = fn ->
      ~H"""
      <%= for slot <- @row do %>
        <div class={@classes.row.(slot)}>
          <%= render_slot(slot, @classes) %>
        </div>
      <% end %>
      """
    end

    render_body = fn ->
      ~H"""
      <%= for slot <- @body do %>
        <div class={@classes.body.(slot)}>
          <%= render_slot(slot) %>
        </div>
      <% end %>
      """
    end

    render_footer = fn ->
      ~H"""
      <%= for slot <- @footer do %>
        <div class={@classes.footer.(slot)}>
          <%= render_slot(slot) %>
        </div>
      <% end %>
      """
    end

    assigns =
      assigns
      |> assign(:render_body, render_body)
      |> assign(:render_row, render_row)

    # Render inner_block, body and rows
    render_inner_content = fn ->
      ~H"""
      <%= render_slot(@inner_block) %>
      <%= if @body && @body !== [] do %>
        <%= @render_body.() %>
      <% end %>
      <%= if @row && @row !== [] do %>
        <%= @render_row.() %>
      <% end %>
      """
    end

    assigns =
      assigns
      |> assign(:render_header, render_header)
      |> assign(:render_inner_content, render_inner_content)
      |> assign(:render_footer, render_footer)

    ~H"""
    <div class={@classes.box} {@rest}>
      <%= if @header_slots && @header_slots !== [] do %>
        <%= @render_header.() %>
      <% end %>
      <%= if @is_scrollable do %>
        <div class="overflow-auto">
          <%= @render_inner_content.() %>
        </div>
      <% else %>
        <%= @render_inner_content.() %>
      <% end %>
      <%= if @footer && @footer !== [] do %>
        <%= @render_footer.() %>
      <% end %>
    </div>
    """
  end

  # ------------------------------------------------------------------------------------
  # header
  # ------------------------------------------------------------------------------------

  @doc section: :header

  @doc ~S"""
  Generates a navigational header, to be placed at the top of the page.

  [Examples](#header/1-examples) • [Attributes](#header/1-attributes) • [Slots](#header/1-slots) • [Lets](#header/1-lets) •  [Reference](#header/1-reference)

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

  ## Lets

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
    attr :is_full, :boolean, doc: "Stretches the item to maximum."

    attr(:rest, :any,
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

    assigns =
      assigns
      |> assign(:classes, classes)

    render_item = fn item ->
      {item_rest, item_class, item_classes} = item_attributes.(item)

      assigns =
        assigns
        |> assign(:item_rest, item_rest)
        |> assign(:item, item)
        |> assign(:item_classes, item_classes)
        |> assign(:item_class, item_class)

      ~H"""
      <div class={@item_class} {@item_rest}>
        <%= if not is_nil(@item.inner_block) do %>
          <%= render_slot(@item, @item_classes) %>
        <% end %>
      </div>
      """
    end

    assigns =
      assigns
      |> assign(:render_item, render_item)

    ~H"""
    <div class={@classes.header} {@rest}>
      <%= for item <- @item do %>
        <%= @render_item.(item) %>
      <% end %>
    </div>
    """
  end

  # ------------------------------------------------------------------------------------
  # dropdown
  # ------------------------------------------------------------------------------------

  @doc section: :dropdown

  @doc ~S"""
  Generates a dropdown menu.

  Dropdowns are small context menus that can be used for navigation and actions. They are a simple alternative to [select menus](`select_menu/1`).

  [Examples](#dropdown/1-examples) • [Attributes](#dropdown/1-attributes) • [Slots](#dropdown/1-slots) • [Reference](#dropdown/1-reference)

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
    Generates a toggle element (default with button appearance) using the slot content as label.

    Any custom class will override the default class "btn".
    """
  )

  slot :menu,
    doc: """
    Generates a menu element.
    """ do
    attr(:title, :string,
      doc: """
      Generates a menu header with specified title.
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
      Generates a divider element.
      """
    )

    attr(:href, :any,
      doc: """
      Link attribute. If used, the menu item will be created with `Phoenix.Component.link/1`, passing all other attributes to the link.
      """
    )

    attr(:patch, :string,
      doc: """
      Link attribute - see `href`.
      """
    )

    attr(:navigate, :string,
      doc: """
      Link attribute - see `href`.
      """
    )

    attr(:rest, :any,
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

    toggle_attrs =
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

    menu_attributes =
      AttributeHelpers.append_attributes([], [
        [class: classes[:menu]]
      ])

    assigns =
      assigns
      |> assign(:menu_attributes, menu_attributes)
      |> assign(:toggle_attrs, toggle_attrs)
      |> assign(:classes, classes)
      |> assign(:toggle_slot, toggle_slot)
      |> assign(:menu_title, menu_slot[:title])

    render_item = fn item ->
      is_divider = !!item[:is_divider]

      assigns =
        assigns
        |> assign(:item, item)
        |> assign(:is_divider, is_divider)
        |> assign(:item_attributes, item_attributes.(item, is_divider))

      ~H"""
      <%= if @is_divider do %>
        <li {@item_attributes} />
      <% else %>
        <li>
          <Phoenix.Component.link {@item_attributes}>
            <%= render_slot(@item) %>
          </Phoenix.Component.link>
        </li>
      <% end %>
      """
    end

    assigns =
      assigns
      |> assign(:render_item, render_item)

    render_menu = fn menu_attributes ->
      assigns =
        assigns
        |> assign(:menu_attributes, menu_attributes)

      ~H"""
      <ul {@menu_attributes}>
        <%= for item <- @item do %>
          <%= @render_item.(item) %>
        <% end %>
      </ul>
      """
    end

    assigns =
      assigns
      |> assign(:render_menu, render_menu)

    ~H"""
    <details class={@classes.dropdown} {@rest}>
      <summary {@toggle_attrs}>
        <%= render_slot(@toggle_slot) %>
        <div class={@classes.caret}></div>
      </summary>
      <%= if not is_nil(@menu_title) do %>
        <div {@menu_attributes}>
          <div class={@classes.header}>
            <%= @menu_title %>
          </div>
          <%= @render_menu.([]) %>
        </div>
      <% else %>
        <%= @render_menu.(@menu_attributes) %>
      <% end %>
    </details>
    """
  end

  # ------------------------------------------------------------------------------------
  # select_menu
  # ------------------------------------------------------------------------------------

  @doc section: :select_menu

  @doc ~S"""
  Generates a select menu.

  [Examples](#select_menu/1-examples) • [Attributes](#select_menu/1-attributes) • [Slots](#select_menu/1-slots) • [Reference](#select_menu/1-reference)

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
    ...
  </.select_menu>
  ```

  Add a message:

  ```
  <.select_menu>
    <:toggle>Menu</:toggle>
    <:message class="color-bg-danger color-fg-danger">Message</:message>
    ...
  </.select_menu>
  ```

  Add a filter input:

  ```
   <.select_menu>
    <:toggle>Menu</:toggle>
    <:filter>
      <form>
        <.text_input class="SelectMenu-input" type="search" name="q" placeholder="Filter" />
      </form>
    </:filter>
    ...
  </.select_menu>
  ```

  Add a tab menu filter by using slot `tab`:

  ```
   <.select_menu>
    <:toggle>Menu</:toggle>
    <:tab is_selected>
      Selected
    </:tab>
    <:tab>
      Other tab
    </:tab>
    ...
  </.select_menu>
  ```

  Add a footer:

  ```
  <.select_menu>
    <:toggle>Menu</:toggle>
    ...
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

  Feature complete.

  """

  attr :is_right_aligned, :boolean, default: false, doc: "Aligns the menu to the right."
  attr :is_borderless, :boolean, default: false, doc: "Removes the borders between list items."

  attr :class, :string, doc: "Additional classname."

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
      select_menu: nil,
      tabs: nil,
      tab: nil,
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
      select_menu: "",         # Select menu container (details element).
      tabs: "",                # Tab container.
      tab: "",                 # Tab button.
      toggle: "",              # Toggle element. Any value will override the
                               # default class "btn".
    }
    ```
    """

  attr :is_backdrop, :boolean,
    default: false,
    doc: """
    Generates a light backdrop background color.
    """

  attr :is_dark_backdrop, :boolean,
    default: false,
    doc: """
    Generates a darker backdrop background color.
    """

  attr :is_medium_backdrop, :boolean,
    default: false,
    doc: """
    Generates a medium backdrop background color.
    """

  attr :is_light_backdrop, :boolean,
    default: false,
    doc: """
    Generates a lighter backdrop background color (default).
    """

  attr :is_fast, :boolean,
    default: true,
    doc: """
    Generates fast fade transitions for backdrop and content.
    """

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the outer element.
    """
  )

  slot(:toggle,
    required: true,
    doc: """
    Generates a toggle element (default with button appearance) using the slot content as label.

    Any custom class will override the default class "btn".
    """
  )

  slot :menu,
    doc: """
    Generates a menu element.
    """ do
    attr(:title, :string,
      doc: """
      Generates a menu header with specified title.
      """
    )
  end

  slot(:filter,
    doc: """
    Filter slot to insert a `text_input/1` component that will drive a custom filter function.
    """
  )

  slot :tab,
    doc: """
    Tab item element. If a tab slot is used, a tab navigation will be generated containing button elements.
    """ do
    attr(:is_selected, :boolean,
      doc: """
      The currently selected tab.
      """
    )

    attr(:rest, :any,
      doc: """
      Additional HTML attributes added to the tab element.
      """
    )
  end

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
      Generates a disabled state.
      """
    )

    attr(:is_divider, :boolean,
      doc: """
      Generates a divider. The divider may have content, for example a label "More options".
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
      Link attribute - see `href`.
      """
    )

    attr(:navigate, :string,
      doc: """
      Link attribute - see `href`.
      """
    )

    attr(:rest, :any,
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
          select_menu: nil,
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
          assigns_classes[:select_menu],
          assigns[:class]
        ]),
      toggle:
        AttributeHelpers.classnames([
          # If a custom class is set, remove the default btn class
          if assigns_classes[:toggle] || toggle_slot[:class] do
            AttributeHelpers.classnames([
              assigns_classes[:toggle],
              toggle_slot[:class]
            ])
          else
            "btn"
          end
        ]),
      menu:
        AttributeHelpers.classnames([
          "SelectMenu",
          assigns.is_right_aligned and "right-0",
          assigns[:filter] !== [] && "SelectMenu--hasFilter",
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
        ]),
      tabs:
        AttributeHelpers.classnames([
          "SelectMenu-tabs",
          assigns_classes.tabs
        ]),
      tab: fn slot ->
        AttributeHelpers.classnames([
          "SelectMenu-tab",
          assigns.classes.tab,
          slot[:class]
        ])
      end
    }

    toggle_attrs =
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

    select_menu_attrs =
      AttributeHelpers.append_attributes(assigns.rest, [
        [class: classes.select_menu],
        # Add the menu id when we will show a header with close button
        not is_nil(menu_id) and [data_menuid: menu_id],
        [data_prompt: ""],
        [ontoggle: "Prompt.init(this)"],
        assigns.is_fast &&
          (assigns.is_dark_backdrop ||
             assigns.is_medium_backdrop ||
             assigns.is_light_backdrop ||
             assigns.is_backdrop) && [data_isfast: ""]
      ])

    menu_container_attrs =
      AttributeHelpers.append_attributes([], [
        [class: classes.menu_container],
        [data_content: ""],
        [aria_role: "menu"]
      ])

    backdrop_attrs =
      AttributeHelpers.append_attributes([], [
        cond do
          assigns.is_dark_backdrop -> [data_backdrop: "", data_isdark: ""]
          assigns.is_medium_backdrop -> [data_backdrop: "", data_ismedium: ""]
          assigns.is_light_backdrop -> [data_backdrop: "", data_islight: ""]
          assigns.is_backdrop -> [data_backdrop: "", data_islight: ""]
          true -> []
        end
      ])

    render_item = fn item ->
      is_link = AttributeHelpers.is_link?(item)
      is_divider = !!item[:is_divider]
      is_divider_content = is_divider && !!item.inner_block
      is_button = !is_link && !is_divider
      selected_octicon_name = item[:selected_octicon_name] || "check-16"

      assigns =
        assigns
        |> assign(:item, item)
        |> assign(:is_divider, is_divider)
        |> assign(:is_divider_content, is_divider_content)
        |> assign(:divider_attributes, divider_attributes)
        |> assign(:is_button, is_button)
        |> assign(:item_attributes, item_attributes)
        |> assign(:selected_octicon_name, selected_octicon_name)
        |> assign(:is_any_item_selected, is_any_item_selected)
        |> assign(:is_link, is_link)

      ~H"""
      <%= if @is_divider do %>
        <%= if @is_divider_content do %>
          <div {@divider_attributes.(@item)}>
            <%= render_slot(@item) %>
          </div>
        <% else %>
          <hr {@divider_attributes.(@item)} />
        <% end %>
      <% end %>
      <%= if @is_button do %>
        <button {@item_attributes.(@item)}>
          <%= if @is_any_item_selected do %>
            <.octicon name={@selected_octicon_name} class="SelectMenu-icon SelectMenu-icon--check" />
          <% end %>
          <%= render_slot(@item) %>
        </button>
      <% end %>
      <%= if @is_link do %>
        <Phoenix.Component.link {@item_attributes.(@item)}>
          <%= if @is_any_item_selected do %>
            <.octicon name={@selected_octicon_name} class="SelectMenu-icon SelectMenu-icon--check" />
          <% end %>
          <%= render_slot(@item) %>
        </Phoenix.Component.link>
      <% end %>
      """
    end

    render_tab = fn slot ->
      is_link = AttributeHelpers.is_link?(slot)

      rest =
        assigns_to_attributes(slot, [
          :class,
          :is_selected
        ])

      attributes =
        AttributeHelpers.append_attributes(rest, [
          [class: classes.tab.(slot)],
          [role: "tab"],
          slot[:is_selected] && [aria_selected: "true"]
        ])

      assigns =
        assigns
        |> assign(:is_link, is_link)
        |> assign(:attributes, attributes)
        |> assign(:slot, slot)

      ~H"""
      <%= if @is_link do %>
        <Phoenix.Component.link {@attributes}>
          <%= render_slot(@slot) %>
        </Phoenix.Component.link>
      <% else %>
        <button {@attributes}>
          <%= render_slot(@slot) %>
        </button>
      <% end %>
      """
    end

    assigns =
      assigns
      |> assign(:classes, classes)
      |> assign(:select_menu_attrs, select_menu_attrs)
      |> assign(:toggle_attrs, toggle_attrs)
      |> assign(:toggle_slot, toggle_slot)
      |> assign(:backdrop_attrs, backdrop_attrs)
      |> assign(:menu_container_attrs, menu_container_attrs)
      |> assign(:menu_title, menu_title)
      |> assign(:item_slots, item_slots)
      |> assign(:render_item, render_item)
      |> assign(:render_tab, render_tab)

    ~H"""
    <details {@select_menu_attrs}>
      <summary {@toggle_attrs}>
        <%= render_slot(@toggle_slot) %>
      </summary>
      <%= if @backdrop_attrs !== [] do %>
        <div {@backdrop_attrs} />
      <% end %>
      <div data-touch=""></div>
      <div class={@classes.menu}>
        <div {@menu_container_attrs}>
          <%= if not is_nil(@menu_title) do %>
            <header class={@classes.header}>
              <h3 class={@classes.menu_title}><%= @menu_title %></h3>
              <button class={@classes.header_close_button} type="button" onclick="Prompt.hide(this)">
                <.octicon name="x-16" />
              </button>
            </header>
          <% end %>
          <%= if @message do %>
            <%= for message <- @message do %>
              <div class={AttributeHelpers.classnames([@classes.message, message[:class]])}>
                <%= render_slot(message) %>
              </div>
            <% end %>
          <% end %>
          <%= if @filter && @filter !== [] do %>
            <div class={@classes.filter}>
              <%= render_slot(@filter) %>
            </div>
          <% end %>
          <%= if @tab && @tab !== [] do %>
            <div class={@classes.tabs}>
              <%= for slot <- @tab do %>
                <%= @render_tab.(slot) %>
              <% end %>
            </div>
          <% end %>
          <%= if @loading do %>
            <%= for loading <- @loading do %>
              <div class={AttributeHelpers.classnames([@classes.loading, loading[:class]])}>
                <%= render_slot(loading) %>
              </div>
            <% end %>
          <% end %>
          <div class={@classes.menu_list}>
            <%= if @blankslate do %>
              <%= for blankslate <- @blankslate do %>
                <div class={AttributeHelpers.classnames([@classes.blankslate, blankslate[:class]])}>
                  <%= render_slot(blankslate) %>
                </div>
              <% end %>
            <% end %>

            <%= for item <- @item_slots do %>
              <%= @render_item.(item) %>
            <% end %>
          </div>
          <%= if @footer do %>
            <%= for footer <- @footer do %>
              <div class={AttributeHelpers.classnames([@classes.footer, footer[:class]])}>
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
  Generates a button.

  [Examples](#button/1-examples) • [Attributes](#button/1-attributes) • [Slots](#button/1-slots) • Reference](#button/1-reference)

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
  attr :is_full_width, :boolean, default: false, doc: "Generates a full-width button."

  attr :is_close_button, :boolean,
    default: false,
    doc: "Use when enclosing icon \"x-16\". This setting removes the default padding."

  attr :is_danger, :boolean, default: false, doc: "Generates a red button."
  attr :is_disabled, :boolean, default: false, doc: "Generates a disabled button."

  attr :is_icon_only, :boolean,
    default: false,
    doc: "Generates an icon button without a label. Add `is_danger` to create a danger icon."

  attr :is_invisible, :boolean,
    default: false,
    doc: "Create a button that looks like a link, maintaining the paddings of a regular button."

  attr :is_large, :boolean, default: false, doc: "Generates a large button."
  attr :is_link, :boolean, default: false, doc: "Create a button that looks like a link."
  attr :is_outline, :boolean, default: false, doc: "Generates an outline button."
  attr :is_primary, :boolean, default: false, doc: "Generates a primary colored button."
  attr :is_selected, :boolean, default: false, doc: "Generates a selected button."
  attr :is_small, :boolean, default: false, doc: "Generates a small button."
  attr :is_submit, :boolean, default: false, doc: "Generates a button with type=\"submit\"."

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the button element.
    """
  )

  slot(:inner_block, required: true, doc: "Button content.")

  def button(assigns) do
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

    assigns =
      assigns
      |> assign(:class, class)
      |> assign(:aria_attributes, aria_attributes)
      |> assign(:type, if(assigns.is_submit, do: "submit", else: "button"))

    ~H"""
    <button class={@class} type={@type} {@rest} {@aria_attributes}>
      <%= render_slot(@inner_block) %>
    </button>
    """
  end

  # ------------------------------------------------------------------------------------
  # button_group
  # ------------------------------------------------------------------------------------

  @doc section: :buttons

  @doc ~S"""
  Generates a group of buttons.

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

    assigns = assigns |> assign(:classes, classes)

    ~H"""
    <div class={@classes.button_group} {@rest}>
      <%= for slot <- @button do %>
        <.button {slot} class={@classes.button.(slot)}>
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
  Generates a control to navigate search results.

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

  attr :is_numbered, :any, default: true, doc: "Boolean atom or string. Showing page numbers."
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

    assigns =
      assigns
      |> assign(:classes, classes)
      |> assign(:show_prev_next, show_prev_next)
      |> assign(:has_previous_page, has_previous_page)
      |> assign(:has_next_page, has_next_page)
      |> assign(:show_numbers, show_numbers)
      |> assign(:pagination_elements, pagination_elements)
      |> assign(:current_page, current_page)

    ~H"""
    <%= if @page_count > 1 do %>
      <nav class={@classes.pagination_container} {@rest} aria-label={@labels.aria_label_container}>
        <div class={@classes.pagination}>
          <%= if @show_prev_next do %>
            <%= if @has_previous_page do %>
              <Phoenix.Component.link
                navigate={@link_path.(@current_page - 1)}
                class={@classes.previous_page}
                rel="previous"
                aria-label={@labels.aria_label_previous_page}
                replace={@link_options.replace}
              >
                <%= @labels.previous_page %>
              </Phoenix.Component.link>
            <% else %>
              <span class={@classes.previous_page} aria-disabled="true" phx-no-format><%= @labels.previous_page %></span>
            <% end %>
          <% end %>
          <%= if @show_numbers do %>
            <%= for item <- @pagination_elements do %>
              <%= if item === @current_page do %>
                <em aria-current="page"><%= @current_page %></em>
              <% else %>
                <%= if item == 0 do %>
                  <span class={@classes.gap} phx-no-format><%= @labels.gap %></span>
                <% else %>
                  <Phoenix.Component.link
                    navigate={@link_path.(item)}
                    class={@classes.page}
                    aria-label={
                      @labels.aria_label_page |> String.replace("{page_number}", to_string(item))
                    }
                    replace={@link_options.replace}
                  >
                    <%= item %>
                  </Phoenix.Component.link>
                <% end %>
              <% end %>
            <% end %>
          <% end %>
          <%= if @show_prev_next do %>
            <%= if @has_next_page do %>
              <Phoenix.Component.link
                navigate={@link_path.(@current_page + 1)}
                class={@classes.next_page}
                rel="next"
                aria-label={@labels.aria_label_next_page}
                replace={@link_options.replace}
              >
                <%= @labels.next_page %>
              </Phoenix.Component.link>
            <% else %>
              <span class={@classes.next_page} aria-disabled="true" phx-no-format><%= @labels.next_page %></span>
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

    assigns =
      assigns |> assign(:icon, PrimerLive.Octicons.octicons(assigns) |> Map.get(assigns[:name]))

    ~H"""
    <%= if @icon do %>
      <%= @icon %>
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
  Generates a label element.

  Labels add metadata or indicate status of items and navigational elements.

  [Examples](#label/1-examples) • [Attributes](#label/1-attributes) • [Slots](#label/1-slots) • [Reference](#label/1-reference)

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
    Generates a label with a stronger border.
    """

  attr :is_secondary, :boolean,
    default: false,
    doc: """
    Generates a label with a subtler text color.
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

    assigns = assigns |> assign(:class, class)

    # Keep this as a single line to preserve whitespace in the rendered HTML
    ~H"""
    <span class={@class} {@rest}><%= render_slot(@inner_block) %></span>
    """
  end

  # ------------------------------------------------------------------------------------
  # issue_label
  # ------------------------------------------------------------------------------------

  @doc section: :labels

  @doc ~S"""
  Issue labels are used for adding labels to issues and pull requests. They also come with emoji support.

  And issue label is basically labels without a border. It expects background and foreground colors.

  [Examples](#issue_label/1-examples) • [Attributes](#issue_label/1-attributes) • [Slots](#issue_label/1-slots) • [Reference](#issue_label/1-reference)

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

    assigns = assigns |> assign(:class, class)

    # Keep this as a single line to preserve whitespace in the rendered HTML
    ~H"""
    <span class={@class} {@rest}><%= render_slot(@inner_block) %></span>
    """
  end

  # ------------------------------------------------------------------------------------
  # state_label
  # ------------------------------------------------------------------------------------

  @doc section: :labels

  @doc ~S"""
  Shows an item's status.

  State labels are larger and styled with bolded text. Attribute settings allows to apply colors.

  [Examples](#state_label/1-examples) • [Attributes](#state_label/1-attributes) • [Slots](#state_label/1-slots) • [Reference](#state_label/1-reference)

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

    assigns = assigns |> assign(:class, class)

    # Keep this as a single line to preserve whitespace in the rendered HTML
    ~H"""
    <span class={@class} {@rest}><%= render_slot(@inner_block) %></span>
    """
  end

  # ------------------------------------------------------------------------------------
  # counter
  # ------------------------------------------------------------------------------------

  @doc section: :labels

  @doc ~S"""
  Adds a count to navigational elements and buttons.

  [Examples](#counter/1-examples) • [Attributes](#counter/1-attributes) • [Slots](#counter/1-slots) • [Reference](#counter/1-reference)

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

    assigns = assigns |> assign(:class, class)

    # Keep this as a single line to preserve whitespace in the rendered HTML
    ~H"""
    <span class={@class} {@rest}><%= render_slot(@inner_block) %></span>
    """
  end

  # ------------------------------------------------------------------------------------
  # subhead
  # ------------------------------------------------------------------------------------

  @doc section: :subhead

  @doc ~S"""
  Configurable and styled h2 heading.

  [Examples](#subhead/1-examples) • [Attributes](#subhead/1-attributes) • [Slots](#subhead/1-slots) • [Reference](#subhead/1-reference)

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

    assigns = assigns |> assign(:classes, classes)

    ~H"""
    <div class={@classes.subhead} {@rest}>
      <h2 class={@classes.heading}><%= render_slot(@inner_block) %></h2>
      <%= if @description do %>
        <%= for description <- @description do %>
          <div class={AttributeHelpers.classnames([@classes.description, description[:class]])}>
            <%= render_slot(description) %>
          </div>
        <% end %>
      <% end %>
      <%= if @actions do %>
        <%= for action <- @actions do %>
          <div class={AttributeHelpers.classnames([@classes.actions, action[:class]])}>
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

  [Examples](#breadcrumb/1-examples) • [Attributes](#breadcrumb/1-attributes) • [Slots](#breadcrumb/1-slots) • [Reference](#breadcrumb/1-reference)

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
      Link attribute - see `href`.
      """
    )

    attr(:navigate, :string,
      doc: """
      Link attribute - see `href`.
      """
    )

    attr(:rest, :any,
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

    assigns =
      assigns
      |> assign(:classes, classes)
      |> assign(:items_data, items_data)
      |> assign(:item_attributes, item_attributes)
      |> assign(:link_attributes, link_attributes)

    ~H"""
    <div class={@classes.breadcrumb} {@rest}>
      <%= if @items_data !== [] do %>
        <ol>
          <%= for {item, is_last} <- @items_data do %>
            <li {@item_attributes.(is_last)}>
              <Phoenix.Component.link {@link_attributes.(item)}>
                <%= render_slot(item) %>
              </Phoenix.Component.link>
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
  Generates a consistent link-like appearance of actual links and spans inside links.

  The component name deviates from the PrimerCSS name `Link` to prevent a naming conflict with `Phoenix.Component.link/1`.

  [Examples](#as_link/1-examples) • [Attributes](#as_link/1-attributes) • [Slots](#as_link/1-slots) • [Reference](#as_link/1-reference)

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

  attr(:href, :any,
    doc: """
    Link attribute. If used, the link will be created with `Phoenix.Component.link/1`, passing all other attributes to the link.
    """
  )

  attr(:patch, :string,
    doc: """
    Link attribute - see `href`.
    """
  )

  attr(:navigate, :string,
    doc: """
    Link attribute - see `href`.
    """
  )

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the link or span.
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

    attributes =
      AttributeHelpers.append_attributes(assigns.rest, [
        [class: class],
        [href: assigns[:href], navigate: assigns[:navigate], patch: assigns[:patch]]
      ])

    is_link = AttributeHelpers.is_link?(assigns)

    assigns =
      assigns
      |> assign(:is_link, is_link)
      |> assign(:attributes, attributes)

    ~H"""
    <%= if @is_link do %>
      <Phoenix.Component.link {@attributes}>
        <%= render_slot(@inner_block) %>
      </Phoenix.Component.link>
    <% else %>
      <span {@attributes}><%= render_slot(@inner_block) %></span>
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

    assigns = assigns |> assign(:class, class)

    ~H"""
    <img class={@class} {@rest} />
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

  # ------------------------------------------------------------------------------------
  # parent_child_avatar
  # ------------------------------------------------------------------------------------

  @doc section: :avatars

  @doc ~S"""
  Generates a larger "parent" avatar with a smaller "child" overlaid on top.

  [Examples](#parent_child_avatar/1-examples) • [Attributes](#parent_child_avatar/1-attributes) • [Slots](#parent_child_avatar/1-slots) • [Reference](#parent_child_avatar/1-reference)

  ## Examples

  Use slots `parent` and `child` to create the avatars using `avatar/1` attributes:

  ```
  <.parent_child_avatar>
    <:parent src="emma.jpg" size="7" />
    <:child src="kim.jpg" size="2" />
  </.parent_child_avatar>
  ```

  [INSERT LVATTRDOCS]

  ## Reference

  [Primer/CSS Avatars](https://primer.style/css/components/avatars)

  ## Status

  Feature complete.

  """

  attr(:class, :string, default: nil, doc: "Additional classname.")

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the outer element.
    """
  )

  slot :parent,
    doc: "Generates a parent avatar." do
    attr(:size, :integer, doc: "Avatar size - see `avatar/1`.")

    attr(:rest, :any,
      doc: """
      Additional HTML attributes added to the parent avatar.
      """
    )
  end

  slot :child,
    doc: "Generates a child avatar." do
    attr(:size, :integer, doc: "Avatar size - see `avatar/1`.")

    attr(:rest, :any,
      doc: """
      Additional HTML attributes added to the child avatar.
      """
    )
  end

  def parent_child_avatar(assigns) do
    classes = %{
      parent_child:
        AttributeHelpers.classnames([
          "avatar-parent-child",
          "d-inline-flex",
          assigns[:class]
        ]),
      child:
        AttributeHelpers.classnames([
          "avatar-child"
        ])
    }

    render_avatar = fn slot, is_child ->
      class =
        AttributeHelpers.classnames([
          if is_child do
            classes.child
          end,
          slot[:class]
        ])

      rest =
        assigns_to_attributes(slot, [
          :class
        ])

      assigns =
        assigns
        |> assign(:class, class)
        |> assign(:rest, rest)

      ~H"""
      <.avatar class={@class} {@rest} />
      """
    end

    assigns =
      assigns
      |> assign(:classes, classes)
      |> assign(:render_avatar, render_avatar)

    ~H"""
    <div class={@classes.parent_child} {@rest}>
      <%= if @parent && @parent !== [] do %>
        <%= for parent <- @parent do %>
          <%= @render_avatar.(parent, false) %>
        <% end %>
      <% end %>
      <%= if @child && @child !== [] do %>
        <%= for child <- @child do %>
          <%= @render_avatar.(child, true) %>
        <% end %>
      <% end %>
    </div>
    """
  end

  # ------------------------------------------------------------------------------------
  # circle_badge
  # ------------------------------------------------------------------------------------

  @doc section: :avatars

  @doc ~S"""
  What is it

  [Examples](#circle_badge/1-examples) • [Attributes](#circle_badge/1-attributes) • [Reference](#circle_badge/1-reference)

  ```
  <.circle_badge>
    <:octicon name="alert-16" />
  </.circle_badge>
  ```

  ## Examples

  Use slot `octicon` to create an `octicon/1` icon

  ```
  <.circle_badge>
    <:octicon name="alert-16" />
  </.circle_badge>
  ```

  Use slot `img` to create an image icon

  ```
  <.circle_badge>
    <:img src="https://github.com/travis-ci.png" />
  </.circle_badge>
  ```

  Create a large badge (size "medium" or "large"):

  ```
  <.circle_badge size="medium">
    <:octicon name="alert-24" />
  </.circle_badge>
  ```

  By default, items are turned into `<div>` elements. Pass a link attribute (`href`, `navigate` or `patch`) to change it automatically to a `Phoenix.Component.link/1`:

  ```
  <.circle_badge href="#url">...</.circle_badge>
  <.circle_badge navigate={Routes.page_path(@socket, :index)} class="underline">...</.circle_badge>
  <.circle_badge patch={Routes.page_path(@socket, :index, :details)}>...</.circle_badge>
  ```

  [INSERT LVATTRDOCS]

  ## Reference

  [Primer/CSS Avatars](https://primer.style/css/components/avatars)

  ## Status

  Feature complete.

  """

  attr(:class, :string, default: nil, doc: "Additional classname.")

  attr :size, :string,
    default: "small",
    doc: """
    Badge size: "small", "medium" or "large".

    Sizes:
    - small: `56px` (default)
    - medium: `96px`
    - large: `128px`
    """

  attr(:href, :any,
    doc: """
    Link attribute. If used, the badge will be created with `Phoenix.Component.link/1`, passing all other attributes to the link.
    """
  )

  attr(:patch, :string,
    doc: """
    Link attribute - see `href`.
    """
  )

  attr(:navigate, :string,
    doc: """
    Link attribute - see `href`.
    """
  )

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the outer element.
    """
  )

  slot :octicon,
    doc: "Generates a badge icon with `octicon/1`." do
    attr(:rest, :any,
      doc: """
      Attributes supplied to the `octicon` component.
      """
    )
  end

  slot :img,
    doc: "Generates a badge icon with an `img` tag." do
    attr(:rest, :any,
      doc: """
      HTML attributes supplied to the `img` element.
      """
    )
  end

  def circle_badge(assigns) do
    classes = %{
      circle_badge:
        AttributeHelpers.classnames([
          "CircleBadge",
          assigns.size === "small" && "CircleBadge--small",
          assigns.size === "medium" && "CircleBadge--medium",
          assigns.size === "large" && "CircleBadge--large",
          assigns[:class]
        ]),
      octicon: "CircleBadge-icon",
      img: "CircleBadge-icon"
    }

    render_octicon = fn slot ->
      class =
        AttributeHelpers.classnames([
          classes.octicon,
          slot[:class]
        ])

      rest =
        assigns_to_attributes(slot, [
          :class
        ])

      assigns =
        assigns
        |> assign(:class, class)
        |> assign(:rest, rest)

      ~H"""
      <.octicon class={@class} {@rest} />
      """
    end

    render_img = fn slot ->
      class =
        AttributeHelpers.classnames([
          classes.img,
          slot[:class]
        ])

      rest =
        assigns_to_attributes(slot, [
          :class
        ])

      assigns =
        assigns
        |> assign(:class, class)
        |> assign(:rest, rest)

      ~H"""
      <img class={@class} {@rest} />
      """
    end

    assigns =
      assigns
      |> assign(:render_img, render_img)
      |> assign(:render_octicon, render_octicon)

    render_content = fn ->
      ~H"""
      <%= if @octicon && @octicon !== [] do %>
        <%= for octicon <- @octicon do %>
          <%= @render_octicon.(octicon) %>
        <% end %>
      <% end %>
      <%= if @img && @img !== [] do %>
        <%= for img <- @img do %>
          <%= @render_img.(img) %>
        <% end %>
      <% end %>
      """
    end

    attributes =
      AttributeHelpers.append_attributes(assigns.rest, [
        [class: classes.circle_badge],
        [href: assigns[:href], navigate: assigns[:navigate], patch: assigns[:patch]]
      ])

    is_link = AttributeHelpers.is_link?(assigns)

    assigns =
      assigns
      |> assign(:is_link, is_link)
      |> assign(:attributes, attributes)
      |> assign(:render_content, render_content)

    ~H"""
    <%= if @is_link do %>
      <Phoenix.Component.link {@attributes}>
        <%= @render_content.() %>
      </Phoenix.Component.link>
    <% else %>
      <div {@attributes}>
        <%= @render_content.() %>
      </div>
    <% end %>
    """
  end

  # ------------------------------------------------------------------------------------
  # animated_ellipsis
  # ------------------------------------------------------------------------------------

  @doc section: :loaders

  @doc ~S"""
  Adds animated ellipsis to indicate progress.

  [Examples](#animated_ellipsis/1-examples) • [Attributes](#animated_ellipsis/1-attributes) • [Reference](#animated_ellipsis/1-reference)

  ```
  <.animated_ellipsis />
  ```

  ## Examples

  Inside a header:

  ```
  <h2>Loading<.animated_ellipsis /></h2>
  ```

  Inside a label:

  ```
  <.label>Loading<.animated_ellipsis /></.label>
  ```

  Inside a button:

  ```
  <.button is_disabled>Loading<.animated_ellipsis /></.label>
  ```

  [INSERT LVATTRDOCS]

  ## Reference

  [Primer/CSS Loaders](https://primer.style/css/components/loaders)

  ## Status

  Feature complete.

  """

  attr(:class, :string, default: nil, doc: "Additional classname.")

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the element.
    """
  )

  def animated_ellipsis(assigns) do
    class =
      AttributeHelpers.classnames([
        "AnimatedEllipsis",
        assigns[:class]
      ])

    assigns = assigns |> assign(:class, class)

    ~H"""
    <span class={@class} {@rest} />
    """
  end

  # ------------------------------------------------------------------------------------
  # spinner
  # ------------------------------------------------------------------------------------

  @doc section: :loaders

  @doc ~S"""
  SVG spinner animation.

  This spinner is derived from the Toast loading animation.

  [Examples](#spinner/1-examples) • [Attributes](#spinner/1-attributes)

  ```
  <.spinner />
  ```

  Alternatively, use `octicon/1` with class "Toast--spinner", using any circular icon:

  ```
  <.octicon name="skip-16" class="Toast--spinner" />
  ```

  ## Examples

  Set the size (default: `18`):

  ```
  <.spinner size="40" />
  ```

  Set the circle color (default: `#959da5`):

  ```
  <.spinner color="red" />
  <.spinner color="#ff0000" />
  <.spinner color="rgba(250, 50, 150, 0.5)" />
  ```

  Set the gap color (default: `#ffffff`):

  ```
  <.spinner gap_color="black" />
  <.spinner gap_color="#000000" />
  <.spinner gap_color="rgba(0, 0, 0, 1)" />
  ```

  [INSERT LVATTRDOCS]

  """

  attr(:class, :string, default: nil, doc: "Additional classname.")

  attr(:size, :integer, default: 18, doc: "Spinner size.")

  attr(:color, :string, default: "#959da5", doc: "Spinner color as SVG fill color.")

  attr(:gap_color, :string, default: "#ffffff", doc: "Spinner gap color as SVG fill color.")

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the element.
    """
  )

  def spinner(assigns) do
    class =
      AttributeHelpers.classnames([
        "Toast--spinner",
        assigns[:class]
      ])

    assigns = assigns |> assign(:class, class)

    ~H"""
    <svg class={@class} viewBox="0 0 32 32" width={@size} height={@size} {@rest}>
      <path
        fill={@color}
        d="M16 0 A16 16 0 0 0 16 32 A16 16 0 0 0 16 0 M16 4 A12 12 0 0 1 16 28 A12 12 0 0 1 16 4"
      />
      <path fill={@gap_color} d="M16 0 A16 16 0 0 1 32 16 L28 16 A12 12 0 0 0 16 4z"></path>
    </svg>
    """
  end

  # ------------------------------------------------------------------------------------
  # blankslate
  # ------------------------------------------------------------------------------------

  @doc section: :blankslate

  @doc ~S"""
  What is it

  [Examples](#blankslate/1-examples) • [Attributes](#blankslate/1-attributes) • [Slots](#blankslate/1-slots) • [Reference](#blankslate/1-reference)

  ```
  <.blankslate>
    <:heading>
      This is a blank slate
    </:heading>
    <p>Use it to provide information when no dynamic content exists.</p>
  </.blankslate>
  ```

  Blankslate is created with slots that are applied in this order:
  1. `octicon` or `img`
  1. `heading`
  1. `inner_block`
  1. `action` (multiple)

  ## Examples

  With an `octicon/1`:

  ```
  <.blankslate>
    <:octicon name="rocket-24" />
    ...
  </.blankslate>
  ```

  With an image:

  ```
  <.blankslate>
    <:img src="https://ghicons.github.com/assets/images/blue/png/Pull%20request.png" alt="" />
    ...
  </.blankslate>
  ```

  With an action:

  ```
  <.blankslate>
    <:action>
      <.button is_primary>New project</.button>
    </:action>
    ...
  </.blankslate>
  ```

  Narrow layout:

  ```
  <.blankslate is_narrow>
    ...
  </.blankslate>
  ```

  Large text:

  ```
  <.blankslate is_large>
    ...
  </.blankslate>
  ```

  Combined slots, in a `box/1`:

  ```
  <.box>
    <.blankslate>
      <:heading>
        This is a blank slate
      </:heading>
      <:img
        src="https://ghicons.github.com/assets/images/blue/png/Pull%20request.png"
        alt=""
      />
      <:action>
        <.button is_primary>New project</.button>
      </:action>
      <:action>
        <.button is_link>Learn more</.button>
      </:action>
      <p>Use it to provide information when no dynamic content exists.</p>
    </.blankslate>
  </.box>
  ```

  [INSERT LVATTRDOCS]

  ## Reference

  [Primer/CSS Blankslate](https://primer.style/css/components/blankslate)

  ## Status

  Feature complete.

  """

  attr(:class, :string, default: nil, doc: "Additional classname.")

  attr(:classes, :map,
    default: %{
      blankslate: nil,
      octicon: nil,
      img: nil,
      heading: nil,
      action: nil
    },
    doc: """
    Additional classnames for blankslate elements.

    Any provided value will be appended to the default classname.

    Default map:
    ```
    %{
      blankslate: "", # Blankslate wrapper
      octicon: ""     # Icon element
      img: "",        # Image element
      heading: "",    # Heading element
      action: "",     # Action element
    }
    ```
    """
  )

  attr :is_narrow, :boolean,
    default: false,
    doc: """
    Narrows the blankslate container to not occupy the entire available width.
    """

  attr :is_large, :boolean,
    default: false,
    doc: """
    Increases the size of the text in the blankslate.
    """

  attr :is_spacious, :boolean,
    default: false,
    doc: """
    Significantly increases the vertical padding.
    """

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the blankslate.
    """
  )

  slot :heading,
    doc: "Heading." do
    attr(:tag, :string,
      doc: """
      HTML tag used for the heading.

      Default: "h3".
      """
    )

    attr(:rest, :any,
      doc: """
      Attributes supplied to the heading.
      """
    )
  end

  slot :octicon,
    doc: "Adds a top icon with `octicon/1`." do
    attr(:rest, :any,
      doc: """
      Attributes supplied to the `octicon` component.
      """
    )
  end

  slot :img,
    doc: "Adds a top image with an `img` tag." do
    attr(:rest, :any,
      doc: """
      HTML attributes supplied to the `img` element.
      """
    )
  end

  slot :action,
    doc: "Adds a wrapper for a button or link." do
    attr(:rest, :any,
      doc: """
      HTML attributes supplied to the action wrapper element.
      """
    )
  end

  slot(:inner_block, required: false, doc: "Regular content.")

  def blankslate(assigns) do
    classes = %{
      blankslate:
        AttributeHelpers.classnames([
          "blankslate",
          assigns.is_narrow && "blankslate-narrow",
          assigns.is_large && "blankslate-large",
          assigns.is_spacious && "blankslate-spacious",
          assigns.classes[:blankslate],
          assigns[:class]
        ]),
      heading:
        AttributeHelpers.classnames([
          "blankslate-heading",
          assigns.classes[:heading]
        ]),
      octicon:
        AttributeHelpers.classnames([
          "blankslate-icon",
          assigns.classes[:octicon]
        ]),
      img:
        AttributeHelpers.classnames([
          "blankslate-image",
          assigns.classes[:img]
        ]),
      action:
        AttributeHelpers.classnames([
          "blankslate-action",
          assigns.classes[:action]
        ])
    }

    render_octicon = fn slot ->
      class =
        AttributeHelpers.classnames([
          classes.octicon,
          slot[:class]
        ])

      rest =
        assigns_to_attributes(slot, [
          :class
        ])

      assigns =
        assigns
        |> assign(:class, class)
        |> assign(:rest, rest)

      ~H"""
      <.octicon class={@class} {@rest} />
      """
    end

    render_img = fn slot ->
      class =
        AttributeHelpers.classnames([
          classes.img,
          slot[:class]
        ])

      rest =
        assigns_to_attributes(slot, [
          :class
        ])

      assigns =
        assigns
        |> assign(:class, class)
        |> assign(:rest, rest)

      ~H"""
      <img class={@class} {@rest} />
      """
    end

    render_action = fn slot ->
      class =
        AttributeHelpers.classnames([
          classes.action,
          slot[:class]
        ])

      rest =
        assigns_to_attributes(slot, [
          :class
        ])

      assigns =
        assigns
        |> assign(:class, class)
        |> assign(:rest, rest)
        |> assign(:slot, slot)

      ~H"""
      <div class={@class} {@rest}>
        <%= render_slot(@slot) %>
      </div>
      """
    end

    render_heading = fn slot ->
      tag = slot[:tag] || "h3"

      class =
        AttributeHelpers.classnames([
          classes.heading,
          slot[:class]
        ])

      rest =
        assigns_to_attributes(slot, [
          :class,
          :tag
        ])

      attributes =
        AttributeHelpers.append_attributes(rest, [
          [class: class],
          [name: tag]
        ])

      assigns =
        assigns
        |> assign(:attributes, attributes)
        |> assign(:slot, slot)

      ~H"""
      <.dynamic_tag {@attributes}>
        <%= render_slot(@slot) %>
      </.dynamic_tag>
      """
    end

    assigns =
      assigns
      |> assign(:classes, classes)
      |> assign(:render_heading, render_heading)
      |> assign(:render_action, render_action)
      |> assign(:render_img, render_img)
      |> assign(:render_octicon, render_octicon)

    ~H"""
    <div class={@classes.blankslate} {@rest}>
      <%= if @octicon && @octicon !== [] do %>
        <%= for slot <- @octicon do %>
          <%= @render_octicon.(slot) %>
        <% end %>
      <% end %>
      <%= if @img && @img !== [] do %>
        <%= for slot <- @img do %>
          <%= @render_img.(slot) %>
        <% end %>
      <% end %>
      <%= if @heading && @heading !== [] do %>
        <%= for slot <- @heading do %>
          <%= @render_heading.(slot) %>
        <% end %>
      <% end %>
      <%= if @inner_block && @inner_block !== [] do %>
        <%= render_slot(@inner_block) %>
      <% end %>
      <%= if @action && @action !== [] do %>
        <%= for slot <- @action do %>
          <%= @render_action.(slot) %>
        <% end %>
      <% end %>
    </div>
    """
  end

  # ------------------------------------------------------------------------------------
  # truncate
  # ------------------------------------------------------------------------------------

  @doc section: :truncate

  @doc ~S"""
  Shortens text with ellipsis.

  [Examples](#truncate/1-examples) • [Attributes](#truncate/1-attributes) • [Slots](#truncate/1-slots) • [Reference](#truncate/1-reference)

  ```
  <.truncate>
    <:item>really-long-text</:item>
  </.truncate>
  ```

  ## Examples

  Change the default generated HTML tags (default "span"). Note that the outer element is by default styled as `inline-flex`, regardless of the provided tag.

  ```
  <.truncate tag="ol">
    <:item tag="li">really-long-text</:item>
    <:item tag="li">really-long-text</:item>
  </.truncate>
  ```

  By default, items are turned into `span` elements. Pass a link attribute (`href`, `navigate` or `patch`) to change it automatically to a `Phoenix.Component.link/1`:

  ```
  <:item href="#url">Item 1</:item>
  <:item navigate={Routes.page_path(@socket, :index)} class="underline">Item 2</:item>
  <:item patch={Routes.page_path(@socket, :index, :details)}>Item 3</:item>
  ```

  Multiple item texts will truncate evenly.

  ```
  <.truncate>
    <:item>really-long-text</:item>
    <:item>really-long-text</:item>
  </.truncate>
  ```

  Delay the truncating of specific items:

  ```
  <.truncate>
    <:item>really-long-user-nametext</:item>
    <:item is_primary>really-long-project-name</:item>
  </.truncate>
  ```

  Expand the items on `hover` and `focus`:

  ```
  <.truncate>
    <:item expandable>really-long-text</:item>
    <:item expandable>really-long-text</:item>
  </.truncate>
  ```

  Limit the maximum width by adding `max-width` style:

  ```
  <.truncate>
    <:item is_expandable style="max-width: 300px;">
      really-long-text
    </:item>
  </.truncate>
  ```

  [INSERT LVATTRDOCS]

  ## Reference

  [Primer/CSS Truncate](https://primer.style/css/components/truncate)

  ## Status

  Feature complete.

  """

  attr(:class, :string, default: nil, doc: "Additional classname.")

  attr(:classes, :map,
    default: %{
      truncate: nil,
      item: nil
    },
    doc: """
    Additional classnames for truncate elements.

    Any provided value will be appended to the default classname.

    Default map:
    ```
    %{
      truncate: "", # Truncate wrapper element
      item: "",     # Text wrapper element
    }
    ```
    """
  )

  attr(:tag, :string, default: "span", doc: "HTML tag used for the truncate wrapper.")

  slot :item,
    required: true,
    doc: "Wrapper around text to be truncated." do
    attr(:tag, :string,
      doc: """
      HTML tag used for the text wrapper.

      Default: "span".
      """
    )

    attr(:href, :any,
      doc: """
      Link attribute. If used, the item will be created with `Phoenix.Component.link/1`, passing all other attributes to the link.
      """
    )

    attr(:patch, :string,
      doc: """
      Link attribute - see `href`.
      """
    )

    attr(:navigate, :string,
      doc: """
      Link attribute - see `href`.
      """
    )

    attr :is_primary, :boolean,
      doc: """
      When using multiple items. Delays the truncating of the item.
      """

    attr :is_expandable, :boolean,
      doc: """
      When using multiple items. Will expand the text on `hover` and `focus`.
      """

    attr(:rest, :any,
      doc: """
      Attributes supplied to the item.
      """
    )
  end

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the truncate element.
    """
  )

  def truncate(assigns) do
    classes = %{
      truncate:
        AttributeHelpers.classnames([
          "Truncate",
          assigns.classes[:truncate],
          assigns[:class]
        ])
      # item: set in render_item/1
    }

    render_item = fn slot ->
      is_link = AttributeHelpers.is_link?(slot)
      tag = slot[:tag] || "span"

      class =
        AttributeHelpers.classnames([
          "Truncate-text",
          slot[:is_primary] && "Truncate-text--primary",
          slot[:is_expandable] && "Truncate-text--expandable",
          assigns.classes[:item],
          slot[:class]
        ])

      rest =
        assigns_to_attributes(slot, [
          :class,
          :tag,
          :is_expandable,
          :is_primary
        ])

      attributes =
        AttributeHelpers.append_attributes(rest, [
          [class: class],
          [name: tag]
        ])

      assigns =
        assigns
        |> assign(:is_link, is_link)
        |> assign(:attributes, attributes)
        |> assign(:slot, slot)

      ~H"""
      <%= if @is_link do %>
        <Phoenix.Component.link {@attributes}>
          <%= render_slot(@slot) %>
        </Phoenix.Component.link>
      <% else %>
        <.dynamic_tag {@attributes}>
          <%= render_slot(@slot) %>
        </.dynamic_tag>
      <% end %>
      """
    end

    assigns =
      assigns
      |> assign(:classes, classes)
      |> assign(:render_item, render_item)

    ~H"""
    <.dynamic_tag name={@tag || "span"} class={@classes.truncate} {@rest}>
      <%= if @item && @item !== [] do %>
        <%= for slot <- @item do %>
          <%= @render_item.(slot) %>
        <% end %>
      <% end %>
    </.dynamic_tag>
    """
  end

  # ------------------------------------------------------------------------------------
  # dialog
  # ------------------------------------------------------------------------------------

  @doc section: :dialog

  @doc ~S"""
  Dialog, often called Modal.

  [Examples](#dialog/1-examples) • [Attributes](#dialog/1-attributes) • [Slots](#dialog/1-slots) • [Reference](#dialog/1-reference)

  A dialog is created with `box/1` slots.

  ```
  <.dialog>
    <:header_title>Title</:header_title>
    <:body>
      Message in a dialog
    </:body>
  </.dialog>
  ```

  Showing and hiding is done with JS function `Prompt` from [dialogic-js](https://github.com/ArthurClemens/dialogic-js), included in `primer-js` (see Installation). Function `Prompt.show` requires a selector. When placed inside the dialog component, the selector can be replaced with `this`:

  ```
  <.dialog id="my-dialog">
    <:body>
      Message in a dialog
      <.button onclick="Prompt.hide(this)">Close</.button>
    </:body>
  </.dialog>

  <.button onclick="Prompt.show('#my-dialog')">Open dialog</.button>
  ```

  ## Examples

  Add a backdrop. Optionally add `is_light_backdrop` or `is_dark_backdrop`:

  ```
  <.dialog is_backdrop is_dark_backdrop>
    ...
  </.dialog>
  ```

  Create a modal dialog; clicking the backdrop (if used) or outside of the dialog will not close the dialog:

  ```
  <.dialog is_modal>
    ...
  </.dialog>
  ```

  Close the button with the Escape key:

  ```
  <.dialog is_escapable>
    ...
  </.dialog>
  ```

  Focus the first element after opening the dialog. Pass a selector to match the element.

  ```
  <.dialog focus_first="#login_first_name">
    ...
  </.dialog>
  ```

  or

  ```
  <.dialog focus_first="[name=login\[first_name\]]">
    ...
  </.dialog>
  ```

  Create faster fade in and out:

  ```
  <.dialog is_fast>
    ...
  </.dialog>
  ```

  A narrow dialog:

  ```
  <.dialog is_narrow>
    ...
  </.dialog>
  ```

  A wide dialog:

  ```
  <.dialog is_wide>
    ...
  </.dialog>
  ```

  Long content will automatically show a scrollbar. To change the maxium height of the dialog, use a CSS value. Use unit `vh` or `%`.

  ```
  <.dialog max_height="50vh">
    ...
  </.dialog>
  ```

  Add a header title and a footer.

  `box` slot `header` slot is automatically added when `header_title` is used.

  ```
  <.dialog>
    <:header_title>Title</:header_title>
    ...
    <:footer>Footer</:footer>
  </.dialog>
  ```

  A dialog with rows:

  ```
   <.dialog>
    <:header_title>Title</:header_title>
    <:row>Row 1</:row>
    <:row>Row 2</:row>
    <:row>Row 3</:row>
    <:row>Row 4</:row>
    <:footer>Footer</:footer>
  </.dialog>
  ```

  Dialog are wrapped inside a `Phoenix.Compoennt.focus_wrap/1` so that navigating with Tab won't leave the dialog.

  ```
  <.dialog is_backdrop is_modal>
    <:header_title>Title</:header_title>
    <:body>
    <.text_input form={:user} field={:first_name} is_group />
    <.text_input form={:user} field={:last_name} is_group />
    </:body>
  </.dialog>
  ```

  [INSERT LVATTRDOCS]

  ## Reference

  [Primer/CSS Box overlay](https://primer.style/css/components/box-overlay)

  ## Status

  Feature complete.

  """

  attr(:class, :string, default: nil, doc: "Additional classname.")

  attr(:classes, :map,
    default: %{
      dialog_wrapper: nil,
      dialog: nil,
      box: nil,
      header: nil,
      row: nil,
      body: nil,
      footer: nil,
      header_title: nil,
      link: nil
    },
    doc: """
    Additional classnames for dialog elements.

    Any provided value will be appended to the default classname.

    Default map:
    ```
    %{
      # Dialog classes
      dialog_wrapper: "",  # The outer element
      dialog: "",          # Dialog  element
      # Box classes - see box component:
      box: "",
      header: "",
      row: "",
      body: "",
      footer: "",
      header_title: "",
      link: "",
    }
    ```
    """
  )

  attr :is_backdrop, :boolean,
    default: false,
    doc: """
    Generates a medium backdrop background color.
    """

  attr :is_dark_backdrop, :boolean,
    default: false,
    doc: """
    Generates a darker backdrop background color.
    """

  attr :is_medium_backdrop, :boolean,
    default: false,
    doc: """
    Generates a medium backdrop background color (default).
    """

  attr :is_light_backdrop, :boolean,
    default: false,
    doc: """
    Generates a lighter backdrop background color.
    """

  attr :is_fast, :boolean,
    default: false,
    doc: """
    Generates fast fade transitions for backdrop and content.
    """

  attr :is_modal, :boolean,
    default: false,
    doc: """
    Generates a modal dialog; clicking the backdrop (if used) or outside of the dialog will not close the dialog.
    """

  attr :is_escapable, :boolean,
    default: false,
    doc: """
    Closes the content when pressing the Escape key.
    """

  attr :focus_first, :string,
    doc: """
    Focus the first element after opening the dialog. Pass a selector to match the element.
    """

  attr :is_narrow, :boolean,
    default: false,
    doc: """
    Generates a smaller dialog, width: `320px` (default: `440px`).
    """

  attr :is_wide, :boolean,
    default: false,
    doc: """
    Generates a wider dialog, width: `640px` (default: `440px`).
    """

  attr :max_height, :string,
    default: "80vh",
    doc: """
    Maximum height of dialog as CSS value. Use unit `vh` or `%`.
    """

  attr :max_width, :string,
    default: "90vw",
    doc: """
    Maximum width of dialog as CSS value. Use unit `vh` or `%`.
    """

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the outer element.
    """
  )

  slot :header_title,
    doc: """
    Dialog header title. Uses `box/1` `header_title` slot.

    Note that slot `header` is automatically created to ensure the correct close button.
    """ do
    attr(:rest, :any,
      doc: """
      Additional attributes.
      """
    )
  end

  slot :body,
    doc: """
    Dialog body. Uses `box/1` `body` slot.
    """ do
    attr(:rest, :any,
      doc: """
      Additional attributes.
      """
    )
  end

  slot :row,
    doc: """
    Dialog row. Uses `box/1` `row` slot.
    """ do
    attr(:rest, :any,
      doc: """
      Additional attributes.
      """
    )
  end

  slot :footer,
    doc: """
    Dialog footer. Uses `box/1` `footer` slot.
    """ do
    attr(:rest, :any,
      doc: """
      Additional attributes.
      """
    )
  end

  slot(:inner_block,
    doc: "Unstructured dialog content. Uses `box/1` `inner_block` slot."
  )

  @default_dialog_max_height_css "80vh"
  @default_dialog_max_width_css "90vw"

  def dialog(assigns) do
    classes = %{
      dialog_wrapper:
        AttributeHelpers.classnames([
          assigns[:classes][:dialog_wrapper],
          assigns[:class]
        ]),
      dialog:
        AttributeHelpers.classnames([
          "Box--overlay",
          assigns.is_narrow && "Box-overlay--narrow",
          assigns.is_wide && "Box-overlay--wide",
          assigns[:classes][:dialog]
        ])
    }

    # Assign an id for focus wrap
    dialog_id = assigns.rest[:id] || AttributeHelpers.random_string()
    focus_wrap_id = "focus-wrap-#{dialog_id}"

    wrapper_attrs =
      AttributeHelpers.append_attributes(assigns.rest |> Map.drop([:id]), [
        [class: classes.dialog_wrapper],
        [id: dialog_id],
        [data_prompt: ""],
        assigns.is_modal && [data_ismodal: ""],
        assigns.is_escapable && [data_isescapable: ""],
        assigns.is_fast && [data_isfast: ""],
        assigns[:focus_first] && [data_focusfirst: assigns[:focus_first]]
      ])

    close_button_attrs =
      AttributeHelpers.append_attributes([], [
        [is_close_button: true],
        [aria_label: "Close"],
        [class: "Box-btn-octicon btn-octicon flex-shrink-0"],
        [onclick: "Prompt.hide(this)"]
      ])

    max_height_css = assigns.max_height || @default_dialog_max_height_css
    max_width_css = assigns.max_width || @default_dialog_max_width_css

    box_attrs =
      AttributeHelpers.append_attributes([], [
        [class: classes.dialog],
        [classes: assigns.classes |> Map.drop([:dialog_wrapper, :dialog])],
        [is_scrollable: true],
        [data_content: ""],
        [
          style:
            AttributeHelpers.inline_styles([
              max_height_css !== @default_dialog_max_height_css &&
                "max-height: #{max_height_css}",
              max_width_css !== @default_dialog_max_width_css && "max-width: #{max_width_css}"
            ])
        ],
        # box_header set in main H_sigil
        [header_title: assigns.header_title],
        [body: assigns.body],
        [row: assigns.row],
        [footer: assigns.footer],
        [inner_block: assigns.inner_block]
      ])

    touch_layer_attrs =
      AttributeHelpers.append_attributes([], [
        [data_touch: ""]
      ])

    backdrop_attrs =
      AttributeHelpers.append_attributes([], [
        cond do
          assigns.is_dark_backdrop -> [data_backdrop: "", data_isdark: ""]
          assigns.is_medium_backdrop -> [data_backdrop: "", data_ismedium: ""]
          assigns.is_light_backdrop -> [data_backdrop: "", data_islight: ""]
          assigns.is_backdrop -> [data_backdrop: "", data_ismedium: ""]
          true -> []
        end
      ])

    assigns =
      assigns
      |> assign(:wrapper_attrs, wrapper_attrs)
      |> assign(:touch_layer_attrs, touch_layer_attrs)
      |> assign(:backdrop_attrs, backdrop_attrs)
      |> assign(:box_attrs, box_attrs)
      |> assign(:close_button_attrs, close_button_attrs)
      |> assign(:focus_wrap_id, focus_wrap_id)

    ~H"""
    <div {@wrapper_attrs}>
      <div {@touch_layer_attrs}>
        <%= if @backdrop_attrs !== [] do %>
          <div {@backdrop_attrs} />
        <% end %>
        <.focus_wrap id={@focus_wrap_id}>
          <.box {@box_attrs}>
            <:header
              :if={@header_title && @header_title !== []}
              class="d-flex flex-justify-between flex-items-start"
            >
              <.button {@close_button_attrs}>
                <.octicon name="x-16" />
              </.button>
            </:header>
            <%= render_slot(@inner_block) %>
          </.box>
        </.focus_wrap>
      </div>
    </div>
    """
  end
end
