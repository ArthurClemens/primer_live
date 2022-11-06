defmodule PrimerLive.Components.TabnavTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Slot: item links" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.tabnav aria_label="Tabs">
             <:item href="#url" is_selected>
               href link
             </:item>
             <:item navigate="#url">
               navigate link
             </:item>
             <:item patch="#url">
               patch link
             </:item>
           </.tabnav>
           """)
           |> format_html() ==
             """
             <div class="tabnav">
             <nav class="tabnav-tabs" aria-label="Tabs">
             <a href="#url" aria-current="page" aria-selected="true" class="tabnav-tab" role="tab">href link</a>
             <a href="#url" data-phx-link="redirect" data-phx-link-state="push" class="tabnav-tab" role="tab">navigate link</a>
             <a href="#url" data-phx-link="patch" data-phx-link-state="push" class="tabnav-tab" role="tab">patch link</a>
             </nav>
             </div>
             """
             |> format_html()
  end

  test "Slot: item links (with various content)" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.tabnav>
             <:item href="#url" is_selected>
               <.octicon name="comment-discussion-16" />
               <span>Conversation</span>
               <span class="Counter">2</span>
             </:item>
             <:item href="#url">
               <.octicon name="check-circle-16" />
               <span>Done</span>
               <span class="Counter">99</span>
             </:item>
           </.tabnav>
           """)
           |> format_html() ==
             """
             <div class="tabnav">
             <nav class="tabnav-tabs">
             <a href="#url" aria-current="page" aria-selected="true" class="tabnav-tab" role="tab">
             <svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M1.5 2.75a.25.25 0 01.25-.25h8.5a.25.25 0 01.25.25v5.5a.25.25 0 01-.25.25h-3.5a.75.75 0 00-.53.22L3.5 11.44V9.25a.75.75 0 00-.75-.75h-1a.25.25 0 01-.25-.25v-5.5zM1.75 1A1.75 1.75 0 000 2.75v5.5C0 9.216.784 10 1.75 10H2v1.543a1.457 1.457 0 002.487 1.03L7.061 10h3.189A1.75 1.75 0 0012 8.25v-5.5A1.75 1.75 0 0010.25 1h-8.5zM14.5 4.75a.25.25 0 00-.25-.25h-.5a.75.75 0 110-1.5h.5c.966 0 1.75.784 1.75 1.75v5.5A1.75 1.75 0 0114.25 12H14v1.543a1.457 1.457 0 01-2.487 1.03L9.22 12.28a.75.75 0 111.06-1.06l2.22 2.22v-2.19a.75.75 0 01.75-.75h1a.25.25 0 00.25-.25v-5.5z"></path></svg>
             <span>Conversation</span>
             <span class="Counter">2</span>
             </a>
             <a href="#url" class="tabnav-tab" role="tab">
             <svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M1.5 8a6.5 6.5 0 1113 0 6.5 6.5 0 01-13 0zM0 8a8 8 0 1116 0A8 8 0 010 8zm11.78-1.72a.75.75 0 00-1.06-1.06L6.75 9.19 5.28 7.72a.75.75 0 00-1.06 1.06l2 2a.75.75 0 001.06 0l4.5-4.5z"></path></svg>
             <span>Done</span>
             <span class="Counter">99</span>
             </a>
             </nav>
             </div>
             """
             |> format_html()
  end

  test "Slot: item buttons" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.tabnav aria_label="Tabs">
             <:item is_selected>
               Button 1
             </:item>
             <:item>
               Button 2
             </:item>
           </.tabnav>
           """)
           |> format_html() ==
             """
             <div class="tabnav">
             <nav class="tabnav-tabs" aria-label="Tabs">
             <button class="tabnav-tab" role="tab" aria-selected="true" aria-current="page">Button 1</button>
             <button class="tabnav-tab" role="tab">Button 2</button>
             </nav>
             </div>
             """
             |> format_html()
  end

  test "Slot: position_end" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.tabnav>
             <:item href="#url" is_selected>
               One
             </:item>
             <:item href="#url">
               Two
             </:item>
             <:item href="#url">
               Three
             </:item>
             <:position_end>
               <a class="btn btn-sm" href="#url" role="button">Button</a>
             </:position_end>
           </.tabnav>
           """)
           |> format_html() ==
             """
             <div class="tabnav">
             <div class="float-right">
             <a class="btn btn-sm" href="#url" role="button">Button</a>
             </div>
             <nav class="tabnav-tabs">
             <a href="#url" aria-current="page" aria-selected="true" class="tabnav-tab" role="tab">One</a><a href="#url" class="tabnav-tab" role="tab">Two</a>
             <a href="#url" class="tabnav-tab" role="tab">Three</a>
             </nav>
             </div>
             """
             |> format_html()
  end

  test "Slot: position_end, is_extra" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.tabnav aria_label="Tabs">
             <:item href="#url" is_selected>
               One
             </:item>
             <:item href="#url">
               Two
             </:item>
             <:item href="#url">
               Three
             </:item>
             <:position_end is_extra>
               Tabnav widget text here.
             </:position_end>
           </.tabnav>
           """)
           |> format_html() ==
             """
             <div class="tabnav">
             <div class="float-right tabnav-extra">Tabnav widget text here.</div>
             <nav class="tabnav-tabs" aria-label="Tabs">
             <a href="#url" aria-current="page" aria-selected="true" class="tabnav-tab" role="tab">One</a>
             <a href="#url" class="tabnav-tab" role="tab">Two</a><a href="#url" class="tabnav-tab" role="tab">Three</a>
             </nav>
             </div>
             """
             |> format_html()
  end

  test "Classes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.tabnav
             classes={
               %{
                 tabnav: "tabnav-x",
                 nav: "nav-x",
                 tab: "tab-x",
                 position_end: "position_end-x"
               }
             }
             class="my-tabnav"
           >
             <:item href="#url" is_selected class="my-tab">
               One
             </:item>
             <:item href="#url">
               Two
             </:item>
             <:position_end class="my-position-end">
               Tabnav widget text here.
             </:position_end>
           </.tabnav>
           """)
           |> format_html() ==
             """
             <div class="tabnav tabnav-x my-tabnav">
             <div class="float-right position_end-x my-position-end">Tabnav widget text here.</div>
             <nav class="tabnav-tabs nav-x">
             <a href="#url" aria-current="page" aria-selected="true" class="tabnav-tab tab-x my-tab" role="tab">One</a>
             <a href="#url" class="tabnav-tab tab-x" role="tab">Two</a>
             </nav>
             </div>
             """
             |> format_html()
  end

  test "Extra attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.tabnav aria_label="Topics navigation" dir="rtl">
             <:item href="#url" is_selected aria-label="View One">
               One
             </:item>
             <:item href="#url">
               Two
             </:item>
             <:position_end aria-label="End content">
               Tabnav widget text here.
             </:position_end>
           </.tabnav>
           """)
           |> format_html() ==
             """
             <div class="tabnav" dir="rtl">
             <div aria-label="End content" class="float-right">
             Tabnav widget text here.
             </div>
             <nav class="tabnav-tabs" aria-label="Topics navigation">
             <a href="#url" aria-label="View One" aria-current="page" aria-selected="true" class="tabnav-tab" role="tab">One</a>
             <a href="#url" class="tabnav-tab" role="tab">Two</a>
             </nav>
             </div>
             """
             |> format_html()
  end
end
