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
               Missing link attr
             </:item>
           </.menu>
           """)
           |> format_html() ==
             """
             <nav class="menu" aria-label="Menu">
             <a href="#url" aria-current="page" class="menu-item">href link</a>
             <a href="#url" data-phx-link="redirect" data-phx-link-state="push" class="menu-item">navigate link</a>
             <a href="#url" data-phx-link="patch" data-phx-link-state="push" class="menu-item">patch link</a>
             Not a link
             </nav>
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
             <nav class="menu">
             <a href="#url" aria-current="page" class="menu-item">
             <svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">
             <path fill-rule="evenodd"
             d="M1.5 2.75a.25.25 0 01.25-.25h8.5a.25.25 0 01.25.25v5.5a.25.25 0 01-.25.25h-3.5a.75.75 0 00-.53.22L3.5 11.44V9.25a.75.75 0 00-.75-.75h-1a.25.25 0 01-.25-.25v-5.5zM1.75 1A1.75 1.75 0 000 2.75v5.5C0 9.216.784 10 1.75 10H2v1.543a1.457 1.457 0 002.487 1.03L7.061 10h3.189A1.75 1.75 0 0012 8.25v-5.5A1.75 1.75 0 0010.25 1h-8.5zM14.5 4.75a.25.25 0 00-.25-.25h-.5a.75.75 0 110-1.5h.5c.966 0 1.75.784 1.75 1.75v5.5A1.75 1.75 0 0114.25 12H14v1.543a1.457 1.457 0 01-2.487 1.03L9.22 12.28a.75.75 0 111.06-1.06l2.22 2.22v-2.19a.75.75 0 01.75-.75h1a.25.25 0 00.25-.25v-5.5z">
             </path>
             </svg>
             <span>Conversation</span>
             <span class="Counter">2</span>
             </a>
             <a href="#url" class="menu-item">
             <svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">
             <path fill-rule="evenodd" d="M1.5 8a6.5 6.5 0 1113 0 6.5 6.5 0 01-13 0zM0 8a8 8 0 1116 0A8 8 0 010 8zm11.78-1.72a.75.75 0 00-1.06-1.06L6.75 9.19 5.28 7.72a.75.75 0 00-1.06 1.06l2 2a.75.75 0 001.06 0l4.5-4.5z"></path>
             </svg>
             <span>Done</span>
             <span class="Counter">99</span>
             </a>
             </nav>
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
             <nav id="menu-yyy" class="menu" aria-labelledby="heading-menu-yyy">
             <span class="menu-heading" id="heading-menu-yyy">Menu heading</span>
             <a href="#url" aria-current="page" class="menu-item">Link 1</a>
             <a href="#url" class="menu-item">Link 2</a>
             </nav>
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
             <nav id="menu-xxx" class="menu menu-x my-menu" aria-labelledby="heading-menu-xxx">
             <span class="menu-heading heading-x my-heading" id="heading-menu-xxx">Menu heading</span>
             <a href="#url" aria-current="page" class="menu-item item-x my-item">One</a>
             <a href="#url" class="menu-item item-x">Two</a>
             </nav>
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
             <nav dir="rtl" id="qqq" class="menu" aria-labelledby="heading-qqq">
             <span aria-label="Heading" class="menu-heading" id="heading-qqq">Menu heading</span>
             <a href="#url" aria-label="View One" aria-current="page" class="menu-item">One</a>
             <a href="#url" class="menu-item">Two</a>
             </nav>
             """
             |> format_html()
  end
end
