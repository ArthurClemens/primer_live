defmodule PrimerLive.Component do
  @moduledoc """
  PrimerLive components.
  """

  use Phoenix.Component
  use Phoenix.HTML

  alias PrimerLive.Helpers.{AttributeHelpers, FormHelpers, SchemaHelpers, ComponentHelpers}
  alias PrimerLive.Theme

  # ------------------------------------------------------------------------------------
  # action_list
  # ------------------------------------------------------------------------------------

  @doc section: :navigation

  @doc ~S"""
  Generates a vertical list of interactive actions or options. It’s composed of items presented in a consistent single-column format, with room for icons, descriptions, side information, and other rich visuals.

  Action list is composed of one or more child components:
  - `action_list_section_divider/1` - a divider with optional title
  - `action_list_item/1` - versatile list item

  See the [Primer Action List interface guidelines](https://primer.style/design/components/action-list) for more examples.

  ## Examples

  ### action_list

  ```
  <.action_list>
    <.action_list_item>Item</.action_list_item>
    <.action_list_item>Item</.action_list_item>
  </.action_list>
  ```

  Create separator lines between the items:

  ```
  <.action_list is_divided>
    ...
  </.action_list>
  ```

  Remove default padding:

  ```
  <.action_list is_full_bleed>
    ...
  </.action_list>
  ```

  ### action_list_section_divider

  Add a divider to separate a group of content:

  ```
  <.action_list>
    <.action_list_section_divider />
    ...
  </.action_list>
  ```

  Add a title to the divider, and optionally a description:

  ```
  <.action_list>
    <.action_list_section_divider>
      <:title>Section title</:title>
      <:description>A descriptive text</:description>
    </.action_list_section_divider>
    ...
  </.action_list>
  ```

  Use the title slot to set the id for `aria-labelledby`:

  ```
  <.action_list aria-labelledby="title-01">
    <.action_list_section_divider>
      <:title id="title-01">Section title</:title>
    </.action_list_section_divider>
    ...
  </.action_list>
  ```

  ### action_list_item

  Common list item attributes:

  ```
  <.action_list_item is_selected>
    This is the selected item
  </.action_list_item>

  <.action_list_item is_danger>
    Descructive item
  </.action_list_item>

  <.action_list_item is_disabled>
    Disabled item
  </.action_list_item>

  <.action_list_item is_button phx-click="remove">
    Button
  </.action_list_item>

  <.action_list_item is_height_medium>
    A higher item
  </.action_list_item>

  <.action_list_item is_height_large>
    An even higher item
  </.action_list_item>

  <.action_list_item is_truncated>
    A very long text that should stay on one line, abbreviated by ellipsis
  </.action_list_item>
  ```

  Use slot `description` to add a descriptive text. The description is displayed on a new line by default.

  ```
  <.action_list_item>
    Short label
    <:description>
      A more descriptive text
    </:description>
  </.action_list_item>
  ```

  Place the description on the same line:

  ```
  <.action_list_item is_inline_description>
    Short label
    <:description>
      A more descriptive text after the title
    </:description>
  </.action_list_item>
  ```

  Add a leading visual. This is usually an `octicon/1`, but can be any small image:

  ```
  <.action_list_item>
    Item
    <:leading_visual>
      <.octicon name="bell-16" />
    </:leading_visual>
  </.action_list_item>
  ```

  Likewise, add a trailing visual:

  ```
  <.action_list_item>
    Item
    <:leading_visual>
      <.counter>12</.counter>
    </:leading_visual>
  </.action_list_item>
  ```

  Items are by default rendered as span elements. To create link elements, place the label text inside slot `link` and pass attribute `href`, `navigate` or `patch`.
  When a link attribute is supplied to the link slot, links are created with `Phoenix.Component.link/1`, passing all other slot attributes to the link. Link examples:

  ```
  <.action_list_item>
    <:link href="/url" target="_blank">
      href link
    </:link>
  </.action_list_item>
  <.action_list_item>
    <:link navigate={Routes.page_path(@socket, :index)}>
      navigate link
    </:link>
  </.action_list_item>
  <.action_list_item>
    <:link patch={Routes.page_path(@socket, :index)}>
      patch link
    </:link>
  </.action_list_item>
  ```


  Action list items can be selected. Single selections are represented with a check `ui_icon/1`, while multiple selections are represented with a checkbox `ui_icon/1`.

  Create a single select list:

  ```
  <.action_list>
    <.action_list_item is_single_select is_selected>
      Option
    </.action_list_item>
    <.action_list_item is_single_select>
      Option
    </.action_list_item>
    <.action_list_item is_single_select>
      Option
    </.action_list_item>
  </.action_list>
  ```

  Create a multiple select list:

  ```
  <.action_list>
    <.action_list_item is_multiple_select is_selected>
      Option
    </.action_list_item>
    <.action_list_item is_multiple_select is_selected>
      Option
    </.action_list_item>
    <.action_list_item is_multiple_select>
      Option
    </.action_list_item>
  </.action_list>
  ```

  Deviating from the Primer implementation, selected items don't show a highlight border at the left. To give these items a navigation like appearance, use `is_selected_link_marker`:

  ```
  <.action_list>
    <.action_list_item is_single_select is_selected_link_marker is_selected>
      Option
    </.action_list_item>
    <.action_list_item is_single_select is_selected_link_marker>
      Option
    </.action_list_item>
    <.action_list_item is_single_select is_selected_link_marker>
      Option
    </.action_list_item>
  </.action_list>
  ```

  Nested sub lists ("sub groups") can be used to initially hide additional options. A sub group is an action list placed inside a list item, which is automatically created by slot `sub_group`.

  ```
  <.action_list>
    <.action_list_section_divider>
      <:title>Section title</:title>
    </.action_list_section_divider>
    <.action_list_item leading_visual_width="16" is_collapsible is_expanded>
      Collapsible and expanded item
      <:leading_visual>
        <.octicon name="comment-discussion-16" />
      </:leading_visual>
      <:sub_group>
        <.action_list_item is_sub_item>
          Sub item
        </.action_list_item>
        <.action_list_item is_sub_item>
          Sub item
        </.action_list_item>
      </:sub_group>
    </.action_list_item>
  </.action_list>
  ```

  - slot `sub_group` accepts `action_list/1` attributes
  - `is_collapsible` indicates that the sub group is conditionally hidden. The item is rendered as button.
  - `is_expanded` reveals hidden items.
  - `leading_visual_width` can be used to align the content with the visual.
  - action list attribute `is_sub_item` renders the item smaller.

  When using a sub group, use the divider's title slot to set the id for `aria-labelledby` on the sub group:

  ```
  <.action_list_section_divider>
    <:title id="title-01">Section title</:title>
  </.action_list_section_divider>
  <.action_list_item>
    Item
    <:sub_group aria-labelledby="title-01">
      ...
    </:sub_group>
  </.action_list_item>
  ```

  [INSERT LVATTRDOCS]

  ## Reference

  [Primer/CSS Action List](https://primer.style/css/components/action-list)

  ## Status

  Feature complete.

  """

  attr(:aria_label, :string,
    default: nil,
    doc: "Adds attribute `aria-label` to the outer element."
  )

  attr(:role, :string,
    default: "listbox",
    doc: "Adds attribute `role` to the outer element."
  )

  attr(:class, :string, default: nil, doc: "Additional classname.")

  attr :is_divided, :boolean,
    default: false,
    doc: """
    Show dividers between items.
    """

  attr :is_full_bleed, :boolean,
    default: false,
    doc: """
    Removes the default padding.
    """

  attr :is_multiple_select, :boolean,
    default: false,
    doc: """
    Sets ARIA attribute and classes for multi select checkmarks.
    """

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the action list element.
    """
  )

  slot(:inner_block, required: true, doc: "Action list components.")

  def action_list(assigns) do
    class =
      AttributeHelpers.classnames([
        "ActionList",
        assigns.is_divided and "ActionList--divided",
        assigns.is_full_bleed and "ActionList--full",
        assigns[:class]
      ])

    attributes =
      AttributeHelpers.append_attributes(assigns.rest, [
        [class: class],
        [role: assigns.role],
        assigns.aria_label && [aria_label: assigns.aria_label],
        assigns.is_multiple_select and [aria_multiselectable: "true"]
      ])

    assigns =
      assigns
      |> assign(:attributes, attributes)

    ~H"""
    <ul {@attributes}>
      <%= render_slot(@inner_block) %>
    </ul>
    """
  end

  # ------------------------------------------------------------------------------------
  # action_list_section_divider
  # ------------------------------------------------------------------------------------

  @doc section: :navigation

  @doc ~S"""
  Action list section divider for separating groups of content. See `action_list/1`.

  [INSERT LVATTRDOCS]
  """

  attr(:class, :string, default: nil, doc: "Additional classname.")

  attr(:classes, :map,
    default: %{
      section_divider: nil,
      title: nil,
      description: nil
    },
    doc: """
    Additional classnames for section divider elements.

    Any provided value will be appended to the default classname.

    Default map:
    ```
    %{
      section_divider: "", # Section divider element (li)
      title: "",           # Title container (h3)
      description: "",     # Description container (span)
    }
    ```
    """
  )

  attr :is_filled, :boolean,
    default: false,
    doc: """
    Creates a higher horizontal line. When used with the `title` slot, the title is placed inside the line.
    """

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the section divider element.
    """
  )

  slot :title,
    required: false,
    doc: """
    Title separator. The input text is wrapped in a `<h3>` element. Omit to create a horizontal line only.
    """ do
    attr(:rest, :any,
      doc: """
      Additional HTML attributes added to the action list element.
      """
    )
  end

  slot :description,
    required: false,
    doc: """
    Optional extra text. Requires `title` slot.
    """ do
    attr(:rest, :any,
      doc: """
      Additional HTML attributes added to the action list element.
      """
    )
  end

  def action_list_section_divider(assigns) do
    has_title = assigns.title !== []

    classes = %{
      section_divider:
        AttributeHelpers.classnames([
          "ActionList-sectionDivider",
          assigns.is_filled and "ActionList-sectionDivider--filled",
          assigns[:classes][:section_divider],
          assigns[:class]
        ]),
      title: fn slot ->
        AttributeHelpers.classnames([
          "ActionList-sectionDivider-title",
          assigns[:classes][:title],
          slot[:class]
        ])
      end,
      description: fn slot ->
        AttributeHelpers.classnames([
          "ActionList-item-description",
          assigns[:classes][:description],
          slot[:class]
        ])
      end
    }

    render_title = fn slot ->
      rest =
        assigns_to_attributes(slot, [
          :class
        ])

      attributes =
        AttributeHelpers.append_attributes(rest, [
          [class: classes.title.(slot)]
        ])

      assigns =
        assigns
        |> assign(:attributes, attributes)
        |> assign(:slot, slot)

      ~H"""
      <h3 {@attributes}>
        <%= render_slot(@slot) %>
      </h3>
      """
    end

    render_description = fn slot ->
      rest =
        assigns_to_attributes(slot, [
          :class
        ])

      attributes =
        AttributeHelpers.append_attributes(rest, [
          [class: classes.description.(slot)]
        ])

      assigns =
        assigns
        |> assign(:attributes, attributes)
        |> assign(:slot, slot)

      ~H"""
      <span {@attributes}><%= render_slot(@slot) %></span>
      """
    end

    attributes =
      AttributeHelpers.append_attributes(assigns.rest, [
        [class: classes.section_divider],
        !has_title && [role: "separator", aria_hidden: "true"]
      ])

    has_title = assigns.title && assigns.title !== []
    has_description = has_title && assigns.description && assigns.description !== []

    assigns =
      assigns
      |> assign(:attributes, attributes)
      |> assign(:has_title, has_title)
      |> assign(:has_description, has_description)
      |> assign(:render_title, render_title)
      |> assign(:render_description, render_description)

    ~H"""
    <%= if !@has_title do %>
      <li {@attributes}></li>
    <% else %>
      <li {@attributes}>
        <%= if @has_title do %>
          <%= for slot <- @title do %>
            <%= @render_title.(slot) %>
          <% end %>
        <% end %>
        <%= if @has_description do %>
          <%= for slot <- @description do %>
            <%= @render_description.(slot) %>
          <% end %>
        <% end %>
      </li>
    <% end %>
    """
  end

  # ------------------------------------------------------------------------------------
  # action_list_item
  # ------------------------------------------------------------------------------------

  @doc section: :navigation

  @doc ~S"""
  Action list item. See `action_list/1`.

  [INSERT LVATTRDOCS]
  """

  attr(:class, :string, default: nil, doc: "Additional classname.")

  attr(:classes, :map,
    default: %{
      section_divider: nil,
      content: nil,
      label: nil,
      description: nil,
      description_container: nil,
      leading_visual: nil,
      trailing_visual: nil,
      sub_group: nil
    },
    doc: """
    Additional classnames for section item elements.

    Any provided value will be appended to the default classname.

    Default map:
    ```
    %{
      action_list_item: "",          # Action list item element (li)
      content: "",                   # Content wrapper (span, a or button)
      label: "",                     # Label container (span)
      description: "",               # Description container (span)
      description_container: "",     # Container around label and description (span)
      leading_visual: "",            # Leading visual container (span)
      trailing_visual: "",           # Trailing visual container (span)
      sub_group: "",                 # Nested action_list
    }
    ```
    """
  )

  attr(:is_selected, :boolean,
    default: false,
    doc: """
    Shows the selected state.
    - Link items show an active border at the left and a gray highlighted background
    - Single select items show a check icon
    - Multiple select items show a selected checkbox icon
    """
  )

  attr(:is_selected_link_marker, :boolean,
    default: false,
    doc: """
    When using `is_single_select` or `is_multiple_select`: creates a selected state similar for selected link items (border and background).
    """
  )

  attr(:is_inline_description, :boolean,
    default: false,
    doc: """
    Renders the description inline, on the same line as the label.
    """
  )

  attr :is_height_medium, :boolean,
    default: false,
    doc: """
    Sets the row height to at least 40px. The default row height is 32px (on touch devices this is 48px).
    """

  attr :is_height_large, :boolean,
    default: false,
    doc: """
    Sets the row height to at least 48px. The default row height is 32px (on touch devices this is 48px as well).
    """

  attr :is_single_select, :boolean,
    default: false,
    doc: """
    Inserts checkmark icons (override the visual by using `leading_visual` slot) and sets ARIA attributes.
    """

  attr :is_multiple_select, :boolean,
    default: false,
    doc: """
    Inserts multi select checkmark icons (override the visual by using `leading_visual` slot) and sets ARIA attributes.
    """

  attr :is_button, :boolean,
    default: false,
    doc: """
    Renders the content element as button.
    """

  attr :is_collapsible, :boolean,
    default: false,
    doc: """
    Inserts a collapse icon as trailing visual (override the visual by using `trailing_visual` slot). Use with `is_expanded` and sets ARIA attributes. Uses a `button` element instead of `span`.

    When using slot `sub_group`, a false value of `is_expanded` will hide the sub group items.
    """

  attr :is_expanded, :boolean,
    default: false,
    doc: """
    Use with `is_collapsible`. Sets the state of the collapsible by setting ARIA attributes.

    When using slot `sub_group`, a false value of `is_expanded` will hide the sub group items; a true value will show the items and make the current item bold.
    """

  attr :is_danger, :boolean,
    default: false,
    doc: """
    Adds a "danger" style to show that the item is descrucive.
    """

  attr :is_disabled, :boolean,
    default: false,
    doc: """
    Shows the item is disabled.
    """

  attr :is_truncated, :boolean,
    default: false,
    doc: """
    Shortens the item label with ellipsis.
    """

  attr :is_sub_item, :boolean,
    default: false,
    doc: """
    For items within a `sub_group`. Renders the item smaller.
    """

  attr :leading_visual_width, :any,
    doc: """
    Use with the item that contains slots `sub_group` and `leading_visual`. Indents the items within the sub group to match the leading visual.

    Supported sizes: 16, 20, 24.
    """

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the action list element.
    """
  )

  slot(:inner_block, required: true, doc: "Label.")

  slot :link,
    required: false,
    doc: """
    Creates a link. Pass attribute `href`, `navigate` or `patch`.
    """ do
    attr(:href, :any,
      doc: """
      Link attribute. The link is created with `Phoenix.Component.link/1`, passing all other slot attributes to the link.
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
      Additional HTML attributes added to the link element.
      """
    )
  end

  slot(:description, required: false, doc: "Description.")

  slot(:leading_visual,
    required: false,
    doc: """
    Container for a leading visual. Commonly a `octicon/1` component is used.

    The container's width is determined by the content. Use the same size icons and graphics for consistency. A common icon size is 16px.
    """
  )

  slot(:trailing_visual,
    required: false,
    doc:
      "Container for a trailing visual. Commonly a `octicon/1` component is used, but a textual \"visual\" is also possible."
  )

  slot :sub_group,
    required: false,
    doc: """
    Creates a nested `action_list/1`. Pass `action_list_items` as children.

    Use `is_sub_item` for child items to render them smaller.
    """ do
    attr(:rest, :any,
      doc: """
      Additional HTML attributes added to the action list element.
      """
    )
  end

  def action_list_item(assigns) do
    is_selected = assigns.is_selected
    # Get the first link slot, if any
    link_slot = if assigns[:link] && assigns[:link] !== [], do: hd(assigns[:link]), else: []
    is_link = AttributeHelpers.is_link?(link_slot)
    is_anchor_link = AttributeHelpers.is_anchor_link?(link_slot)
    is_selected_link_marker = assigns.is_selected_link_marker
    is_single_select = assigns.is_single_select
    is_multiple_select = assigns.is_multiple_select && !is_single_select
    is_select = is_single_select || is_multiple_select
    has_sub_group = assigns[:sub_group] && assigns[:sub_group] !== []
    leading_visual_width = AttributeHelpers.as_integer(assigns[:leading_visual_width])

    classes = %{
      action_list_item:
        AttributeHelpers.classnames([
          "ActionList-item",
          is_selected && (!is_select || is_selected_link_marker) && "ActionList-item--navActive",
          assigns.is_danger && "ActionList-item--danger",
          has_sub_group && "ActionList-item--hasSubItem",
          assigns.is_sub_item && "ActionList-item--subItem",
          assigns[:classes][:action_list_item],
          assigns[:class]
        ]),
      content:
        AttributeHelpers.classnames([
          "ActionList-content",
          assigns.is_height_medium && "ActionList-content--sizeMedium",
          assigns.is_height_large && "ActionList-content--sizeLarge",
          has_sub_group && assigns.is_expanded && assigns.is_expanded &&
            "ActionList-content--hasActiveSubItem",
          leading_visual_width === 16 && "ActionList-content--visual16",
          leading_visual_width === 20 && "ActionList-content--visual20",
          leading_visual_width === 24 && "ActionList-content--visual24",
          assigns[:classes][:content]
        ]),
      label:
        AttributeHelpers.classnames([
          "ActionList-item-label",
          assigns.is_truncated && "ActionList-item-label--truncate",
          assigns[:classes][:label]
        ]),
      description:
        AttributeHelpers.classnames([
          "ActionList-item-description",
          assigns[:classes][:description]
        ]),
      description_container:
        AttributeHelpers.classnames([
          "ActionList-item-descriptionWrap",
          if assigns.is_inline_description do
            "ActionList-item-descriptionWrap--inline"
          else
            "ActionList-item-blockDescription"
          end,
          assigns[:classes][:description_container]
        ]),
      leading_visual:
        AttributeHelpers.classnames([
          "ActionList-item-visual",
          "ActionList-item-visual--leading",
          # Note that classes for action are identical ("ActionList-item-action ActionList-item-action--leading") and therefore not implemented
          assigns[:classes][:leading_visual]
        ]),
      trailing_visual:
        AttributeHelpers.classnames([
          "ActionList-item-visual",
          "ActionList-item-visual--trailing",
          # Note that classes for action are identical ("ActionList-item-action ActionList-item-action--trailing") and therefore not implemented
          assigns[:classes][:trailing_visual]
        ]),
      sub_group: fn slot ->
        AttributeHelpers.classnames([
          "ActionList--subGroup",
          assigns[:classes][:sub_group],
          slot[:class]
        ])
      end,
      leading_visual_single_select_checkmark: "ActionList-item-singleSelectCheckmark",
      leading_visual_multiple_select_checkmark: "ActionList-item-multiSelectIcon"
    }

    render_content_elements = fn content ->
      assigns =
        assigns
        |> assign(:classes, classes)
        |> assign(:content, content)

      ~H"""
      <%= if @content && @content !== [] do %>
        <span class={@classes.label}><%= render_slot(@content) %></span>
      <% end %>
      <%= if @description && @description !== [] do %>
        <span class={@classes.description}><%= render_slot(@description) %></span>
      <% end %>
      """
    end

    render_maybe_wrap_content_elements = fn content ->
      has_description = assigns.description && assigns.description !== []
      has_leading_visual = assigns.leading_visual && assigns.leading_visual !== []
      has_trailing_visual = assigns.trailing_visual && assigns.trailing_visual !== []

      assigns =
        assigns
        |> assign(:content, content)
        |> assign(:has_description, has_description)
        |> assign(:classes, classes)
        |> assign(:render_content_elements, render_content_elements)
        |> assign(:has_leading_visual, has_leading_visual)
        |> assign(:has_trailing_visual, has_trailing_visual)
        |> assign(:is_select, is_select)

      ~H"""
      <%= if @is_select do %>
        <%= if @has_leading_visual do %>
          <span class={@classes.leading_visual}>
            <span class={@classes.leading_visual_single_select_checkmark}>
              <%= render_slot(@leading_visual) %>
            </span>
          </span>
        <% else %>
          <span class={@classes.leading_visual}>
            <%= if @is_single_select do %>
              <.ui_icon name="single-select-16" class={@classes.leading_visual_single_select_checkmark} />
            <% end %>
            <%= if @is_multiple_select do %>
              <.ui_icon
                name="multiple-select-16"
                class={@classes.leading_visual_multiple_select_checkmark}
              />
            <% end %>
          </span>
        <% end %>
      <% else %>
        <%= if @has_leading_visual do %>
          <span class={@classes.leading_visual}>
            <%= render_slot(@leading_visual) %>
          </span>
        <% end %>
      <% end %>
      <%= if @has_description do %>
        <span class={@classes.description_container}>
          <%= @render_content_elements.(@content) %>
        </span>
      <% else %>
        <%= @render_content_elements.(@content) %>
      <% end %>
      <%= if @has_trailing_visual do %>
        <span class={@classes.trailing_visual}>
          <%= render_slot(@trailing_visual) %>
        </span>
      <% else %>
        <%= if @is_collapsible do %>
          <span class={@classes.trailing_visual}>
            <.ui_icon name="collapse-16" class="ActionList-item-collapseIcon" />
          </span>
        <% end %>
      <% end %>
      """
    end

    render_sub_group = fn slot ->
      rest =
        assigns_to_attributes(slot, [
          :class
        ])

      attributes =
        AttributeHelpers.append_attributes(rest, [
          [class: classes.sub_group.(slot)],
          [role: "list"]
        ])

      assigns =
        assigns
        |> assign(:attributes, attributes)
        |> assign(:slot, slot)

      ~H"""
      <.action_list {@attributes}>
        <%= render_slot(@slot) %>
      </.action_list>
      """
    end

    render_content = fn ->
      is_button = assigns.is_button || assigns.is_collapsible
      # If is_collapsible is not used, unhide the sub_group
      is_expanded =
        if assigns.is_collapsible do
          assigns.is_expanded
        else
          if has_sub_group do
            true
          end
        end

      attributes =
        AttributeHelpers.append_attributes([], [
          [class: classes.content],
          !is_nil(is_expanded) &&
            [aria_expanded: is_expanded |> Atom.to_string()]
        ])

      link_attributes =
        AttributeHelpers.append_attributes(assigns_to_attributes(link_slot), [
          [
            class:
              AttributeHelpers.classnames([
                classes.content,
                link_slot[:class]
              ])
          ],
          !is_nil(is_expanded) &&
            [aria_expanded: is_expanded |> Atom.to_string()],
          [role: "menuitem"],
          is_selected && [aria_selected: "true"],
          if is_selected do
            if is_anchor_link do
              [aria_current: "location"]
            else
              [aria_current: "page"]
            end
          end
        ])

      assigns =
        assigns
        |> assign(:attributes, attributes)
        |> assign(:link_attributes, link_attributes)
        |> assign(:is_link, is_link)
        |> assign(:render_maybe_wrap_content_elements, render_maybe_wrap_content_elements)
        |> assign(:has_sub_group, has_sub_group)
        |> assign(:render_sub_group, render_sub_group)
        |> assign(:is_button, is_button)
        |> assign(:link_slot, link_slot)

      ~H"""
      <%= if @is_link do %>
        <Phoenix.Component.link {@link_attributes}>
          <%= @render_maybe_wrap_content_elements.(@link_slot) %>
        </Phoenix.Component.link>
      <% else %>
        <%= if @is_button do %>
          <button {@attributes}>
            <%= @render_maybe_wrap_content_elements.(@inner_block) %>
          </button>
        <% else %>
          <span {@attributes}>
            <%= @render_maybe_wrap_content_elements.(@inner_block) %>
          </span>
        <% end %>
      <% end %>
      <%= if @has_sub_group do %>
        <%= for slot <- @sub_group do %>
          <%= @render_sub_group.(slot) %>
        <% end %>
      <% end %>
      """
    end

    attributes =
      AttributeHelpers.append_attributes(assigns.rest, [
        [class: classes.action_list_item],
        is_link && [role: "none"],
        !is_link && is_selected && [aria_selected: "true"],
        is_select && !is_selected && [aria_selected: "false"],
        !is_link && is_select && [role: "option"],
        assigns.is_disabled && [aria_disabled: "true"]
      ])

    assigns =
      assigns
      |> assign(:attributes, attributes)
      |> assign(:render_content, render_content)

    ~H"""
    <li {@attributes}>
      <%= @render_content.() %>
    </li>
    """
  end

  # ------------------------------------------------------------------------------------
  # tabnav
  # ------------------------------------------------------------------------------------

  @doc section: :navigation

  @doc ~S"""
  Generates a tab navigation.

  Tabs are by default rendered as buttons. To create link elements, pass attribute `href`, `navigate` or `patch`.

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

  When a link attribute is supplied to the item slot, links are created with `Phoenix.Component.link/1`, passing all other slot attributes to the link. Link examples:

  ```
  <:item href="#url">href link</:item>
  <:item navigate={Routes.page_path(@socket, :index)}>navigate link</:item>
  <:item patch={Routes.page_path(@socket, :index)}>patch link</:item>
  ```

  Add other types of content, such as icons and counters:

  ```
  <.tabnav>
    <:item href="#url" is_selected>
      <.octicon name="comment-discussion-16" />
      <span>Conversation</span>
      <.counter>2</.counter>
    </:item>
    <:item href="#url">
      <.octicon name="check-circle-16" />
      <span>Done</span>
      <.counter>99</.counter>
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

  Create small tabs (similar to tabs inside a `select_menu/1`) with `is_small`:

  ```
  <.tabnav>
    <:item is_small is_selected>
      One
    </:item>
    <:item is_small>
      Two
    </:item>
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
    doc: "Adds attribute `aria-label` to the outer element."
  )

  slot :item,
    required: true,
    doc: """
    Tab item content. Tabs are by default rendered as buttons. To create a link element, pass attribute `href`, `navigate` or `patch`.
    """ do
    attr(:is_selected, :boolean,
      doc: """
      Shows the selected state.
      """
    )

    attr(:is_small, :boolean,
      doc: """
      Creates a small tab, similar to tabs inside a `select_menu/1`.
      """
    )

    attr(:href, :any,
      doc: """
      Link attribute. The link is created with `Phoenix.Component.link/1`, passing all other slot attributes to the link.
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
          slot[:is_small] && "tabnav-tab--small",
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
          :is_selected,
          :is_small
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

  Tabs are by default rendered as buttons. To create link elements, pass attribute `href`, `navigate` or `patch`.

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

  When a link attribute is supplied to the item slot, links are created with `Phoenix.Component.link/1`, passing all other slot attributes to the link. Link examples:

  ```
  <:item href="#url">href link</:item>
  <:item navigate={Routes.page_path(@socket, :index)}>navigate link</:item>
  <:item patch={Routes.page_path(@socket, :index)}>patch link</:item>
  ```

  Add other types of content, such as icons and counters:

  ```
  <.underline_nav>
    <:item href="#url" is_selected>
      <.octicon name="comment-discussion-16" />
      <span>Conversation</span>
      <.counter>2</.counter>
    </:item>
    <:item href="#url">
      <.octicon name="check-circle-16" />
      <span>Done</span>
      <.counter>99</.counter>
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
      underline_nav: "", # Outer container (nav element)
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

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the outer element.
    """
  )

  slot :item,
    required: true,
    doc: """
    Tab item content: either a link or a button.

    Tab item content. Tabs are by default rendered as buttons. To create a link element, pass attribute `href`, `navigate` or `patch`.
    """ do
    attr(:is_selected, :boolean,
      doc: """
      Shows the selected state.
      """
    )

    attr(:href, :any,
      doc: """
      Link attribute. The link is created with `Phoenix.Component.link/1`, passing all other slot attributes to the link.
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
  # menu
  # ------------------------------------------------------------------------------------

  @doc section: :navigation

  @doc ~S"""
  Generates a vertical list of navigational links.

  Menu items are rendered as link element.

  ```
  <.menu aria_label="Site navigation">
    <:item href="#url" is_selected>
      Account
    </:item>
    <:item href="#url">
      Emails
    </:item>
  </.menu>
  ```

  ## Examples

  Menu links are created with `Phoenix.Component.link/1`, passing all other slot attributes to the link. Link examples:

  ```
  <:item href="#url">href link</:item>
  <:item navigate={Routes.page_path(@socket, :index)}>navigate link</:item>
  <:item patch={Routes.page_path(@socket, :index)}>patch link</:item>
  ```

  Add other types of content, such as icons and counters:

  ```
  <.menu>
    <:item href="#url" is_selected>
      <.octicon name="comment-discussion-16" />
      <span>Conversation</span>
      <.counter>2</.counter>
    </:item>
    <:item href="#url">
      <.octicon name="check-circle-16" />
      <span>Done</span>
      <.counter>99</.counter>
    </:item>
  </.menu>
  ```

  Add a heading:

  ```
  <.menu aria_label="Site navigation">
    <:heading>Menu heading</:heading>
    <:item href="#url" is_selected>
      Account
    </:item>
    <:item href="#url">
      Emails
    </:item>
  </.menu>
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
      menu: nil,
      item: nil,
      heading: nil
    },
    doc: """
    Additional classnames for underline nav elements.

    Any provided value will be appended to the default classname.

    Default map:
    ```
    %{
      menu: "",    # Outer container (nav element)
      item: "",    # Menu item element
      heading: "", # Heading element
    }
    ```
    """
  )

  attr(:aria_label, :string,
    default: nil,
    doc: "Adds attribute `aria-label` to the outer element."
  )

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the outer element.
    """
  )

  slot :item,
    required: true,
    doc: """
    Menu content. To create a link element, pass attribute `href`, `navigate` or `patch`.
    """ do
    attr(:is_selected, :boolean,
      doc: """
      Shows the selected state.
      """
    )

    attr(:href, :any,
      doc: """
      Link attribute. The link is created with `Phoenix.Component.link/1`, passing all other slot attributes to the link.
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

  slot(:heading,
    required: false,
    doc: """
    Menu heading.
    """
  )

  def menu(assigns) do
    classes = %{
      menu:
        AttributeHelpers.classnames([
          "menu",
          assigns.classes[:menu],
          assigns[:class]
        ]),
      heading: fn slot ->
        AttributeHelpers.classnames([
          "menu-heading",
          assigns.classes[:heading],
          slot[:class]
        ])
      end,
      item: fn slot ->
        AttributeHelpers.classnames([
          "menu-item",
          assigns.classes[:item],
          slot[:class]
        ])
      end
    }

    has_heading = assigns.heading !== []

    heading_id =
      case has_heading do
        true ->
          "heading-#{assigns.rest[:id] || AttributeHelpers.random_string()}"

        false ->
          nil
      end

    render_item = fn slot ->
      is_link = AttributeHelpers.is_link?(slot)

      rest =
        assigns_to_attributes(slot, [
          :class,
          :is_selected
        ])

      attributes =
        AttributeHelpers.append_attributes(rest, [
          [class: classes.item.(slot)],
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
        <%= render_slot(@slot) %>
      <% end %>
      """
    end

    render_heading = fn slot ->
      rest =
        assigns_to_attributes(slot, [
          :class
        ])

      attributes =
        AttributeHelpers.append_attributes(rest, [
          [class: classes.heading.(slot)],
          [id: heading_id]
        ])

      assigns =
        assigns
        |> assign(:attributes, attributes)
        |> assign(:slot, slot)

      ~H"""
      <span {@attributes}>
        <%= render_slot(@slot) %>
      </span>
      """
    end

    menu_attributes =
      AttributeHelpers.append_attributes(assigns.rest, [
        [class: classes.menu],
        [aria_label: assigns.aria_label],
        has_heading && [aria_labelledby: heading_id]
      ])

    assigns =
      assigns
      |> assign(:classes, classes)
      |> assign(:render_item, render_item)
      |> assign(:render_heading, render_heading)
      |> assign(:menu_attributes, menu_attributes)

    ~H"""
    <nav {@menu_attributes}>
      <%= if @heading && @heading !== [] do %>
        <%= for slot <- @heading do %>
          <%= @render_heading.(slot) %>
        <% end %>
      <% end %>
      <%= if @item && @item !== [] do %>
        <%= for slot <- @item do %>
          <%= @render_item.(slot) %>
        <% end %>
      <% end %>
    </nav>
    """
  end

  # ------------------------------------------------------------------------------------
  # side_nav
  # ------------------------------------------------------------------------------------

  @doc section: :navigation

  @doc ~S"""
  Generates a vertical list of navigational links.

  Menu items are rendered as link element.

  ```
  <.side_nav aria_label="Site navigation">
    <:item href="#url" is_selected>
      Account
    </:item>
    <:item href="#url">
      Emails
    </:item>
  </.side_nav>
  ```

  ## Examples

  Menu links are created with `Phoenix.Component.link/1`, passing all other slot attributes to the link. Link examples:

  ```
  <:item href="#url">href link</:item>
  <:item navigate={Routes.page_path(@socket, :index)}>navigate link</:item>
  <:item patch={Routes.page_path(@socket, :index)}>patch link</:item>
  ```

  Add other types of content, such as icons and counters:

  ```
  <.side_nav>
    <:item href="#url" is_selected>
      <.octicon name="comment-discussion-16" />
      <span>Conversation</span>
      <.counter>2</.counter>
    </:item>
    <:item href="#url">
      <.octicon name="check-circle-16" />
      <span>Done</span>
      <.counter>99</.counter>
    </:item>
    <:item href="#url">
      <h5>With a heading</h5>
      <span>and some longer description</span>
    </:item>
  </.side_nav>
  ```

  Add a border (not for sub navigation):

  ```
  <.side_nav is_border>
    ...
  </.side_nav>
  ```

  Create a sub navigation: a lightweight version without borders and more condensed.

  ```
  <.side_nav is_sub_nav>
    ...
  </.side_nav>
  ```

  A sub navigation can be placed inside a side navigation, using an `item` slot without attributes:

  ```
  <.side_nav is_border>
    <:item href="#url">
      Item 1
    </:item>
    <:item navigate="#url" is_selected>
      Item 2
    </:item>
    <:item>
      <.side_nav is_sub_nav class="border-top py-3" style="padding-left: 16px">
        <:item href="#url" is_selected>
          Sub item 1
        </:item>
        <:item navigate="#url">
          Sub item 2
        </:item>
      </.side_nav>
    </:item>
    <:item navigate="#url">
      Item 3
    </:item>
  </.side_nav>
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
      side_nav: nil,
      item: nil,
      sub_item: nil
    },
    doc: """
    Additional classnames for underline nav elements.

    Any provided value will be appended to the default classname.

    Default map:
    ```
    %{
      side_nav: "", # Outer container (nav element)
      item: "",     # Menu item element
      sub_item: "", # Menu sub item element
    }
    ```
    """
  )

  attr(:aria_label, :string,
    default: nil,
    doc: "Adds attribute `aria-label` to the outer element."
  )

  attr(:is_border, :boolean,
    default: false,
    doc: "Adds a border. Not applied when using `is_sub_nav`."
  )

  attr(:is_sub_nav, :boolean,
    default: false,
    doc:
      "Sets the menu style to \"sub navigation\": a lightweight version without borders and more condensed."
  )

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the outer element.
    """
  )

  slot :item,
    required: true,
    doc: """
    Menu content. To create a link element, pass attribute `href`, `navigate` or `patch`.
    """ do
    attr(:is_selected, :boolean,
      doc: """
      Shows the selected state.
      """
    )

    attr(:href, :any,
      doc: """
      Link attribute. The link is created with `Phoenix.Component.link/1`, passing all other slot attributes to the link.
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

  def side_nav(assigns) do
    classes = %{
      side_nav:
        AttributeHelpers.classnames([
          "SideNav",
          assigns.is_border && !assigns.is_sub_nav && "border",
          assigns.classes[:side_nav],
          assigns[:class]
        ]),
      item: fn slot ->
        AttributeHelpers.classnames([
          if assigns.is_sub_nav do
            AttributeHelpers.classnames([
              "SideNav-subItem",
              assigns.classes[:sub_item]
            ])
          else
            AttributeHelpers.classnames([
              "SideNav-item",
              assigns.classes[:item]
            ])
          end,
          slot[:class]
        ])
      end
    }

    render_item = fn slot ->
      is_link = AttributeHelpers.is_link?(slot)

      rest =
        assigns_to_attributes(slot, [
          :class,
          :is_selected
        ])

      attributes =
        AttributeHelpers.append_attributes(rest, [
          [class: classes.item.(slot)],
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
        <%= render_slot(@slot) %>
      <% end %>
      """
    end

    side_nav_attributes =
      AttributeHelpers.append_attributes(assigns.rest, [
        [class: classes.side_nav],
        [aria_label: assigns.aria_label]
      ])

    assigns =
      assigns
      |> assign(:classes, classes)
      |> assign(:render_item, render_item)
      |> assign(:side_nav_attributes, side_nav_attributes)

    ~H"""
    <nav {@side_nav_attributes}>
      <%= if @item && @item !== [] do %>
        <%= for slot <- @item do %>
          <%= @render_item.(slot) %>
        <% end %>
      <% end %>
    </nav>
    """
  end

  # ------------------------------------------------------------------------------------
  # subnav
  # ------------------------------------------------------------------------------------

  @doc section: :navigation

  @doc ~S"""
  Subnav is navigation that is typically used when on a dashboard type interface with another set of navigation above it. This helps distinguish navigation hierarchy

  Subnav is composed of one or more child components:
  - `subnav_links/1` - a link row
  - `subnav_search/1` - a search field
  - `subnav_search_context/1` - a search filter menu adjacent to the search field

  Minimal version, showing the link row:

  ```
  <.subnav>
    <.subnav_links>
      <:item href="#url" is_selected>Item 1</:item>
      <:item href="#url">Item 2</:item>
      <:item href="#url">Item 3</:item>
    </.subnav_links>
  </.subnav>
  ```

  ## Examples

  ### subnav_links

  To show a link row, use child component `subnav_links/1`.

  Navigation links are created with `Phoenix.Component.link/1`, passing all other slot attributes to the link. Link examples:

  ```
  <:item href="#url">href link</:item>
  <:item navigate={Routes.page_path(@socket, :index)}>navigate link</:item>
  <:item patch={Routes.page_path(@socket, :index)}>patch link</:item>
  ```

  ### subnav_search

  To add a search field, use child component `subnav_search/1` with a `text_input/1` component. Use `type="search"` to display a search icon inside the search field.

  ```
  <.subnav>
    <.subnav_search>
      <.text_input type="search" />
    </.subnav_search>
  </.subnav>
  ```

  ### subnav_search_context

  To place a filter menu adjacent to the search field, use child component `subnav_search_context/1` with a `select_menu/1` component:

  ```
  <.subnav>
    <.subnav_search_context>
      <.select_menu is_dropdown_caret>
        <:toggle>Menu</:toggle>
        <:item>Item 1</:item>
        <:item>Item 2</:item>
        <:item>Item 3</:item>
      </.select_menu>
    </.subnav_search_context>
    <.subnav_search>
      <.text_input type="search" />
    </.subnav_search>
  </.subnav>
  ```

  [INSERT LVATTRDOCS]

  ## Reference

  [Primer/CSS Navigation](https://primer.style/css/components/navigation)

  ## Status

  Feature complete.

  """

  attr(:class, :string, default: nil, doc: "Additional classname.")

  attr(:is_wrap, :boolean,
    default: false,
    doc: "Allows child elements to wrap, for example a link row followed by a search field."
  )

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the subnav element.
    """
  )

  slot(:inner_block, required: true, doc: "Subnav components.")

  def subnav(assigns) do
    class =
      AttributeHelpers.classnames([
        "subnav",
        assigns.is_wrap and "pl-subnav--wrap",
        assigns[:class]
      ])

    assigns = assigns |> assign(:class, class)

    ~H"""
    <div class={@class} {@rest}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  # ------------------------------------------------------------------------------------
  # subnav_links
  # ------------------------------------------------------------------------------------

  @doc section: :navigation

  @doc ~S"""
  Subnav link row. See `subnav/1`.

  [INSERT LVATTRDOCS]
  """

  attr(:aria_label, :string,
    default: nil,
    doc: "Adds attribute `aria-label` to the subnav links element."
  )

  attr(:class, :string, default: nil, doc: "Additional classname.")

  attr(:classes, :map,
    default: %{
      subnav_links: nil,
      item: nil
    },
    doc: """
    Additional classnames for subnav links elements.

    Any provided value will be appended to the default classname.

    Default map:
    ```
    %{
      subnav_links: "", # Outer container (nav element)
      item: "",         # Link item element
    }
    ```
    """
  )

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the subnav links element.
    """
  )

  slot :item,
    required: true,
    doc: """
    Subnav buttons item. To create a link element, pass attribute `href`, `navigate` or `patch`.
    """ do
    attr(:is_selected, :boolean,
      doc: """
      Shows the selected state.
      """
    )

    attr(:href, :any,
      doc: """
      Link attribute. The link is created with `Phoenix.Component.link/1`, passing all other slot attributes to the link.
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

  def subnav_links(assigns) do
    classes = %{
      subnav_links:
        AttributeHelpers.classnames([
          "subnav-links",
          assigns.classes[:subnav_links],
          assigns[:class]
        ]),
      item:
        AttributeHelpers.classnames([
          "subnav-item",
          assigns.classes[:item]
        ])
    }

    render_item = fn slot ->
      is_link = AttributeHelpers.is_link?(slot)

      rest =
        assigns_to_attributes(slot, [
          :class,
          :is_selected
        ])

      attributes =
        AttributeHelpers.append_attributes(rest, [
          [class: classes.item],
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
        <%= render_slot(@slot) %>
      <% end %>
      """
    end

    subnav_links_attributes =
      AttributeHelpers.append_attributes(assigns.rest, [
        [class: classes.subnav_links],
        [aria_label: assigns.aria_label]
      ])

    assigns =
      assigns
      |> assign(:render_item, render_item)
      |> assign(:subnav_links_attributes, subnav_links_attributes)

    ~H"""
    <nav {@subnav_links_attributes}>
      <%= if @item && @item !== [] do %>
        <%= for slot <- @item do %>
          <%= @render_item.(slot) %>
        <% end %>
      <% end %>
    </nav>
    """
  end

  # ------------------------------------------------------------------------------------
  # subnav_search
  # ------------------------------------------------------------------------------------

  @doc section: :navigation

  @doc ~S"""
  Subnav search field. See `subnav/1`.

  [INSERT LVATTRDOCS]
  """

  attr(:class, :string, default: nil, doc: "Additional classname.")

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the subnav search element.
    """
  )

  slot(:inner_block, required: true, doc: "Contents.")

  def subnav_search(assigns) do
    class =
      AttributeHelpers.classnames([
        "subnav-search",
        "float-left",
        assigns[:class]
      ])

    assigns = assigns |> assign(:class, class)

    ~H"""
    <div class={@class} {@rest}>
      <%= render_slot(@inner_block) %>
      <.octicon name="search-16" class="subnav-search-icon" />
    </div>
    """
  end

  # ------------------------------------------------------------------------------------
  # subnav_search_context
  # ------------------------------------------------------------------------------------

  @doc section: :navigation

  @doc ~S"""
  Subnav search filter adjacent to the search field. See `subnav/1`.

  [INSERT LVATTRDOCS]
  """

  attr(:class, :string, default: nil, doc: "Additional classname.")

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the subnav search context element.
    """
  )

  slot(:inner_block, required: true, doc: "Contents.")

  def subnav_search_context(assigns) do
    class =
      AttributeHelpers.classnames([
        "subnav-search-context",
        "float-left",
        assigns[:class]
      ])

    assigns = assigns |> assign(:class, class)

    ~H"""
    <div class={@class} {@rest}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  # ------------------------------------------------------------------------------------
  # filter_list
  # ------------------------------------------------------------------------------------

  @doc section: :navigation

  @doc ~S"""
  Generates a vertical list of filters.

  Filter list items are rendered as link element.

  ```
  <.filter_list aria_label="Menu">
    <:item href="#url" is_selected>
      One
    </:item>
    <:item href="#url">
      Two
    </:item>
    <:item href="#url">
      Three
    </:item>
  </.filter_list>
  ```

  ## Examples

  Filter links are created with `Phoenix.Component.link/1`, passing all other slot attributes to the link. Link examples:

  ```
  <:item href="#url">href link</:item>
  <:item navigate={Routes.page_path(@socket, :index)}>navigate link</:item>
  <:item patch={Routes.page_path(@socket, :index)}>patch link</:item>
  ```

  Add counts to the links:

  ```
  <.filter_list aria_label="Menu">
    <:item href="#url" is_selected count="99">
      First filter
    </:item>
    <:item href="#url" count={3}>
      Second filter
    </:item>
    <:item href="#url">
      Third filter
    </:item>
  </.filter_list>
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
      filter_list: nil,
      item: nil,
      count: nil
    },
    doc: """
    Additional classnames for filter list elements.

    Any provided value will be appended to the default classname.

    Default map:
    ```
    %{
      filter_list: "", # Outer container (ul element)
      item: "",        # Filter list item element (a element)
      count: "",       # Filter list item count element (span element)
    }
    ```
    """
  )

  attr(:aria_label, :string,
    default: nil,
    doc: "Adds attribute `aria-label` to the outer element."
  )

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the subnav links element.
    """
  )

  slot :item,
    required: true,
    doc: """
    Filter list item content. To create a link element, pass attribute `href`, `navigate` or `patch`.
    """ do
    attr(:is_selected, :boolean,
      doc: """
      Shows the selected state.
      """
    )

    attr(:count, :any,
      doc: """
      Integer or string. Displays a number at the far end of the filter link.
      """
    )

    attr(:href, :any,
      doc: """
      Link attribute. The link is created with `Phoenix.Component.link/1`, passing all other slot attributes to the link.
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

  def filter_list(assigns) do
    classes = %{
      filter_list:
        AttributeHelpers.classnames([
          "filter-list",
          assigns.classes[:filter_list],
          assigns[:class]
        ]),
      item: fn slot ->
        AttributeHelpers.classnames([
          "filter-item",
          assigns.classes[:item],
          slot[:class]
        ])
      end,
      count:
        AttributeHelpers.classnames([
          "count",
          assigns.classes[:count]
        ])
    }

    render_item = fn slot ->
      is_link = AttributeHelpers.is_link?(slot)

      rest =
        assigns_to_attributes(slot, [
          :class,
          :is_selected,
          :count
        ])

      attributes =
        AttributeHelpers.append_attributes(rest, [
          [class: classes.item.(slot)],
          slot[:is_selected] && [aria_current: "page"]
        ])

      assigns =
        assigns
        |> assign(:is_link, is_link)
        |> assign(:attributes, attributes)
        |> assign(:slot, slot)
        |> assign(:count, slot[:count])
        |> assign(:classes, classes)

      ~H"""
      <li>
        <%= if @is_link do %>
          <Phoenix.Component.link {@attributes}>
            <%= render_slot(@slot) %>
            <%= if @count do %>
              <span class={@classes.count}><%= @count %></span>
            <% end %>
          </Phoenix.Component.link>
        <% else %>
          <%= render_slot(@slot) %>
        <% end %>
      </li>
      """
    end

    filter_list_attributes =
      AttributeHelpers.append_attributes(assigns.rest, [
        [class: classes.filter_list],
        [aria_label: assigns.aria_label]
      ])

    assigns =
      assigns
      |> assign(:classes, classes)
      |> assign(:filter_list_attributes, filter_list_attributes)
      |> assign(:render_item, render_item)

    ~H"""
    <ul {@filter_list_attributes}>
      <%= if @item !== [] do %>
        <%= for slot <- @item do %>
          <%= @render_item.(slot) %>
        <% end %>
      <% end %>
    </ul>
    """
  end

  # ------------------------------------------------------------------------------------
  # form_group
  # ------------------------------------------------------------------------------------

  @doc section: :forms

  @doc ~S"""
  Generates a form group: a wrapper around one or more inputs. Automatically adds a label based on supplied form and field, with the option to set a custom label.

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

  attr(:for, :string,
    default: nil,
    doc:
      "Internally used by `text_input/1` and `textarea/1` when using `is_form_group` or `form_group`. Label attribute to associate the label with the input. `for` should be the same as the input's `id`."
  )

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
    }
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
    case SchemaHelpers.validate_is_form(assigns) do
      {:error, reason} ->
        assigns =
          assigns
          |> assign(:reason, reason)

        ~H"""
        <%= @reason %>
        """

      _ ->
        render_form_group(assigns)
    end
  end

  defp render_form_group(assigns) do
    %{
      rest: rest,
      form: form,
      field: field
    } = AttributeHelpers.common_input_attrs(assigns, nil)

    classes = %{
      group:
        AttributeHelpers.classnames([
          "form-group",
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
        ])
    }

    # If label is supplied, wrap it inside a label element
    # else use the default generated label
    header_label_attributes =
      AttributeHelpers.append_attributes([], [
        [class: assigns.classes.label],
        [for: assigns[:for] || nil]
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

    ~H"""
    <div {@group_attributes}>
      <%= if @has_header_label do %>
        <div class={@classes.header}>
          <%= @header_label %>
        </div>
      <% end %>
      <div class={@classes.body}>
        <%= render_slot(@inner_block) %>
      </div>
    </div>
    """
  end

  # ------------------------------------------------------------------------------------
  # input_validation_message
  # ------------------------------------------------------------------------------------

  @doc section: :forms

  @doc ~S"""
  Generates a validation message for a form input.

  This component is incorporated in "singular inputs" `text_input/1`, `textarea/1` and `select/1`. It can be used as standalone component for inputs where the position of the validation feedback is not so obvious.

  A validation error message is automatically added when using a changeset with an error state. The message text is taken from the changeset errors.


  To show the default validation message:

  ```
  <.form let={f} for={@changeset} phx-change="validate" phx-submit="save">
    <!-- INPUTS -->
    <.input_validation_message form={@form} field={:availability} />
  </.form>
  ```

  To show a custom error message:

  ```
  <.form let={f} for={@changeset} phx-change="validate" phx-submit="save">
    <!-- INPUTS -->
    <.input_validation_message
      form={@form}
      field={:availability}
      validation_message={
        fn field_state ->
          if !field_state.valid?, do: "Please select your availability"
        end
      }
    />
  </.form>
  ```

  Similarly, to show a custom validation success message:

  ```
  <.form let={f} for={@changeset} phx-change="validate" phx-submit="save">
    <!-- INPUTS -->
    <.input_validation_message
      form={@form}
      field={:availability}
      validation_message={
        fn field_state ->
          if field_state.valid?, do: "Great!"
        end
      }
    />
  </.form>
  ```
  """

  attr(:class, :string, default: nil, doc: "Classname.")

  attr :field, :any, doc: "Field name (atom or string)."

  attr :form, :any,
    doc:
      "Either a [Phoenix.HTML.Form](https://hexdocs.pm/phoenix_html/Phoenix.HTML.Form.html) or an atom."

  attr(:validation_message, :any,
    doc: """
    Function to write a custom validation message (in case of error or success). See `text_input/1`.
    """
  )

  attr(:input_id, :string,
    doc: """
    If the associated input has an id, pass it here as "input_id".
    """
  )

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the input element.
    """
  )

  def input_validation_message(assigns) do
    %{
      show_message?: show_message?,
      validation_message_id: validation_message_id,
      phx_feedback_for_id: phx_feedback_for_id,
      message: message,
      valid?: valid?
    } = AttributeHelpers.common_input_attrs(assigns, nil)

    class =
      AttributeHelpers.classnames([
        "FormControl-inlineValidation",
        if valid? do
          "FormControl-inlineValidation--success"
        else
          "FormControl-inlineValidation--error"
        end,
        assigns[:class]
      ])

    attributes =
      AttributeHelpers.append_attributes([], [
        [class: class],
        [id: validation_message_id],
        [phx_feedback_for: phx_feedback_for_id]
      ])

    assigns =
      assigns
      |> assign(:attributes, attributes)
      |> assign(:message, message)
      |> assign(:valid?, valid?)
      |> assign(:show_message?, show_message?)

    ~H"""
    <%= if @show_message? && not is_nil(@message) do %>
      <div {@attributes}>
        <%= if @valid? do %>
          <.octicon name="check-circle-fill-12" />
        <% else %>
          <.octicon name="alert-fill-12" />
        <% end %>
        <span><%= @message %></span>
      </div>
    <% end %>
    """
  end

  # ------------------------------------------------------------------------------------
  # text_input
  # ------------------------------------------------------------------------------------

  @doc section: :forms

  @doc ~S"""
  Generates a text input field.

  Wrapper around `Phoenix.HTML.Form.text_input/3`, optionally wrapped itself inside a "form group" to add a field label.

  ```
  <.text_input field="first_name" />
  ```

  ## Examples

  Set the input type:

  ```
  <.text_input type="password" />
  <.text_input type="hidden" />
  <.text_input type="email" />
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

  Attach a button to the input with slot `group_button`:

  ```
  <.text_input>
    <:group_button>
      <.button>Send</.button>
    </:group_button>
  </.text_input>
  ```

  or use an icon button:

  ```
  <.text_input>
    <:group_button>
      <.button aria-label="Copy">
        <.octicon name="paste-16" />
      </.button>
    </:group_button>
  </.text_input>
  ```

  Add a button to the text input with slot `trailing_action`:

  ```
  <.text_input>
    <:trailing_action>
      <.button is_icon_only aria-label="Clear">
        <.octicon name="x-16" />
      </.button>
    </:trailing_action>
  </.text_input>
  ```

  Add a leading visual with slot `leading_visual`:

  ```
  <.text_input>
    <:leading_visual>
      <.octicon name="mail-16" />
    </:leading_visual>
  </.text_input>
  ```

  Place the input inside a `form_group/1` with `is_form_group`. Attributes `form` and `field` are passed to the form group to generate a group label.

  ```
  <.form let={f} for={@changeset} phx-change="validate" phx-submit="save">
    <.text_input form={f} field={:first_name} is_form_group />
  </.form>
  ```

  To configure the form group and label, use attr `form_group`. See `form_group/1` for supported attributes.

  A validation error message is automatically added when using a changeset with an error state. The message text is taken from the changeset errors.
  To show a custom validation error message, supply function `validation_message`:

  ```
  <.form let={f} for={@changeset} phx-change="validate" phx-submit="save">
    <.text_input
      form={f}
      field={:first_name}
      form_group={%{
        label: "Custom label",
        validation_message:
          fn field_state ->
            if !field_state.valid?, do: "Please enter your first name"
          end
      }}
    />
  </.form>
  ```

  Similarly, to show a custom validation success message:

  ```
  <.form let={f} for={@changeset} phx-change="validate" phx-submit="save">
    <.text_input
      form={f}
      field={:first_name}
      validation_message={
        fn field_state ->
          if field_state.valid?, do: "Available!"
        end
      }
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

  attr(:class, :string, default: nil, doc: "Additional classname.")

  attr(:classes, :map,
    default: %{
      input: nil,
      input_group: nil,
      input_group_button: nil,
      validation_message: nil,
      input_wrap: nil
    },
    doc: """
    Additional classnames for input elements.

    Any provided value will be appended to the default classname.

    Default map:
    ```
    %{
      input: "",              # Input element
      input_group: "",        # Wrapper around the grouped input and group button
      input_group_button: "", # Wrapper around slot group_button
      validation_message: "", # Validation message
      input_wrap: "",         # Input wrapper when leading or trailing visual is used
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

  attr(:is_large, :boolean,
    default: false,
    doc:
      "Additional padding creates a higher input box. If no width is specified, the input box is slightly wider."
  )

  attr(:is_small, :boolean,
    default: false,
    doc: "Smaller (less high) input with smaller text size."
  )

  attr(:is_short, :boolean,
    default: false,
    doc: "Inside a form group. Generates an input with a reduced width."
  )

  attr(:is_shorter, :boolean,
    default: false,
    doc: "Inside a form group. Generates an input with a even more reduced width."
  )

  attr(:is_monospace, :boolean,
    default: false,
    doc: "Uses a monospace font."
  )

  attr(:is_trailing_action_divider, :boolean,
    default: false,
    doc: "Adds a separator line to slot `trailing_action`."
  )

  attr(:is_form_group, :boolean,
    default: false,
    doc: """
    Inserts the input inside a `form_group/1`. Attributes `form` and `field` are passed to the form group to generate a group label.

    To configure the form group and label, use attr `form_group`.
    """
  )

  attr(:form_group, :any,
    doc: """
    Form group attributes. Inserts the input inside a `form_group/1` with given attributes, alongside `form` and `field` to generate a group label.
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

  slot(:group_button,
    doc: """
    Primer CSS "Input group". Attaches a button at the end of the input.

    Example:
    ```
    <.text_input>
      <:group_button>
        <.button aria-label="Copy">
          <.octicon name="paste-16" />
        </.button>
      </:group_button>
    </.text_input>
    ```
    """
  )

  slot(:leading_visual,
    required: false,
    doc: """
    Container for a leading visual. Commonly a `octicon/1` component is used.
    """
  )

  slot(:trailing_action,
    required: false,
    doc: """
    Container for a trailing action. Commonly a `octicon/1` component, or a `button/1` component with an icon (no label) is used.
    """
  )

  def text_input(assigns) do
    case SchemaHelpers.validate_is_form(assigns) do
      {:error, reason} ->
        assigns =
          assigns
          |> assign(:reason, reason)

        ~H"""
        <%= @reason %>
        """

      _ ->
        render_text_input(assigns)
    end
  end

  defp render_text_input(assigns) do
    %{
      field: field,
      form_group_attrs: form_group_attrs,
      form: form,
      has_form_group: has_form_group,
      input_id: input_id,
      rest: rest,
      show_message?: show_message?,
      validation_marker_attrs: validation_marker_attrs,
      validation_message_id: validation_message_id
    } = AttributeHelpers.common_input_attrs(assigns, nil)

    type = assigns.type

    has_leading_visual =
      type !== "textarea" && !is_nil(assigns[:leading_visual]) && assigns[:leading_visual] !== []

    has_trailing_action =
      type !== "textarea" && !is_nil(assigns[:trailing_action]) &&
        assigns[:trailing_action] !== []

    has_input_wrap = has_leading_visual || has_trailing_action

    classes = %{
      input:
        AttributeHelpers.classnames([
          if type === "textarea" do
            "FormControl-textarea"
          else
            "FormControl-input"
          end,
          assigns.is_contrast and "FormControl-inset",
          assigns.is_hide_webkit_autofill and "input-hide-webkit-autofill",
          !assigns.is_large and !assigns.is_small and "FormControl-medium",
          assigns.is_large and "FormControl-large",
          assigns.is_small and "FormControl-small",
          assigns.is_full_width and "FormControl--fullWidth",
          assigns.is_short and "FormControl--short",
          assigns.is_shorter and "FormControl--shorter",
          assigns.is_monospace and "FormControl-monospace",
          assigns.classes[:input],
          assigns.class
        ]),
      input_group:
        AttributeHelpers.classnames([
          "input-group",
          assigns.classes[:input_group]
        ]),
      input_group_button:
        AttributeHelpers.classnames([
          "input-group-button",
          assigns.classes[:input_group_button]
        ]),
      validation_message: assigns.classes[:validation_message],
      input_wrap:
        AttributeHelpers.classnames([
          "FormControl-input-wrap",
          has_leading_visual and "FormControl-input-wrap--leadingVisual",
          has_trailing_action and "FormControl-input-wrap--trailingAction",
          assigns.classes[:input_wrap]
        ]),
      leading_visual: "FormControl-input-leadingVisualWrap",
      trailing_action:
        AttributeHelpers.classnames([
          "FormControl-input-trailingAction",
          type !== "textarea" && assigns.is_trailing_action_divider &&
            "FormControl-input-trailingAction--divider"
        ])
    }

    render = fn ->
      has_group_button = assigns[:group_button] !== []

      input_attrs =
        AttributeHelpers.append_attributes(
          assigns_to_attributes(rest, [
            :id
          ]),
          [
            [class: classes.input],
            # If aria_label is not set, use the value of placeholder (if any):
            !rest[:aria_label] && [aria_label: rest[:placeholder]],
            validation_message_id && [aria_describedby: validation_message_id],
            [id: input_id],
            show_message? && [invalid: ""]
          ]
        )

      input =
        apply(Phoenix.HTML.Form, FormHelpers.text_input_type_as_atom(type), [
          form,
          field,
          input_attrs
        ])

      render_input_with_validation_marker = fn ->
        assigns =
          assigns
          |> assign(:input, input)
          |> assign(:validation_marker_attrs, validation_marker_attrs)

        ~H"""
        <%= if @validation_marker_attrs do %>
          <span {@validation_marker_attrs}></span>
        <% end %>
        <%= @input %>
        """
      end

      assigns =
        assigns
        |> assign(:classes, classes)
        |> assign(:has_group_button, has_group_button)
        |> assign(:has_input_wrap, has_input_wrap)
        |> assign(:render_input_with_validation_marker, render_input_with_validation_marker)
        |> assign(:input_id, input_id)
        |> assign(:form, form)
        |> assign(:field, field)
        |> assign(:show_message?, show_message?)
        |> assign(:validation_message_class, classes.validation_message)
        |> assign(:validation_message, assigns[:validation_message])

      ~H"""
      <%= if @has_group_button do %>
        <div class={@classes.input_group}>
          <%= @render_input_with_validation_marker.() %>
          <span class={@classes.input_group_button}>
            <%= render_slot(@group_button) %>
          </span>
        </div>
      <% else %>
        <%= if @has_input_wrap do %>
          <div class={@classes.input_wrap}>
            <%= if !is_nil(@leading_visual) && @leading_visual !== [] do %>
              <span class={@classes.leading_visual}><%= render_slot(@leading_visual) %></span>
            <% end %>
            <%= @render_input_with_validation_marker.() %>
            <%= if !is_nil(@trailing_action) && @trailing_action !== [] do %>
              <span class={@classes.trailing_action}><%= render_slot(@trailing_action) %></span>
            <% end %>
          </div>
        <% else %>
          <%= @render_input_with_validation_marker.() %>
        <% end %>
      <% end %>
      <%= if @show_message? do %>
        <.input_validation_message
          form={@form}
          field={@field}
          input_id={@input_id}
          validation_message={@validation_message}
          class={@validation_message_class}
        />
      <% end %>
      """
    end

    assigns =
      assigns
      |> assign(:has_form_group, has_form_group)
      |> assign(:form_group_attrs, form_group_attrs)
      |> assign(:render, render)

    ~H"""
    <%= if @has_form_group do %>
      <.form_group {@form_group_attrs}>
        <%= @render.() %>
      </.form_group>
    <% else %>
      <%= @render.() %>
    <% end %>
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
  <.select
    name="age"
    options={25..35}
    prompt={[key: "Choose your age", disabled: true, selected: true]}
  />
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

  Place the select inside a `form_group/1` with `is_form_group`. See `text_input/1` for examples.

  A validation error message is automatically added when using a changeset with an error state. See `text_input/1` how to customise the validation messages.

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

  attr(:classes, :map,
    default: %{
      select_container: nil,
      select: nil,
      validation_message: nil
    },
    doc: """
    Additional classnames for select elements.

    Any provided value will be appended to the default classname.

    Default map:
    ```
    %{
      select_container: "",   # Select container element
      select: "",             # Select element
      validation_message: "", # Validation message
    }
    ```
    """
  )

  attr(:prompt, :any,
    doc: """
    The default option that is displayed in the select options before the user makes a selection. See
    `Phoenix.HTML.Form.multiple_select/4`.

    Pass a string or a keyword list.

    Examples:

    ```
    <.select name="age" options={25..35} prompt="Choose your age" />
    ```

    Set attributes to the prompt option:

    ```
    <.select
      name="age"
      options={25..35}
      prompt={[key: "Choose your age", disabled: true, selected: true]}
    />
    ```
    """
  )

  attr(:is_multiple, :boolean,
    default: false,
    doc: """
    Creates a multiple select. Uses `Phoenix.HTML.Form.multiple_select/4`.

    From the Phoenix documentation:

    Values are expected to be an Enumerable containing two-item tuples (like maps and keyword lists) or any Enumerable where the element will be used both as key and value for the generated select.
    """
  )

  attr :is_small, :boolean, default: false, doc: "Creates a small select."
  attr :is_large, :boolean, default: false, doc: "Creates a large select."
  attr :is_short, :boolean, default: false, doc: "Creates a short select."
  attr :is_shorter, :boolean, default: false, doc: "Creates a shorter select."
  attr :is_full_width, :boolean, default: false, doc: "Full width select."

  attr :is_auto_height, :boolean,
    default: false,
    doc: "When using `is_multiple`: sets the size to the number of options."

  attr(:is_monospace, :boolean,
    default: false,
    doc: "Uses a monospace font."
  )

  attr(:is_form_group, :boolean,
    default: false,
    doc: """
    Inserts the select inside a `form_group/1`. Attributes `form` and `field` are passed to the form group to generate a group label.

    To configure the form group and label, use attr `form_group`.
    """
  )

  attr(:form_group, :any,
    doc: """
    Form group attributes. Inserts the select inside a `form_group/1` with given attributes, alongside `form` and `field` to generate a group label.
    """
  )

  attr(:validation_message, :any,
    doc: """
    Function to write a custom validation message (in case of error or success). See `text_input/1`.
    """
  )

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the select input.
    """
  )

  def select(assigns) do
    case SchemaHelpers.validate_is_form(assigns) do
      {:error, reason} ->
        assigns =
          assigns
          |> assign(:reason, reason)

        ~H"""
        <%= @reason %>
        """

      _ ->
        render_select(assigns)
    end
  end

  defp render_select(assigns) do
    %{
      rest: rest,
      form: form,
      field: field,
      validation_marker_attrs: validation_marker_attrs,
      input_id: input_id,
      has_form_group: has_form_group,
      form_group_attrs: form_group_attrs,
      show_message?: show_message?,
      validation_message_id: validation_message_id
    } = AttributeHelpers.common_input_attrs(assigns, nil)

    is_multiple = assigns.is_multiple

    classes = %{
      select_container:
        AttributeHelpers.classnames([
          "FormControl-select-wrap",
          is_multiple and "pl-multiple-select",
          assigns.is_short and "FormControl--short",
          assigns.is_shorter and "FormControl--shorter",
          assigns.is_full_width and "FormControl--fullWidth",
          assigns.classes[:select_container],
          assigns[:class]
        ]),
      select:
        AttributeHelpers.classnames([
          "FormControl-select",
          !assigns.is_large and !assigns.is_small and "FormControl-medium",
          assigns.is_small and "FormControl-small",
          assigns.is_large and "FormControl-large",
          assigns.is_monospace and "FormControl-monospace",
          assigns.classes[:select]
        ]),
      validation_message: assigns.classes[:validation_message]
    }

    render = fn ->
      options = assigns.options
      is_auto_height = assigns.is_auto_height

      container_attrs = [class: classes.select_container]

      input_attrs =
        AttributeHelpers.append_attributes(
          assigns_to_attributes(rest, [
            :id
          ]),
          [
            [class: classes.select],
            is_auto_height && [size: Enum.count(options)],
            validation_message_id && [aria_describedby: validation_message_id],
            [id: input_id],
            [prompt: assigns[:prompt]],
            show_message? && [invalid: ""]
          ]
        )

      input_fn =
        if is_multiple do
          :multiple_select
        else
          :select
        end

      input = apply(Phoenix.HTML.Form, input_fn, [form, field, options, input_attrs])

      assigns =
        assigns
        |> assign(:input, input)
        |> assign(:container_attrs, container_attrs)
        |> assign(:classes, classes)
        |> assign(:validation_message_class, classes.validation_message)
        |> assign(:validation_marker_attrs, validation_marker_attrs)
        |> assign(:input_id, input_id)
        |> assign(:form, form)
        |> assign(:field, field)
        |> assign(:validation_message_class, classes.validation_message)
        |> assign(:validation_message, assigns[:validation_message])

      ~H"""
      <div {@container_attrs}>
        <%= if @validation_marker_attrs do %>
          <span {@validation_marker_attrs}></span>
        <% end %>
        <%= @input %>
      </div>
      <.input_validation_message
        form={@form}
        field={@field}
        input_id={@input_id}
        validation_message={@validation_message}
        class={@validation_message_class}
      />
      """
    end

    assigns =
      assigns
      |> assign(:has_form_group, has_form_group)
      |> assign(:form_group_attrs, form_group_attrs)
      |> assign(:render, render)

    ~H"""
    <%= if @has_form_group do %>
      <.form_group {@form_group_attrs}>
        <%= @render.() %>
      </.form_group>
    <% else %>
      <%= @render.() %>
    <% end %>
    """
  end

  # ------------------------------------------------------------------------------------
  # checkbox
  # ------------------------------------------------------------------------------------

  @doc section: :forms

  @doc ~S"""
  Generates a checkbox.

  Wrapper around `Phoenix.HTML.Form.checkbox/3`.

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
      <.text_input is_contrast size="3" />
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
      container: nil,
      label_container: nil,
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
      container: "",       # Checkbox container
      label_container: "", # Input label container
      label: "",           # Input label
      input: "",           # Checkbox input element
      hint: "",            # Hint message container
      disclosure: ""       # Disclosure container (inline)
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
    case SchemaHelpers.validate_is_form(assigns) do
      {:error, reason} ->
        assigns =
          assigns
          |> assign(:reason, reason)

        ~H"""
        <%= @reason %>
        """

      _ ->
        render_checkbox(assigns)
    end
  end

  defp render_checkbox(assigns) do
    # Remove type from rest, we'll set it on the input
    rest =
      assigns_to_attributes(assigns.rest, [
        :type
      ])

    assigns =
      assigns
      |> assign(:rest, rest)
      |> assign(:input_type, :checkbox)

    render_checkbox_input(assigns)
  end

  defp render_checkbox_input(assigns) do
    input_type = assigns[:input_type]

    %{
      derived_label: derived_label,
      field: field,
      form: form,
      input_id: input_id,
      rest: rest,
      show_message?: show_message?,
      value: value,
      validation_marker_attrs: validation_marker_attrs
    } = AttributeHelpers.common_input_attrs(assigns, input_type)

    classes = %{
      container:
        AttributeHelpers.classnames([
          if input_type === :radio_button do
            "FormControl-radio-wrap"
          else
            "FormControl-checkbox-wrap"
          end,
          assigns[:classes][:container],
          assigns[:class]
        ]),
      input:
        AttributeHelpers.classnames([
          if input_type === :radio_button do
            "FormControl-radio"
          else
            "FormControl-checkbox"
          end,
          assigns[:classes][:input]
        ]),
      label_container:
        AttributeHelpers.classnames([
          if input_type === :radio_button do
            "FormControl-radio-labelWrap"
          else
            "FormControl-checkbox-labelWrap"
          end,
          assigns.classes[:label_container]
        ]),
      label: fn slot ->
        AttributeHelpers.classnames([
          "FormControl-label",
          assigns[:classes][:label],
          slot[:class]
        ])
      end,
      hint: fn slot ->
        AttributeHelpers.classnames([
          "FormControl-caption",
          assigns[:classes][:hint],
          slot[:class]
        ])
      end,
      disclosure: fn slot ->
        AttributeHelpers.classnames([
          "form-checkbox-details",
          "text-normal",
          assigns[:classes][:disclosure],
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
    has_label = has_label_slot || derived_label !== "Nil"

    container_attributes =
      AttributeHelpers.append_attributes([
        [class: classes.container]
      ])

    input_class =
      AttributeHelpers.classnames([
        if has_disclosure_slot do
          "form-checkbox-details-trigger"
        end,
        classes.input
      ])

    input_opts =
      AttributeHelpers.append_attributes(
        assigns_to_attributes(rest, [
          :id
        ]),
        [
          input_class && [class: input_class],
          input_id && [id: input_id],
          show_message? && [invalid: ""]
        ]
      )

    input =
      case assigns.input_type do
        :checkbox ->
          Phoenix.HTML.Form.checkbox(form, field, input_opts)

        :radio_button ->
          Phoenix.HTML.Form.radio_button(form, field, value, input_opts)
      end

    label_container_attributes = [
      class: classes.label_container
    ]

    label_attributes =
      AttributeHelpers.append_attributes(
        assigns_to_attributes(label_slot, [
          :class
        ]),
        [
          [class: classes.label.(label_slot)],
          has_disclosure_slot && [aria_live: "polite"],
          [for: input_id]
        ]
      )

    assigns =
      assigns
      |> assign(:container_attributes, container_attributes)
      |> assign(:label_container_attributes, label_container_attributes)
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
      |> assign(:validation_marker_attrs, validation_marker_attrs)

    ~H"""
    <div {@container_attributes}>
      <%= if @validation_marker_attrs do %>
        <span {@validation_marker_attrs}></span>
      <% end %>
      <%= @input %>
      <%= if @has_label do %>
        <div {@label_container_attributes}>
          <label {@label_attributes}>
            <%= @label %>
          </label>
          <%= if @hint && @hint !== [] do %>
            <%= @render_hint.() %>
          <% end %>
          <%= if @has_disclosure_slot do %>
            <%= @render_disclosure.() %>
          <% end %>
        </div>
      <% end %>
    </div>
    """
  end

  # ------------------------------------------------------------------------------------
  # radio_button
  # ------------------------------------------------------------------------------------

  @doc section: :forms

  @doc ~S"""
  Generates a radio button.

  Wrapper around `Phoenix.HTML.Form.radio_button/4`.

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
      <.text_input is_contrast size="3" />
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
    case SchemaHelpers.validate_is_form(assigns) do
      {:error, reason} ->
        assigns =
          assigns
          |> assign(:reason, reason)

        ~H"""
        <%= @reason %>
        """

      _ ->
        render_radio_button(assigns)
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
    case SchemaHelpers.validate_is_form(assigns) do
      {:error, reason} ->
        assigns =
          assigns
          |> assign(:reason, reason)

        ~H"""
        <%= @reason %>
        """

      _ ->
        render_radio_group(assigns)
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
          "FormControl-radio",
          assigns.classes[:radio_input]
        ])
    }

    render_radio_button = fn slot ->
      initial_opts =
        assigns_to_attributes(slot, [
          :inner_block,
          :__slot__,
          :value,
          :class,
          :id
        ])

      value = slot[:value]
      escaped_value = Phoenix.HTML.html_escape(value)
      id_prefix = if is_nil(assigns.id_prefix), do: "", else: assigns.id_prefix <> "-"
      id = slot[:id] || id_prefix <> Phoenix.HTML.Form.input_id(form, field, escaped_value)

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

  ```
  <.alert>
    Flash message goes here.
  </.alert>
  ```

  ## Examples

  Add color to the alert by using attribute `state`. Possible states:

  - "default" - light blue
  - "info" - same as default
  - "success" - light green
  - "warning" - light yellow
  - "error" - pink

  Add a success color to the alert:

  ```
  <.alert state="success">
    You're done!
  </.alert>
  ```

  Multiline message:

  ```
  <.alert state="success">
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

  attr(:classes, :map,
    default: %{
      alert: nil,
      state_default: nil,
      state_info: nil,
      state_success: nil,
      state_warning: nil,
      state_error: nil
    },
    doc: """
    Additional classnames for the alert element and alert states.

    Any provided value will be appended to the default classname.

    Default map:
    ```
    %{
      alert: "",         # Outer container
      state_default: "", # Alert color modifier
      state_info: "",    # Alert color modifier
      state_success: "", # Alert color modifier
      state_warning: "", # Alert color modifier
      state_error: "",   # Alert color modifier
    }
    ```
    """
  )

  attr(:state, :string,
    values: ~w(default info success warning error),
    doc: """
    Color mapping:

    - "default" - light blue
    - "info" - same as default
    - "success" - light green
    - "warning" - light yellow
    - "error" - pink

    """
  )

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
    state_modifier_classes = %{
      state_default:
        AttributeHelpers.classnames([
          assigns.classes[:state_default]
        ]),
      state_info:
        AttributeHelpers.classnames([
          assigns.classes[:state_info]
        ]),
      state_success:
        AttributeHelpers.classnames([
          "flash-success",
          assigns.classes[:state_success]
        ]),
      state_warning:
        AttributeHelpers.classnames([
          "flash-warn",
          assigns.classes[:state_warning]
        ]),
      state_error:
        AttributeHelpers.classnames([
          "flash-error",
          assigns.classes[:state_error]
        ])
    }

    class =
      AttributeHelpers.classnames([
        "flash",
        assigns[:state] === "default" and state_modifier_classes.state_default,
        assigns[:state] === "info" and state_modifier_classes.state_info,
        assigns[:state] === "success" and state_modifier_classes.state_success,
        assigns[:state] === "warning" and state_modifier_classes.state_warning,
        assigns[:state] === "error" and state_modifier_classes.state_error,
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
  # styled_html
  # ------------------------------------------------------------------------------------

  @doc section: :styled_html

  @doc ~S"""
  Adds styling to HTML.

  This can be used to format HTML generated by a Markdown library, or to create consistent layout of HTML content.

  ```
  <.styled_html>
    Content
  </.styled_html>
  ```

  [INSERT LVATTRDOCS]

  ## Reference

  [Primer/CSS Markdown](https://primer.style/css/components/markdown/)

  ## Status

  Feature complete.

  """

  attr(:class, :string, doc: "Additional classname.")

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the outer element.
    """
  )

  slot(:inner_block, required: true, doc: "Content to be formatted.")

  def styled_html(assigns) do
    class =
      AttributeHelpers.classnames([
        "markdown-body",
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
      values: [1, 2],
      doc: """
      Markup order, defines in what order the slot is rendered in HTML. Keyboard navigation follows the markup order. Decide carefully how the focus order should be be by deciding whether main or sidebar comes first in code. The markup order won't affect the visual position. Default value: 2.
      """
    )
  end

  slot(:divider,
    doc:
      "Generates a divider element. The divider will only be shown with option `is_divided`. Generates a line between the main and sidebar elements - horizontal when the elements are stacked and vertical when they are shown side by side."
  )

  slot :sidebar,
    doc:
      "Generates a sidebar element. Widths: md: 256px, lg: 296px (change with `is_narrow_sidebar` and `is_wide_sidebar`)." do
    attr :order, :integer, values: [1, 2], doc: "See `main` slot. Default value: 1."
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
      A very long title that wraps onto multiple lines without overlapping
      or wrapping underneath the icon to it's right
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

  To make the entire row a link, pass attribute `href`, `navigate` or `patch`. Tweak the link behaviour with row attrs `is_hover_gray`, `is_hover_blue` and/or Primer CSS modifier class "no-underline". Link examples:

  ```
  <:row href="#url">href link</:row>
  <:row navigate={Routes.page_path(@socket, :index)}>navigate link</:row>
  <:row patch={Routes.page_path(@socket, :index)}>patch link</:row>
  <:row href="#url" class="no-underline" is_hover_gray>Link, no underline, hover gray</:row>
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
    doc:
      "Generates a content row element. To create a link element, pass attribute `href`, `navigate` or `patch`." do
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

    attr(:href, :any,
      doc: """
      Link attribute. The link is created with `Phoenix.Component.link/1`, passing all other slot attributes to the link.
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
      row: fn slot, is_link ->
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
          is_link && "d-block",
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

    render_row = fn slot ->
      is_link = AttributeHelpers.is_link?(slot)
      class = classes.row.(slot, is_link)

      rest =
        assigns_to_attributes(slot, [
          :class,
          :is_blue,
          :is_gray,
          :is_yellow,
          :is_hover_blue,
          :is_hover_gray,
          :is_focus_blue,
          :is_focus_gray,
          :is_navigation_focus,
          :is_unread
        ])

      attributes =
        AttributeHelpers.append_attributes(rest, [
          [class: class]
        ])

      assigns =
        assigns
        |> assign(:is_link, is_link)
        |> assign(:attributes, attributes)
        |> assign(:slot, slot)
        |> assign(:classes, classes)

      ~H"""
      <%= if @is_link do %>
        <Phoenix.Component.link {@attributes}>
          <%= render_slot(@slot, @classes) %>
        </Phoenix.Component.link>
      <% else %>
        <div {@attributes}>
          <%= render_slot(@slot, @classes) %>
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
        <%= for slot <- @row do %>
          <%= @render_row.(slot) %>
        <% end %>
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

  @doc section: :menus

  @doc ~S"""
  Generates a dropdown menu.

  Dropdowns are small context menus that can be used for navigation and actions. They are a simple alternative to [select menus](`select_menu/1`).

  Menu items are rendered as link element.

  ```
  <.dropdown>
    <:toggle>Menu</:toggle>
    <:item href="#url">Item 1</:item>
    <:item href="#url">Item 2</:item>
  </.dropdown>
  ```

  ## Examples

  Menu links are created with `Phoenix.Component.link/1`, passing all other slot attributes to the link. Link examples:

  ```
  <:item href="#url">href link</:item>
  <:item navigate={Routes.page_path(@socket, :index)}>navigate link</:item>
  <:item patch={Routes.page_path(@socket, :index)}>patch link</:item>
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
      values: ~w(se ne e sw s w),
      doc: """
      Position of the menu relative to the dropdown toggle.

      Default: "se".
      """
    )
  end

  slot :item,
    required: true,
    doc: """
    Menu item content. To create a link element, pass attribute `href`, `navigate` or `patch`.
    """ do
    attr(:is_divider, :boolean,
      doc: """
      Generates a divider element.
      """
    )

    attr(:href, :any,
      doc: """
      Link attribute. The link is created with `Phoenix.Component.link/1`, passing all other slot attributes to the link.
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
        <li {@item_attributes}></li>
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

  @doc section: :menus

  @doc ~S"""
  Generates a select menu.

  ```
  <.select_menu>
    <:toggle>Menu</:toggle>
    <:item>Item 1</:item>
    <:item>Item 2</:item>
    <:item>Item 3</:item>
  </.select_menu>
  ```

  ## Examples

  When a link attribute is supplied to the item slot, links are created with `Phoenix.Component.link/1`, passing all other slot attributes to the link. Link examples:

  ```
  <:item href="#url">href link</:item>
  <:item navigate={Routes.page_path(@socket, :index)}>navigate link</:item>
  <:item patch={Routes.page_path(@socket, :index)}>patch link</:item>
  ```

  Add a dropdown caret:

  ```
  <.select_menu is_dropdown_caret>
    ...
  </.select_menu>
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

  [INSERT LVATTRDOCS]

  ## Reference

  [Primer/CSS Select menu](https://primer.style/css/components/select-menu/)

  ## Status

  Feature complete.

  """

  attr :is_dropdown_caret, :boolean, default: false, doc: "Adds a dropdown caret to the button."
  attr :is_right_aligned, :boolean, default: false, doc: "Aligns the menu to the right."
  attr :is_borderless, :boolean, default: false, doc: "Removes the borders between list items."

  attr :class, :string, doc: "Additional classname."

  attr :classes, :map,
    default: %{
      blankslate: nil,
      caret: nil,
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
      caret: "",               # Dropdown caret element.
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

  slot :toggle,
    required: true,
    doc: """
    Generates a toggle element (default with button appearance) using the slot content as label.

    Any custom class will override the default class "btn".
    """ do
    attr(:rest, :any,
      doc: """
      Additional HTML attributes added to the item element.
      """
    )
  end

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
    Menu item content. To create a link element, pass attribute `href`, `navigate` or `patch`.
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
      Link attribute. The link is created with `Phoenix.Component.link/1`, passing all other slot attributes to the link.
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
          caret: nil,
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
      caret:
        AttributeHelpers.classnames([
          "dropdown-caret",
          assigns.classes[:caret]
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
      AttributeHelpers.append_attributes(
        assigns_to_attributes(assigns.rest, [
          :open
        ]),
        [
          [class: classes.select_menu],
          # Add the menu id when we will show a header with close button
          not is_nil(menu_id) and [data_menuid: menu_id],
          [data_prompt: ""],
          [ontoggle: "window.Prompt && Prompt.init(this)"],
          assigns.is_fast &&
            (assigns.is_dark_backdrop ||
               assigns.is_medium_backdrop ||
               assigns.is_light_backdrop ||
               assigns.is_backdrop) && [data_isfast: ""]
        ]
      )

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
        <%= if @is_dropdown_caret do %>
          <div class={@classes.caret}></div>
        <% end %>
      </summary>
      <%= if @backdrop_attrs !== [] do %>
        <div {@backdrop_attrs}></div>
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
  # action_menu
  # ------------------------------------------------------------------------------------

  @doc section: :menus

  @doc ~S"""
  Generates an action menu.

  The action menu functions similarly to a `select_menu/1`, but with an `action_list/1` as content.

  ```
  <.action_menu>
    <:toggle>Menu</:toggle>
    <.action_list>
      ...
    </.action_list>
  </.action_menu>
  ```

  ## Examples

  Create a multiple select menu:

  ```
  <.action_menu is_dropdown_caret>
    <:toggle>Select <.counter>2</.counter></:toggle>
    <.action_list>
      <.action_list_item is_multiple_select is_selected>
        Option
      </.action_list_item>
      <.action_list_item is_multiple_select is_selected>
        Option
      </.action_list_item>
      <.action_list_item is_multiple_select>
        Option
      </.action_list_item>
    </.action_list>
  </.action_menu>
  ```

  See for more examples:
  - [Action list examples](#action_list/1-examples)
  - [Select menu examples](#select_menu/1-examples)

  [INSERT LVATTRDOCS]

  ## Reference

  - [Primer/CSS Select menu](https://primer.style/css/components/select-menu/)
  - [Primer/CSS Action List](https://primer.style/css/components/action-list/)

  ## Status

  Feature complete.

  """

  attr :is_dropdown_caret, :boolean, default: false, doc: "Adds a dropdown caret to the button."
  attr :is_right_aligned, :boolean, default: false, doc: "Aligns the menu to the right."

  attr :class, :string, doc: "Additional classname."

  attr :classes, :map,
    default: %{
      action_menu: nil,
      caret: nil,
      menu_container: nil,
      menu_list: nil,
      menu: nil,
      toggle: nil
    },
    doc: """
    Additional classnames for action menu elements.

    Any provided value will be appended to the default classname, except for `toggle` that will override the default class \"btn\".

    Default map:
    ```
    %{
      action_menu: "",         # Action menu container (details element).
      caret: "",               # Dropdown caret element.
      menu_container: "",      # Menu container (called "modal" at PrimerCSS).
      menu_list: "",           # Menu list container.
      menu: "",                # Menu element
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

  attr :menu_theme, :map,
    default: nil,
    doc: """
    Sets the theme of the menu, including the dropdown shadow, but excluding the toggle button. This is useful when the button resides in a part with a different theme, such as a dark header.

    Pass a a map with all theme state keys. See `theme/1`.

    Example:
    ```
    <.header>
      <.action_menu menu_theme={@theme_state}>
        <:toggle>
          <.octicon name="sun-16" />
        </:toggle>
        <.theme_menu_options
          default_theme_state={@default_theme_state}
          theme_state={@theme_state}
        />
      </.action_menu>
    <./header>
    ```
    """

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the outer element.
    """
  )

  slot :toggle,
    required: true,
    doc: """
    Generates a toggle element (default with button appearance) using the slot content as label.

    Any custom class will override the default class "btn".
    """ do
    attr(:rest, :any,
      doc: """
      Additional HTML attributes added to the item element.
      """
    )
  end

  slot(:inner_block,
    doc: """
    Slot to place the `action_list/1` component.
    """
  )

  def action_menu(assigns) do
    assigns_classes =
      Map.merge(
        %{
          action_menu: nil,
          caret: nil,
          menu_container: nil,
          menu_list: nil,
          menu: nil,
          toggle: nil
        },
        assigns.classes
      )

    # Get the toggle menu slot, if any
    toggle_slot = if assigns.toggle && assigns.toggle !== [], do: hd(assigns.toggle), else: []

    classes = %{
      action_menu:
        AttributeHelpers.classnames([
          "details-reset",
          "details-overlay",
          assigns_classes[:action_menu],
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
      caret:
        AttributeHelpers.classnames([
          "dropdown-caret",
          assigns.classes[:caret]
        ]),
      menu:
        AttributeHelpers.classnames([
          "ActionMenu",
          assigns.is_right_aligned and "right-0",
          assigns_classes.menu
        ]),
      menu_container:
        AttributeHelpers.classnames([
          "ActionMenu-modal",
          assigns_classes.menu_container
        ]),
      menu_list:
        AttributeHelpers.classnames([
          "SelectMenu-list",
          assigns_classes.menu_list
        ])
    }

    toggle_attrs =
      AttributeHelpers.append_attributes([], [
        [class: classes.toggle],
        [aria_haspopup: "true"]
      ])

    action_menu_attrs =
      AttributeHelpers.append_attributes(
        assigns_to_attributes(assigns.rest, [
          :open
        ]),
        [
          [class: classes.action_menu],
          [data_prompt: ""],
          [ontoggle: "window.Prompt && Prompt.init(this)"],
          assigns.is_fast &&
            (assigns.is_dark_backdrop ||
               assigns.is_medium_backdrop ||
               assigns.is_light_backdrop ||
               assigns.is_backdrop) && [data_isfast: ""]
        ]
      )

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

    menu_container_attrs =
      AttributeHelpers.append_attributes([], [
        [class: classes.menu_container],
        [data_content: ""],
        [aria_role: "menu"],
        !is_nil(assigns[:menu_theme]) && Theme.html_attributes(assigns[:menu_theme])
      ])

    assigns =
      assigns
      |> assign(:classes, classes)
      |> assign(:action_menu_attrs, action_menu_attrs)
      |> assign(:toggle_attrs, toggle_attrs)
      |> assign(:toggle_slot, toggle_slot)
      |> assign(:backdrop_attrs, backdrop_attrs)
      |> assign(:menu_container_attrs, menu_container_attrs)

    ~H"""
    <details {@action_menu_attrs}>
      <summary {@toggle_attrs}>
        <%= render_slot(@toggle_slot) %>
        <%= if @is_dropdown_caret do %>
          <div class={@classes.caret}></div>
        <% end %>
      </summary>
      <%= if @backdrop_attrs !== [] do %>
        <div {@backdrop_attrs}></div>
      <% end %>
      <div data-touch=""></div>
      <div class={@classes.menu}>
        <div {@menu_container_attrs}>
          <div class={@classes.menu_list}>
            <%= render_slot(@inner_block) %>
          </div>
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

  ```
  <.button>Click me</.button>
  ```

  ## Examples

  Optionally create an anchor link rendered as a button. Anchor links are created with `Phoenix.Component.link/1`, passing all other slot attributes to the link. Link examples:

  ```
  <.button href="#url">href link</.button>
  <.button navigate={Routes.page_path(@socket, :index)}>navigate link</.button>
  <.button patch={Routes.page_path(@socket, :index)}>patch link</.button>
  ```

  Primary button:

  ```
  <.button is_primary>Sign in</.button>
  ```

  Small button:

  ```
  <.button is_small>Edit</.button>
  ```

  Selected button:

  ```
  <.button is_selected>Unread</.button>
  ```

  With a dropdown caret:

  ```
  <.button is_dropdown_caret>Menu</.button>
  ```

  Button that contains an icon next to the button label:

  ```
  <.button is_primary>
    <.octicon name="download-16" />
    <span>Clone</span>
  </.button>
  ```

  Icon button (a button with an icon, similar to Primer React's IconButton):

  ```
  <.button is_icon_button aria-label="Desktop">
    <.octicon name="device-desktop-16" />
  </.button>
  ```

  Icon as button (reduced padding):

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

  attr :is_dropdown_caret, :boolean,
    default: false,
    doc: "Adds a dropdown caret icon."

  attr :is_danger, :boolean,
    default: false,
    doc: "Generates a danger button (red label, turns the button red on hover)."

  attr :is_disabled, :boolean, default: false, doc: "Generates a disabled button."

  attr :is_icon_button, :boolean,
    default: false,
    doc:
      "Generates an icon button without a label (similar to Primer React's IconButton). Add `is_danger` to create a danger icon (turns the icon red on hover)."

  attr :is_icon_only, :boolean,
    default: false,
    doc:
      "Generates an icon that functions as a button. Add `is_danger` to create a danger icon (turns the icon red on hover)."

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

  attr(:href, :any,
    doc: """
    Creates an anchor link using `Phoenix.Component.link/1`, passing all other attributes to the link.
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
        assigns.is_icon_button and "btn-icon",
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

    is_link = AttributeHelpers.is_link?(assigns)

    attributes =
      AttributeHelpers.append_attributes(assigns.rest, [
        assigns.is_selected && [aria_selected: "true"],
        assigns.is_disabled && [aria_disabled: "true"],
        [class: class],
        !is_link && [type: if(assigns.is_submit, do: "submit", else: "button")],
        [href: assigns[:href], navigate: assigns[:navigate], patch: assigns[:patch]]
      ])

    render_content = fn ->
      ~H"""
      <%= render_slot(@inner_block) %>
      <%= if @is_dropdown_caret do %>
        <span class="dropdown-caret"></span>
      <% end %>
      """
    end

    assigns =
      assigns
      |> assign(:attributes, attributes)
      |> assign(:is_link, is_link)
      |> assign(:render_content, render_content)

    ~H"""
    <%= if @is_link do %>
      <Phoenix.Component.link {@attributes}>
        <%= @render_content.() %>
      </Phoenix.Component.link>
    <% else %>
      <button {@attributes}>
        <%= @render_content.() %>
      </button>
    <% end %>
    """
  end

  # ------------------------------------------------------------------------------------
  # button_group
  # ------------------------------------------------------------------------------------

  @doc section: :buttons

  @doc ~S"""
  Generates a group of buttons.

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
        case acc == [] do
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
  # ui_icon
  # ------------------------------------------------------------------------------------

  @doc section: :icons

  @doc ~S"""
  Renders an interface icon.

  These icons, while not part of the `octicon/1` icons, are used in interface elements.

  ```
  <.ui_icon name="single-select-16" />
  <.ui_icon name="multiple-select-16" />
  <.ui_icon name="collapse-16" />
  ```

  [INSERT LVATTRDOCS]

  """

  attr :name, :string,
    required: true,
    doc: "Icon name, e.g. \"single-select-16\"."

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the icon svg element.
    """
  )

  def ui_icon(assigns) do
    assigns =
      assigns |> assign(:icon, PrimerLive.UIIcons.ui_icons(assigns) |> Map.get(assigns[:name]))

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

  All items are rendered as links. The last link will show a selected state.

  ```
  <.breadcrumb>
    <:item href="/home">Home</:item>
    <:item href="/account">Account</:item>
    <:item href="/account/history">History</:item>
  </.breadcrumb>
  ```

  ## Examples

  Links are created with `Phoenix.Component.link/1`, passing all other slot attributes to the link. Link examples:

  ```
  <:item href="#url">href link</:item>
  <:item navigate={Routes.page_path(@socket, :index)}>navigate link</:item>
  <:item patch={Routes.page_path(@socket, :index)}>patch link</:item>
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
    Breadcrumb item content. To create a link element, pass attribute `href`, `navigate` or `patch`.
    """ do
    attr(:href, :any,
      doc: """
      Link attribute. The link is created with `Phoenix.Component.link/1`, passing all other slot attributes to the link.
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

  ```
  Some text with a <.as_link>link</.as_link>
  ```

  ## Examples

  links are created with `Phoenix.Component.link/1`. Link examples:

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
    Link attribute. The link is created with `Phoenix.Component.link/1`, passing all other attributes to the link.
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
    values: [1, 2, 3, 4, 5, 6, 7, 8],
    default: 3,
    doc: """
    Avatar size.

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
  Generates a badge-like icon or logo.

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

  Badges are by default rendered as div elements. To create link elements, pass attribute `href`, `navigate` or `patch`. Link examples:

  ```
  <.circle_badge href="#url">...</.circle_badge>
  <.circle_badge navigate={Routes.page_path(@socket, :index)}>...</.circle_badge>
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
  Generates fallback content if the actual content does not yet exist or if the user needs to perform an action.

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

  Tabs are by default rendered as `span` elements. To create link elements, pass attribute `href`, `navigate` or `patch`. Link examples:

  ```
  <:item href="#url">href link</:item>
  <:item navigate={Routes.page_path(@socket, :index)}>navigate link</:item>
  <:item patch={Routes.page_path(@socket, :index)}>patch link</:item>
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
      Link attribute. The link is created with `Phoenix.Component.link/1`, passing all other slot attributes to the link.
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

  Close the dialog with the Escape key:

  ```
  <.dialog is_escapable>
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
      dialog: "",          # Dialog element
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
    Maximum height of the dialog as CSS value. Use unit `vh` or `%`.
    """

  attr :max_width, :string,
    default: "90vw",
    doc: """
    Maximum width of the dialog as CSS value. Use unit `vh` or `%`.
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

  # ------------------------------------------------------------------------------------
  # drawer
  # ------------------------------------------------------------------------------------

  @doc section: :drawer

  @doc ~S"""
  Generates a drawer with configuration options for backdrop, position and behavior.

  ```
  <.drawer>
    <.drawer_content>
      Content
    </.drawer_content>
  </.drawer>
  ```

  Showing and hiding is done with JS function `Prompt` from [dialogic-js](https://github.com/ArthurClemens/dialogic-js), included in `primer-js` (see Installation). Function `Prompt.show` requires a selector. When placed inside the drawer component, the selector can be replaced with `this`:

  ```
  <.drawer id="my-drawer">
    <.drawer_content>
      <.button onclick="Prompt.hide(this)">Close</.button>
      Content
    </.drawer_content>
  </.drawer>

  <.button onclick="Prompt.show('#my-drawer')">Open drawer</.button>
  ```

  ## Examples

  By default the drawer width is defined by its content. To set an explicit width of the drawer content:

  ```
  <.drawer>
    <.drawer_content width="300px">
      ...
    </.drawer_content>
  </.drawer>
  ```


  Add a backdrop. Optionally add `is_light_backdrop` or `is_dark_backdrop`:

  ```
  <.drawer is_backdrop is_dark_backdrop>
    ...
  </.drawer>
  ```

  Create a modal drawer; clicking the backdrop (if used) or outside of the drawer will not close the drawer:

  ```
  <.drawer is_modal>
    ...
  </.drawer>
  ```

  Close the drawer with the Escape key:

  ```
  <.drawer is_escapable>
    ...
  </.drawer>
  ```

  Create faster slide in and out:

  ```
  <.drawer is_fast>
    ...
  </.drawer>
  ```

  Focus the first element after opening the drawer. Pass a selector to match the element.

  ```
  <.drawer focus_first="#login_first_name">
    ...
  </.drawer>
  ```

  or

  ```
  <.drawer focus_first="[name=login\[first_name\]]">
    ...
  </.drawer>
  ```

  Create a local drawer (inside a container) with `is_local`:

  ```
  <div style="position: relative; overflow-x: hidden;">
    Page content
    <.drawer is_local>
      <.drawer_content>
        Content
      </.drawer_content>
    </.drawer>
  </div>
  ```

  Create a push drawer - where the drawer content pushes the adjacent content aside when it opens - with attr `is_push` and the content to be pushed inside `<.drawer>`:

  ```
  <div style="position: relative; overflow-x: hidden;">
    <.drawer is_push>
      Page content
      <.drawer_content>
        Content
      </.drawer_content>
    </.drawer>
  </div>
  ```

  [INSERT LVATTRDOCS]

  ## Reference

  Neither Primer CSS nor Primer React provide a drawer component. However, a drawer is used on their documentation site (mobile view).
  """

  attr(:class, :string, default: nil, doc: "Additional classname.")

  attr :is_far_side, :boolean,
    default: false,
    doc: """
    Opens the drawer at the far end of the reading direction.
    """

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
    Generates a modal drawer; clicking the backdrop (if used) or outside of the drawer will not close the drawer.
    """

  attr :is_escapable, :boolean,
    default: false,
    doc: """
    Closes the content when pressing the Escape key.
    """

  attr :is_local, :boolean,
    default: false,
    doc: """
    Adds styles for a drawer inside a a container.
    """

  attr :is_push, :boolean,
    default: false,
    doc: """
    Adds styles for a push drawer inside a a container.
    """

  attr :focus_first, :string,
    doc: """
    Focus the first element after opening the drawer. Pass a selector to match the element.
    """

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the outer element.
    """
  )

  slot(:inner_block,
    doc:
      "Drawer content and any adjacent elements. Use `drawer_content/1` for the content to be displayed inside the drawer."
  )

  def drawer(assigns) do
    drawer_id = assigns.rest[:id] || AttributeHelpers.random_string()

    wrapper_attrs =
      AttributeHelpers.append_attributes(assigns.rest |> Map.drop([:id]), [
        assigns[:class] && [class: assigns[:class]],
        [id: drawer_id],
        [data_prompt: ""],
        [data_isdrawer: ""],
        if assigns.is_far_side do
          [data_isfarside: ""]
        end,
        assigns.is_modal && [data_ismodal: ""],
        assigns.is_local && [data_islocal: ""],
        assigns.is_push && [data_ispush: ""],
        assigns.is_escapable && [data_isescapable: ""],
        assigns.is_fast && [data_isfast: ""],
        assigns[:focus_first] && [data_focusfirst: assigns[:focus_first]]
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

    content_attrs =
      AttributeHelpers.append_attributes([], [
        [data_content: ""]
      ])

    assigns =
      assigns
      |> assign(:wrapper_attrs, wrapper_attrs)
      |> assign(:touch_layer_attrs, touch_layer_attrs)
      |> assign(:backdrop_attrs, backdrop_attrs)
      |> assign(:content_attrs, content_attrs)

    ~H"""
    <div {@wrapper_attrs}>
      <%= if !@is_push do %>
        <%= if @backdrop_attrs !== [] do %>
          <div {@backdrop_attrs}></div>
        <% end %>
        <div {@touch_layer_attrs}></div>
      <% end %>
      <div {@content_attrs}>
        <%= if @is_push do %>
          <%= if @backdrop_attrs !== [] do %>
            <div {@backdrop_attrs}></div>
          <% end %>
          <div {@touch_layer_attrs}></div>
        <% end %>
        <%= render_slot(@inner_block) %>
      </div>
    </div>
    """
  end

  # ------------------------------------------------------------------------------------
  # drawer_content
  # ------------------------------------------------------------------------------------

  @doc section: :drawer

  @doc ~S"""
  Drawer content. See `drawer/1`.

  [INSERT LVATTRDOCS]
  """

  attr(:class, :string, default: nil, doc: "Additional classname.")

  attr :width, :string,
    default: nil,
    doc: """
    Sets the width of the drawer as CSS value. Add unit `px` or `rem` or other size unit.

    By default the drawer width is defined by its content.
    """

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the outer element.
    """
  )

  slot(:inner_block,
    doc: "Drawer content."
  )

  def drawer_content(assigns) do
    class =
      AttributeHelpers.classnames([
        "Box--overlay",
        assigns[:class]
      ])

    # Assign an id for focus wrap
    drawer_content_id = assigns.rest[:id] || AttributeHelpers.random_string()
    focus_wrap_id = "focus-wrap-#{drawer_content_id}"

    content_attrs =
      AttributeHelpers.append_attributes(assigns.rest, [
        [data_drawer_content: ""],
        [class: class],
        assigns[:width] &&
          [
            style: "width: #{assigns[:width]}"
          ]
      ])

    assigns =
      assigns
      |> assign(:content_attrs, content_attrs)
      |> assign(:focus_wrap_id, focus_wrap_id)

    ~H"""
    <div {@content_attrs}>
      <.focus_wrap id={@focus_wrap_id}>
        <%= render_slot(@inner_block) %>
      </.focus_wrap>
    </div>
    """
  end

  # ------------------------------------------------------------------------------------
  # branch_name
  # ------------------------------------------------------------------------------------

  @doc section: :branch_name

  @doc ~S"""
  Formats a branch name.

  ```
  <.branch_name>development</.branch_name>
  ```

  ## Examples

  A branch name may be a link. Links are created with `Phoenix.Component.link/1`, passing all other attributes to the link. Link examples:

  ```
  <.branch_name href="#url">some-name</.branch_name>
  <.branch_name navigate={Routes.page_path(@socket, :index)}>some-name</.branch_name>
  <.branch_name patch={Routes.page_path(@socket, :index, :details)}>some-name</.branch_name>
  ```

  Add an icon before the branch name:

  ```
  <.branch_name>
    <.octicon name="git-branch-16" />
    some-name
  </.branch_name>
  ```

  [INSERT LVATTRDOCS]

  ## Reference

  [Primer/CSS Branch name](https://primer.style/css/components/branch-name)

  ## Status

  Feature complete.
  """

  attr(:class, :string, default: nil, doc: "Additional classname.")

  attr(:href, :any,
    doc: """
    Link attribute. The link is created with `Phoenix.Component.link/1`, passing all other attributes to the link.
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

  slot(:inner_block, required: true, doc: "The branch name text and optionally an icon.")

  def branch_name(assigns) do
    class =
      AttributeHelpers.classnames([
        "branch-name",
        assigns[:class]
      ])

    is_link = AttributeHelpers.is_link?(assigns)

    attributes =
      AttributeHelpers.append_attributes(assigns.rest, [
        [class: class],
        [href: assigns[:href], navigate: assigns[:navigate], patch: assigns[:patch]]
      ])

    assigns =
      assigns
      |> assign(:attributes, attributes)
      |> assign(:is_link, is_link)

    ~H"""
    <%= if @is_link do %>
      <Phoenix.Component.link {@attributes}>
        <%= render_slot(@inner_block) %>
      </Phoenix.Component.link>
    <% else %>
      <span {@attributes}>
        <%= render_slot(@inner_block) %>
      </span>
    <% end %>
    """
  end

  # ------------------------------------------------------------------------------------
  # progress
  # ------------------------------------------------------------------------------------

  @doc section: :progress

  @doc ~S"""
  Generates a progress bar to visualize task completion.

  The item slot creates the colored bar. Its width is a percentage value (0 - 100).

  ```
  <.progress aria_label="Tasks: 8 of 10 complete">
    <:item width="50"></:item>
  </.progress>
  ```

  ## Examples

  The default bar state is "success" (green). Possible states:

  - "info" - blue
  - "success" - green
  - "warning" - ocher
  - "error" - red

  ```
  <.progress>
    <:item width="50" state="error"></:item>
  </.progress>
  ```

  Use multiple items to show a multicolored bar:

  ```
  <.progress>
    <:item width="50" state="success"></:item>
    <:item width="30" state="warning"></:item>
    <:item width="10" state="error"></:item>
    <:item width="5" state="info"></:item>
  </.progress>
  ```

  Create a large progress bar:

  ```
  <.progress is_large>
    <:item width="50"></:item>
  </.progress>
  ```

  Create a small progress bar:

  ```
  <.progress is_small>
    <:item width="50"></:item>
  </.progress>
  ```

  Create an inline progress bar:

  ```
  <span class="text-small color-fg-muted mr-2">4 of 16</span>
  <.progress is_inline style="width: 160px;">
    <:item width="25"></:item>
  </.progress>
  ```

  [INSERT LVATTRDOCS]

  ## Reference

  [Primer/CSS Progress](https://primer.style/css/components/progress)

  ## Status

  Feature complete.

  """

  attr(:aria_label, :string,
    default: nil,
    doc: "Adds attribute `aria-label` to the outer element."
  )

  attr(:class, :string, default: nil, doc: "Additional classname.")

  attr(:classes, :map,
    default: %{
      progress: nil,
      item: nil,
      state_success: nil,
      state_info: nil,
      state_warning: nil,
      state_error: nil
    },
    doc: """
    Additional classnames for progress elements.

    Any provided value will be appended to the default classname.

    Default map:
    ```
    %{
      progress: "",      # Outer container
      item: "",          # Colored bar element
      state_success: "", # Color bar modifier
      state_info: "",    # Color bar modifier
      state_warning: "", # Color bar modifier
      state_error: "",   # Color bar modifier
    }
    ```
    """
  )

  attr :is_large, :boolean,
    default: false,
    doc: """
    Creates a large progress bar.
    """

  attr :is_small, :boolean,
    default: false,
    doc: """
    Creates a small progress bar.
    """

  attr :is_inline, :boolean,
    default: false,
    doc: """
    Creates an inline progress bar, to be used next to other elements.

    The "progress" element must have a width, for example:

    ```
    <.progress is_inline style="width: 160px;">
      <:item width="25"></:item>
    </.progress>
    ```
    """

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the outer element.
    """
  )

  slot :item,
    required: true,
    doc: """
    Colored bar.
    """ do
    attr(:width, :any,
      doc: """
      String or integer. Percentage value (0 - 100).
      """
    )

    attr(:state, :string,
      values: ~w(info success warning error),
      doc: """
      Color mapping:

      - "info" - blue
      - "success" - green
      - "warning" - ocher
      - "error" - red

      """
    )
  end

  def progress(assigns) do
    state_modifier_classes = %{
      state_success:
        AttributeHelpers.classnames([
          "color-bg-success-emphasis",
          assigns.classes[:state_success]
        ]),
      state_info:
        AttributeHelpers.classnames([
          "color-bg-accent-emphasis",
          assigns.classes[:state_info]
        ]),
      state_warning:
        AttributeHelpers.classnames([
          "color-bg-attention-emphasis",
          assigns.classes[:state_warning]
        ]),
      state_error:
        AttributeHelpers.classnames([
          "color-bg-danger-emphasis",
          assigns.classes[:state_error]
        ])
    }

    classes = %{
      progress:
        AttributeHelpers.classnames([
          "Progress",
          assigns.is_large and "Progress--large",
          assigns.is_small and "Progress--small",
          assigns.is_inline and "d-inline-flex",
          assigns.classes[:progress],
          assigns[:class]
        ])
      # item: defined in render_item
    }

    render_item = fn slot ->
      state = slot[:state] || "success"
      width = AttributeHelpers.as_integer(slot[:width] || 0)

      slot_style =
        case is_nil(slot[:style]) do
          true -> ""
          false -> slot[:style] <> "; "
        end

      style = "#{slot_style}width:#{width}%;"

      class =
        AttributeHelpers.classnames([
          "Progress-item",
          state === "success" && state_modifier_classes.state_success,
          state === "info" && state_modifier_classes.state_info,
          state === "warning" && state_modifier_classes.state_warning,
          state === "error" && state_modifier_classes.state_error,
          assigns.classes[:item],
          slot[:class]
        ])

      rest =
        assigns_to_attributes(slot, [
          :class,
          :state,
          :width,
          :style
        ])

      attributes =
        AttributeHelpers.append_attributes(rest, [
          [class: class],
          [style: style]
        ])

      assigns =
        assigns
        |> assign(:attributes, attributes)

      ~H"""
      <span {@attributes}></span>
      """
    end

    progress_attributes =
      AttributeHelpers.append_attributes(assigns.rest, [
        [class: classes.progress],
        [aria_label: assigns.aria_label]
      ])

    assigns =
      assigns
      |> assign(:progress_attributes, progress_attributes)
      |> assign(:render_item, render_item)

    ~H"""
    <span {@progress_attributes}>
      <%= if @item !== [] do %>
        <%= for slot <- @item do %>
          <%= @render_item.(slot) %>
        <% end %>
      <% end %>
    </span>
    """
  end

  # ------------------------------------------------------------------------------------
  # timeline_item
  # ------------------------------------------------------------------------------------

  @doc section: :timeline

  @doc ~S"""
  Generates a timeline item to display items on a vertical timeline.

  ```
  <.timeline_item>
    <:badge>
      <.octicon name="flame-16" />
    </:badge>
    Everything is fine
  </.timeline_item>
  ```

  ## Examples

  Add color to the badge by using attribute `state`. Possible states:

  - "default" - light gray
  - "info" - blue
  - "success" - green
  - "warning" - ocher
  - "error" - red

  ```
  <.timeline_item state="error">
    <:badge>
      <.octicon name="flame-16" />
    </:badge>
    Everything will be fine
  </.timeline_item>
  ```

  Alternatively, use Primer CSS modifier classes on the badge slot to assign colors:

  ```
  <.timeline_item>
    <:badge class="color-bg-done-emphasis color-fg-on-emphasis">
      <.octicon name="flame-16" />
    </:badge>
    Everything will be fine
  </.timeline_item>
  ```

  When a link attribute is supplied to the badge slot, links are created with `Phoenix.Component.link/1`, passing all other slot attributes to the link. Link examples:

  ```
  <:badge href="#url">href link</:item>
  <:badge navigate={Routes.page_path(@socket, :index)}>navigate link</:item>
  <:badge patch={Routes.page_path(@socket, :index)}>patch link</:item>
  ```

  Create a condensed item, reducing the vertical padding and removing the background from the badge item:

  ```
  <.timeline_item is_condensed>
    <:badge>
      <.octicon name="git-commit-16" />
    </:badge>
    My commit
  </.timeline_item>
  ```

  Display an avatar of the author:

  ```
  <.timeline_item>
    <:badge>
      <.octicon name="git-commit-16" />
    </:badge>
    <:avatar>
      <.avatar size="6" src="user.jpg" />
    </:avatar>
    Someone's commit
  </.timeline_item>
  ```

  Create a visual break in the timeline with attribute `is_break`. This adds a horizontal bar across the timeline to show that something has disrupted it.

  ```
  <.timeline_item state="error">
    <:badge><.octicon name="flame-16" /></:badge>
    Everything will be fine
  </.timeline_item>
  <.timeline_item is_break />
  <.timeline_item state="success">
    <:badge><.octicon name="smiley-16" /></:badge>
    Everything is fine
  </.timeline_item>
  ```

  [INSERT LVATTRDOCS]

  ## Reference

  [Primer/CSS Timeline](https://primer.style/css/components/timeline)

  ## Status

  Feature complete.

  """

  attr(:class, :string, default: nil, doc: "Additional classname.")

  attr(:classes, :map,
    default: %{
      timeline_item: nil,
      badge: nil,
      avatar: nil,
      body: nil,
      state_default: nil,
      state_info: nil,
      state_success: nil,
      state_warning: nil,
      state_error: nil
    },
    doc: """
    Additional classnames for timeline elements.

    Any provided value will be appended to the default classname.

    Default map:
    ```
    %{
      timeline_item: "", # Outer container
      badge: "",         # Badge element
      avatar: "",        # Avatar container
      body: "",          # Body element
      state_default: "", # Badge color modifier
      state_info: "",    # Badge color modifier
      state_success: "", # Badge color modifier
      state_warning: "", # Badge color modifier
      state_error: "",   # Badge color modifier
    }
    ```
    """
  )

  attr(:state, :string,
    values: ~w(default info success warning error),
    doc: """
    Create a badge color variant by setting the state. Color mapping:

    - "default" - light gray
    - "info" - blue
    - "success" - green
    - "warning" - ocher
    - "error" - red

    """
  )

  attr :is_condensed, :boolean,
    default: false,
    doc: """
    Creates a condensed item, reducing the vertical padding and removing the background from the badge item.
    """

  attr :is_break, :boolean,
    default: false,
    doc: """
    Creates a visual break in the timeline. This adds a horizontal bar across the timeline to show that something has disrupted it. Ignores any slots.
    """

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the outer element.
    """
  )

  slot :badge,
    doc: """
    Badge content. Pass an `octicon/1` to display an icon. To create a link element, pass attribute `href`, `navigate` or `patch`.
    """ do
    attr(:href, :any,
      doc: """
      Link attribute. The link is created with `Phoenix.Component.link/1`, passing all other slot attributes to the link.
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
      Additional HTML attributes added to the badge element.
      """
    )
  end

  slot(:avatar, doc: "Avatar container.")
  slot(:inner_block, doc: "Item body.")

  def timeline_item(assigns) do
    state = assigns[:state] || "default"

    state_modifier_classes = %{
      state_default:
        AttributeHelpers.classnames([
          assigns.classes[:state_default]
        ]),
      state_info:
        AttributeHelpers.classnames([
          "color-bg-accent-emphasis",
          "color-fg-on-emphasis",
          assigns.classes[:state_info]
        ]),
      state_success:
        AttributeHelpers.classnames([
          "color-bg-success-emphasis",
          "color-fg-on-emphasis",
          assigns.classes[:state_success]
        ]),
      state_warning:
        AttributeHelpers.classnames([
          "color-bg-attention-emphasis",
          "color-fg-on-emphasis",
          assigns.classes[:state_warning]
        ]),
      state_error:
        AttributeHelpers.classnames([
          "color-bg-danger-emphasis",
          "color-fg-on-emphasis",
          assigns.classes[:state_error]
        ])
    }

    classes = %{
      timeline_item:
        AttributeHelpers.classnames([
          if assigns.is_break do
            "TimelineItem-break"
          else
            "TimelineItem"
          end,
          assigns.is_condensed and "TimelineItem--condensed",
          assigns.classes[:timeline_item],
          assigns[:class]
        ]),
      body:
        AttributeHelpers.classnames([
          "TimelineItem-body",
          assigns.classes[:body]
        ])
      # badge: defined in render_badge
      # avatar: defined in render_avatar
    }

    render_badge = fn slot, state ->
      is_link = AttributeHelpers.is_link?(slot)

      rest =
        assigns_to_attributes(slot, [
          :class
        ])

      class =
        AttributeHelpers.classnames([
          "TimelineItem-badge",
          state === "default" && state_modifier_classes.state_default,
          state === "info" && state_modifier_classes.state_info,
          state === "success" && state_modifier_classes.state_success,
          state === "warning" && state_modifier_classes.state_warning,
          state === "error" && state_modifier_classes.state_error,
          assigns.classes[:badge],
          slot[:class]
        ])

      attributes =
        AttributeHelpers.append_attributes(rest, [
          [class: class],
          [href: slot[:href], navigate: slot[:navigate], patch: slot[:patch]]
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
        <div {@attributes}>
          <%= render_slot(@slot) %>
        </div>
      <% end %>
      """
    end

    render_avatar = fn slot ->
      rest =
        assigns_to_attributes(slot, [
          :class
        ])

      class =
        AttributeHelpers.classnames([
          "TimelineItem-avatar",
          assigns.classes[:avatar],
          slot[:class]
        ])

      attributes =
        AttributeHelpers.append_attributes(rest, [
          [class: class]
        ])

      assigns =
        assigns
        |> assign(:attributes, attributes)
        |> assign(:slot, slot)

      ~H"""
      <div {@attributes}>
        <%= render_slot(@slot) %>
      </div>
      """
    end

    timeline_item_attributes =
      AttributeHelpers.append_attributes(assigns.rest, [
        [class: classes.timeline_item]
      ])

    assigns =
      assigns
      |> assign(:classes, classes)
      |> assign(:state, state)
      |> assign(:render_badge, render_badge)
      |> assign(:render_avatar, render_avatar)
      |> assign(:timeline_item_attributes, timeline_item_attributes)

    ~H"""
    <%= if @is_break do %>
      <div {@timeline_item_attributes}></div>
    <% else %>
      <div {@timeline_item_attributes}>
        <%= if @avatar && @avatar !== [] do %>
          <%= for slot <- @avatar do %>
            <%= @render_avatar.(slot) %>
          <% end %>
        <% end %>
        <%= if @badge && @badge !== [] do %>
          <%= for slot <- @badge do %>
            <%= @render_badge.(slot, @state) %>
          <% end %>
        <% end %>
        <%= if not is_nil(@inner_block) && @inner_block !== [] do %>
          <div class={@classes.body}>
            <%= render_slot(@inner_block) %>
          </div>
        <% end %>
      </div>
    <% end %>
    """
  end

  # ------------------------------------------------------------------------------------
  # theme
  # ------------------------------------------------------------------------------------

  @doc section: :theme

  @doc ~S"""
  Creates a wrapper that sets the light/dark color mode and theme, with support for color blindness.

  See also `PrimerLive.Theme`.

  ## Alternative method

  Instead of using a wrapper, consider using `Theme.html_attributes` to set a theme on a component or element directly:

  ```
  <.button
    {PrimerLive.Theme.html_attributes([color_mode: "dark", dark_theme: "dark_high_contrast"])}
  >Button</.button>

  <.octicon name="sun-24"
    {PrimerLive.Theme.html_attributes(%{color_mode: "dark", dark_theme: "dark_dimmed"})}
  />
  ```


  ## Theme wrapper examples

  Use default settings:

  ```
  <.theme>
    Content
  </.theme>
  ```

  Set the color mode to dark and specify the dark theme:

  ```
  <.theme color_mode="dark" dark_theme="dark_dimmed">
    Content
  </.theme>
  ```

  Specify light and dark themes:

  ```
  <.theme color_mode="dark" light_theme="light_high_contrast" dark_theme="dark_high_contrast">
    Content
  </.theme>
  ```

  Use a `theme_state` struct for easier passing around state:

  ```
  assigns = assign
    |> assign(:theme_state, %{
      color_mode: "light",
      light_theme: "light_high_contrast",
      dark_theme: "dark_high_contrast"
    })

  <.theme theme_state={@theme_state}>
    Content
  </.theme>
  ```

  [INSERT LVATTRDOCS]

  ## Reference

  [Primer/CSS Theming](https://primer.style/css/support/theming)

  ## Status

  Feature complete.

  """

  attr(:theme_state, :map, default: nil, doc: "Sets all theme values at once.")

  attr(:color_mode, :string,
    default: Theme.default_theme_state().color_mode,
    values: ~w(light dark auto),
    doc: "Color mode."
  )

  attr(:light_theme, :string,
    default: Theme.default_theme_state().light_theme,
    values: ~w(light light_high_contrast light_colorblind light_tritanopia),
    doc: """
    Light theme.

    Possible values:
    - "light"
    - "light_high_contrast"
    - "light_colorblind"
    - "light_tritanopia"
    """
  )

  attr(:dark_theme, :string,
    default: Theme.default_theme_state().dark_theme,
    values: ~w(dark dark_dimmed dark_high_contrast dark_colorblind dark_tritanopia),
    doc: """
    Dark theme.

    Possible values:
    - "dark"
    - "dark_dimmed"
    - "dark_high_contrast"
    - "dark_colorblind"
    - "dark_tritanopia"
    """
  )

  attr(:is_inline, :boolean,
    default: false,
    doc: """
    Renders the wrapper as a `span`. Useful for setting the color on an inline element.
    """
  )

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the outer element.
    """
  )

  slot(:inner_block, required: true, doc: "Content.")

  def theme(assigns) do
    theme_state =
      assigns[:theme_state] ||
        %{
          color_mode: assigns.color_mode,
          light_theme: assigns.light_theme,
          dark_theme: assigns.dark_theme
        }

    attributes =
      AttributeHelpers.append_attributes(assigns.rest, [Theme.html_attributes(theme_state)])

    assigns = assigns |> assign(:attributes, attributes)

    ~H"""
    <%= if @is_inline do %>
      <span {@attributes}>
        <%= render_slot(@inner_block) %>
      </span>
    <% else %>
      <div {@attributes}>
        <%= render_slot(@inner_block) %>
      </div>
    <% end %>
    """
  end

  # ------------------------------------------------------------------------------------
  # theme_menu_options
  # ------------------------------------------------------------------------------------

  @doc section: :theme

  @doc ~S"""
  Generates theme menu options as an `action_list/1`, to be used inside an `action_menu/1`.

  See also `PrimerLive.Theme`.

  ## Menu options

  To create a default menu - showing all possible options, using default labels:

  ```
  <.theme_menu_options
    theme_state={@theme_state}
    default_theme_state={@default_theme_state}
  />
  ```

  - `theme_state` contains the current theme state
  - `default_theme_state` contains the initial (default) state

  ## Menu

  Place the menu options inside an expanding menu:

  ```
  <.action_menu>
    <:toggle class="btn btn-invisible">
      <.octicon name="sun-16" />
    </:toggle>
    <.theme_menu_options
      theme_state={@theme_state}
    />
  </.action_menu>
  ```

  To make the selected theme persist, follow the instructions in `PrimerLive.Theme`.

  [INSERT LVATTRDOCS]

  """

  attr(:default_theme_state, :map,
    required: false,
    default: Theme.default_theme_state(),
    doc: """
    Defines the default (and initial) theme state.

    Pass a map with all theme state keys.

    Change the values to meet specific use cases, for example to set a light color mode instead of "auto":
    ```
    %{
      color_mode: "light",
      light_theme: "light",
      dark_theme: "dark_dimmed"
    }
    ```
    """
  )

  attr(:theme_state, :map,
    required: true,
    doc: """
    Defines the current theme state. When using persistent data, this will be passed from the session.

    Pass a map with all theme state keys. For example:
    ```
    %{
      color_mode: "light",
      light_theme: "light_high_contrast",
      dark_theme: "dark_high_contrast"
    }
    ```
    """
  )

  attr(:options, :map,
    required: false,
    default: Theme.default_menu_options(),
    doc: """
    Selectable options (keys).

    To show a limited set of theme options:
    ```
    %{
      color_mode: ~w(light dark),
      light_theme: ~w(light light_high_contrast),
      dark_theme: ~w(dark dark_dimmed)
    }
    ```
    or even:
    ```
    %{
      color_mode: ~w(light dark)
    }
    ```
    """
  )

  attr(:labels, :map,
    required: false,
    default: Theme.default_menu_labels(),
    doc: """
    Custom labels for menu items. For example:
    ```
    %{
      color_mode: %{
        light: "Light theme"
      },
      reset: "Reset"
    }
    ```
    """
  )

  attr(:is_show_group_labels, :boolean,
    required: false,
    default: true,
    doc: """
    Set to `false` to remove the labels above the menu groups.
    """
  )

  attr(:is_show_reset_link, :boolean,
    required: false,
    default: true,
    doc: """
    Set to `false` to remove the reset link.
    """
  )

  attr(:is_click_disabled, :boolean,
    required: false,
    default: false,
    doc: """
    For demo purposes. Set to `true` to prevent clicks on options.
    """
  )

  attr(:rest, :global,
    doc: """
    Additional HTML attributes added to the outer element.
    """
  )

  def theme_menu_options(assigns) do
    menu_items =
      Theme.create_menu_items(
        assigns.theme_state,
        assigns.options,
        assigns.labels
      )

    is_default_theme = Theme.is_default_theme(assigns.theme_state, assigns.default_theme_state)

    assigns =
      assigns
      |> assign(:menu_items, menu_items)
      |> assign(:is_default_theme, is_default_theme)
      |> assign(:is_reset_enabled, !is_default_theme && !assigns.is_click_disabled)

    ~H"""
    <.action_list {@rest}>
      <%= for {{key, _}, idx} <- @menu_items |> Enum.with_index() do %>
        <%= if idx > 0 do %>
          <.action_list_section_divider />
        <% end %>
        <.theme_menu_option_items
          key={key}
          menu_items={@menu_items}
          is_show_group_labels={@is_show_group_labels}
          is_click_disabled={@is_click_disabled}
        />
      <% end %>
      <%= if @is_show_reset_link && assigns.labels[:reset] do %>
        <.action_list_section_divider />
        <.action_list_item
          phx-click={@is_reset_enabled && Theme.update_theme_event_key()}
          phx-value-key={Theme.reset_key()}
          phx-value-data=""
          is_disabled={!@is_reset_enabled}
        >
          <%= assigns.labels.reset %>
        </.action_list_item>
      <% end %>
    </.action_list>
    """
  end

  attr :menu_items, :map, required: true
  attr :key, :atom, required: true, values: [:color_mode, :light_theme, :dark_theme]
  attr :is_show_group_labels, :boolean, required: true
  attr :is_click_disabled, :boolean, required: true

  defp theme_menu_option_items(assigns) do
    group = assigns.menu_items[assigns.key]

    assigns =
      assigns
      |> assign(:group, group)

    ~H"""
    <%= if @group.title && @is_show_group_labels do %>
      <.action_list_section_divider>
        <:title><%= @group.title %></:title>
      </.action_list_section_divider>
    <% end %>
    <%= for {value, label} <- @group.labeled_options do %>
      <.action_list_item
        is_single_select
        is_selected={@group.selected && value === @group.selected}
        phx-click={!@is_click_disabled && Theme.update_theme_event_key()}
        phx-value-key={@key}
        phx-value-data={value}
      >
        <%= label %>
      </.action_list_item>
    <% end %>
    """
  end
end
