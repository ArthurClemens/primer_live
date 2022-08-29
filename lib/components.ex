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

  To render multiple alerts, wrap each with `alert_messages/1`.

  ### Examples

  ```
  <.alert is_success>
    You're done!
  </.alert>
  ```

  ```
  <.alert is_success>
    <p>You're done!</p>
    <p>You may close this message</p>
  </.alert>
  ```

  ### Features

  - Boolean options for setting alert styles: `is_error`, `is_success` and so on

  ### Options

  - `PrimerLive.Options.Alert`
  - Additional HTML attributes to be passed to the alert element

  ### Reference

  - [Primer/CSS Buttons](https://primer.style/css/components/alerts)

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
      Attributes.join_classnames([
        "flash",
        assigns.class,
        assigns.is_error and "flash-error",
        assigns.is_success and "flash-success",
        assigns.is_warning and "flash-warn"
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
  Wrapper around an `alert/1` messages to create spacing when showing multiple alerts.

  ### Example

  ```
  <.alert_messages>
    <.alert is_success>
      <p>You're done!</p>
    </.alert>
  </.alert_messages>
  <.alert_messages>
    <.alert>
      <p>You may close this message</p>
    </.alert>
  </.alert_messages>
  ```
  ### Options

  - `PrimerLive.Options.AlertMessages`
  - Additional HTML attributes to be passed to the alert messages element

  ### Reference

  - [Primer/CSS Buttons](https://primer.style/css/components/alerts)

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
      Attributes.join_classnames([
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
  # button
  # ------------------------------------------------------------------------------------

  @doc section: :buttons

  @doc ~S"""
  Creates a button.

  ### Examples

  ```
  <.button is_primary>Sign in</.button>
  ```

  ```
  <.button is_primary>
    <.octicon name="download-16" />
    <span>Clone</span>
    <span class="dropdown-caret"></span>
  </.button>
  ```

  ### Features

  - Boolean options for setting button styles: `is_link`, `is_primary` and so on
  - Handles class logic, for example with `is_icon_only` and `is_close_button`

  ### Options

  - `PrimerLive.Options.Button`
  - Additional HTML attributes to be passed to the button element

  ### Reference

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
      Attributes.join_classnames([
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

  ### Example

  ```
  <.button_group>
    <.button_group_item>Button 1</.button_group_item>
    <.button_group_item is_selected>Button 2</.button_group_item>
    <.button_group_item is_danger>Button 3</.button_group_item>
  </.button_group>
  ```

  ### Options

  - `PrimerLive.Options.ButtonGroup`
  - Additional HTML attributes to be passed to the button group element

  ### Reference

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
      Attributes.join_classnames([
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

  ### Options

  - Equal to `PrimerLive.Options.Button`

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
        Attributes.join_classnames([
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

  ### Example

  ```
  <.pagination
    page_count={@page_count}
    current_page={@current_page}
    link_path={fn page_num -> "/page/#{page_num}" end}
  />
  ```

  ### Features

  - Configure the page number ranges for siblings and both ends
  - Optionally disable page number display (minimal UI)
  - Custom labels
  - Custom classnames for all elements

  ### Options

  - `PrimerLive.Options.Pagination`
  - Additional HTML attributes to be passed to the outer HTML element

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
        Attributes.join_classnames([
          "paginate-container",
          assigns.class,
          assigns.classes.pagination_container
        ]),
      pagination:
        Attributes.join_classnames([
          "pagination",
          assigns.classes.pagination
        ]),
      previous_page:
        Attributes.join_classnames([
          "previous_page",
          assigns.classes.previous_page
        ]),
      next_page:
        Attributes.join_classnames([
          "next_page",
          assigns.classes.next_page
        ]),
      page:
        Attributes.join_classnames([
          assigns.classes.page
        ]),
      gap:
        Attributes.join_classnames([
          "gap",
          assigns.classes.gap
        ])
    }

    pagination_elements =
      get_pagination_elements(
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

  defp get_pagination_elements(
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
  Renders an icon from the set of GitHub icons.

  Pass the icon name with the size: icon "arrow-left" with size "16" becomes "arrow-left-16".

  ### Example

  ```
  <.octicon name="arrow-left-24" />
  ```

  ### Options

  - `PrimerLive.Options.Octicon`
  - Additional HTML attributes to be passed to the SVG element

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
        Attributes.join_classnames([
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
