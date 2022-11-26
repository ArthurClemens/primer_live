defmodule PrimerLive.TestComponents.ActionListTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Content slot" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_list>
             content
           </.action_list>
           """)
           |> format_html() ==
             """
             <ul class="ActionList" role="listbox">content</ul>
             """
             |> format_html()
  end

  test "Attributes: aria_label, role" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_list aria_label="Menu" role="list">
             content
           </.action_list>
           """)
           |> format_html() ==
             """
             <ul class="ActionList" role="list" aria-label="Menu">content</ul>
             """
             |> format_html()
  end

  test "Attributes: is_divided, is_full_bleed, is_multiple_select" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_list is_divided>
             content
           </.action_list>
           <.action_list is_full_bleed>
             content
           </.action_list>
           <.action_list is_multiple_select>
             content
           </.action_list>
           """)
           |> format_html() ==
             """
             <ul class="ActionList ActionList--divided" role="listbox">content</ul>
             <ul class="ActionList ActionList--full" role="listbox">content</ul>
             <ul class="ActionList" role="listbox" aria-multiselectable="true">content</ul>
             """
             |> format_html()
  end

  test "Class" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_list class="my-action-list">
             content
           </.action_list>
           """)
           |> format_html() ==
             """
             <ul class="ActionList my-action-list" role="listbox">content</ul>
             """
             |> format_html()
  end

  test "Extra attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_list dir="rtl">
             content
           </.action_list>
           """)
           |> format_html() ==
             """
             <ul dir="rtl" class="ActionList" role="listbox">content</ul>
             """
             |> format_html()
  end

  test "With divider and aria-labelledby" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_list aria-labelledby="title-01">
             <.action_list_section_divider>
               <:title id="title-01">Title</:title>
             </.action_list_section_divider>
             <.action_list_item>
               Item
             </.action_list_item>
           </.action_list>
           """)
           |> format_html() ==
             """
             <ul aria-labelledby="title-01" class="ActionList" role="listbox">
             <li class="ActionList-sectionDivider">
             <h3 id="title-01" class="ActionList-sectionDivider-title">Title</h3>
             </li>
             <li class="ActionList-item"><span class="ActionList-content"><span class="ActionList-item-label">Item</span></span></li>
             </ul>
             """
             |> format_html()
  end
end
