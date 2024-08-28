defmodule PrimerLive.TestComponents.DropdownTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Attribute: is_backdrop" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dropdown id="my-dropdown" is_backdrop>
             <:toggle>Menu</:toggle>
             <:item>item</:item>
             <:item>item</:item>
             <:item>item</:item>
           </.dropdown>
           """)
           |> format_html() ==
             """
             <div class="dropdown d-inline-block" data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dropdown&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:130,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;transition&quot;:[[&quot;duration-130&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isescapable="" data-isfast="" data-open="[[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dropdown&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-dropdown [data-content]&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-dropdown" phx-hook="Prompt"><label aria-haspopup="true" class="btn" for="my-dropdown-toggle" phx-click="[[&quot;dispatch&quot;,{&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;event&quot;:&quot;prompt:toggle&quot;}]]">Menu<div class="dropdown-caret"></div></label><div data-prompt-content=""><div data-backdrop="" data-islight=""></div><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div id="focus-wrap-my-dropdown" phx-hook="Phoenix.FocusWrap" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-dropdown-start" tabindex="0" aria-hidden="true"></span><ul aria-role="menu" class="dropdown-menu dropdown-menu-se" data-content=""><li><a href="#" class="dropdown-item">item</a></li><li><a href="#" class="dropdown-item">item</a></li><li><a href="#" class="dropdown-item">item</a></li></ul><span id="focus-wrap-my-dropdown-end" tabindex="0" aria-hidden="true"></span></div></div></div>
             """
             |> format_html()
  end

  test "Attribute: is_dropdown_caret (false)" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dropdown id="my-dropdown" is_dropdown_caret={false}>
             <:toggle>Menu</:toggle>
             <:item>item</:item>
             <:item>item</:item>
             <:item>item</:item>
           </.dropdown>
           """)
           |> format_html() ==
             """
             <div class="dropdown d-inline-block" data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dropdown&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:130,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;transition&quot;:[[&quot;duration-130&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isescapable="" data-isfast="" data-open="[[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dropdown&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-dropdown [data-content]&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-dropdown" phx-hook="Prompt"><label aria-haspopup="true" class="btn" for="my-dropdown-toggle" phx-click="[[&quot;dispatch&quot;,{&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;event&quot;:&quot;prompt:toggle&quot;}]]">Menu</label><div data-prompt-content=""><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div id="focus-wrap-my-dropdown" phx-hook="Phoenix.FocusWrap" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-dropdown-start" tabindex="0" aria-hidden="true"></span><ul aria-role="menu" class="dropdown-menu dropdown-menu-se" data-content=""><li><a href="#" class="dropdown-item">item</a></li><li><a href="#" class="dropdown-item">item</a></li><li><a href="#" class="dropdown-item">item</a></li></ul><span id="focus-wrap-my-dropdown-end" tabindex="0" aria-hidden="true"></span></div></div></div>
             """
             |> format_html()
  end

  test "Attribute: prompt_options" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dropdown
             id="my-dropdown"
             prompt_options="{
              didHide: function() {
              document.querySelector('#role-form').dispatchEvent(new Event('submit', {bubbles: true, cancelable: true}));
            }
           }"
           >
             <:toggle>Menu</:toggle>
             <:item>item</:item>
             <:item>item</:item>
             <:item>item</:item>
           </.dropdown>
           """)
           |> format_html() ==
             """
             <div class="dropdown d-inline-block" data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dropdown&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:130,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;transition&quot;:[[&quot;duration-130&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isescapable="" data-isfast="" data-open="[[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dropdown&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-dropdown [data-content]&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-dropdown" phx-hook="Prompt" prompt_options="{ didHide: function() { document.querySelector(&#39;#role-form&#39;).dispatchEvent(new Event(&#39;submit&#39;, {bubbles: true, cancelable: true})); } }"><label aria-haspopup="true" class="btn" for="my-dropdown-toggle" phx-click="[[&quot;dispatch&quot;,{&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;event&quot;:&quot;prompt:toggle&quot;}]]">Menu<div class="dropdown-caret"></div></label><div data-prompt-content=""><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div id="focus-wrap-my-dropdown" phx-hook="Phoenix.FocusWrap" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-dropdown-start" tabindex="0" aria-hidden="true"></span><ul aria-role="menu" class="dropdown-menu dropdown-menu-se" data-content=""><li><a href="#" class="dropdown-item">item</a></li><li><a href="#" class="dropdown-item">item</a></li><li><a href="#" class="dropdown-item">item</a></li></ul><span id="focus-wrap-my-dropdown-end" tabindex="0" aria-hidden="true"></span></div></div></div>
             """
             |> format_html()
  end

  test "Slot: item (various types)" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dropdown id="my-dropdown">
             <:toggle>Menu</:toggle>
             <:item href="#url">
               href link
             </:item>
             <:item navigate="#url">
               navigate link
             </:item>
             <:item patch="#url">
               patch link
             </:item>
           </.dropdown>
           """)
           |> format_html() ==
             """
             <div class="dropdown d-inline-block" data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dropdown&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:130,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;transition&quot;:[[&quot;duration-130&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isescapable="" data-isfast="" data-open="[[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dropdown&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-dropdown [data-content]&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-dropdown" phx-hook="Prompt"><label aria-haspopup="true" class="btn" for="my-dropdown-toggle" phx-click="[[&quot;dispatch&quot;,{&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;event&quot;:&quot;prompt:toggle&quot;}]]">Menu<div class="dropdown-caret"></div></label><div data-prompt-content=""><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div id="focus-wrap-my-dropdown" phx-hook="Phoenix.FocusWrap" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-dropdown-start" tabindex="0" aria-hidden="true"></span><ul aria-role="menu" class="dropdown-menu dropdown-menu-se" data-content=""><li><a href="#url" class="dropdown-item">href link</a></li><li><a href="#url" data-phx-link="redirect" data-phx-link-state="push" class="dropdown-item">navigate link</a></li><li><a href="#url" data-phx-link="patch" data-phx-link-state="push" class="dropdown-item">patch link</a></li></ul><span id="focus-wrap-my-dropdown-end" tabindex="0" aria-hidden="true"></span></div></div></div>
             """
             |> format_html()
  end

  test "Slot: menu with title" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dropdown id="my-dropdown">
             <:toggle>Menu</:toggle>
             <:menu title="Menu title" />
             <:item href="#url">
               Item 1
             </:item>
             <:item href="#url">
               Item 2
             </:item>
           </.dropdown>
           """)
           |> format_html() ==
             """
             <div class="dropdown d-inline-block" data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dropdown&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:130,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;transition&quot;:[[&quot;duration-130&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isescapable="" data-isfast="" data-open="[[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dropdown&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-dropdown [data-content]&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-dropdown" phx-hook="Prompt"><label aria-haspopup="true" class="btn" for="my-dropdown-toggle" phx-click="[[&quot;dispatch&quot;,{&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;event&quot;:&quot;prompt:toggle&quot;}]]">Menu<div class="dropdown-caret"></div></label><div data-prompt-content=""><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div aria-role="menu" class="dropdown-menu dropdown-menu-se" data-content=""><div class="dropdown-header">Menu title</div><div id="focus-wrap-my-dropdown" phx-hook="Phoenix.FocusWrap" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-dropdown-start" tabindex="0" aria-hidden="true"></span><ul><li><a href="#url" class="dropdown-item">Item 1</a></li><li><a href="#url" class="dropdown-item">Item 2</a></li></ul><span id="focus-wrap-my-dropdown-end" tabindex="0" aria-hidden="true"></span></div></div></div></div>
             """
             |> format_html()
  end

  test "Slot: menu with position" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dropdown id="my-dropdown">
             <:toggle>Menu</:toggle>
             <:menu position="e" />
             <:item href="#url">
               Item 1
             </:item>
             <:item href="#url">
               Item 2
             </:item>
           </.dropdown>
           """)
           |> format_html() ==
             """
             <div class="dropdown d-inline-block" data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dropdown&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:130,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;transition&quot;:[[&quot;duration-130&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isescapable="" data-isfast="" data-open="[[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dropdown&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-dropdown [data-content]&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-dropdown" phx-hook="Prompt"><label aria-haspopup="true" class="btn" for="my-dropdown-toggle" phx-click="[[&quot;dispatch&quot;,{&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;event&quot;:&quot;prompt:toggle&quot;}]]">Menu<div class="dropdown-caret"></div></label><div data-prompt-content=""><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div id="focus-wrap-my-dropdown" phx-hook="Phoenix.FocusWrap" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-dropdown-start" tabindex="0" aria-hidden="true"></span><ul aria-role="menu" class="dropdown-menu dropdown-menu-e" data-content=""><li><a href="#url" class="dropdown-item">Item 1</a></li><li><a href="#url" class="dropdown-item">Item 2</a></li></ul><span id="focus-wrap-my-dropdown-end" tabindex="0" aria-hidden="true"></span></div></div></div>
             """
             |> format_html()
  end

  test "Slot: item" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dropdown id="my-dropdown">
             <:toggle>Menu</:toggle>
             <:item href="#url">
               Item 1
             </:item>
             <:item href="#url">
               Item 2
             </:item>
           </.dropdown>
           """)
           |> format_html() ==
             """
             <div class="dropdown d-inline-block" data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dropdown&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:130,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;transition&quot;:[[&quot;duration-130&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isescapable="" data-isfast="" data-open="[[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dropdown&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-dropdown [data-content]&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-dropdown" phx-hook="Prompt"><label aria-haspopup="true" class="btn" for="my-dropdown-toggle" phx-click="[[&quot;dispatch&quot;,{&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;event&quot;:&quot;prompt:toggle&quot;}]]">Menu<div class="dropdown-caret"></div></label><div data-prompt-content=""><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div id="focus-wrap-my-dropdown" phx-hook="Phoenix.FocusWrap" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-dropdown-start" tabindex="0" aria-hidden="true"></span><ul aria-role="menu" class="dropdown-menu dropdown-menu-se" data-content=""><li><a href="#url" class="dropdown-item">Item 1</a></li><li><a href="#url" class="dropdown-item">Item 2</a></li></ul><span id="focus-wrap-my-dropdown-end" tabindex="0" aria-hidden="true"></span></div></div></div>
             """
             |> format_html()
  end

  test "Slot: items with divider" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dropdown id="my-dropdown">
             <:toggle>Menu</:toggle>
             <:item href="#url">
               Item 1
             </:item>
             <:item href="#url">
               Item 2
             </:item>
             <:item is_divider />
             <:item is_divider class="my-divider" />
             <:item href="#url">
               Item 3
             </:item>
           </.dropdown>
           """)
           |> format_html() ==
             """
             <div class="dropdown d-inline-block" data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dropdown&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:130,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;transition&quot;:[[&quot;duration-130&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isescapable="" data-isfast="" data-open="[[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dropdown&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-dropdown [data-content]&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-dropdown" phx-hook="Prompt"><label aria-haspopup="true" class="btn" for="my-dropdown-toggle" phx-click="[[&quot;dispatch&quot;,{&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;event&quot;:&quot;prompt:toggle&quot;}]]">Menu<div class="dropdown-caret"></div></label><div data-prompt-content=""><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div id="focus-wrap-my-dropdown" phx-hook="Phoenix.FocusWrap" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-dropdown-start" tabindex="0" aria-hidden="true"></span><ul aria-role="menu" class="dropdown-menu dropdown-menu-se" data-content=""><li><a href="#url" class="dropdown-item">Item 1</a></li><li><a href="#url" class="dropdown-item">Item 2</a></li><li class="dropdown-divider" role="separator"></li><li class="dropdown-divider my-divider" role="separator"></li><li><a href="#url" class="dropdown-item">Item 3</a></li></ul><span id="focus-wrap-my-dropdown-end" tabindex="0" aria-hidden="true"></span></div></div></div>
             """
             |> format_html()
  end

  test "Attribute: classes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dropdown
             id="my-dropdown"
             class="my-dropdown"
             classes={
               %{
                 dropdown: "dropdown-x",
                 toggle: "toggle-x",
                 caret: "caret-x",
                 menu: "menu-x",
                 item: "item-x",
                 divider: "divider-x",
                 header: "header-x"
               }
             }
           >
             <:toggle class="my-toggle">Menu</:toggle>
             <:menu title="Menu title" />
             <:item href="#url" class="my-item">
               Item 1
             </:item>
             <:item href="#url">
               Item 2
             </:item>
             <:item is_divider class="my-divider" />
             <:item href="#url">
               Item 3
             </:item>
           </.dropdown>
           """)
           |> format_html() ==
             """
             <div class="dropdown d-inline-block dropdown-x my-dropdown" data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dropdown&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:130,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;transition&quot;:[[&quot;duration-130&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isescapable="" data-isfast="" data-open="[[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dropdown&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-dropdown [data-content]&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-dropdown" phx-hook="Prompt"><label aria-haspopup="true" class="toggle-x my-toggle" for="my-dropdown-toggle" phx-click="[[&quot;dispatch&quot;,{&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;event&quot;:&quot;prompt:toggle&quot;}]]">Menu<div class="dropdown-caret caret-x"></div></label><div data-prompt-content=""><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div aria-role="menu" class="dropdown-menu dropdown-menu-se menu-x" data-content=""><div class="dropdown-header header-x">Menu title</div><div id="focus-wrap-my-dropdown" phx-hook="Phoenix.FocusWrap" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-dropdown-start" tabindex="0" aria-hidden="true"></span><ul><li><a href="#url" class="dropdown-item item-x my-item">Item 1</a></li><li><a href="#url" class="dropdown-item item-x">Item 2</a></li><li class="dropdown-divider divider-x my-divider" role="separator"></li><li><a href="#url" class="dropdown-item item-x">Item 3</a></li></ul><span id="focus-wrap-my-dropdown-end" tabindex="0" aria-hidden="true"></span></div></div></div></div>
             """
             |> format_html()
  end

  test "Extra attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dropdown id="my-dropdown" dir="rtl">
             <:toggle>Menu</:toggle>
             <:item href="#url">
               Item 1
             </:item>
             <:item href="#url">
               Item 2
             </:item>
           </.dropdown>
           """)
           |> format_html() ==
             """
             <div class="dropdown d-inline-block" data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dropdown&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:130,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;transition&quot;:[[&quot;duration-130&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isescapable="" data-isfast="" data-open="[[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dropdown&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-dropdown [data-content]&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" dir="rtl" id="my-dropdown" phx-hook="Prompt"><label aria-haspopup="true" class="btn" for="my-dropdown-toggle" phx-click="[[&quot;dispatch&quot;,{&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;event&quot;:&quot;prompt:toggle&quot;}]]">Menu<div class="dropdown-caret"></div></label><div data-prompt-content=""><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div id="focus-wrap-my-dropdown" phx-hook="Phoenix.FocusWrap" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dropdown&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-dropdown-start" tabindex="0" aria-hidden="true"></span><ul aria-role="menu" class="dropdown-menu dropdown-menu-se" data-content=""><li><a href="#url" class="dropdown-item">Item 1</a></li><li><a href="#url" class="dropdown-item">Item 2</a></li></ul><span id="focus-wrap-my-dropdown-end" tabindex="0" aria-hidden="true"></span></div></div></div>
             """
             |> format_html()
  end
end
