defmodule PrimerLive.Components.FilterListTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Slot: item links" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.filter_list aria_label="Menu">
             <:item href="#url" is_selected>
               href link
             </:item>
             <:item navigate="#url">
               navigate link
             </:item>
             <:item patch="#url">
               patch link
             </:item>
             <:item>
               Other content
             </:item>
           </.filter_list>
           """)
           |> format_html() ==
             """
             <ul aria-label="Menu" class="filter-list">
             <li><a href="#url" class="filter-item" aria-current="page">href link</a></li>
             <li><a href="#url" data-phx-link="redirect" data-phx-link-state="push" class="filter-item">navigate link</a></li>
             <li><a href="#url" data-phx-link="patch" data-phx-link-state="push" class="filter-item">patch link</a></li>
             <li>Other content</li>
             </ul>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Slot: item links with counts" do
    assigns = %{}

    assert rendered_to_string(~H"""
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
           """)
           |> format_html() ==
             """
             <ul aria-label="Menu" class="filter-list">
             <li><a href="#url" class="filter-item" aria-current="page">First filter<span class="count">99</span></a></li>
             <li><a href="#url" class="filter-item">Second filter<span class="count">3</span></a></li>
             <li><a href="#url" class="filter-item">Third filter</a></li>
             </ul>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Classes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.filter_list
             aria_label="Menu"
             classes={
               %{
                 filter_list: "filter_list-x",
                 item: "item-x",
                 count: "count-x"
               }
             }
             class="my-filter-list"
           >
             <:item href="#url" is_selected count="99" class="my-item">
               First filter
             </:item>
             <:item href="#url" count={3}>
               Second filter
             </:item>
             <:item href="#url">
               Third filter
             </:item>
           </.filter_list>
           """)
           |> format_html() ==
             """
             <ul aria-label="Menu" class="filter-list filter_list-x my-filter-list">
             <li><a href="#url" class="filter-item item-x my-item" aria-current="page">First filter<span
                class="count count-x">99</span></a></li>
             <li><a href="#url" class="filter-item item-x">Second filter<span class="count count-x">3</span></a></li>
             <li><a href="#url" class="filter-item item-x">Third filter</a></li>
             </ul>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Extra attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.filter_list aria_label="Menu" dir="rtl">
             <:item href="#url" is_selected aria-label="Item">
               href link
             </:item>
           </.filter_list>
           """)
           |> format_html() ==
             """
             <ul aria-label="Menu" class="filter-list" dir="rtl">
             <li><a href="#url" class="filter-item" aria-label="Item" aria-current="page">href link</a></li>
             </ul>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end
end
