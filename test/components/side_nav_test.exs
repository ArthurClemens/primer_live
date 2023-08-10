defmodule PrimerLive.Components.SideNavTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Slot: item links" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.side_nav aria_label="Menu">
             <:item href="#url" is_selected>
               href link
             </:item>
             <:item navigate="#url">
               navigate link
             </:item>
             <:item patch="#url">
               patch link
             </:item>
           </.side_nav>
           """)
           |> format_html() ==
             """
             <nav aria-label="Menu" class="SideNav"><a href="#url" class="SideNav-item" aria-current="page">href link</a><a
             href="#url" data-phx-link="redirect" data-phx-link-state="push" class="SideNav-item">navigate link</a><a href="#url"
             data-phx-link="patch" data-phx-link-state="push" class="SideNav-item">patch link</a></nav>
             """
             |> format_html()
  end

  test "Slot: item links (with various content)" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.side_nav>
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
             <:item href="#url">
               <h5>With a heading</h5>
               <span>and some longer description</span>
             </:item>
           </.side_nav>
           """)
           |> format_html() ==
             """
             <nav class="SideNav"><a href="#url" class="SideNav-item" aria-current="page"><svg class="octicon"
             xmlns="http://www.w3.org/2000/svg" width="16" height="16"
             viewBox="0 0 16 16">STRIPPED_SVG_PATHS</svg><span>Conversation</span><span class="Counter">2</span></a><a
             href="#url" class="SideNav-item"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16"
             viewBox="0 0 16 16">STRIPPED_SVG_PATHS</svg><span>Done</span><span class="Counter">99</span></a><a href="#url"
             class="SideNav-item">
             <h5>With a heading</h5><span>and some longer description</span>
             </a></nav>
             """
             |> format_html()
  end

  test "Sub navigation" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.side_nav is_sub_nav>
             <:item href="#url" is_selected>
               Item 1
             </:item>
             <:item href="#url">
               Item 2
             </:item>
             <:item href="#url">
               Item 3
             </:item>
           </.side_nav>
           """)
           |> format_html() ==
             """
             <nav class="SideNav"><a href="#url" class="SideNav-subItem" aria-current="page">Item 1</a><a href="#url"
             class="SideNav-subItem">Item 2</a><a href="#url" class="SideNav-subItem">Item 3</a></nav>
             """
             |> format_html()
  end

  test "Nested item" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.side_nav>
             <:item href="#url" is_selected>
               Item 1
             </:item>
             <:item navigate="#url">
               Item 2
             </:item>
             <:item>
               <.side_nav is_sub_nav class="border-top py-3" style="padding-left: 16px">
                 <:item href="#url" is_selected>
                   Sub item 1
                 </:item>
                 <:item navigate="#url">
                   Sub item 2
                 </:item>
               </.side_nav>
             </:item>
             <:item navigate="#url">
               Item 3
             </:item>
           </.side_nav>
           """)
           |> format_html() ==
             """
             <nav class="SideNav"><a href="#url" class="SideNav-item" aria-current="page">Item 1</a><a href="#url"
             data-phx-link="redirect" data-phx-link-state="push" class="SideNav-item">Item 2</a>
             <nav class="SideNav border-top py-3" style="padding-left: 16px"><a href="#url" class="SideNav-subItem"
             aria-current="page">Sub item 1</a><a href="#url" data-phx-link="redirect" data-phx-link-state="push"
             class="SideNav-subItem">Sub item 2</a></nav><a href="#url" data-phx-link="redirect" data-phx-link-state="push"
             class="SideNav-item">Item 3</a>
             </nav>
             """
             |> format_html()
  end

  test "Attribute: is_border" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.side_nav is_border>
             <:item href="#url" is_selected class="my-item">
               One
             </:item>
             <:item href="#url">
               Two
             </:item>
           </.side_nav>
           """)
           |> format_html() ==
             """
             <nav class="SideNav border"><a href="#url" class="SideNav-item my-item" aria-current="page">One</a><a href="#url"
             class="SideNav-item">Two</a></nav>
             """
             |> format_html()
  end

  test "Classes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.side_nav
             classes={
               %{
                 side_nav: "side_nav-x",
                 item: "item-x",
                 sub_item: "sub-item-x"
               }
             }
             class="my-side_nav"
           >
             <:item href="#url" is_selected class="my-item">
               One
             </:item>
             <:item href="#url">
               Two
             </:item>
           </.side_nav>
           <.side_nav
             is_sub_nav
             classes={
               %{
                 side_nav: "side_nav-x",
                 item: "item-x",
                 sub_item: "sub-item-x"
               }
             }
             class="my-side_nav"
           >
             <:item href="#url" is_selected class="my-item">
               One
             </:item>
             <:item href="#url">
               Two
             </:item>
           </.side_nav>
           """)
           |> format_html() ==
             """
             <nav class="SideNav side_nav-x my-side_nav"><a href="#url" class="SideNav-item item-x my-item"
             aria-current="page">One</a><a href="#url" class="SideNav-item item-x">Two</a></nav>
             <nav class="SideNav side_nav-x my-side_nav"><a href="#url" class="SideNav-subItem sub-item-x my-item"
             aria-current="page">One</a><a href="#url" class="SideNav-subItem sub-item-x">Two</a></nav>
             """
             |> format_html()
  end

  test "Extra attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.side_nav aria_label="Topics navigation" dir="rtl">
             <:item href="#url" is_selected aria-label="View One">
               One
             </:item>
             <:item href="#url">
               Two
             </:item>
           </.side_nav>
           """)
           |> format_html() ==
             """
             <nav aria-label="Topics navigation" class="SideNav" dir="rtl"><a href="#url" class="SideNav-item" aria-label="View One"
             aria-current="page">One</a><a href="#url" class="SideNav-item">Two</a></nav>
             """
             |> format_html()
  end
end
