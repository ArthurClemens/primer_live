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
             <div class="UnderlineNav-body" role="tablist"><a href="#url" role="tab" class="UnderlineNav-item" aria-selected="true"
             aria-current="page">href link</a><a href="#url" data-phx-link="redirect" data-phx-link-state="push" role="tab"
             class="UnderlineNav-item">navigate link</a><a href="#url" data-phx-link="patch" data-phx-link-state="push"
             role="tab" class="UnderlineNav-item">patch link</a></div>
             </nav>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
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
             <div class="UnderlineNav-body" role="tablist"><a href="#url" role="tab" class="UnderlineNav-item" aria-selected="true"
             aria-current="page"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16"
             viewBox="0 0 16 16">STRIPPED_SVG_PATHS</svg><span>Conversation</span><span class="Counter">2</span></a><a
             href="#url" role="tab" class="UnderlineNav-item"><svg class="octicon" xmlns="http://www.w3.org/2000/svg"
             width="16" height="16" viewBox="0 0 16 16">STRIPPED_SVG_PATHS</svg><span>Done</span><span
             class="Counter">99</span></a></div>
             </nav>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
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
             <div class="UnderlineNav-body" role="tablist"><button aria-current="page" aria-selected="true"
             class="UnderlineNav-item" role="tab">Button 1</button><button class="UnderlineNav-item" role="tab">Button
             2</button></div>
             </nav>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
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
             <div class="UnderlineNav-body" role="tablist"><a href="#url" role="tab" class="UnderlineNav-item" aria-selected="true"
             aria-current="page">One</a><a href="#url" role="tab" class="UnderlineNav-item">Two</a></div>
             <div class="UnderlineNav-actions"><a class="btn btn-sm" href="#url" role="button">Button</a></div>
             </nav>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
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
             <a href="#url" role="tab" class="UnderlineNav-item" aria-selected="true" aria-current="page">One</a>
             <a href="#url" role="tab" class="UnderlineNav-item">Two</a>
             </div>
             </div>
             </nav>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
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
             <div class="UnderlineNav-actions"><a class="btn btn-sm" href="#url" role="button">Button</a></div>
             <div class="UnderlineNav-body" role="tablist"><a href="#url" role="tab" class="UnderlineNav-item" aria-selected="true"
             aria-current="page">One</a><a href="#url" role="tab" class="UnderlineNav-item">Two</a></div>
             </nav>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
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
             <a href="#url" role="tab" class="UnderlineNav-item tab-x my-tab" aria-selected="true" aria-current="page">One</a>
             <a href="#url" role="tab" class="UnderlineNav-item tab-x">Two</a>
             </div>
             <div class="UnderlineNav-actions position_end-x my-position-end">Actions here</div>
             </div>
             </nav>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
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
             <a href="#url" role="tab" class="UnderlineNav-item" aria-label="View One" aria-selected="true" aria-current="page">One</a>
             <a href="#url" role="tab" class="UnderlineNav-item">Two</a>
             </div>
             <div aria-label="Actions" class="UnderlineNav-actions">Actions here</div>
             </nav>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end
end
