defmodule PrimerLive.Components do
  use Phoenix.Component
  use Phoenix.HTML

  alias PrimerLive.Helpers.{Schema, Attributes}
  alias PrimerLive.Options

  # ------------------------------------------------------------------------------------
  # alert
  # ------------------------------------------------------------------------------------

  @doc section: :alerts

  @doc ~S"""
  Creates an alert message.

  ```
  <.alert>
    Flash message goes here.
  </.alert>
  ```

  ## Features

  - Boolean options for setting alert styles: `is_error`, `is_success` and so on

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

  To render a vertical stack of alerts, wrap each with `alert_messages/1`.

  ## All options

  - `PrimerLive.Options.Alert`
  - Additional HTML attributes are passed to the alert element

  ## Reference

  - [Primer/CSS Alerts](https://primer.style/css/components/alerts)

  """
  def alert(assigns) do
    with {:ok, assigns} <- Schema.validate_options(assigns, Options.Alert, "alert") do
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

  - `PrimerLive.Options.AlertMessages`
  - Additional HTML attributes are passed to the alert messages element

  ## Reference

  - [Primer/CSS Alerts](https://primer.style/css/components/alerts)

  """

  def alert_messages(assigns) do
    with {:ok, assigns} <-
           Schema.validate_options(assigns, Options.AlertMessages, "alert_messages") do
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
  # box
  # ------------------------------------------------------------------------------------

  @doc section: :layout

  @doc ~S"""
  Creates a content container.

  ```
  <.box>
    My content
  </.box>
  ```

  Boxes are often composed with `box_row/1` elements:

  ```
  <.box>
    <.box_row>Row 1</.box_row>
    <.box_row>Row 2</.box_row>
    <.box_row>Row 3</.box_row>
  </.box>
  ```

  ## Examples

  With title, body and footer sections:

  ```
  <.box>
    <:title>
      My title
    </:title>
    <:body>
      My body
    </:body>
    <:footer>
      My footer
    </:footer>
  </.box>
  ```

  With a full-width alert. Alerts are always placed between header and body, regardless the order in the component call:

  ```
  <.box>
    <:header>
      Header
    </:header>
    <:body>
      Rest
    </:body>
     <:alert>
      <.alert is_success is_full>
        <.octicon name="check-16" is_small /> Done!
      </.alert>
    </:alert>
  </.box>
  ```

  To render search results:

  ```
  <.box>
    <%= for result <- @results do %>
      <.box_row>
        {result.id}
      </.box_row>
    <% end %>
  </.box>
  ```

  Form elements and buttons in a box:

  ```
  <.box classes={
    %{
      header: "d-flex flex-items-center"
    }
  }>
    <:header>
      <h3 class="Box-title overflow-hidden flex-auto">
        Box title
      </h3>
      <.button is_primary is_smmall>
        Button
      </.button>
    </:header>
    <:body>
      Rest
    </:body>
  </.box>
  ```

  ## All options

  - `PrimerLive.Options.Box`
  - Additional HTML attributes are passed to the box element

  ## Reference

  - [Primer/CSS Box](https://primer.style/css/components/box)

  """

  def box(assigns) do
    with {:ok, assigns} <- Schema.validate_options(assigns, Options.Box, "box") do
      render_box(assigns)
    else
      message -> message
    end
  end

  defp render_box(assigns) do
    classes = %{
      box:
        Attributes.classnames([
          "Box",
          assigns.class,
          assigns.classes.box,
          assigns.is_blue and "Box--blue",
          assigns.is_border_dashed and "border-dashed",
          assigns.is_condensed and "Box--condensed",
          assigns.is_danger and "Box--danger",
          assigns.is_spacious and "Box--spacious"
        ]),
      header:
        Attributes.classnames([
          "Box-header",
          assigns.classes.header,
          assigns.is_blue_header and "Box-header--blue"
        ]),
      body:
        Attributes.classnames([
          "Box-body",
          assigns.classes.body
        ]),
      footer:
        Attributes.classnames([
          "Box-footer",
          assigns.classes.footer
        ]),
      title:
        Attributes.classnames([
          "Box-title",
          assigns.classes.title
        ])
    }

    ~H"""
    <div class={classes.box} {@extra}>
      <%= if @header || @title do %>
        <div class={classes.header}>
          <%= if @title do %>
            <h3 class={classes.title}>
              <%= render_slot(@title) %>
            </h3>
          <% else %>
            <%= render_slot(@header) %>
          <% end %>
        </div>
      <% end %>
      <%= if @alert do %>
        <%= render_slot(@alert) %>
      <% end %>
      <%= if @body do %>
        <div class={classes.body}>
          <%= render_slot(@body) %>
        </div>
      <% end %>
      <%= if @inner_block do %>
        <%= render_slot(@inner_block) %>
      <% end %>
      <%= if @footer do %>
        <div class={classes.footer}>
          <%= render_slot(@footer) %>
        </div>
      <% end %>
    </div>
    """
  end

  # ------------------------------------------------------------------------------------
  # box_row
  # ------------------------------------------------------------------------------------

  @doc section: :layout

  @doc ~S"""
  A row element for `box/1` that renders content with borders while preserving padding.

  ```
  <.box>
    <.box_row>
      1
    </.box_row>
    <.box_row>
      2
    </.box_row>
    <.box_row>
      3
    </.box_row>
  </.box>
  ```

  ## Examples

  Blue row theme:

  ```
  <.box_row is_blue>
    Content
  </.box_row>
  ```

  Blue row theme on hover:

  ```
  <.box_row is_hover_blue>
    Content
  </.box_row>
  ```

  To highlight that the row contains unread items:

  ```
  <.box_row is_unread>
    Content
  </.box_row>
  ```

  ## All options

  - `PrimerLive.Options.BoxRow`
  - Additional HTML attributes are passed to the box row element

  ## Reference

  - [Primer/CSS Box](https://primer.style/css/components/box)

  """
  def box_row(assigns) do
    with {:ok, assigns} <- Schema.validate_options(assigns, Options.BoxRow, "box_row") do
      render_box_row(assigns)
    else
      message -> message
    end
  end

  defp render_box_row(assigns) do
    class =
      Attributes.classnames([
        "Box-row",
        assigns.class,
        assigns.is_blue and "Box-row--blue",
        assigns.is_focus_blue and "Box-row--focus-blue",
        assigns.is_focus_gray and "Box-row--focus-gray",
        assigns.is_gray and "Box-row--gray",
        assigns.is_hover_blue and "Box-row--hover-blue",
        assigns.is_hover_gray and "Box-row--hover-gray",
        assigns.is_navigation_focus and "navigation-focus",
        assigns.is_yellow and "Box-row--yellow",
        assigns.is_unread and "Box-row--unread"
      ])

    ~H"""
    <div class={class} {@extra}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  # ------------------------------------------------------------------------------------
  # button
  # ------------------------------------------------------------------------------------

  @doc section: :buttons

  @doc ~S"""
  Creates a button.

  ```
  <.button>Click me</.button>
  ```

  ## Features

  - Boolean options for setting button styles: `is_link`, `is_primary` and so on
  - Handles class logic, for example with `is_icon_only` and `is_close_button`


  ## Examples

  Primary:

  ```
  <.button is_primary>Sign in</.button>
  ```

  Small:

  ```
  <.button is_small>Edit</.button>
  ```

  Selected:

  ```
  <.button is_selected>Unread</.button>
  ```

  With icon:
  ```
  <.button is_primary>
    <.octicon name="download-16" />
    <span>Clone</span>
    <span class="dropdown-caret"></span>
  </.button>
  ```

  Icon-only:
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

  ## All options

  - `PrimerLive.Options.Button`
  - Additional HTML attributes are passed to the button element

  ## Reference

  - [Primer/CSS Buttons](https://primer.style/css/components/buttons)

  """

  def button(assigns) do
    with {:ok, assigns} <- Schema.validate_options(assigns, Options.Button, "button") do
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

  Use the button wrapper component `button_group_item/1` to automatically apply the correct classes to the buttons.

  ```
  <.button_group>
    <.button_group_item>Button 1</.button_group_item>
    <.button_group_item is_selected>Button 2</.button_group_item>
    <.button_group_item is_danger>Button 3</.button_group_item>
  </.button_group>
  ```

  ## Options

  - `PrimerLive.Options.ButtonGroup`
  - Additional HTML attributes are passed to the button group element

  ## Reference

  - [Primer/CSS Button groups](https://primer.style/css/components/buttons#button-groups)

  """

  def button_group(assigns) do
    with {:ok, assigns} <- Schema.validate_options(assigns, Options.ButtonGroup, "button_group") do
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

  - Equal to `PrimerLive.Options.Button`

  ## Reference

  - [Primer/CSS Button groups](https://primer.style/css/components/buttons#button-groups)

  """
  def button_group_item(assigns) do
    with {:ok, assigns} <-
           Schema.validate_options(assigns, Options.ButtonGroupItem, "button_group_item") do
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
  # pagination
  # ------------------------------------------------------------------------------------

  @doc section: :pagination

  @doc ~S"""
  Creates a control to navigate search results.

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

  Simplified

  ```
  <.pagination
    ...
    is_numbered="false"
  />
  ```

  The number of sibling and boundary page numbers to show:

  ```
  <.pagination
    ...
    sibling_count="1"
    boundary_count="1"
  />
  ```

  Custom labels:

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

  ## All options

  - `PrimerLive.Options.Pagination`
  - Additional HTML attributes are passed to the outer HTML element

  ### Reference

  - [Primer/CSS Pagination](https://primer.style/css/components/pagination)

  """

  def pagination(assigns) do
    with {:ok, assigns} <- Schema.validate_options(assigns, Options.Pagination, "pagination") do
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
  defp get_pagination_numbers(
         page_count,
         current_page,
         boundary_count,
         sibling_count
       ) do
    list = 1..page_count

    # Create list slices for each part, e.g. [1,2] and [5,6,7,8,9] and [99,100]
    section_start = Enum.take(list, boundary_count)
    section_end = Enum.take(list, -boundary_count)

    section_middle =
      Enum.slice(
        list,
        (current_page - sibling_count)..(current_page + sibling_count)
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
  Renders an icon from the set of GitHub icons, 512 including all size variations. See `PrimerLive.Octicons` for the complete list.

  Pass the icon name with the size: icon "comment" with size "16" becomes "comment-16":

  ```
  <.octicon name="comment-16" />
  ```

  ## Examples

  Icon "alert-fill" with size 12:

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

  - `PrimerLive.Options.Octicon`
  - Additional HTML attributes are passed to the SVG element

  ### Reference

  - [List of icons](https://primer.style/octicons/)
  - [Primer/Octicons Usage](https://primer.style/octicons/guidelines/usage)

  """
  def octicon(assigns) do
    with {:ok, assigns} <- Schema.validate_options(assigns, Options.Octicon, "octicon") do
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
    <Schema.error_message component_name="octicon">
      <p>name <%= @name %> does not exist</p>
    </Schema.error_message>
    """
  end
end
