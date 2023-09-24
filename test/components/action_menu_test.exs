defmodule PrimerLive.TestComponents.ActionMenuTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Basic" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_menu id="qwerty">
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
             <div data-isfast="" data-prompt="" id="qwerty" phx-hook="Prompt"><label aria-haspopup="true" class="btn"
             for="qwerty-toggle">Menu</label><input aria-hidden="true" id="qwerty-toggle" name="[]"
             onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-touch=""></div>
             <div class="ActionMenu">
             <div aria-role="menu" class="ActionMenu-modal" data-content="">
                <div class="SelectMenu-list">
                    <ul class="ActionList" role="listbox">
                        <li class="ActionList-item"><span class="ActionList-content"><span
                                    class="ActionList-item-label">One</span></span></li>
                        <li class="ActionList-item"><span class="ActionList-content"><span
                                    class="ActionList-item-label">Two</span></span></li>
                        <li class="ActionList-item"><span class="ActionList-content"><span
                                    class="ActionList-item-label">Three</span></span></li>
                    </ul>
                </div>
             </div>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "With single select" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_menu is_dropdown_caret id="qwerty">
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
             <div data-isfast="" data-prompt="" id="qwerty" phx-hook="Prompt"><label aria-haspopup="true" class="btn"
             for="qwerty-toggle"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16"
             viewBox="0 0 16 16">STRIPPED_SVG_PATHS</svg><span>Number</span>
             <div class="dropdown-caret"></div>
             </label><input aria-hidden="true" id="qwerty-toggle" name="[]"
             onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-touch=""></div>
             <div class="ActionMenu">
             <div aria-role="menu" class="ActionMenu-modal" data-content="">
                <div class="SelectMenu-list">
                    <ul class="ActionList" role="listbox">
                        <li class="ActionList-item" role="option"><span class="ActionList-content"><span
                                    class="ActionList-item-visual ActionList-item-visual--leading"><span
                                        class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input
                                            class="FormControl-checkbox" type="checkbox"
                                            value="true" /></span></span><span class="ActionList-item-label"><svg
                                        class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                        viewBox="0 0 16 16">STRIPPED_SVG_PATHS</svg><span>Text</span></span></span></li>
                        <li class="ActionList-item" role="option"><span class="ActionList-content"><span
                                    class="ActionList-item-visual ActionList-item-visual--leading"><span
                                        class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input
                                            checked class="FormControl-checkbox" type="checkbox"
                                            value="true" /></span></span><span class="ActionList-item-label"><svg
                                        class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                        viewBox="0 0 16 16">STRIPPED_SVG_PATHS</svg><span>Number</span></span></span>
                        </li>
                        <li class="ActionList-item" role="option"><span class="ActionList-content"><span
                                    class="ActionList-item-visual ActionList-item-visual--leading"><span
                                        class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input
                                            class="FormControl-checkbox" type="checkbox"
                                            value="true" /></span></span><span class="ActionList-item-label"><svg
                                        class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                        viewBox="0 0 16 16">STRIPPED_SVG_PATHS</svg><span>Calendar</span></span></span>
                        </li>
                        <li class="ActionList-item" role="option"><span class="ActionList-content"><span
                                    class="ActionList-item-visual ActionList-item-visual--leading"><span
                                        class="FormControl-checkbox-wrap ActionList-item-singleSelectCheckmark"><input
                                            class="FormControl-checkbox" type="checkbox"
                                            value="true" /></span></span><span class="ActionList-item-label"><svg
                                        class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                        viewBox="0 0 16 16">STRIPPED_SVG_PATHS</svg><span>Iteration</span></span></span>
                        </li>
                    </ul>
                </div>
             </div>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "With multiple select" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_menu is_dropdown_caret id="qwerty">
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
             <div data-isfast="" data-prompt="" id="qwerty" phx-hook="Prompt"><label aria-haspopup="true" class="btn"
             for="qwerty-toggle">Select<span class="Counter">2</span>
             <div class="dropdown-caret"></div>
             </label><input aria-hidden="true" id="qwerty-toggle" name="[]"
             onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-touch=""></div>
             <div class="ActionMenu">
             <div aria-role="menu" class="ActionMenu-modal" data-content="">
                <div class="SelectMenu-list">
                    <ul class="ActionList" role="listbox">
                        <li class="ActionList-item" role="option"><span class="ActionList-content"><span
                                    class="ActionList-item-visual ActionList-item-visual--leading"><span
                                        class="FormControl-checkbox-wrap ActionList-item-multiSelectIcon"><input checked
                                            class="FormControl-checkbox" type="checkbox"
                                            value="true" /></span></span><span
                                    class="ActionList-item-label">Option</span></span></li>
                        <li class="ActionList-item" role="option"><span class="ActionList-content"><span
                                    class="ActionList-item-visual ActionList-item-visual--leading"><span
                                        class="FormControl-checkbox-wrap ActionList-item-multiSelectIcon"><input checked
                                            class="FormControl-checkbox" type="checkbox"
                                            value="true" /></span></span><span
                                    class="ActionList-item-label">Option</span></span></li>
                        <li class="ActionList-item" role="option"><span class="ActionList-content"><span
                                    class="ActionList-item-visual ActionList-item-visual--leading"><span
                                        class="FormControl-checkbox-wrap ActionList-item-multiSelectIcon"><input
                                            class="FormControl-checkbox" type="checkbox"
                                            value="true" /></span></span><span
                                    class="ActionList-item-label">Option</span></span></li>
                    </ul>
                </div>
             </div>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: is_aligned_end" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_menu is_aligned_end id="qwerty">
             <:toggle>
               Menu
             </:toggle>
             LIST
           </.action_menu>
           """)
           |> format_html() ==
             """
             <div data-isfast="" data-prompt="" id="qwerty" phx-hook="Prompt"><label aria-haspopup="true" class="btn"
             for="qwerty-toggle">Menu</label><input aria-hidden="true" id="qwerty-toggle" name="[]"
             onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-touch=""></div>
             <div class="ActionMenu pl-aligned-end">
             <div aria-role="menu" class="ActionMenu-modal" data-content="">
                <div class="SelectMenu-list">LIST</div>
             </div>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: is_backdrop" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_menu is_backdrop id="qwerty">
             <:toggle>
               Menu
             </:toggle>
             LIST
           </.action_menu>
           """)
           |> format_html() ==
             """
             <div data-isfast="" data-prompt="" id="qwerty" phx-hook="Prompt"><label aria-haspopup="true" class="btn"
             for="qwerty-toggle">Menu</label><input aria-hidden="true" id="qwerty-toggle" name="[]"
             onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-backdrop="" data-islight=""></div>
             <div data-touch=""></div>
             <div class="ActionMenu">
             <div aria-role="menu" class="ActionMenu-modal" data-content="">
                <div class="SelectMenu-list">LIST</div>
             </div>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: is_dark_backdrop" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_menu is_dark_backdrop id="qwerty">
             <:toggle>
               Menu
             </:toggle>
             LIST
           </.action_menu>
           """)
           |> format_html() ==
             """
             <div data-isfast="" data-prompt="" id="qwerty" phx-hook="Prompt"><label aria-haspopup="true" class="btn"
             for="qwerty-toggle">Menu</label><input aria-hidden="true" id="qwerty-toggle" name="[]"
             onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-backdrop="" data-isdark=""></div>
             <div data-touch=""></div>
             <div class="ActionMenu">
             <div aria-role="menu" class="ActionMenu-modal" data-content="">
                <div class="SelectMenu-list">LIST</div>
             </div>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: is_fast" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_menu id="qwerty" is_fast={false}>
             <:toggle>
               Menu
             </:toggle>
             LIST
           </.action_menu>
           """)
           |> format_html() ==
             """
             <div data-prompt="" id="qwerty" phx-hook="Prompt"><label aria-haspopup="true" class="btn"
             for="qwerty-toggle">Menu</label><input aria-hidden="true" id="qwerty-toggle" name="[]"
             onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-touch=""></div>
             <div class="ActionMenu">
             <div aria-role="menu" class="ActionMenu-modal" data-content="">
                <div class="SelectMenu-list">LIST</div>
             </div>
             </div>
             </div>
             </div>
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
           <.action_menu is_aligned_end menu_theme={@theme_state} id="qwerty">
             <:toggle>
               Menu
             </:toggle>
             LIST
           </.action_menu>
           """)
           |> format_html() ==
             """
             <div data-isfast="" data-prompt="" id="qwerty" phx-hook="Prompt"><label aria-haspopup="true" class="btn"
             for="qwerty-toggle">Menu</label><input aria-hidden="true" id="qwerty-toggle" name="[]"
             onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-touch=""></div>
             <div class="ActionMenu pl-aligned-end">
             <div aria-role="menu" class="ActionMenu-modal" data-color-mode="dark" data-content=""
                data-dark-theme="dark_high_contrast" data-light-theme="light_colorblind">
                <div class="SelectMenu-list">LIST</div>
             </div>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: classes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_menu
             is_dropdown_caret
             id="qwerty"
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
             <div class="action_menu-x my-action-menu" data-isfast="" data-prompt="" id="qwerty" phx-hook="Prompt"><label
             aria-haspopup="true" class="toggle-x my-toggle" for="qwerty-toggle">Menu<div class="dropdown-caret caret-x">
             </div></label><input aria-hidden="true" id="qwerty-toggle" name="[]"
             onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-touch=""></div>
             <div class="ActionMenu menu-x">
             <div aria-role="menu" class="ActionMenu-modal menu_container-x" data-content="">
                <div class="SelectMenu-list menu_list-x">LIST</div>
             </div>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: toggle options (deprecated)" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_menu is_backdrop id="qwerty">
             <:toggle options="{
            didHide: function() {
              document.querySelector('#role-form').dispatchEvent(new Event('submit', {bubbles: true, cancelable: true}));
            }
           }">
               Menu
             </:toggle>
             LIST
           </.action_menu>
           """)
           |> format_html() ==
             """
             <div data-isfast="" data-prompt="" id="qwerty" phx-hook="Prompt"><label aria-haspopup="true" class="btn"
             for="qwerty-toggle">Menu</label><input aria-hidden="true" id="qwerty-toggle" name="[]"
             onchange="window.Prompt &amp;&amp; Prompt.change(this, { didHide: function() { document.querySelector(&#39;#role-form&#39;).dispatchEvent(new Event(&#39;submit&#39;, {bubbles: true, cancelable: true})); } })"
             type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-backdrop="" data-islight=""></div>
             <div data-touch=""></div>
             <div class="ActionMenu">
             <div aria-role="menu" class="ActionMenu-modal" data-content="">
                <div class="SelectMenu-list">LIST</div>
             </div>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: prompt options" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_menu
             is_backdrop
             id="qwerty"
             prompt_options="{
              didHide: function() {
                document.querySelector('#role-form').dispatchEvent(new Event('submit', {bubbles: true, cancelable: true}));
              }
             }"
           >
             <:toggle>
               Menu
             </:toggle>
             LIST
           </.action_menu>
           """)
           |> format_html() ==
             """
             <div data-isfast="" data-prompt="" id="qwerty" phx-hook="Prompt"><label aria-haspopup="true" class="btn"
             for="qwerty-toggle">Menu</label><input aria-hidden="true" id="qwerty-toggle" name="[]"
             onchange="window.Prompt &amp;&amp; Prompt.change(this, { didHide: function() { document.querySelector(&#39;#role-form&#39;).dispatchEvent(new Event(&#39;submit&#39;, {bubbles: true, cancelable: true})); } })"
             type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-backdrop="" data-islight=""></div>
             <div data-touch=""></div>
             <div class="ActionMenu">
             <div aria-role="menu" class="ActionMenu-modal" data-content="">
                <div class="SelectMenu-list">LIST</div>
             </div>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: phx_click_touch" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_menu phx_click_touch="handle_close" id="some-id">
             <:toggle>
               Menu
             </:toggle>
             LIST
           </.action_menu>
           """)
           |> format_html() ==
             """
             <div data-isfast="" data-prompt="" id="some-id" phx-hook="Prompt"><label aria-haspopup="true" class="btn"
             for="some-id-toggle">Menu</label><input aria-hidden="true" id="some-id-toggle" name="[]"
             onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-touch="" phx-click="handle_close"></div>
             <div class="ActionMenu">
             <div aria-role="menu" class="ActionMenu-modal" data-content="">
                <div class="SelectMenu-list">LIST</div>
             </div>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end
end
