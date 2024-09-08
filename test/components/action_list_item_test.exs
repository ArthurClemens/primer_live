defmodule PrimerLive.TestComponents.ActionListItemTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Slot: inner_block" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_list_item>
             Content
           </.action_list_item>
           """)
           |> format_html() ==
             """
             <li class="ActionList-item"><span class="ActionList-content"><span class="ActionList-item-label">Content</span></span></li>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Slot: link" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_list_item is_selected>
             <:link href="/url" target="_blank">
               href link
             </:link>
           </.action_list_item>
           <.action_list_item>
             <:link navigate="/url">
               navigate link
             </:link>
           </.action_list_item>
           <.action_list_item>
             <:link patch="/url">
               patch link
             </:link>
           </.action_list_item>
           """)
           |> format_html() ==
             """
             <li class="ActionList-item ActionList-item--navActive" role="none"><a href="/url" target="_blank" role="menuitem" class="ActionList-content" aria-selected="true" aria-current="page"><span class="ActionList-item-label">href link</span></a></li><li class="ActionList-item" role="none"><a href="/url" data-phx-link="redirect" data-phx-link-state="push" role="menuitem" class="ActionList-content" tabindex="0"><span class="ActionList-item-label">navigate link</span></a></li><li class="ActionList-item" role="none"><a href="/url" data-phx-link="patch" data-phx-link-state="push" role="menuitem" class="ActionList-content" tabindex="0"><span class="ActionList-item-label">patch link</span></a></li>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Link attributes (anchor links)" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_list_item is_selected>
             <:link href="#url">
               href link
             </:link>
           </.action_list_item>
           <.action_list_item>
             <:link navigate="#url">
               navigate link
             </:link>
           </.action_list_item>
           <.action_list_item>
             <:link patch="#url">
               patch link
             </:link>
           </.action_list_item>
           """)
           |> format_html() ==
             """
             <li class="ActionList-item ActionList-item--navActive" role="none"><a href="#url" role="menuitem" class="ActionList-content" aria-selected="true" aria-current="location"><span class="ActionList-item-label">href link</span></a></li><li class="ActionList-item" role="none"><a href="#url" data-phx-link="redirect" data-phx-link-state="push" role="menuitem" class="ActionList-content" tabindex="0"><span class="ActionList-item-label">navigate link</span></a></li><li class="ActionList-item" role="none"><a href="#url" data-phx-link="patch" data-phx-link-state="push" role="menuitem" class="ActionList-content" tabindex="0"><span class="ActionList-item-label">patch link</span></a></li>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Attribute: is_button" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_list_item is_button phx-click="remove">
             Button
           </.action_list_item>
           """)
           |> format_html() ==
             """
             <li class="ActionList-item" phx-click="remove"><button class="ActionList-content"><span
             class="ActionList-item-label">Button</span></button></li>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Attribute: is_selected" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_list_item is_selected>
             <:link href="/url">
               Item
             </:link>
           </.action_list_item>
           <.action_list_item is_selected>
             Item
           </.action_list_item>
           """)
           |> format_html() ==
             """
             <li class="ActionList-item ActionList-item--navActive" role="none"><a href="/url" role="menuitem"
             class="ActionList-content" aria-selected="true" aria-current="page"><span
             class="ActionList-item-label">Item</span></a></li>
             <li class="ActionList-item ActionList-item--navActive"><span class="ActionList-content"><span
             class="ActionList-item-label">Item</span></span></li>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Attributes: is_danger, is_disabled, is_truncated" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_list_item is_danger>
             Item
           </.action_list_item>
           <.action_list_item is_disabled>
             Item
           </.action_list_item>
           <.action_list_item is_truncated>
             Very long label
           </.action_list_item>
           """)
           |> format_html() ==
             """
             <li class="ActionList-item ActionList-item--danger"><span class="ActionList-content"><span
             class="ActionList-item-label">Item</span></span></li>
             <li aria-disabled="true" class="ActionList-item"><span class="ActionList-content"><span
             class="ActionList-item-label">Item</span></span></li>
             <li class="ActionList-item"><span class="ActionList-content"><span
             class="ActionList-item-label ActionList-item-label--truncate">Very long label</span></span></li>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Attribute: is_single_select" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_list_item is_single_select is_selected input_id="item-1">
             Item
           </.action_list_item>
           <.action_list_item is_single_select input_id="item-2">
             Item
           </.action_list_item>
           """)
           |> format_html() ==
             """
             <li class="ActionList-item" role="option"><span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><span class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input checked class="FormControl-checkbox" id="item-1" name="item-1" tabindex="0" type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Item</span></span></li><li class="ActionList-item" role="option"><span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><span class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox" id="item-2" name="item-2" tabindex="0" type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Item</span></span></li>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Attribute: is_single_select (custom visual)" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_list_item is_single_select is_selected input_id="item-1">
             Item
             <:leading_visual>
               Icon
             </:leading_visual>
           </.action_list_item>
           <.action_list_item is_single_select input_id="item-2">
             Item
             <:leading_visual>
               Icon
             </:leading_visual>
           </.action_list_item>
           """)
           |> format_html() ==
             """
             <li class="ActionList-item" role="option"><span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading">Icon</span><span class="ActionList-item-label">Item</span></span></li><li class="ActionList-item" role="option"><span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading">Icon</span><span class="ActionList-item-label">Item</span></span></li>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Attribute: is_multiple_select" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_list_item is_multiple_select is_selected input_id="item-1">
             Item
           </.action_list_item>
           <.action_list_item is_multiple_select input_id="item-2">
             Item
           </.action_list_item>
           """)
           |> format_html() ==
             """
             <li class="ActionList-item" role="option"><span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><span class="FormControl-checkbox-wrap ActionList-item-multiSelectIcon"><input checked class="FormControl-checkbox" id="item-1" name="item-1" tabindex="0" type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Item</span></span></li><li class="ActionList-item" role="option"><span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><span class="FormControl-checkbox-wrap ActionList-item-multiSelectIcon"><input class="FormControl-checkbox" id="item-2" name="item-2" tabindex="0" type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Item</span></span></li>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Attribute: is_multiple_select (custom visual)" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_list_item is_multiple_select is_selected input_id="item-1">
             Item
             <:leading_visual>
               Icon
             </:leading_visual>
           </.action_list_item>
           <.action_list_item is_multiple_select input_id="item-2">
             Item
             <:leading_visual>
               Icon
             </:leading_visual>
           </.action_list_item>
           """)
           |> format_html() ==
             """
             <li class="ActionList-item" role="option"><span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading">Icon</span><span class="ActionList-item-label">Item</span></span></li><li class="ActionList-item" role="option"><span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading">Icon</span><span class="ActionList-item-label">Item</span></span></li>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Attribute: is_multiple_select with is_checkmark_icon" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_list_item is_multiple_select is_checkmark_icon is_selected input_id="item-1">
             Item
             <:leading_visual>
               Icon
             </:leading_visual>
           </.action_list_item>
           <.action_list_item is_multiple_select is_checkmark_icon input_id="item-2">
             Item
             <:leading_visual>
               Icon
             </:leading_visual>
           </.action_list_item>
           """)
           |> format_html() ==
             """
             <li class="ActionList-item" role="option"><span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading">Icon</span><span class="ActionList-item-label">Item</span></span></li>
             <li class="ActionList-item" role="option"><span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading">Icon</span><span class="ActionList-item-label">Item</span></span></li>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Attribute: is_collapsible, is_expanded" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_list_item is_collapsible is_expanded>
             Item
           </.action_list_item>
           <.action_list_item is_collapsible>
             Item
           </.action_list_item>
           """)
           |> format_html() ==
             """
             <li class="ActionList-item"><button aria-expanded="true" class="ActionList-content"><span
             class="ActionList-item-label">Item</span><span
             class="ActionList-item-visual ActionList-item-visual--trailing"><svg viewBox="0 0 16 16"
             xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false" width="16" height="16"
             class="ActionList-item-collapseIcon">STRIPPED_SVG_PATHS</svg></span></button></li>
             <li class="ActionList-item"><button aria-expanded="false" class="ActionList-content"><span
             class="ActionList-item-label">Item</span><span
             class="ActionList-item-visual ActionList-item-visual--trailing"><svg viewBox="0 0 16 16"
             xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false" width="16" height="16"
             class="ActionList-item-collapseIcon">STRIPPED_SVG_PATHS</svg></span></button></li>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Attribute: is_collapsible, is_expanded (custom visual)" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_list_item is_collapsible is_expanded>
             Item
             <:trailing_visual>
               Trailing visual
             </:trailing_visual>
           </.action_list_item>
           <.action_list_item is_collapsible>
             Item
             <:trailing_visual>
               Trailing visual
             </:trailing_visual>
           </.action_list_item>
           """)
           |> format_html() ==
             """
             <li class="ActionList-item"><button aria-expanded="true" class="ActionList-content"><span
             class="ActionList-item-label">Item</span><span
             class="ActionList-item-visual ActionList-item-visual--trailing">Trailing visual</span></button></li>
             <li class="ActionList-item"><button aria-expanded="false" class="ActionList-content"><span
             class="ActionList-item-label">Item</span><span
             class="ActionList-item-visual ActionList-item-visual--trailing">Trailing visual</span></button></li>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Sizes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_list_item>
             regular
           </.action_list_item>
           <.action_list_item is_height_medium>
             medium
           </.action_list_item>
           <.action_list_item is_height_large>
             large
           </.action_list_item>
           """)
           |> format_html() ==
             """
             <li class="ActionList-item"><span class="ActionList-content"><span class="ActionList-item-label">regular</span></span></li>
             <li class="ActionList-item"><span class="ActionList-content ActionList-content--sizeMedium"><span class="ActionList-item-label">medium</span></span></li>
             <li class="ActionList-item"><span class="ActionList-content ActionList-content--sizeLarge"><span class="ActionList-item-label">large</span></span></li>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Slot: description" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_list_item>
             Content
             <:description>
               A descriptive text
             </:description>
           </.action_list_item>
           """)
           |> format_html() ==
             """
             <li class="ActionList-item">
             <span class="ActionList-content">
             <span class="ActionList-item-descriptionWrap ActionList-item-blockDescription">
             <span class="ActionList-item-label">Content</span>
             <span class="ActionList-item-description">A descriptive text</span>
             </span>
             </span>
             </li>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Slot: description, attr is_inline_description" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_list_item is_inline_description>
             Content
             <:description>
               A descriptive text
             </:description>
           </.action_list_item>
           """)
           |> format_html() ==
             """
             <li class="ActionList-item">
             <span class="ActionList-content">
             <span class="ActionList-item-descriptionWrap ActionList-item-descriptionWrap--inline">
             <span class="ActionList-item-label">Content</span>
             <span class="ActionList-item-description">A descriptive text</span>
             </span>
             </span>
             </li>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Slots: leading_visual and trailing_visual" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_list_item>
             Item
             <:leading_visual>
               Icon
             </:leading_visual>
             <:trailing_visual>
               Trailing visual
             </:trailing_visual>
           </.action_list_item>
           """)
           |> format_html() ==
             """
             <li class="ActionList-item"><span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading">Icon</span><span class="ActionList-item-label">Item</span><span class="ActionList-item-visual ActionList-item-visual--trailing">Trailing visual</span></span></li>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Slot: sub_group" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_list_section_divider>
             <:title id="title-01">Section title</:title>
           </.action_list_section_divider>
           <.action_list_item>
             Not collapsible item, default expanded
             <:sub_group aria-labelledby="title-01">
               <.action_list_item is_sub_item>
                 Sub item
               </.action_list_item>
               <.action_list_item is_sub_item>
                 Sub item
               </.action_list_item>
             </:sub_group>
           </.action_list_item>
           <.action_list_section_divider>
             <:title>Section title</:title>
           </.action_list_section_divider>
           <.action_list_item leading_visual_width="16" is_collapsible>
             Collapsible, not expanded item
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
           <.action_list_section_divider>
             <:title>Section title</:title>
           </.action_list_section_divider>
           <.action_list_item leading_visual_width="24" is_collapsible is_expanded>
             Collapsible and expanded item, wide visual
             <:leading_visual>
               <.octicon name="comment-discussion-24" />
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
           """)
           |> format_html() ==
             """
             <li class="ActionList-sectionDivider" tabidex="-1"><h3 class="ActionList-sectionDivider-title" id="title-01">Section title</h3></li><li class="ActionList-item ActionList-item--hasSubItem"><span aria-expanded="true" class="ActionList-content"><span class="ActionList-item-label">Not collapsible item, default expanded</span></span><ul aria-labelledby="title-01" class="ActionList ActionList--subGroup" role="list"><li class="ActionList-item ActionList-item--subItem"><span class="ActionList-content"><span class="ActionList-item-label">Sub item</span></span></li><li class="ActionList-item ActionList-item--subItem"><span class="ActionList-content"><span class="ActionList-item-label">Sub item</span></span></li></ul></li><li class="ActionList-sectionDivider" tabidex="-1"><h3 class="ActionList-sectionDivider-title">Section title</h3></li><li class="ActionList-item ActionList-item--hasSubItem"><button aria-expanded="false" class="ActionList-content ActionList-content--visual16"><span class="ActionList-item-visual ActionList-item-visual--leading"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">STRIPPED_SVG_PATHS</svg></span><span class="ActionList-item-label">Collapsible, not expanded item</span><span class="ActionList-item-visual ActionList-item-visual--trailing"><svg viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false" width="16" height="16" class="ActionList-item-collapseIcon">STRIPPED_SVG_PATHS</svg></span></button><ul class="ActionList ActionList--subGroup" role="list"><li class="ActionList-item ActionList-item--subItem"><span class="ActionList-content"><span class="ActionList-item-label">Sub item</span></span></li><li class="ActionList-item ActionList-item--subItem"><span class="ActionList-content"><span class="ActionList-item-label">Sub item</span></span></li></ul></li><li class="ActionList-sectionDivider" tabidex="-1"><h3 class="ActionList-sectionDivider-title">Section title</h3></li><li class="ActionList-item ActionList-item--hasSubItem"><button aria-expanded="true" class="ActionList-content ActionList-content--hasActiveSubItem ActionList-content--visual16"><span class="ActionList-item-visual ActionList-item-visual--leading"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">STRIPPED_SVG_PATHS</svg></span><span class="ActionList-item-label">Collapsible and expanded item</span><span class="ActionList-item-visual ActionList-item-visual--trailing"><svg viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false" width="16" height="16" class="ActionList-item-collapseIcon">STRIPPED_SVG_PATHS</svg></span></button><ul class="ActionList ActionList--subGroup" role="list"><li class="ActionList-item ActionList-item--subItem"><span class="ActionList-content"><span class="ActionList-item-label">Sub item</span></span></li><li class="ActionList-item ActionList-item--subItem"><span class="ActionList-content"><span class="ActionList-item-label">Sub item</span></span></li></ul></li><li class="ActionList-sectionDivider" tabidex="-1"><h3 class="ActionList-sectionDivider-title">Section title</h3></li><li class="ActionList-item ActionList-item--hasSubItem"><button aria-expanded="true" class="ActionList-content ActionList-content--hasActiveSubItem ActionList-content--visual24"><span class="ActionList-item-visual ActionList-item-visual--leading"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">STRIPPED_SVG_PATHS</svg></span><span class="ActionList-item-label">Collapsible and expanded item, wide visual</span><span class="ActionList-item-visual ActionList-item-visual--trailing"><svg viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false" width="16" height="16" class="ActionList-item-collapseIcon">STRIPPED_SVG_PATHS</svg></span></button><ul class="ActionList ActionList--subGroup" role="list"><li class="ActionList-item ActionList-item--subItem"><span class="ActionList-content"><span class="ActionList-item-label">Sub item</span></span></li><li class="ActionList-item ActionList-item--subItem"><span class="ActionList-content"><span class="ActionList-item-label">Sub item</span></span></li></ul></li>
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
           <.action_list_item
             classes={
               %{
                 action_list_item: "action_list_item-x",
                 content: "content-x",
                 label: "label-x",
                 description: "description-x",
                 description_container: "description_container-x",
                 leading_visual: "leading_visual-x",
                 trailing_visual: "trailing_visual-x",
                 sub_group: "sub_group-x"
               }
             }
             class="my-action-list-item"
           >
             <:link href="/url" class="my-link">
               Content
             </:link>
             <:description>
               A descriptive text
             </:description>
             <:leading_visual>
               Leading visual
             </:leading_visual>
             <:trailing_visual>
               Trailing visual
             </:trailing_visual>
             <:sub_group class="my-sub-group">
               <.action_list_item is_sub_item class="my-sub-item">
                 Sub item
               </.action_list_item>
             </:sub_group>
           </.action_list_item>
           """)
           |> format_html() ==
             """
             <li class="ActionList-item ActionList-item--hasSubItem action_list_item-x my-action-list-item" role="none"><a href="/url" role="menuitem" class="ActionList-content content-x my-link" tabindex="0" aria-expanded="true"><span class="ActionList-item-visual ActionList-item-visual--leading leading_visual-x">Leading visual</span><span class="ActionList-item-descriptionWrap ActionList-item-blockDescription description_container-x"><span class="ActionList-item-label label-x">Content</span><span class="ActionList-item-description description-x">A descriptive text</span></span><span class="ActionList-item-visual ActionList-item-visual--trailing trailing_visual-x">Trailing visual</span></a><ul class="ActionList ActionList--subGroup sub_group-x my-sub-group" role="list"><li class="ActionList-item ActionList-item--subItem my-sub-item"><span class="ActionList-content"><span class="ActionList-item-label">Sub item</span></span></li></ul></li>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end
end
