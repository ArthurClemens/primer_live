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
             <.drawer_content id="my-drawer-content-id">
               Content
             </.drawer_content>
           </.drawer>
           """)
           |> format_html() ==
             """
             <div data-prompt="" id="my-drawer-id" phx-hook="Prompt" data-isdrawer="">
             <input aria-hidden="true" id="my-drawer-id-toggle" name="[]" onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-touch=""></div>
             <div data-content="">
             <div id="my-drawer-content-id" data-drawer-content="" class="Box--overlay">
                <div id="focus-wrap-my-drawer-content-id" phx-hook="Phoenix.FocusWrap"><span
                        id="focus-wrap-my-drawer-content-id-start" tabindex="0" aria-hidden="true"></span>Content<span
                        id="focus-wrap-my-drawer-content-id-end" tabindex="0" aria-hidden="true"></span></div>
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
             <.drawer_content id="my-drawer-content-id">
               Content
             </.drawer_content>
           </.drawer>
           """)
           |> format_html() ==
             """
             <div data-prompt="" id="my-drawer-id" phx-hook="Prompt" data-isdrawer="" data-isfarside=""><input aria-hidden="true" id="my-drawer-id-toggle" name="[]" onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-touch=""></div>
             <div data-content="">
             <div id="my-drawer-content-id" data-drawer-content="" class="Box--overlay">
                <div id="focus-wrap-my-drawer-content-id" phx-hook="Phoenix.FocusWrap"><span
                        id="focus-wrap-my-drawer-content-id-start" tabindex="0" aria-hidden="true"></span>Content<span
                        id="focus-wrap-my-drawer-content-id-end" tabindex="0" aria-hidden="true"></span></div>
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
             <.drawer_content id="my-drawer-content-id">
               Content
             </.drawer_content>
           </.drawer>
           """)
           |> format_html() ==
             """
             <div width="10em" data-prompt="" id="my-drawer-id" phx-hook="Prompt" data-isdrawer="">
             <input aria-hidden="true" id="my-drawer-id-toggle" name="[]" onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-touch=""></div>
             <div data-content="">
                 <div id="my-drawer-content-id" data-drawer-content="" class="Box--overlay">
                     <div id="focus-wrap-my-drawer-content-id" phx-hook="Phoenix.FocusWrap"><span
                             id="focus-wrap-my-drawer-content-id-start" tabindex="0" aria-hidden="true"></span>Content<span
                             id="focus-wrap-my-drawer-content-id-end" tabindex="0" aria-hidden="true"></span></div>
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
             <.drawer_content id="my-drawer-content-id">
               Content
             </.drawer_content>
           </.drawer>
           """)
           |> format_html() ==
             """
             <div data-prompt="" id="my-drawer-id" phx-hook="Prompt" data-isfast="" data-isdrawer="">
             <input aria-hidden="true" id="my-drawer-id-toggle" name="[]" onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-touch=""></div>
             <div data-content="">
             <div id="my-drawer-content-id" data-drawer-content="" class="Box--overlay">
                <div id="focus-wrap-my-drawer-content-id" phx-hook="Phoenix.FocusWrap"><span
                        id="focus-wrap-my-drawer-content-id-start" tabindex="0" aria-hidden="true"></span>Content<span
                        id="focus-wrap-my-drawer-content-id-end" tabindex="0" aria-hidden="true"></span></div>
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
             <.drawer_content id="my-drawer-content-id">
               Content
             </.drawer_content>
           </.drawer>
           """)
           |> format_html() ==
             """
             <div data-prompt="" id="my-drawer-id" phx-hook="Prompt" data-isescapable="" data-isdrawer="">
             <input aria-hidden="true" id="my-drawer-id-toggle" name="[]" onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-touch=""></div>
             <div data-content="">
             <div id="my-drawer-content-id" data-drawer-content="" class="Box--overlay">
                <div id="focus-wrap-my-drawer-content-id" phx-hook="Phoenix.FocusWrap"><span
                        id="focus-wrap-my-drawer-content-id-start" tabindex="0" aria-hidden="true"></span>Content<span
                        id="focus-wrap-my-drawer-content-id-end" tabindex="0" aria-hidden="true"></span></div>
             </div>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: focus_first" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.drawer id="my-drawer-id" focus_first="[name=first_name]">
             <.drawer_content id="my-drawer-content-id">
               Content
             </.drawer_content>
           </.drawer>
           """)
           |> format_html() ==
             """
             <div data-prompt="" id="my-drawer-id" phx-hook="Prompt" data-focusfirst="[name=first_name]" data-isdrawer="">
             <input aria-hidden="true" id="my-drawer-id-toggle" name="[]" onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-touch=""></div>
             <div data-content="">
             <div id="my-drawer-content-id" data-drawer-content="" class="Box--overlay">
                <div id="focus-wrap-my-drawer-content-id" phx-hook="Phoenix.FocusWrap"><span
                        id="focus-wrap-my-drawer-content-id-start" tabindex="0" aria-hidden="true"></span>Content<span
                        id="focus-wrap-my-drawer-content-id-end" tabindex="0" aria-hidden="true"></span></div>
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
             <.drawer_content id="my-drawer-content-id">
               Content
             </.drawer_content>
           </.drawer>
           """)
           |> format_html() ==
             """
             <div data-prompt="" id="my-drawer-id" phx-hook="Prompt" data-isdrawer="">
             <input aria-hidden="true" id="my-drawer-id-toggle" name="[]" onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-backdrop=""></div>
             <div data-touch=""></div>
             <div data-content="">
             <div id="my-drawer-content-id" data-drawer-content="" class="Box--overlay">
                <div id="focus-wrap-my-drawer-content-id" phx-hook="Phoenix.FocusWrap"><span
                        id="focus-wrap-my-drawer-content-id-start" tabindex="0" aria-hidden="true"></span>Content<span
                        id="focus-wrap-my-drawer-content-id-end" tabindex="0" aria-hidden="true"></span></div>
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
             <.drawer_content id="my-drawer-content-id">
               Content
             </.drawer_content>
           </.drawer>
           """)
           |> format_html() ==
             """
             <div data-prompt="" id="my-drawer-id" phx-hook="Prompt" data-isdrawer="">
             <input aria-hidden="true" id="my-drawer-id-toggle" name="[]" onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-backdrop="" data-isdark=""></div>
             <div data-touch=""></div>
             <div data-content="">
             <div id="my-drawer-content-id" data-drawer-content="" class="Box--overlay">
                <div id="focus-wrap-my-drawer-content-id" phx-hook="Phoenix.FocusWrap"><span
                        id="focus-wrap-my-drawer-content-id-start" tabindex="0" aria-hidden="true"></span>Content<span
                        id="focus-wrap-my-drawer-content-id-end" tabindex="0" aria-hidden="true"></span></div>
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
             <.drawer_content id="my-drawer-content-id">
               Content
             </.drawer_content>
           </.drawer>
           """)
           |> format_html() ==
             """
             <div data-prompt="" id="my-drawer-id" phx-hook="Prompt" data-isdrawer="">
             <input aria-hidden="true" id="my-drawer-id-toggle" name="[]" onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-backdrop="" data-islight=""></div>
             <div data-touch=""></div>
             <div data-content="">
             <div id="my-drawer-content-id" data-drawer-content="" class="Box--overlay">
                <div id="focus-wrap-my-drawer-content-id" phx-hook="Phoenix.FocusWrap"><span
                        id="focus-wrap-my-drawer-content-id-start" tabindex="0" aria-hidden="true"></span>Content<span
                        id="focus-wrap-my-drawer-content-id-end" tabindex="0" aria-hidden="true"></span></div>
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
             <.drawer_content id="my-drawer-content-id">
               Content
             </.drawer_content>
           </.drawer>
           """)
           |> format_html() ==
             """
             <div data-prompt="" id="my-drawer-id" phx-hook="Prompt" data-ismodal="" data-isdrawer="">
             <input aria-hidden="true" id="my-drawer-id-toggle" name="[]" onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-touch=""></div>
             <div data-content="">
             <div id="my-drawer-content-id" data-drawer-content="" class="Box--overlay">
                <div id="focus-wrap-my-drawer-content-id" phx-hook="Phoenix.FocusWrap"><span
                        id="focus-wrap-my-drawer-content-id-start" tabindex="0" aria-hidden="true"></span>Content<span
                        id="focus-wrap-my-drawer-content-id-end" tabindex="0" aria-hidden="true"></span></div>
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
               <.drawer_content id="my-drawer-content-id">
                 Content
               </.drawer_content>
             </.drawer>
           </div>
           """)
           |> format_html() ==
             """
             <div style="position: relative; overflow-x: hidden;">Page content<div data-prompt="" id="my-drawer-id"
             phx-hook="Prompt" data-isdrawer="" data-islocal="">
             <input aria-hidden="true" id="my-drawer-id-toggle" name="[]" onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-touch=""></div>
             <div data-content="">
                <div id="my-drawer-content-id" data-drawer-content="" class="Box--overlay">
                    <div id="focus-wrap-my-drawer-content-id" phx-hook="Phoenix.FocusWrap"><span
                            id="focus-wrap-my-drawer-content-id-start" tabindex="0"
                            aria-hidden="true"></span>Content<span id="focus-wrap-my-drawer-content-id-end" tabindex="0"
                            aria-hidden="true"></span></div>
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
               <.drawer_content id="my-drawer-content-id">
                 Content
               </.drawer_content>
             </.drawer>
           </div>
           """)
           |> format_html() ==
             """
             <div style="position: relative; overflow-x: hidden;">
             <div data-prompt="" id="my-drawer-id" phx-hook="Prompt" data-isdrawer="" data-ispush=""><input aria-hidden="true" id="my-drawer-id-toggle" name="[]" onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-content="">
                <div data-touch=""></div>Page content<div id="my-drawer-content-id" data-drawer-content=""
                    class="Box--overlay">
                    <div id="focus-wrap-my-drawer-content-id" phx-hook="Phoenix.FocusWrap"><span
                            id="focus-wrap-my-drawer-content-id-start" tabindex="0"
                            aria-hidden="true"></span>Content<span id="focus-wrap-my-drawer-content-id-end" tabindex="0"
                            aria-hidden="true"></span></div>
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
             <.drawer_content id="my-drawer-content-id" aria-role="menu" class="my-drawer-content">
               Content
             </.drawer_content>
           </.drawer>
           """)
           |> format_html() ==
             """
             <div dir="rtl" data-prompt="" id="my-drawer-id" phx-hook="Prompt" class="my-drawer" data-isdrawer="">
             <input aria-hidden="true" id="my-drawer-id-toggle" name="[]" onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-touch=""></div>
             <div data-content="">
             <div aria-role="menu" id="my-drawer-content-id" data-drawer-content=""
                class="Box--overlay my-drawer-content">
                <div id="focus-wrap-my-drawer-content-id" phx-hook="Phoenix.FocusWrap"><span
                        id="focus-wrap-my-drawer-content-id-start" tabindex="0" aria-hidden="true"></span>Content<span
                        id="focus-wrap-my-drawer-content-id-end" tabindex="0" aria-hidden="true"></span></div>
             </div>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end
end
