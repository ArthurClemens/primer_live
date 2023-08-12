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
             <nav aria-label="Tabs" class="tabnav-tabs"><a href="#url" role="tab" class="tabnav-tab" aria-selected="true"
             aria-current="page">href link</a><a href="#url" data-phx-link="redirect" data-phx-link-state="push" role="tab"
             class="tabnav-tab">navigate link</a><a href="#url" data-phx-link="patch" data-phx-link-state="push" role="tab"
             class="tabnav-tab">patch link</a></nav>
             </div>
             """
             |> format_html()
  end

  test "Attribute: is_small" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.tabnav aria_label="Tabs">
             <:item is_small is_selected>
               One
             </:item>
             <:item is_small>
               Two
             </:item>
           </.tabnav>
           """)
           |> format_html() ==
             """
             <div class="tabnav">
             <nav aria-label="Tabs" class="tabnav-tabs"><button aria-current="page" aria-selected="true"
             class="tabnav-tab tabnav-tab--small" role="tab">One</button><button class="tabnav-tab tabnav-tab--small"
             role="tab">Two</button></nav>
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
               <.counter>2</.counter>
             </:item>
             <:item href="#url">
               <.octicon name="check-circle-16" />
               <span>Done</span>
               <.counter>99</.counter>
             </:item>
           </.tabnav>
           """)
           |> format_html() ==
             """
             <div class="tabnav">
             <nav class="tabnav-tabs"><a href="#url" role="tab" class="tabnav-tab" aria-selected="true" aria-current="page"><svg
             class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16"
             viewBox="0 0 16 16">STRIPPED_SVG_PATHS</svg><span>Conversation</span><span class="Counter">2</span></a><a
             href="#url" role="tab" class="tabnav-tab"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16"
             height="16" viewBox="0 0 16 16">STRIPPED_SVG_PATHS</svg><span>Done</span><span class="Counter">99</span></a>
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
             <nav aria-label="Tabs" class="tabnav-tabs"><button aria-current="page" aria-selected="true" class="tabnav-tab"
             role="tab">Button 1</button><button class="tabnav-tab" role="tab">Button 2</button></nav>
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
             <div class="float-right"><a class="btn btn-sm" href="#url" role="button">Button</a></div>
             <nav class="tabnav-tabs"><a href="#url" role="tab" class="tabnav-tab" aria-selected="true"
             aria-current="page">One</a><a href="#url" role="tab" class="tabnav-tab">Two</a><a href="#url" role="tab"
             class="tabnav-tab">Three</a></nav>
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
             <nav aria-label="Tabs" class="tabnav-tabs"><a href="#url" role="tab" class="tabnav-tab" aria-selected="true"
             aria-current="page">One</a><a href="#url" role="tab" class="tabnav-tab">Two</a><a href="#url" role="tab"
             class="tabnav-tab">Three</a></nav>
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
             <nav class="tabnav-tabs nav-x"><a href="#url" role="tab" class="tabnav-tab tab-x my-tab" aria-selected="true"
             aria-current="page">One</a><a href="#url" role="tab" class="tabnav-tab tab-x">Two</a></nav>
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
             <div aria-label="End content" class="float-right">Tabnav widget text here.</div>
             <nav aria-label="Topics navigation" class="tabnav-tabs"><a href="#url" role="tab" class="tabnav-tab"
             aria-label="View One" aria-selected="true" aria-current="page">One</a><a href="#url" role="tab"
             class="tabnav-tab">Two</a></nav>
             </div>
             """
             |> format_html()
  end
end
