defmodule PrimerLive.Components.UnderlineNavTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Slot: item links" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.underline_nav aria_label="Tabs">
             <:item href="#url" is_selected>
               href link
             </:item>
             <:item navigate="#url">
               navigate link
             </:item>
             <:item patch="#url">
               patch link
             </:item>
           </.underline_nav>
           """)
           |> format_html() ==
             """
             <nav class="UnderlineNav">
             <div class="UnderlineNav-body" role="tablist">
             <a href="#url" aria-current="page" aria-selected="true" class="UnderlineNav-item" role="tab">href link</a>
             <a href="#url" data-phx-link="redirect" data-phx-link-state="push" class="UnderlineNav-item" role="tab">navigate link</a>
             <a href="#url" data-phx-link="patch" data-phx-link-state="push" class="UnderlineNav-item" role="tab">patch link</a>
             </div>
             </nav>
             """
             |> format_html()
  end

  test "Slot: item links (with various content)" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.underline_nav>
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
           </.underline_nav>
           """)
           |> format_html() ==
             """
             <nav class="UnderlineNav">
             <div class="UnderlineNav-body" role="tablist">
             <a href="#url" aria-current="page" aria-selected="true" class="UnderlineNav-item" role="tab">
             <svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M1.5 2.75a.25.25 0 01.25-.25h8.5a.25.25 0 01.25.25v5.5a.25.25 0 01-.25.25h-3.5a.75.75 0 00-.53.22L3.5 11.44V9.25a.75.75 0 00-.75-.75h-1a.25.25 0 01-.25-.25v-5.5zM1.75 1A1.75 1.75 0 000 2.75v5.5C0 9.216.784 10 1.75 10H2v1.543a1.457 1.457 0 002.487 1.03L7.061 10h3.189A1.75 1.75 0 0012 8.25v-5.5A1.75 1.75 0 0010.25 1h-8.5zM14.5 4.75a.25.25 0 00-.25-.25h-.5a.75.75 0 110-1.5h.5c.966 0 1.75.784 1.75 1.75v5.5A1.75 1.75 0 0114.25 12H14v1.543a1.457 1.457 0 01-2.487 1.03L9.22 12.28a.75.75 0 111.06-1.06l2.22 2.22v-2.19a.75.75 0 01.75-.75h1a.25.25 0 00.25-.25v-5.5z"></path></svg>
             <span>Conversation</span>
             <span class="Counter">2</span>
             </a>
             <a href="#url" class="UnderlineNav-item" role="tab">
             <svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M1.5 8a6.5 6.5 0 1113 0 6.5 6.5 0 01-13 0zM0 8a8 8 0 1116 0A8 8 0 010 8zm11.78-1.72a.75.75 0 00-1.06-1.06L6.75 9.19 5.28 7.72a.75.75 0 00-1.06 1.06l2 2a.75.75 0 001.06 0l4.5-4.5z"></path></svg>
             <span>Done</span>
             <span class="Counter">99</span>
             </a>
             </div>
             </nav>
             """
             |> format_html()
  end

  test "Slot: item buttons" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.underline_nav aria_label="Tabs">
             <:item is_selected>
               Button 1
             </:item>
             <:item>
               Button 2
             </:item>
           </.underline_nav>
           """)
           |> format_html() ==
             """
             <nav class="UnderlineNav">
             <div class="UnderlineNav-body" role="tablist">
             <button class="UnderlineNav-item" role="tab" aria-selected="true" aria-current="page">Button 1</button>
             <button class="UnderlineNav-item" role="tab">Button 2</button>
             </div>
             </nav>
             """
             |> format_html()
  end

  test "Slot: position_end" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.underline_nav>
             <:item href="#url" is_selected>
               One
             </:item>
             <:item href="#url">
               Two
             </:item>
             <:position_end>
               <a class="btn btn-sm" href="#url" role="button">Button</a>
             </:position_end>
           </.underline_nav>
           """)
           |> format_html() ==
             """
             <nav class="UnderlineNav">
             <div class="UnderlineNav-body" role="tablist">
             <a href="#url" aria-current="page" aria-selected="true" class="UnderlineNav-item" role="tab">One</a>
             <a href="#url" class="UnderlineNav-item" role="tab">Two</a>
             </div>
             <div class="UnderlineNav-actions"><a class="btn btn-sm" href="#url" role="button">Button</a></div>
             </nav>
             """
             |> format_html()
  end

  test "Attribute: is_container_width" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.underline_nav
             is_container_width
             classes={
               %{
                 container: "container-sm"
               }
             }
           >
             <:item href="#url" is_selected>
               One
             </:item>
             <:item href="#url">
               Two
             </:item>
           </.underline_nav>
           """)
           |> format_html() ==
             """
             <nav class="UnderlineNav UnderlineNav--full">
             <div class="UnderlineNav-container container-sm">
             <div class="UnderlineNav-body" role="tablist">
             <a href="#url" aria-current="page" aria-selected="true" class="UnderlineNav-item" role="tab">One</a>
             <a href="#url" class="UnderlineNav-item" role="tab">Two</a>
             </div>
             </div>
             </nav>
             """
             |> format_html()
  end

  test "Attribute: is_reversed" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.underline_nav is_reversed>
             <:item href="#url" is_selected>
               One
             </:item>
             <:item href="#url">
               Two
             </:item>
             <:position_end>
               <a class="btn btn-sm" href="#url" role="button">Button</a>
             </:position_end>
           </.underline_nav>
           """)
           |> format_html() ==
             """
             <nav class="UnderlineNav UnderlineNav--right">
             <div class="UnderlineNav-actions">
             <a class="btn btn-sm" href="#url" role="button">Button</a>
             </div>
             <div class="UnderlineNav-body" role="tablist">
             <a href="#url" aria-current="page" aria-selected="true" class="UnderlineNav-item" role="tab">One</a>
             <a href="#url" class="UnderlineNav-item" role="tab">Two</a>
             </div>
             </nav>
             """
             |> format_html()
  end

  test "Classes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.underline_nav
             classes={
               %{
                 underline_nav: "underline_nav-x",
                 body: "body-x",
                 container: "container-x",
                 tab: "tab-x",
                 position_end: "position_end-x"
               }
             }
             is_container_width
             class="my-underline_nav"
           >
             <:item href="#url" is_selected class="my-tab">
               One
             </:item>
             <:item href="#url">
               Two
             </:item>
             <:position_end class="my-position-end">
               Actions here
             </:position_end>
           </.underline_nav>
           """)
           |> format_html() ==
             """
             <nav class="UnderlineNav UnderlineNav--full underline_nav-x my-underline_nav">
             <div class="UnderlineNav-container container-x">
             <div class="UnderlineNav-body body-x" role="tablist">
             <a href="#url" aria-current="page" aria-selected="true" class="UnderlineNav-item tab-x my-tab" role="tab">One</a>
             <a href="#url" class="UnderlineNav-item tab-x" role="tab">Two</a>
             </div>
             <div class="UnderlineNav-actions position_end-x my-position-end">Actions here</div>
             </div>
             </nav>
             """
             |> format_html()
  end

  test "Extra attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.underline_nav aria_label="Topics navigation" dir="rtl">
             <:item href="#url" is_selected aria-label="View One">
               One
             </:item>
             <:item href="#url">
               Two
             </:item>
             <:position_end aria-label="Actions">
               Actions here
             </:position_end>
           </.underline_nav>
           """)
           |> format_html() ==
             """
             <nav class="UnderlineNav" dir="rtl">
             <div class="UnderlineNav-body" role="tablist">
             <a href="#url" aria-current="page" aria-label="View One" aria-selected="true" class="UnderlineNav-item" role="tab">One</a>
             <a href="#url" class="UnderlineNav-item" role="tab">Two</a>
             </div>
             <div aria-label="Actions" class="UnderlineNav-actions">Actions here</div>
             </nav>
             """
             |> format_html()
  end
end
