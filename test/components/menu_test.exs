defmodule PrimerLive.Components.MenuTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Slot: item links" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.menu aria_label="Menu">
             <:item href="#url" is_selected>
               href link
             </:item>
             <:item navigate="#url">
               navigate link
             </:item>
             <:item patch="#url">
               patch link
             </:item>
             <:item>
               Other content
             </:item>
           </.menu>
           """)
           |> format_html() ==
             """
             <nav aria-label="Menu" class="menu"><a href="#url" class="menu-item" aria-current="page">href link</a><a href="#url"
             data-phx-link="redirect" data-phx-link-state="push" class="menu-item">navigate link</a><a href="#url"
             data-phx-link="patch" data-phx-link-state="push" class="menu-item">patch link</a>Other content</nav>
             """
             |> format_html()
  end

  test "Slot: item links (with various content)" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.menu>
             <:item href="#url" is_selected>
               <.octicon name="comment-discussion-16" />
               <span>Conversation</span>
               <.counter>2</.counter>
             </:item>
             <:item href="#url">
               <.octicon name="check-circle-16" />
               <span>Done</span>
               <.counter>99</.counter>
             </:item>
           </.menu>
           """)
           |> format_html() ==
             """
             <nav class="menu"><a href="#url" class="menu-item" aria-current="page"><svg class="octicon"
             xmlns="http://www.w3.org/2000/svg" width="16" height="16"
             viewBox="0 0 16 16">STRIPPED_SVG_PATHS</svg><span>Conversation</span><span class="Counter">2</span></a><a
             href="#url" class="menu-item"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16"
             viewBox="0 0 16 16">STRIPPED_SVG_PATHS</svg><span>Done</span><span class="Counter">99</span></a></nav>
             """
             |> format_html()
  end

  test "Slot: heading" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.menu id="menu-yyy">
             <:item href="#url" is_selected>
               Link 1
             </:item>
             <:item href="#url">
               Link 2
             </:item>
             <:heading>Menu heading</:heading>
           </.menu>
           """)
           |> format_html() ==
             """
             <nav aria-labelledby="heading-menu-yyy" class="menu" id="menu-yyy"><span class="menu-heading" id="heading-menu-yyy">Menu
             heading</span><a href="#url" class="menu-item" aria-current="page">Link 1</a><a href="#url" class="menu-item">Link
             2</a></nav>
             """
             |> format_html()
  end

  test "Classes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.menu
             classes={
               %{
                 menu: "menu-x",
                 item: "item-x",
                 heading: "heading-x"
               }
             }
             class="my-menu"
             id="menu-xxx"
           >
             <:item href="#url" is_selected class="my-item">
               One
             </:item>
             <:item href="#url">
               Two
             </:item>
             <:heading class="my-heading">
               Menu heading
             </:heading>
           </.menu>
           """)
           |> format_html() ==
             """
             <nav aria-labelledby="heading-menu-xxx" class="menu menu-x my-menu" id="menu-xxx"><span
             class="menu-heading heading-x my-heading" id="heading-menu-xxx">Menu heading</span><a href="#url"
             class="menu-item item-x my-item" aria-current="page">One</a><a href="#url" class="menu-item item-x">Two</a></nav>
             """
             |> format_html()
  end

  test "Extra attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.menu dir="rtl" id="qqq">
             <:item href="#url" is_selected aria-label="View One">
               One
             </:item>
             <:item href="#url">
               Two
             </:item>
             <:heading aria-label="Heading">
               Menu heading
             </:heading>
           </.menu>
           """)
           |> format_html() ==
             """
             <nav aria-labelledby="heading-qqq" class="menu" dir="rtl" id="qqq"><span aria-label="Heading" class="menu-heading"
             id="heading-qqq">Menu heading</span><a href="#url" class="menu-item" aria-label="View One"
             aria-current="page">One</a><a href="#url" class="menu-item">Two</a></nav>
             """
             |> format_html()
  end
end
