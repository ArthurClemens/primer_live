defmodule PrimerLive.TestComponents.DropdownTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Slot: item (various types)" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dropdown>
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
             <details class="dropdown details-reset details-overlay d-inline-block">
             <summary class="btn" aria-haspopup="true">Menu<div class="dropdown-caret"></div>
             </summary>
             <ul class="dropdown-menu dropdown-menu-se">
             <li><a href="#url" class="dropdown-item">href link</a></li>
             <li><a href="#url" data-phx-link="redirect" data-phx-link-state="push" class="dropdown-item">navigate link</a></li>
             <li><a href="#url" data-phx-link="patch" data-phx-link-state="push" class="dropdown-item">patch link</a></li>
             </ul>
             </details>
             """
             |> format_html()
  end

  test "Slot: menu with title" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dropdown>
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
             <details class="dropdown details-reset details-overlay d-inline-block">
             <summary class="btn" aria-haspopup="true">Menu<div class="dropdown-caret"></div>
             </summary>
             <div class="dropdown-menu dropdown-menu-se">
             <div class="dropdown-header">Menu title</div>
             <ul>
             <li><a href="#url" class="dropdown-item">Item 1</a></li>
             <li><a href="#url" class="dropdown-item">Item 2</a></li>
             </ul>
             </div>
             </details>
             """
             |> format_html()
  end

  test "Slot: menu with position" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dropdown>
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
             <details class="dropdown details-reset details-overlay d-inline-block">
             <summary class="btn" aria-haspopup="true">Menu<div class="dropdown-caret"></div>
             </summary>
             <ul class="dropdown-menu dropdown-menu-e">
             <li><a href="#url" class="dropdown-item">Item 1</a></li>
             <li><a href="#url" class="dropdown-item">Item 2</a></li>
             </ul>
             </details>
             """
             |> format_html()
  end

  test "Slot: item" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dropdown>
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
             <details class="dropdown details-reset details-overlay d-inline-block">
             <summary class="btn" aria-haspopup="true">Menu<div class="dropdown-caret"></div>
             </summary>
             <ul class="dropdown-menu dropdown-menu-se">
             <li><a href="#url" class="dropdown-item">Item 1</a></li>
             <li><a href="#url" class="dropdown-item">Item 2</a></li>
             </ul>
             </details>
             """
             |> format_html()
  end

  test "Slot: items with divider" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dropdown>
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
             <details class="dropdown details-reset details-overlay d-inline-block">
             <summary class="btn" aria-haspopup="true">Menu<div class="dropdown-caret"></div>
             </summary>
             <ul class="dropdown-menu dropdown-menu-se">
             <li><a href="#url" class="dropdown-item">Item 1</a></li>
             <li><a href="#url" class="dropdown-item">Item 2</a></li>
             <li class="dropdown-divider" role="separator"></li>
             <li class="dropdown-divider my-divider" role="separator"></li>
             <li><a href="#url" class="dropdown-item">Item 3</a></li>
             </ul>
             </details>
             """
             |> format_html()
  end

  test "Attribute: classes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dropdown
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
             <:toggle class="my-toggle" dir="rtl">Menu</:toggle>
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
             <details class="dropdown details-reset details-overlay d-inline-block dropdown-x my-dropdown">
             <summary dir="rtl" class="toggle-x my-toggle" aria-haspopup="true">Menu<div class="dropdown-caret caret-x"></div>
             </summary>
             <div class="dropdown-menu dropdown-menu-se menu-x">
             <div class="dropdown-header header-x">Menu title</div>
             <ul>
             <li><a href="#url" class="dropdown-item item-x my-item">Item 1</a></li>
             <li><a href="#url" class="dropdown-item item-x">Item 2</a></li>
             <li class="dropdown-divider divider-x my-divider" role="separator"></li>
             <li><a href="#url" class="dropdown-item item-x">Item 3</a></li>
             </ul>
             </div>
             </details>
             """
             |> format_html()
  end

  test "Extra attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dropdown dir="rtl">
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
             <details class="dropdown details-reset details-overlay d-inline-block" dir="rtl">
             <summary class="btn" aria-haspopup="true">Menu<div class="dropdown-caret"></div>
             </summary>
             <ul class="dropdown-menu dropdown-menu-se">
             <li><a href="#url" class="dropdown-item">Item 1</a></li>
             <li><a href="#url" class="dropdown-item">Item 2</a></li>
             </ul>
             </details>
             """
             |> format_html()
  end

  test "Extra attributes: open" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dropdown open>
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
             <details class="dropdown details-reset details-overlay d-inline-block" open>
             <summary class="btn" aria-haspopup="true">Menu<div class="dropdown-caret"></div>
             </summary>
             <ul class="dropdown-menu dropdown-menu-se">
             <li><a href="#url" class="dropdown-item">Item 1</a></li>
             <li><a href="#url" class="dropdown-item">Item 2</a></li>
             </ul>
             </details>
             """
             |> format_html()
  end
end
