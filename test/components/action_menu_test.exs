defmodule PrimerLive.TestComponents.ActionMenuTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Basic" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_menu id="my-menu">
             <:toggle phx-click={open_menu("my-menu")}>Menu</:toggle>
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
             <div data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-menu&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:130,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-menu&quot;,&quot;transition&quot;:[[&quot;duration-130&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isescapable="" data-isfast="" data-ismenu="" data-open="[[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-menu&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-menu [data-content]&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-menu&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-menu" phx-hook="Prompt"><label aria-haspopup="true" class="btn" for="my-menu-toggle" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-menu&quot;,&quot;attr&quot;:&quot;data-open&quot;}]]">Menu</label><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-menu&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div class="ActionMenu"><div aria-role="menu" class="ActionMenu-modal" data-content=""><div class="SelectMenu-list"><div id="focus-wrap-my-menu" phx-hook="Phoenix.FocusWrap" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-menu&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-menu-start" tabindex="0" aria-hidden="true"></span><ul class="ActionList" role="listbox"><li class="ActionList-item"><span class="ActionList-content"><span class="ActionList-item-label">One</span></span></li><li class="ActionList-item"><span class="ActionList-content"><span class="ActionList-item-label">Two</span></span></li><li class="ActionList-item"><span class="ActionList-content"><span class="ActionList-item-label">Three</span></span></li></ul><span id="focus-wrap-my-menu-end" tabindex="0" aria-hidden="true"></span></div></div></div></div></div>
             """
             |> format_html()
  end

  test "With single select" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_menu is_dropdown_caret id="my-menu">
             <:toggle phx-click={toggle_menu("my-menu")}>
               <.octicon name="number-16" /><span>Number</span>
             </:toggle>
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
             <div data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-menu&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:130,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-menu&quot;,&quot;transition&quot;:[[&quot;duration-130&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isescapable="" data-isfast="" data-ismenu="" data-open="[[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-menu&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-menu [data-content]&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-menu&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-menu" phx-hook="Prompt"><label aria-haspopup="true" class="btn" for="my-menu-toggle" phx-click="[[&quot;dispatch&quot;,{&quot;to&quot;:&quot;#my-menu&quot;,&quot;event&quot;:&quot;prompt:toggle&quot;}]]"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">STRIPPED_SVG_PATHS</svg><span>Number</span><div class="dropdown-caret"></div></label><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-menu&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div class="ActionMenu"><div aria-role="menu" class="ActionMenu-modal" data-content=""><div class="SelectMenu-list"><div id="focus-wrap-my-menu" phx-hook="Phoenix.FocusWrap" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-menu&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-menu-start" tabindex="0" aria-hidden="true"></span><ul class="ActionList" role="listbox"><li class="ActionList-item" role="option"><span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><span class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox" tabindex="0" type="checkbox" value="true" /></span></span><span class="ActionList-item-label"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">STRIPPED_SVG_PATHS</svg><span>Text</span></span></span></li><li class="ActionList-item" role="option"><span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><span class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input checked class="FormControl-checkbox" tabindex="0" type="checkbox" value="true" /></span></span><span class="ActionList-item-label"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">STRIPPED_SVG_PATHS</svg><span>Number</span></span></span></li><li class="ActionList-item" role="option"><span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><span class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox" tabindex="0" type="checkbox" value="true" /></span></span><span class="ActionList-item-label"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">STRIPPED_SVG_PATHS</svg><span>Calendar</span></span></span></li><li class="ActionList-item" role="option"><span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><span class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input class="FormControl-checkbox" tabindex="0" type="checkbox" value="true" /></span></span><span class="ActionList-item-label"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">STRIPPED_SVG_PATHS</svg><span>Iteration</span></span></span></li></ul><span id="focus-wrap-my-menu-end" tabindex="0" aria-hidden="true"></span></div></div></div></div></div>
             """
             |> format_html()
  end

  test "With multiple select" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_menu is_dropdown_caret id="my-menu">
             <:toggle phx-click={toggle_menu("my-menu")}>
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
             <div data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-menu&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:130,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-menu&quot;,&quot;transition&quot;:[[&quot;duration-130&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isescapable="" data-isfast="" data-ismenu="" data-open="[[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-menu&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-menu [data-content]&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-menu&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-menu" phx-hook="Prompt"><label aria-haspopup="true" class="btn" for="my-menu-toggle" phx-click="[[&quot;dispatch&quot;,{&quot;to&quot;:&quot;#my-menu&quot;,&quot;event&quot;:&quot;prompt:toggle&quot;}]]">Select<span class="Counter">2</span><div class="dropdown-caret"></div></label><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-menu&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div class="ActionMenu"><div aria-role="menu" class="ActionMenu-modal" data-content=""><div class="SelectMenu-list"><div id="focus-wrap-my-menu" phx-hook="Phoenix.FocusWrap" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-menu&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-menu-start" tabindex="0" aria-hidden="true"></span><ul class="ActionList" role="listbox"><li class="ActionList-item" role="option"><span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><span class="FormControl-checkbox-wrap ActionList-item-multiSelectIcon"><input checked class="FormControl-checkbox" tabindex="0" type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Option</span></span></li><li class="ActionList-item" role="option"><span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><span class="FormControl-checkbox-wrap ActionList-item-multiSelectIcon"><input checked class="FormControl-checkbox" tabindex="0" type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Option</span></span></li><li class="ActionList-item" role="option"><span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><span class="FormControl-checkbox-wrap ActionList-item-multiSelectIcon"><input class="FormControl-checkbox" tabindex="0" type="checkbox" value="true" /></span></span><span class="ActionList-item-label">Option</span></span></li></ul><span id="focus-wrap-my-menu-end" tabindex="0" aria-hidden="true"></span></div></div></div></div></div>
             """
             |> format_html()
  end

  test "Attribute: is_aligned_end" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_menu is_aligned_end id="my-menu">
             <:toggle phx-click={toggle_menu("my-menu")}>
               Menu
             </:toggle>
             LIST
           </.action_menu>
           """)
           |> format_html() ==
             """
             <div data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-menu&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:130,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-menu&quot;,&quot;transition&quot;:[[&quot;duration-130&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isescapable="" data-isfast="" data-ismenu="" data-open="[[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-menu&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-menu [data-content]&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-menu&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-menu" phx-hook="Prompt"><label aria-haspopup="true" class="btn" for="my-menu-toggle" phx-click="[[&quot;dispatch&quot;,{&quot;to&quot;:&quot;#my-menu&quot;,&quot;event&quot;:&quot;prompt:toggle&quot;}]]">Menu</label><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-menu&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div class="ActionMenu pl-aligned-end"><div aria-role="menu" class="ActionMenu-modal" data-content=""><div class="SelectMenu-list"><div id="focus-wrap-my-menu" phx-hook="Phoenix.FocusWrap" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-menu&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-menu-start" tabindex="0" aria-hidden="true"></span>LIST<span id="focus-wrap-my-menu-end" tabindex="0" aria-hidden="true"></span></div></div></div></div></div>
             """
             |> format_html()
  end

  test "Attribute: is_backdrop" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_menu is_backdrop id="my-menu">
             <:toggle phx-click={toggle_menu("my-menu")}>
               Menu
             </:toggle>
             LIST
           </.action_menu>
           """)
           |> format_html() ==
             """
             <div data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-menu&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:130,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-menu&quot;,&quot;transition&quot;:[[&quot;duration-130&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isescapable="" data-isfast="" data-ismenu="" data-open="[[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-menu&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-menu [data-content]&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-menu&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-menu" phx-hook="Prompt"><label aria-haspopup="true" class="btn" for="my-menu-toggle" phx-click="[[&quot;dispatch&quot;,{&quot;to&quot;:&quot;#my-menu&quot;,&quot;event&quot;:&quot;prompt:toggle&quot;}]]">Menu</label><div data-backdrop="" data-is_light_backdrop=""></div><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-menu&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div class="ActionMenu"><div aria-role="menu" class="ActionMenu-modal" data-content=""><div class="SelectMenu-list"><div id="focus-wrap-my-menu" phx-hook="Phoenix.FocusWrap" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-menu&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-menu-start" tabindex="0" aria-hidden="true"></span>LIST<span id="focus-wrap-my-menu-end" tabindex="0" aria-hidden="true"></span></div></div></div></div></div>
             """
             |> format_html()
  end

  test "Attribute: is_strong_backdrop" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_menu is_strong_backdrop id="my-menu">
             <:toggle phx-click={toggle_menu("my-menu")}>
               Menu
             </:toggle>
             LIST
           </.action_menu>
           """)
           |> format_html() ==
             """
             <div data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-menu&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:130,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-menu&quot;,&quot;transition&quot;:[[&quot;duration-130&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isescapable="" data-isfast="" data-ismenu="" data-open="[[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-menu&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-menu [data-content]&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-menu&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-menu" phx-hook="Prompt"><label aria-haspopup="true" class="btn" for="my-menu-toggle" phx-click="[[&quot;dispatch&quot;,{&quot;to&quot;:&quot;#my-menu&quot;,&quot;event&quot;:&quot;prompt:toggle&quot;}]]">Menu</label><div data-backdrop="" data-is_strong_backdrop=""></div><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-menu&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div class="ActionMenu"><div aria-role="menu" class="ActionMenu-modal" data-content=""><div class="SelectMenu-list"><div id="focus-wrap-my-menu" phx-hook="Phoenix.FocusWrap" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-menu&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-menu-start" tabindex="0" aria-hidden="true"></span>LIST<span id="focus-wrap-my-menu-end" tabindex="0" aria-hidden="true"></span></div></div></div></div></div>
             """
             |> format_html()
  end

  test "Attribute: is_fast" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_menu id="my-menu" is_fast={false}>
             <:toggle phx-click={toggle_menu("my-menu")}>
               Menu
             </:toggle>
             LIST
           </.action_menu>
           """)
           |> format_html() ==
             """
             <div data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-menu&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:130,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-menu&quot;,&quot;transition&quot;:[[&quot;duration-130&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isescapable="" data-ismenu="" data-open="[[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-menu&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-menu [data-content]&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-menu&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-menu" phx-hook="Prompt"><label aria-haspopup="true" class="btn" for="my-menu-toggle" phx-click="[[&quot;dispatch&quot;,{&quot;to&quot;:&quot;#my-menu&quot;,&quot;event&quot;:&quot;prompt:toggle&quot;}]]">Menu</label><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-menu&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div class="ActionMenu"><div aria-role="menu" class="ActionMenu-modal" data-content=""><div class="SelectMenu-list"><div id="focus-wrap-my-menu" phx-hook="Phoenix.FocusWrap" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-menu&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-menu-start" tabindex="0" aria-hidden="true"></span>LIST<span id="focus-wrap-my-menu-end" tabindex="0" aria-hidden="true"></span></div></div></div></div></div>
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
           <.action_menu is_aligned_end menu_theme={@theme_state} id="my-menu">
             <:toggle phx-click={toggle_menu("my-menu")}>
               Menu
             </:toggle>
             LIST
           </.action_menu>
           """)
           |> format_html() ==
             """
             <div data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-menu&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:130,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-menu&quot;,&quot;transition&quot;:[[&quot;duration-130&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isescapable="" data-isfast="" data-ismenu="" data-open="[[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-menu&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-menu [data-content]&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-menu&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-menu" phx-hook="Prompt"><label aria-haspopup="true" class="btn" for="my-menu-toggle" phx-click="[[&quot;dispatch&quot;,{&quot;to&quot;:&quot;#my-menu&quot;,&quot;event&quot;:&quot;prompt:toggle&quot;}]]">Menu</label><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-menu&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div class="ActionMenu pl-aligned-end"><div aria-role="menu" class="ActionMenu-modal" data-color-mode="dark" data-content="" data-dark-theme="dark_high_contrast" data-light-theme="light_colorblind"><div class="SelectMenu-list"><div id="focus-wrap-my-menu" phx-hook="Phoenix.FocusWrap" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-menu&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-menu-start" tabindex="0" aria-hidden="true"></span>LIST<span id="focus-wrap-my-menu-end" tabindex="0" aria-hidden="true"></span></div></div></div></div></div>
             """
             |> format_html()
  end

  test "Attribute: is_show_on_mount" do
    assigns = %{
      condition: true,
      equals_initial_condition: true
    }

    assert rendered_to_string(~H"""
           <.action_menu :if={@condition} id="my-menu" is_show is_show_on_mount={@equals_initial_condition}>
             <:toggle phx-click={toggle_menu("my-menu")}>
               Menu
             </:toggle>
             LIST
           </.action_menu>
           """)
           |> format_html() ==
             """
             <div class="is-open is-showing is-show_on_mount" data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-menu&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:130,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-menu&quot;,&quot;transition&quot;:[[&quot;duration-130&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isescapable="" data-isfast="" data-ismenu="" data-open="[[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-menu&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-menu [data-content]&quot;}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-menu&quot;}],[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-show_on_mount&quot;],&quot;to&quot;:&quot;#my-menu&quot;}]]" data-prompt="" id="my-menu" phx-hook="Prompt" phx-mounted="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-menu&quot;,&quot;attr&quot;:&quot;data-open&quot;}]]"><label aria-haspopup="true" class="btn" for="my-menu-toggle" phx-click="[[&quot;dispatch&quot;,{&quot;to&quot;:&quot;#my-menu&quot;,&quot;event&quot;:&quot;prompt:toggle&quot;}]]">Menu</label><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-menu&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div class="ActionMenu"><div aria-role="menu" class="ActionMenu-modal" data-content=""><div class="SelectMenu-list"><div id="focus-wrap-my-menu" phx-hook="Phoenix.FocusWrap" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-menu&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-menu-start" tabindex="0" aria-hidden="true"></span>LIST<span id="focus-wrap-my-menu-end" tabindex="0" aria-hidden="true"></span></div></div></div></div></div>
             """
             |> format_html()
  end

  test "Attribute: classes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_menu
             is_dropdown_caret
             id="my-menu"
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
             <:toggle phx-click={open_menu("my-menu")} class="my-toggle">
               Menu
             </:toggle>
             LIST
           </.action_menu>
           """)
           |> format_html() ==
             """
             <div class="action_menu-x my-action-menu" data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-menu&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:130,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-menu&quot;,&quot;transition&quot;:[[&quot;duration-130&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isescapable="" data-isfast="" data-ismenu="" data-open="[[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-menu&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-menu [data-content]&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-menu&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-menu" phx-hook="Prompt"><label aria-haspopup="true" class="toggle-x my-toggle" for="my-menu-toggle" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-menu&quot;,&quot;attr&quot;:&quot;data-open&quot;}]]">Menu<div class="dropdown-caret caret-x"></div></label><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-menu&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div class="ActionMenu menu-x"><div aria-role="menu" class="ActionMenu-modal menu_container-x" data-content=""><div class="SelectMenu-list menu_list-x"><div id="focus-wrap-my-menu" phx-hook="Phoenix.FocusWrap" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-menu&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-menu-start" tabindex="0" aria-hidden="true"></span>LIST<span id="focus-wrap-my-menu-end" tabindex="0" aria-hidden="true"></span></div></div></div></div></div>
             """
             |> format_html()
  end
end
