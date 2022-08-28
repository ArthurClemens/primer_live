defmodule PrimerLive.Components do
  use Phoenix.Component
  use Phoenix.HTML

  alias PrimerLive.Helpers.{Schema, Classes}
  alias PrimerLive.Options

  # ------------------------------------------------------------------------------------
  # pagination
  # ------------------------------------------------------------------------------------

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
    option_names = Schema.get_keys(Options.Pagination)

    with {:ok, options} <- Options.Pagination.parse(assigns) do
      assigns =
        assigns
        |> assign(options |> Map.from_struct())
        |> assign(:extra, assigns_to_attributes(assigns, option_names))

      case assigns.page_count < 2 do
        true -> render_empty(assigns)
        false -> render_pagination(assigns)
      end
    else
      {:error, changeset} ->
        Schema.show_errors(changeset, "pagination")
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
      sibling_count: sibling_count,
      class: class,
      classes: input_classes
    } = assigns

    has_previous_page = current_page > 1
    has_next_page = current_page < page_count
    show_numbers = assigns.is_numbered && page_count > 1
    show_prev_next = page_count > 1

    classes = %{
      pagination_container:
        Classes.join_classnames([
          "paginate-container",
          class,
          input_classes.pagination_container
        ]),
      pagination:
        Classes.join_classnames([
          "pagination",
          input_classes.pagination
        ]),
      previous_page:
        Classes.join_classnames([
          "previous_page",
          input_classes.previous_page
        ]),
      next_page:
        Classes.join_classnames([
          "next_page",
          input_classes.next_page
        ]),
      page:
        Classes.join_classnames([
          input_classes.page
        ]),
      gap:
        Classes.join_classnames([
          "gap",
          input_classes.gap
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

  @doc ~S"""
  Renders an icon from the set of GitHub icons.

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
    option_names = Schema.get_keys(Options.Octicon)

    with {:ok, options} <- Options.Octicon.parse(assigns) do
      class =
        Classes.join_classnames([
          "octicon",
          assigns[:class]
        ])

      assigns =
        assigns
        |> assign(options |> Map.from_struct())
        |> assign(:class, class)
        |> assign(:extra, assigns_to_attributes(assigns, option_names))

      icon_fn = PrimerLive.Octicons.name_to_function() |> Map.get(assigns.name)

      case is_function(icon_fn) do
        true -> icon_fn.(assigns)
        false -> render_no_icon_error_message(assigns)
      end
    else
      {:error, changeset} ->
        Schema.show_errors(changeset, "octicon")
    end
  end

  defp render_no_icon_error_message(assigns) do
    ~H"""
    <Schema.error_message component_name="octicon">
      <p>name <%= @name %> does not exist</p>
    </Schema.error_message>
    """
  end
end
