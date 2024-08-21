defmodule PrimerLive.TestComponents.DrawerTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Basic" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.drawer id="my-drawer-id">
             <:body id="my-drawer-content-id">
               Content
             </:body>
           </.drawer>
           """)
           |> format_html() ==
             """
             <div data-isdrawer="" data-prompt="" id="my-drawer-id" phx-hook="Prompt"><input aria-hidden="true"
             id="my-drawer-id-toggle" name="[]" onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox"
             value="true" />
             <div data-prompt-content>
             <div data-touch=""></div>
             <div data-content="">
                 <div class="Box--overlay" data-drawer-content="" id="my-drawer-content-id">
                     <div id="focus-wrap-my-drawer-id" phx-hook="Phoenix.FocusWrap"><span id="focus-wrap-my-drawer-id-start"
                             tabindex="0" aria-hidden="true"></span>Content<span id="focus-wrap-my-drawer-id-end"
                             tabindex="0" aria-hidden="true"></span></div>
                 </div>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: is_far_side" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.drawer id="my-drawer-id" is_far_side>
             <:body id="my-drawer-content-id">
               Content
             </:body>
           </.drawer>
           """)
           |> format_html() ==
             """
             <div data-isdrawer="" data-isfarside="" data-prompt="" id="my-drawer-id" phx-hook="Prompt"><input aria-hidden="true"
             id="my-drawer-id-toggle" name="[]" onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox"
             value="true" />
             <div data-prompt-content>
             <div data-touch=""></div>
             <div data-content="">
             <div class="Box--overlay" data-drawer-content="" id="my-drawer-content-id">
                <div id="focus-wrap-my-drawer-id" phx-hook="Phoenix.FocusWrap"><span id="focus-wrap-my-drawer-id-start"
                        tabindex="0" aria-hidden="true"></span>Content<span id="focus-wrap-my-drawer-id-end"
                        tabindex="0" aria-hidden="true"></span></div>
             </div>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: width" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.drawer id="my-drawer-id" width="10em">
             <:body id="my-drawer-content-id">
               Content
             </:body>
           </.drawer>
           """)
           |> format_html() ==
             """
             <div data-isdrawer="" data-prompt="" id="my-drawer-id" phx-hook="Prompt" width="10em"><input aria-hidden="true"
             id="my-drawer-id-toggle" name="[]" onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox"
             value="true" />
             <div data-prompt-content>
             <div data-touch=""></div>
             <div data-content="">
             <div class="Box--overlay" data-drawer-content="" id="my-drawer-content-id">
                <div id="focus-wrap-my-drawer-id" phx-hook="Phoenix.FocusWrap"><span id="focus-wrap-my-drawer-id-start"
                        tabindex="0" aria-hidden="true"></span>Content<span id="focus-wrap-my-drawer-id-end"
                        tabindex="0" aria-hidden="true"></span></div>
             </div>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: is_fast" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.drawer id="my-drawer-id" is_fast>
             <:body id="my-drawer-content-id">
               Content
             </:body>
           </.drawer>
           """)
           |> format_html() ==
             """
             <div data-isdrawer="" data-isfast="" data-prompt="" id="my-drawer-id" phx-hook="Prompt"><input aria-hidden="true"
             id="my-drawer-id-toggle" name="[]" onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox"
             value="true" />
             <div data-prompt-content>
             <div data-touch=""></div>
             <div data-content="">
             <div class="Box--overlay" data-drawer-content="" id="my-drawer-content-id">
                <div id="focus-wrap-my-drawer-id" phx-hook="Phoenix.FocusWrap"><span id="focus-wrap-my-drawer-id-start"
                        tabindex="0" aria-hidden="true"></span>Content<span id="focus-wrap-my-drawer-id-end"
                        tabindex="0" aria-hidden="true"></span></div>
             </div>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: is_escapable" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.drawer id="my-drawer-id" is_escapable>
             <:body id="my-drawer-content-id">
               Content
             </:body>
           </.drawer>
           """)
           |> format_html() ==
             """
             <div data-isdrawer="" data-isescapable="" data-prompt="" id="my-drawer-id" phx-hook="Prompt"><input aria-hidden="true"
             id="my-drawer-id-toggle" name="[]" onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox"
             value="true" />
             <div data-prompt-content>
             <div data-touch=""></div>
             <div data-content="">
             <div class="Box--overlay" data-drawer-content="" id="my-drawer-content-id">
                <div id="focus-wrap-my-drawer-id" phx-hook="Phoenix.FocusWrap"><span id="focus-wrap-my-drawer-id-start"
                        tabindex="0" aria-hidden="true"></span>Content<span id="focus-wrap-my-drawer-id-end"
                        tabindex="0" aria-hidden="true"></span></div>
             </div>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: focus_after_opening_selector" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.drawer id="my-drawer-id" focus_after_opening_selector="[name=first_name]">
             <:body id="my-drawer-content-id">
               Content
             </:body>
           </.drawer>
           """)
           |> format_html() ==
             """
             <div data-focusfirst="[name=first_name]" data-isdrawer="" data-prompt="" id="my-drawer-id" phx-hook="Prompt"><input
             aria-hidden="true" id="my-drawer-id-toggle" name="[]" onchange="window.Prompt &amp;&amp; Prompt.change(this)"
             type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-touch=""></div>
             <div data-content="">
             <div class="Box--overlay" data-drawer-content="" id="my-drawer-content-id">
                <div id="focus-wrap-my-drawer-id" phx-hook="Phoenix.FocusWrap"><span id="focus-wrap-my-drawer-id-start"
                        tabindex="0" aria-hidden="true"></span>Content<span id="focus-wrap-my-drawer-id-end"
                        tabindex="0" aria-hidden="true"></span></div>
             </div>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: is_backdrop" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.drawer id="my-drawer-id" is_backdrop>
             <:body id="my-drawer-content-id">
               Content
             </:body>
           </.drawer>
           """)
           |> format_html() ==
             """
             <div data-isdrawer="" data-prompt="" id="my-drawer-id" phx-hook="Prompt"><input aria-hidden="true"
             id="my-drawer-id-toggle" name="[]" onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox"
             value="true" />
             <div data-prompt-content>
             <div data-backdrop=""></div>
             <div data-touch=""></div>
             <div data-content="">
             <div class="Box--overlay" data-drawer-content="" id="my-drawer-content-id">
                <div id="focus-wrap-my-drawer-id" phx-hook="Phoenix.FocusWrap"><span id="focus-wrap-my-drawer-id-start"
                        tabindex="0" aria-hidden="true"></span>Content<span id="focus-wrap-my-drawer-id-end"
                        tabindex="0" aria-hidden="true"></span></div>
             </div>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: is_dark_backdrop" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.drawer id="my-drawer-id" is_dark_backdrop>
             <:body id="my-drawer-content-id">
               Content
             </:body>
           </.drawer>
           """)
           |> format_html() ==
             """
             <div data-isdrawer="" data-prompt="" id="my-drawer-id" phx-hook="Prompt"><input aria-hidden="true"
             id="my-drawer-id-toggle" name="[]" onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox"
             value="true" />
             <div data-prompt-content>
             <div data-backdrop="" data-isdark=""></div>
             <div data-touch=""></div>
             <div data-content="">
             <div class="Box--overlay" data-drawer-content="" id="my-drawer-content-id">
                <div id="focus-wrap-my-drawer-id" phx-hook="Phoenix.FocusWrap"><span id="focus-wrap-my-drawer-id-start"
                        tabindex="0" aria-hidden="true"></span>Content<span id="focus-wrap-my-drawer-id-end"
                        tabindex="0" aria-hidden="true"></span></div>
             </div>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: is_light_backdrop" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.drawer id="my-drawer-id" is_light_backdrop>
             <:body id="my-drawer-content-id">
               Content
             </:body>
           </.drawer>
           """)
           |> format_html() ==
             """
             <div data-isdrawer="" data-prompt="" id="my-drawer-id" phx-hook="Prompt"><input aria-hidden="true"
             id="my-drawer-id-toggle" name="[]" onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox"
             value="true" />
             <div data-prompt-content>
             <div data-backdrop="" data-islight=""></div>
             <div data-touch=""></div>
             <div data-content="">
             <div class="Box--overlay" data-drawer-content="" id="my-drawer-content-id">
                <div id="focus-wrap-my-drawer-id" phx-hook="Phoenix.FocusWrap"><span id="focus-wrap-my-drawer-id-start"
                        tabindex="0" aria-hidden="true"></span>Content<span id="focus-wrap-my-drawer-id-end"
                        tabindex="0" aria-hidden="true"></span></div>
             </div>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: is_modal" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.drawer id="my-drawer-id" is_modal>
             <:body id="my-drawer-content-id">
               Content
             </:body>
           </.drawer>
           """)
           |> format_html() ==
             """
             <div data-isdrawer="" data-ismodal="" data-prompt="" id="my-drawer-id" phx-hook="Prompt"><input aria-hidden="true"
             id="my-drawer-id-toggle" name="[]" onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox"
             value="true" />
             <div data-prompt-content>
             <div data-touch=""></div>
             <div data-content="">
             <div class="Box--overlay" data-drawer-content="" id="my-drawer-content-id">
                <div id="focus-wrap-my-drawer-id" phx-hook="Phoenix.FocusWrap"><span id="focus-wrap-my-drawer-id-start"
                        tabindex="0" aria-hidden="true"></span>Content<span id="focus-wrap-my-drawer-id-end"
                        tabindex="0" aria-hidden="true"></span></div>
             </div>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: is_local" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <div style="position: relative; overflow-x: hidden;">
             Page content
             <.drawer id="my-drawer-id" is_local>
               <:body id="my-drawer-content-id">
                 Content
               </:body>
             </.drawer>
           </div>
           """)
           |> format_html() ==
             """
             <div style="position: relative; overflow-x: hidden;">Page content<div data-isdrawer="" data-islocal="" data-prompt=""
             id="my-drawer-id" phx-hook="Prompt"><input aria-hidden="true" id="my-drawer-id-toggle" name="[]"
             onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-touch=""></div>
             <div data-content="">
                <div class="Box--overlay" data-drawer-content="" id="my-drawer-content-id">
                    <div id="focus-wrap-my-drawer-id" phx-hook="Phoenix.FocusWrap"><span
                            id="focus-wrap-my-drawer-id-start" tabindex="0" aria-hidden="true"></span>Content<span
                            id="focus-wrap-my-drawer-id-end" tabindex="0" aria-hidden="true"></span></div>
                </div>
             </div>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: is_push" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <div style="position: relative; overflow-x: hidden;">
             <.drawer id="my-drawer-id" is_push>
               Page content
               <:body id="my-drawer-content-id">
                 Content
               </:body>
             </.drawer>
           </div>
           """)
           |> format_html() ==
             """
             <div style="position: relative; overflow-x: hidden;">
             <div data-isdrawer="" data-ispush="" data-prompt="" id="my-drawer-id" phx-hook="Prompt"><input aria-hidden="true"
             id="my-drawer-id-toggle" name="[]" onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox"
             value="true" />
             <div data-prompt-content>
             <div data-content="">
                <div data-touch=""></div>Page content<div class="Box--overlay" data-drawer-content=""
                    id="my-drawer-content-id">
                    <div id="focus-wrap-my-drawer-id" phx-hook="Phoenix.FocusWrap"><span
                            id="focus-wrap-my-drawer-id-start" tabindex="0" aria-hidden="true"></span>Content<span
                            id="focus-wrap-my-drawer-id-end" tabindex="0" aria-hidden="true"></span></div>
                </div>
             </div>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Extra attribute" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.drawer id="my-drawer-id" class="my-drawer" dir="rtl">
             <:body id="my-drawer-content-id" aria-role="menu" class="my-drawer-content">
               Content
             </:body>
           </.drawer>
           """)
           |> format_html() ==
             """
             <div class="my-drawer" data-isdrawer="" data-prompt="" dir="rtl" id="my-drawer-id" phx-hook="Prompt"><input
             aria-hidden="true" id="my-drawer-id-toggle" name="[]" onchange="window.Prompt &amp;&amp; Prompt.change(this)"
             type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-touch=""></div>
             <div data-content="">
             <div aria-role="menu" class="Box--overlay my-drawer-content" data-drawer-content=""
                id="my-drawer-content-id">
                <div id="focus-wrap-my-drawer-id" phx-hook="Phoenix.FocusWrap"><span id="focus-wrap-my-drawer-id-start"
                        tabindex="0" aria-hidden="true"></span>Content<span id="focus-wrap-my-drawer-id-end"
                        tabindex="0" aria-hidden="true"></span></div>
             </div>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end
end
