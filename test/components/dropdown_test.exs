defmodule PrimerLive.TestComponents.DropdownTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Slot: toggle" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dropdown>
             <:toggle>Menu</:toggle>
             <:item :let={classes}>
               <.link href="#url" class={classes.item}>Item 1</.link>
             </:item>
             <:item :let={classes}>
               <.link href="#url" class={classes.item}>Item 2</.link>
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

  test "Slot: menu with title" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dropdown>
             <:toggle>Menu</:toggle>
             <:menu title="Menu title" />
             <:item :let={classes}>
               <.link href="#url" class={classes.item}>Item 1</.link>
             </:item>
             <:item :let={classes}>
               <.link href="#url" class={classes.item}>Item 2</.link>
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
    assigns = []

    assert rendered_to_string(~H"""
           <.dropdown>
             <:toggle>Menu</:toggle>
             <:menu position="e" />
             <:item :let={classes}>
               <.link href="#url" class={classes.item}>Item 1</.link>
             </:item>
             <:item :let={classes}>
               <.link href="#url" class={classes.item}>Item 2</.link>
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
    assigns = []

    assert rendered_to_string(~H"""
           <.dropdown>
             <:toggle>Menu</:toggle>
             <:item :let={classes}>
               <.link href="#url" class={classes.item}>Item 1</.link>
             </:item>
             <:item :let={classes}>
               <.link href="#url" class={classes.item}>Item 2</.link>
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
    assigns = []

    assert rendered_to_string(~H"""
           <.dropdown>
             <:toggle>Menu</:toggle>
             <:item :let={classes}>
               <.link href="#url" class={classes.item}>Item 1</.link>
             </:item>
             <:item :let={classes}>
               <.link href="#url" class={classes.item}>Item 2</.link>
             </:item>
             <:item is_divider />
             <:item is_divider class="my-divider" />
             <:item :let={classes}>
               <.link href="#url" class={classes.item}>Item 3</.link>
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
    assigns = []

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
             <:toggle class="my-toggle">Menu</:toggle>
             <:menu title="Menu title" />
             <:item :let={classes} class="my-item">
               <.link href="#url" class={classes.item}>Item 1</.link>
             </:item>
             <:item :let={classes}>
               <.link href="#url" class={classes.item}>Item 2</.link>
             </:item>
             <:item is_divider class="my-divider" />
             <:item :let={classes}>
               <.link href="#url" class={classes.item}>Item 3</.link>
             </:item>
           </.dropdown>
           """)
           |> format_html() ==
             """
             <details class="dropdown details-reset details-overlay d-inline-block dropdown-x my-dropdown">
             <summary class="toggle-x my-toggle" aria-haspopup="true">Menu<div class="dropdown-caret caret-x"></div>
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
    assigns = []

    assert rendered_to_string(~H"""
           <.dropdown dir="rtl">
             <:toggle>Menu</:toggle>
             <:item :let={classes}>
               <.link href="#url" class={classes.item}>Item 1</.link>
             </:item>
             <:item :let={classes}>
               <.link href="#url" class={classes.item}>Item 2</.link>
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
    assigns = []

    assert rendered_to_string(~H"""
           <.dropdown open>
             <:toggle>Menu</:toggle>
             <:item :let={classes}>
               <.link href="#url" class={classes.item}>Item 1</.link>
             </:item>
             <:item :let={classes}>
               <.link href="#url" class={classes.item}>Item 2</.link>
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
