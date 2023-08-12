defmodule PrimerLive.TestComponents.HeaderTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Without attributes or slots, ignores any other content" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.header>
             Content
           </.header>
           """)
           |> format_html() ==
             """
             <div class="Header"></div>
             """
             |> format_html()
  end

  test "Slot: item" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.header>
             <:item>Item 1</:item>
             <:item>Item 2</:item>
             <:item>Item 3</:item>
           </.header>
           """)
           |> format_html() ==
             """
             <div class="Header">
             <div class="Header-item">Item 1</div>
             <div class="Header-item">Item 2</div>
             <div class="Header-item">Item 3</div>
             </div>
             """
             |> format_html()
  end

  test "Slot: item with attribute is_full" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.header>
             <:item is_full>Item</:item>
           </.header>
           """)
           |> format_html() ==
             """
             <div class="Header">
             <div class="Header-item Header-item--full">Item</div>
             </div>
             """
             |> format_html()
  end

  test "Slot: item with links" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.header>
             <:item :let={classes}>
               <.link href="/" class={classes.link}>Regular anchor link</.link>
             </:item>
             <:item :let={classes}>
               <.link navigate="/" class={[classes.link, "underline"]}>Home</.link>
             </:item>
           </.header>
           """)
           |> format_html() ==
             """
             <div class="Header">
             <div class="Header-item"><a href="/" class="Header-link">Regular anchor link</a></div>
             <div class="Header-item"><a href="/" data-phx-link="redirect" data-phx-link-state="push"
             class="Header-link underline">Home</a></div>
             </div>
             """
             |> format_html()
  end

  test "Slot: item with input" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.header>
             <:item :let={classes}>
               <.text_input form={:user} field={:first_name} type="search" class={classes.input} />
             </:item>
           </.header>
           """)
           |> format_html() ==
             """
             <div class="Header">
             <div class="Header-item">
             <input class="FormControl-input FormControl-medium Header-input" id="user_first_name" name="user[first_name]" type="search" />
             </div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: classes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.header
             class="my-header"
             classes={
               %{
                 header: "header-x",
                 item: "item-x",
                 link: "link-x"
               }
             }
           >
             <:item class="my-item">Item</:item>
             <:item is_full>Full item</:item>
             <:item :let={classes}>
               <.link navigate="/" class={[classes.link, "underline"]}>Home</.link>
             </:item>
           </.header>
           """)
           |> format_html() ==
             """
             <div class="Header header-x my-header">
             <div class="Header-item item-x my-item">Item</div>
             <div class="Header-item Header-item--full item-x">Full item</div>
             <div class="Header-item item-x"><a href="/" data-phx-link="redirect" data-phx-link-state="push"
             class="Header-link link-x underline">Home</a></div>
             </div>
             """
             |> format_html()
  end

  test "Extra attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.header dir="rtl">
             <:item aria-disabled={true}>Item</:item>
           </.header>
           """)
           |> format_html() ==
             """
             <div class="Header" dir="rtl">
             <div aria-disabled class="Header-item">Item</div>
             </div>
             """
             |> format_html()
  end
end
