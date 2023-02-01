defmodule PrimerLive.TestComponents.ActionMenuTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Basic" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_menu>
             <:toggle>Menu</:toggle>
             <.action_list>
               <.action_list_item>
                 One
               </.action_list_item>
               <.action_list_item>
                 Two
               </.action_list_item>
               <.action_list_item>
                 Three
               </.action_list_item>
             </.action_list>
           </.action_menu>
           """)
           |> format_html() ==
             """
             <details class="details-reset details-overlay" data-prompt="" ontoggle="window.Prompt &amp;&amp; Prompt.init(this)">
             <summary class="btn" aria-haspopup="true">Menu</summary>
             <div data-touch=""></div>
             <div class="ActionMenu">
             <div class="ActionMenu-modal" data-content="" aria-role="menu">
             <div class="SelectMenu-list">
             <ul class="ActionList" role="listbox">
             <li class="ActionList-item"><span class="ActionList-content"><span class="ActionList-item-label">One</span></span></li>
             <li class="ActionList-item"><span class="ActionList-content"><span class="ActionList-item-label">Two</span></span></li>
             <li class="ActionList-item"><span class="ActionList-content"><span class="ActionList-item-label">Three</span></span></li>
             </ul>
             </div>
             </div>
             </div>
             </details>
             """
             |> format_html()
  end

  test "With single select" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_menu is_dropdown_caret>
             <:toggle><.octicon name="number-16" /><span>Number</span></:toggle>
             <.action_list>
               <.action_list_item is_single_select>
                 <.octicon name="typography-16" /><span>Text</span>
               </.action_list_item>
               <.action_list_item is_single_select is_selected>
                 <.octicon name="number-16" /><span>Number</span>
               </.action_list_item>
               <.action_list_item is_single_select>
                 <.octicon name="calendar-16" /><span>Calendar</span>
               </.action_list_item>
               <.action_list_item is_single_select>
                 <.octicon name="iterations-16" /><span>Iteration</span>
               </.action_list_item>
             </.action_list>
           </.action_menu>
           """)
           |> format_html() ==
             """
             <details class="details-reset details-overlay" data-prompt="" ontoggle="window.Prompt &amp;&amp; Prompt.init(this)">
             <summary class="btn" aria-haspopup="true">
             <svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">STRIPPED_SVG_PATHS</svg><span>Number</span>
             <div class="dropdown-caret"></div>
             </summary>
             <div data-touch=""></div>
             <div class="ActionMenu">
             <div class="ActionMenu-modal" data-content="" aria-role="menu">
             <div class="SelectMenu-list">
             <ul class="ActionList" role="listbox">
             <li class="ActionList-item" aria-selected="false" role="option">
             <span class="ActionList-content">
              <span class="ActionList-item-visual ActionList-item-visual--leading">
                <span class="FormControl-radio-wrap ActionList-item-singleSelectCheckmark">
                  <input class="FormControl-radio" type="radio" value="" />
                  <span class="FormControl-radio-labelWrap">
                    <label class="FormControl-label">
                      <svg width="16" height="16" viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false" class="ActionList-item-singleSelectCheckmark">STRIPPED_SVG_PATHS</svg>
                    </label>
                  </span>
                </span>
              </span>
              <span class="ActionList-item-label"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">STRIPPED_SVG_PATHS</svg><span>Text</span></span>
             </span>
             </li>
             <li class="ActionList-item" aria-selected="true" role="option">
             <span class="ActionList-content">
              <span class="ActionList-item-visual ActionList-item-visual--leading">
                <span class="FormControl-radio-wrap ActionList-item-singleSelectCheckmark">
                  <input checked class="FormControl-radio" type="radio" value="" />
                  <span class="FormControl-radio-labelWrap">
                    <label class="FormControl-label">
                      <svg width="16" height="16" viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false" class="ActionList-item-singleSelectCheckmark">STRIPPED_SVG_PATHS</svg>
                    </label>
                  </span>
                </span>
              </span>
              <span class="ActionList-item-label"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">STRIPPED_SVG_PATHS</svg><span>Number</span></span>
             </span>
             </li>
             <li class="ActionList-item" aria-selected="false" role="option">
             <span class="ActionList-content">
              <span class="ActionList-item-visual ActionList-item-visual--leading">
                <span class="FormControl-radio-wrap ActionList-item-singleSelectCheckmark">
                  <input class="FormControl-radio" type="radio" value="" />
                  <span class="FormControl-radio-labelWrap">
                    <label class="FormControl-label">
                      <svg width="16" height="16" viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false" class="ActionList-item-singleSelectCheckmark">STRIPPED_SVG_PATHS</svg>
                    </label>
                  </span>
                </span>
              </span>
              <span class="ActionList-item-label"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">STRIPPED_SVG_PATHS</svg><span>Calendar</span></span>
             </span>
             </li>
             <li class="ActionList-item" aria-selected="false" role="option">
             <span class="ActionList-content">
              <span class="ActionList-item-visual ActionList-item-visual--leading">
                <span class="FormControl-radio-wrap ActionList-item-singleSelectCheckmark">
                  <input class="FormControl-radio" type="radio" value="" />
                  <span class="FormControl-radio-labelWrap">
                    <label class="FormControl-label">
                      <svg width="16" height="16" viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false" class="ActionList-item-singleSelectCheckmark">STRIPPED_SVG_PATHS</svg>
                    </label>
                  </span>
                </span>
              </span>
              <span class="ActionList-item-label"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">STRIPPED_SVG_PATHS</svg><span>Iteration</span></span>
             </span>
             </li>
             </ul>
             </div>
             </div>
             </div>
             </details>
             """
             |> format_html()
  end

  test "With multiple select" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_menu is_dropdown_caret>
             <:toggle>
               Select
               <.counter>2</.counter>
             </:toggle>
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
           """)
           |> format_html() ==
             """
             <details class="details-reset details-overlay" data-prompt="" ontoggle="window.Prompt &amp;&amp; Prompt.init(this)">
             <summary class="btn" aria-haspopup="true">Select<span class="Counter">2</span>
             <div class="dropdown-caret"></div>
             </summary>
             <div data-touch=""></div>
             <div class="ActionMenu">
             <div class="ActionMenu-modal" data-content="" aria-role="menu">
             <div class="SelectMenu-list">
             <ul class="ActionList" role="listbox">
             <li class="ActionList-item" aria-selected="true" role="option">
             <span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading">
                <span class="FormControl-checkbox-wrap ActionList-item-multiSelectIcon">
                  <input checked class="FormControl-checkbox" type="checkbox" value="" />
                </span>
              </span>
              <span class="ActionList-item-label">Option</span>
             </span>
             </li>
             <li class="ActionList-item" aria-selected="true" role="option">
             <span class="ActionList-content">
              <span class="ActionList-item-visual ActionList-item-visual--leading">
                <span class="FormControl-checkbox-wrap ActionList-item-multiSelectIcon">
                  <input checked class="FormControl-checkbox" type="checkbox" value="" />
                </span>
              </span>
              <span class="ActionList-item-label">Option</span>
             </span>
             </li>
             <li class="ActionList-item" aria-selected="false" role="option">
             <span class="ActionList-content">
              <span class="ActionList-item-visual ActionList-item-visual--leading">
                <span class="FormControl-checkbox-wrap ActionList-item-multiSelectIcon">
                  <input class="FormControl-checkbox" type="checkbox" value="" />
                </span>
              </span>
              <span class="ActionList-item-label">Option</span>
             </span>
             </li>
             </ul>
             </div>
             </div>
             </div>
             </details>
             """
             |> format_html()
  end

  test "Attribute: is_right_aligned" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_menu is_right_aligned>
             <:toggle>
               Menu
             </:toggle>
             LIST
           </.action_menu>
           """)
           |> format_html() ==
             """
             <details class="details-reset details-overlay" data-prompt="" ontoggle="window.Prompt &amp;&amp; Prompt.init(this)">
             <summary class="btn" aria-haspopup="true">Menu</summary>
             <div data-touch=""></div>
             <div class="ActionMenu right-0">
             <div class="ActionMenu-modal" data-content="" aria-role="menu">
             <div class="SelectMenu-list">LIST</div>
             </div>
             </div>
             </details>
             """
             |> format_html()
  end

  test "Attribute: is_backdrop" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_menu is_backdrop>
             <:toggle>
               Menu
             </:toggle>
             LIST
           </.action_menu>
           """)
           |> format_html() ==
             """
             <details class="details-reset details-overlay" data-prompt="" ontoggle="window.Prompt &amp;&amp; Prompt.init(this)" data-isfast="">
             <summary class="btn" aria-haspopup="true">Menu</summary>
             <div data-backdrop="" data-islight=""></div>
             <div data-touch=""></div>
             <div class="ActionMenu">
             <div class="ActionMenu-modal" data-content="" aria-role="menu">
             <div class="SelectMenu-list">LIST</div>
             </div>
             </div>
             </details>
             """
             |> format_html()
  end

  test "Attribute: is_dark_backdrop" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_menu is_dark_backdrop>
             <:toggle>
               Menu
             </:toggle>
             LIST
           </.action_menu>
           """)
           |> format_html() ==
             """
             <details class="details-reset details-overlay" data-prompt="" ontoggle="window.Prompt &amp;&amp; Prompt.init(this)" data-isfast="">
             <summary class="btn" aria-haspopup="true">Menu</summary>
             <div data-backdrop="" data-isdark=""></div>
             <div data-touch=""></div>
             <div class="ActionMenu">
             <div class="ActionMenu-modal" data-content="" aria-role="menu">
             <div class="SelectMenu-list">LIST</div>
             </div>
             </div>
             </details>
             """
             |> format_html()
  end

  test "Attribute: is_fast" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_menu is_fast>
             <:toggle>
               Menu
             </:toggle>
             LIST
           </.action_menu>
           """)
           |> format_html() ==
             """
             <details class="details-reset details-overlay" data-prompt="" ontoggle="window.Prompt &amp;&amp; Prompt.init(this)">
             <summary class="btn" aria-haspopup="true">Menu</summary>
             <div data-touch=""></div>
             <div class="ActionMenu">
             <div class="ActionMenu-modal" data-content="" aria-role="menu">
             <div class="SelectMenu-list">LIST</div>
             </div>
             </div>
             </details>
             """
             |> format_html()
  end

  test "Attribute: menu_theme" do
    assigns = %{
      theme_state: %{
        color_mode: "dark",
        light_theme: "light_colorblind",
        dark_theme: "dark_high_contrast"
      }
    }

    assert rendered_to_string(~H"""
           <.action_menu is_right_aligned menu_theme={@theme_state}>
             <:toggle>
               Menu
             </:toggle>
             LIST
           </.action_menu>
           """)
           |> format_html() ==
             """
             <details class="details-reset details-overlay" data-prompt="" ontoggle="window.Prompt &amp;&amp; Prompt.init(this)">
             <summary class="btn" aria-haspopup="true">Menu</summary>
             <div data-touch=""></div>
             <div class="ActionMenu right-0">
             <div class="ActionMenu-modal" data-content="" aria-role="menu" data-color-mode="dark" data-light-theme="light_colorblind" data-dark-theme="dark_high_contrast">
             <div class="SelectMenu-list">LIST</div>
             </div>
             </div>
             </details>
             """
             |> format_html()
  end

  test "Attribute: classes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_menu
             is_dropdown_caret
             classes={
               %{
                 action_menu: "action_menu-x",
                 caret: "caret-x",
                 menu_container: "menu_container-x",
                 menu_list: "menu_list-x",
                 menu: "menu-x",
                 toggle: "toggle-x"
               }
             }
             class="my-action-menu"
           >
             <:toggle class="my-toggle">
               Menu
             </:toggle>
             LIST
           </.action_menu>
           """)
           |> format_html() ==
             """
             <details class="details-reset details-overlay action_menu-x my-action-menu" data-prompt="" ontoggle="window.Prompt &amp;&amp; Prompt.init(this)">
             <summary class="toggle-x my-toggle" aria-haspopup="true">Menu<div class="dropdown-caret caret-x"></div>
             </summary>
             <div data-touch=""></div>
             <div class="ActionMenu menu-x">
             <div class="ActionMenu-modal menu_container-x" data-content="" aria-role="menu">
             <div class="SelectMenu-list menu_list-x">LIST</div>
             </div>
             </div>
             </details>
             """
             |> format_html()
  end
end
