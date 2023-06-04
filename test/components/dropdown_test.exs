defmodule PrimerLive.TestComponents.DropdownTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Slot: item (various types)" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dropdown id="querty">
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
             <div class="dropdown d-inline-block" data-prompt="" id="querty" phx-hook="Prompt" data-isfast="">
             <label class="btn" aria-haspopup="true" for="querty-toggle">Menu<div class="dropdown-caret"></div>
             </label>
             <input aria-hidden="true" id="querty-toggle" name="[]" onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
              <div data-touch="" onclick="window.Prompt &amp;&amp; Prompt.hide(this)"></div>
             <ul class="dropdown-menu dropdown-menu-se" data-content="" aria-role="menu">
             <li><a href="#url" class="dropdown-item">href link</a></li>
             <li><a href="#url" data-phx-link="redirect" data-phx-link-state="push" class="dropdown-item">navigate link</a></li>
             <li><a href="#url" data-phx-link="patch" data-phx-link-state="push" class="dropdown-item">patch link</a></li>
             </ul>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Slot: menu with title" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dropdown id="querty">
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
             <div class="dropdown d-inline-block" data-prompt="" id="querty" phx-hook="Prompt" data-isfast="">
             <label class="btn" aria-haspopup="true" for="querty-toggle">Menu<div class="dropdown-caret"></div>
             </label>
             <input aria-hidden="true" id="querty-toggle" name="[]" onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
              <div data-touch="" onclick="window.Prompt &amp;&amp; Prompt.hide(this)"></div>
              <div class="dropdown-menu dropdown-menu-se" data-content="" aria-role="menu">
              <div class="dropdown-header">Menu title</div>
              <ul>
              <li><a href="#url" class="dropdown-item">Item 1</a></li>
              <li><a href="#url" class="dropdown-item">Item 2</a></li>
              </ul>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Slot: menu with position" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dropdown id="querty">
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
             <div class="dropdown d-inline-block" data-prompt="" id="querty" phx-hook="Prompt" data-isfast="">
             <label class="btn" aria-haspopup="true" for="querty-toggle">Menu<div class="dropdown-caret"></div>
             </label>
             <input aria-hidden="true" id="querty-toggle" name="[]" onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
              <div data-touch="" onclick="window.Prompt &amp;&amp; Prompt.hide(this)"></div>
             <ul class="dropdown-menu dropdown-menu-e" data-content="" aria-role="menu">
             <li><a href="#url" class="dropdown-item">Item 1</a></li>
             <li><a href="#url" class="dropdown-item">Item 2</a></li>
             </ul>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Slot: item" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dropdown id="querty">
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
             <div class="dropdown d-inline-block" data-prompt="" id="querty" phx-hook="Prompt" data-isfast="">
             <label class="btn" aria-haspopup="true" for="querty-toggle">Menu<div class="dropdown-caret"></div>
             </label>
             <input aria-hidden="true" id="querty-toggle" name="[]" onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
              <div data-touch="" onclick="window.Prompt &amp;&amp; Prompt.hide(this)"></div>
             <ul class="dropdown-menu dropdown-menu-se" data-content="" aria-role="menu">
             <li><a href="#url" class="dropdown-item">Item 1</a></li>
             <li><a href="#url" class="dropdown-item">Item 2</a></li>
             </ul>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Slot: items with divider" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dropdown id="querty">
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
             <div class="dropdown d-inline-block" data-prompt="" id="querty" phx-hook="Prompt" data-isfast="">
             <label class="btn" aria-haspopup="true" for="querty-toggle">Menu<div class="dropdown-caret"></div>
             </label>
             <input aria-hidden="true" id="querty-toggle" name="[]" onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
              <div data-touch="" onclick="window.Prompt &amp;&amp; Prompt.hide(this)"></div>
             <ul class="dropdown-menu dropdown-menu-se" data-content="" aria-role="menu">
             <li><a href="#url" class="dropdown-item">Item 1</a></li>
             <li><a href="#url" class="dropdown-item">Item 2</a></li>
             <li class="dropdown-divider" role="separator"></li>
             <li class="dropdown-divider my-divider" role="separator"></li>
             <li><a href="#url" class="dropdown-item">Item 3</a></li>
             </ul>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: classes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dropdown
             id="querty"
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
             <div class="dropdown d-inline-block dropdown-x my-dropdown" data-prompt="" id="querty" phx-hook="Prompt" data-isfast="">
             <label class="toggle-x my-toggle" aria-haspopup="true" for="querty-toggle">Menu<div class="dropdown-caret caret-x"></div>
             </label>
             <input aria-hidden="true" id="querty-toggle" name="[]" onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-touch="" onclick="window.Prompt &amp;&amp; Prompt.hide(this)"></div>
             <div class="dropdown-menu dropdown-menu-se menu-x" data-content="" aria-role="menu">
             <div class="dropdown-header header-x">Menu title</div>
             <ul>
             <li><a href="#url" class="dropdown-item item-x my-item">Item 1</a></li>
             <li><a href="#url" class="dropdown-item item-x">Item 2</a></li>
             <li class="dropdown-divider divider-x my-divider" role="separator"></li>
             <li><a href="#url" class="dropdown-item item-x">Item 3</a></li>
             </ul>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Extra attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dropdown id="querty" dir="rtl">
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
             <div dir="rtl" class="dropdown d-inline-block" data-prompt="" id="querty" phx-hook="Prompt" data-isfast="">
             <label class="btn" aria-haspopup="true" for="querty-toggle">Menu<div class="dropdown-caret"></div>
             </label>
             <input aria-hidden="true" id="querty-toggle" name="[]" onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-touch="" onclick="window.Prompt &amp;&amp; Prompt.hide(this)"></div>
             <ul class="dropdown-menu dropdown-menu-se" data-content="" aria-role="menu">
             <li><a href="#url" class="dropdown-item">Item 1</a></li>
             <li><a href="#url" class="dropdown-item">Item 2</a></li>
             </ul>
             </div>
             </div>
             """
             |> format_html()
  end
end
