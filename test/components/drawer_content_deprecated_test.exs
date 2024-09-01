defmodule PrimerLive.TestComponents.DrawerContentDeprecatedTest do
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
             <div data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:170,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;,&quot;transition&quot;:[[&quot;duration-170&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isdrawer="" data-isescapable="" data-open="[[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-drawer-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-drawer-id" phx-hook="Prompt"><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-drawer-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div data-content=""><div class="Box--overlay" data-drawer-content="" id="my-drawer-content-id"><div id="focus-wrap-my-drawer-content-id" phx-hook="Phoenix.FocusWrap" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-drawer-content-id-start" tabindex="0" aria-hidden="true"></span>Content<span id="focus-wrap-my-drawer-content-id-end" tabindex="0" aria-hidden="true"></span></div></div></div></div>
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
             <div data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:170,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;,&quot;transition&quot;:[[&quot;duration-170&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isdrawer="" data-isescapable="" data-isfarside="" data-open="[[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-drawer-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-drawer-id" phx-hook="Prompt"><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-drawer-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div data-content=""><div class="Box--overlay" data-drawer-content="" id="my-drawer-content-id"><div id="focus-wrap-my-drawer-content-id" phx-hook="Phoenix.FocusWrap" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-drawer-content-id-start" tabindex="0" aria-hidden="true"></span>Content<span id="focus-wrap-my-drawer-content-id-end" tabindex="0" aria-hidden="true"></span></div></div></div></div>
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
             <div data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:170,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;,&quot;transition&quot;:[[&quot;duration-170&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isdrawer="" data-isescapable="" data-open="[[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-drawer-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-drawer-id" phx-hook="Prompt" width="10em"><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-drawer-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div data-content=""><div class="Box--overlay" data-drawer-content="" id="my-drawer-content-id"><div id="focus-wrap-my-drawer-content-id" phx-hook="Phoenix.FocusWrap" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-drawer-content-id-start" tabindex="0" aria-hidden="true"></span>Content<span id="focus-wrap-my-drawer-content-id-end" tabindex="0" aria-hidden="true"></span></div></div></div></div>
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
             <div data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:170,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;,&quot;transition&quot;:[[&quot;duration-170&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isdrawer="" data-isescapable="" data-isfast="" data-open="[[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-drawer-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-drawer-id" phx-hook="Prompt"><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-drawer-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div data-content=""><div class="Box--overlay" data-drawer-content="" id="my-drawer-content-id"><div id="focus-wrap-my-drawer-content-id" phx-hook="Phoenix.FocusWrap" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-drawer-content-id-start" tabindex="0" aria-hidden="true"></span>Content<span id="focus-wrap-my-drawer-content-id-end" tabindex="0" aria-hidden="true"></span></div></div></div></div>
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
             <div data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:170,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;,&quot;transition&quot;:[[&quot;duration-170&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isdrawer="" data-isescapable="" data-open="[[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-drawer-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-drawer-id" phx-hook="Prompt"><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-drawer-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div data-content=""><div class="Box--overlay" data-drawer-content="" id="my-drawer-content-id"><div id="focus-wrap-my-drawer-content-id" phx-hook="Phoenix.FocusWrap" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-drawer-content-id-start" tabindex="0" aria-hidden="true"></span>Content<span id="focus-wrap-my-drawer-content-id-end" tabindex="0" aria-hidden="true"></span></div></div></div></div>
             """
             |> format_html()
  end

  test "Attribute: focus_after_opening_selector" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.drawer id="my-drawer-id" focus_after_opening_selector="[name=first_name]">
             <.drawer_content id="my-drawer-content-id">
               Content
             </.drawer_content>
           </.drawer>
           """)
           |> format_html() ==
             """
             <div data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:170,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;,&quot;transition&quot;:[[&quot;duration-170&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isdrawer="" data-isescapable="" data-open="[[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-drawer-id [data-content]&quot;}],[&quot;focus&quot;,{&quot;to&quot;:&quot;[name=first_name]&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-drawer-id" phx-hook="Prompt"><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-drawer-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div data-content=""><div class="Box--overlay" data-drawer-content="" id="my-drawer-content-id"><div id="focus-wrap-my-drawer-content-id" phx-hook="Phoenix.FocusWrap" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-drawer-content-id-start" tabindex="0" aria-hidden="true"></span>Content<span id="focus-wrap-my-drawer-content-id-end" tabindex="0" aria-hidden="true"></span></div></div></div></div>
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
             <div data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:170,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;,&quot;transition&quot;:[[&quot;duration-170&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isdrawer="" data-isescapable="" data-open="[[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-drawer-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-drawer-id" phx-hook="Prompt"><div data-backdrop=""></div><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-drawer-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div data-content=""><div class="Box--overlay" data-drawer-content="" id="my-drawer-content-id"><div id="focus-wrap-my-drawer-content-id" phx-hook="Phoenix.FocusWrap" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-drawer-content-id-start" tabindex="0" aria-hidden="true"></span>Content<span id="focus-wrap-my-drawer-content-id-end" tabindex="0" aria-hidden="true"></span></div></div></div></div>
             """
             |> format_html()
  end

  test "Attribute: backdrop_strength (strong)" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.drawer id="my-drawer-id" is_backdrop backdrop_strength="strong">
             <.drawer_content id="my-drawer-content-id">
               Content
             </.drawer_content>
           </.drawer>
           """)
           |> format_html() ==
             """
             <div data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:170,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;,&quot;transition&quot;:[[&quot;duration-170&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isdrawer="" data-isescapable="" data-open="[[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-drawer-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-drawer-id" phx-hook="Prompt"><div data-backdrop="" data-backdrop-strength="strong"></div><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-drawer-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div data-content=""><div class="Box--overlay" data-drawer-content="" id="my-drawer-content-id"><div id="focus-wrap-my-drawer-content-id" phx-hook="Phoenix.FocusWrap" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-drawer-content-id-start" tabindex="0" aria-hidden="true"></span>Content<span id="focus-wrap-my-drawer-content-id-end" tabindex="0" aria-hidden="true"></span></div></div></div></div>
             """
             |> format_html()
  end

  test "Attribute: backdrop_strength (light)" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.drawer id="my-drawer-id" is_backdrop backdrop_strength="light">
             <.drawer_content id="my-drawer-content-id">
               Content
             </.drawer_content>
           </.drawer>
           """)
           |> format_html() ==
             """
             <div data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:170,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;,&quot;transition&quot;:[[&quot;duration-170&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isdrawer="" data-isescapable="" data-open="[[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-drawer-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-drawer-id" phx-hook="Prompt"><div data-backdrop="" data-backdrop-strength="light"></div><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-drawer-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div data-content=""><div class="Box--overlay" data-drawer-content="" id="my-drawer-content-id"><div id="focus-wrap-my-drawer-content-id" phx-hook="Phoenix.FocusWrap" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-drawer-content-id-start" tabindex="0" aria-hidden="true"></span>Content<span id="focus-wrap-my-drawer-content-id-end" tabindex="0" aria-hidden="true"></span></div></div></div></div>
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
             <div data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:170,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;,&quot;transition&quot;:[[&quot;duration-170&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isdrawer="" data-isescapable="" data-open="[[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-drawer-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-drawer-id" phx-hook="Prompt"><div data-touch=""></div><div data-content=""><div class="Box--overlay" data-drawer-content="" id="my-drawer-content-id"><div id="focus-wrap-my-drawer-content-id" phx-hook="Phoenix.FocusWrap" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-drawer-content-id-start" tabindex="0" aria-hidden="true"></span>Content<span id="focus-wrap-my-drawer-content-id-end" tabindex="0" aria-hidden="true"></span></div></div></div></div>
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
             <div style="position: relative; overflow-x: hidden;">Page content<div data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:170,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;,&quot;transition&quot;:[[&quot;duration-170&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isdrawer="" data-isescapable="" data-islocal="" data-open="[[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-drawer-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-drawer-id" phx-hook="Prompt"><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-drawer-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div data-content=""><div class="Box--overlay" data-drawer-content="" id="my-drawer-content-id"><div id="focus-wrap-my-drawer-content-id" phx-hook="Phoenix.FocusWrap" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-drawer-content-id-start" tabindex="0" aria-hidden="true"></span>Content<span id="focus-wrap-my-drawer-content-id-end" tabindex="0" aria-hidden="true"></span></div></div></div></div></div>
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
             <div style="position: relative; overflow-x: hidden;"><div class="is-show_on_mount" data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:170,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;,&quot;transition&quot;:[[&quot;duration-170&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isdrawer="" data-isescapable="" data-ispush="" data-open="[[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-drawer-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-show_on_mount&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;}]]" data-prompt="" id="my-drawer-id" phx-hook="Prompt"><div data-content=""><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-drawer-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div>Page content<div class="Box--overlay" data-drawer-content="" id="my-drawer-content-id"><div id="focus-wrap-my-drawer-content-id" phx-hook="Phoenix.FocusWrap" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-drawer-content-id-start" tabindex="0" aria-hidden="true"></span>Content<span id="focus-wrap-my-drawer-content-id-end" tabindex="0" aria-hidden="true"></span></div></div></div></div></div>
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
             <div class="my-drawer" data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:170,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;,&quot;transition&quot;:[[&quot;duration-170&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isdrawer="" data-isescapable="" data-open="[[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-drawer-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-drawer-id&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" dir="rtl" id="my-drawer-id" phx-hook="Prompt"><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-drawer-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div data-content=""><div aria-role="menu" class="Box--overlay my-drawer-content" data-drawer-content="" id="my-drawer-content-id"><div id="focus-wrap-my-drawer-content-id" phx-hook="Phoenix.FocusWrap" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-drawer-content-id-start" tabindex="0" aria-hidden="true"></span>Content<span id="focus-wrap-my-drawer-content-id-end" tabindex="0" aria-hidden="true"></span></div></div></div></div>
             """
             |> format_html()
  end
end
