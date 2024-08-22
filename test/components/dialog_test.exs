defmodule PrimerLive.TestComponents.DialogTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers
  import Phoenix.Component
  import Phoenix.LiveViewTest
  alias Phoenix.LiveView.JS

  test "Basic" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dialog id="my-dialog-id">
             Message
           </.dialog>
           """)
           |> format_html() ==
             """
             <div data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:170,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-170&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isescapable="" data-open="[[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-dialog-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-dialog-id" phx-hook="Prompt"><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-dialog-id-start" tabindex="0" aria-hidden="true"></span><div class="Box d-flex flex-column Box--overlay" data-content=""><div class="overflow-auto">Message</div></div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span></div></div>
             """
             |> format_html()
  end

  test "Attribute: is_narrow" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dialog id="my-dialog-id" is_narrow>
             Message
           </.dialog>
           """)
           |> format_html() ==
             """
             <div data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:170,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-170&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isescapable="" data-open="[[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-dialog-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-dialog-id" phx-hook="Prompt"><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-dialog-id-start" tabindex="0" aria-hidden="true"></span><div class="Box d-flex flex-column Box--overlay Box-overlay--narrow" data-content=""><div class="overflow-auto">Message</div></div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span></div></div>
             """
             |> format_html()
  end

  test "Attribute: is_wide" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dialog id="my-dialog-id" is_wide>
             Message
           </.dialog>
           """)
           |> format_html() ==
             """
             <div data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:170,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-170&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isescapable="" data-open="[[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-dialog-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-dialog-id" phx-hook="Prompt"><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-dialog-id-start" tabindex="0" aria-hidden="true"></span><div class="Box d-flex flex-column Box--overlay Box-overlay--wide" data-content=""><div class="overflow-auto">Message</div></div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span></div></div>
             """
             |> format_html()
  end

  test "Attribute: is_fast" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dialog id="my-dialog-id" is_fast>
             Message
           </.dialog>
           """)
           |> format_html() ==
             """
             <div data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:170,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-170&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isescapable="" data-isfast="" data-open="[[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-dialog-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-dialog-id" phx-hook="Prompt"><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-dialog-id-start" tabindex="0" aria-hidden="true"></span><div class="Box d-flex flex-column Box--overlay" data-content=""><div class="overflow-auto">Message</div></div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span></div></div>
             """
             |> format_html()
  end

  test "Attribute: is_escapable" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dialog id="my-dialog-id" is_escapable>
             Message
           </.dialog>
           """)
           |> format_html() ==
             """
             <div data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:170,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-170&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isescapable="" data-open="[[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-dialog-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-dialog-id" phx-hook="Prompt"><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-dialog-id-start" tabindex="0" aria-hidden="true"></span><div class="Box d-flex flex-column Box--overlay" data-content=""><div class="overflow-auto">Message</div></div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span></div></div>
             """
             |> format_html()
  end

  test "Attribute: focus_after_opening_selector" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dialog id="my-dialog-id" focus_after_opening_selector="[name=first_name]">
             Message
           </.dialog>
           """)
           |> format_html() ==
             """
             <div data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:170,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-170&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isescapable="" data-open="[[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-dialog-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;focus&quot;,{&quot;to&quot;:&quot;[name=first_name]&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-dialog-id" phx-hook="Prompt"><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-dialog-id-start" tabindex="0" aria-hidden="true"></span><div class="Box d-flex flex-column Box--overlay" data-content=""><div class="overflow-auto">Message</div></div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span></div></div>
             """
             |> format_html()
  end

  test "Attribute: focus_after_closing_selector" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dialog id="my-dialog-id" focus_after_closing_selector="#button">
             Message
           </.dialog>
           """)
           |> format_html() ==
             """
             <div data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:170,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-170&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isescapable="" data-open="[[&quot;push_focus&quot;,{&quot;to&quot;:&quot;#button&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-dialog-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-dialog-id" phx-hook="Prompt"><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-dialog-id-start" tabindex="0" aria-hidden="true"></span><div class="Box d-flex flex-column Box--overlay" data-content=""><div class="overflow-auto">Message</div></div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span></div></div>
             """
             |> format_html()
  end

  test "Attribute: is_backdrop" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dialog id="my-dialog-id" is_backdrop>
             Message
           </.dialog>
           """)
           |> format_html() ==
             """
             <div data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:170,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-170&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isescapable="" data-open="[[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-dialog-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-dialog-id" phx-hook="Prompt"><div data-backdrop=""></div><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-dialog-id-start" tabindex="0" aria-hidden="true"></span><div class="Box d-flex flex-column Box--overlay" data-content=""><div class="overflow-auto">Message</div></div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span></div></div>
             """
             |> format_html()
  end

  test "Attribute: is_dark_backdrop" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dialog id="my-dialog-id" is_dark_backdrop>
             Message
           </.dialog>
           """)
           |> format_html() ==
             """
             <div data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:170,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-170&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isescapable="" data-open="[[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-dialog-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-dialog-id" phx-hook="Prompt"><div data-backdrop="" data-isdark=""></div><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-dialog-id-start" tabindex="0" aria-hidden="true"></span><div class="Box d-flex flex-column Box--overlay" data-content=""><div class="overflow-auto">Message</div></div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span></div></div>
             """
             |> format_html()
  end

  test "Attribute: is_light_backdrop" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dialog id="my-dialog-id" is_light_backdrop>
             Message
           </.dialog>
           """)
           |> format_html() ==
             """
             <div data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:170,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-170&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isescapable="" data-open="[[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-dialog-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-dialog-id" phx-hook="Prompt"><div data-backdrop="" data-islight=""></div><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-dialog-id-start" tabindex="0" aria-hidden="true"></span><div class="Box d-flex flex-column Box--overlay" data-content=""><div class="overflow-auto">Message</div></div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span></div></div>
             """
             |> format_html()
  end

  test "Attribute: is_modal" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dialog id="my-dialog-id" is_modal>
             Message
           </.dialog>
           """)
           |> format_html() ==
             """
             <div data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:170,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-170&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isescapable="" data-open="[[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-dialog-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-dialog-id" phx-hook="Prompt"><div data-touch=""></div><div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-dialog-id-start" tabindex="0" aria-hidden="true"></span><div class="Box d-flex flex-column Box--overlay" data-content=""><div class="overflow-auto">Message</div></div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span></div></div>
             """
             |> format_html()
  end

  test "Attribute: max_height and max_width (%)" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dialog id="my-dialog-id" max_height="50%" max_width="90%">
             Message
           </.dialog>
           """)
           |> format_html() ==
             """
             <div data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:170,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-170&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isescapable="" data-open="[[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-dialog-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-dialog-id" phx-hook="Prompt"><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-dialog-id-start" tabindex="0" aria-hidden="true"></span><div class="Box d-flex flex-column Box--overlay" data-content="" style="max-height: 50%; max-width: 90%"><div class="overflow-auto">Message</div></div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span></div></div>
             """
             |> format_html()
  end

  test "Attribute: max_height and max_width (vh, vw)" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dialog id="my-dialog-id" max_height="50vh" max_width="80vw">
             Message
           </.dialog>
           """)
           |> format_html() ==
             """
             <div data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:170,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-170&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isescapable="" data-open="[[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-dialog-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-dialog-id" phx-hook="Prompt"><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-dialog-id-start" tabindex="0" aria-hidden="true"></span><div class="Box d-flex flex-column Box--overlay" data-content="" style="max-height: 50vh; max-width: 80vw"><div class="overflow-auto">Message</div></div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span></div></div>
             """
             |> format_html()
  end

  test "Attribute: on_cancel" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dialog id="my-dialog-id" on_cancel={JS.patch("/dialog")}>
             Message
           </.dialog>
           """)
           |> format_html() ==
             """
             <div data-cancel="[[&quot;patch&quot;,{&quot;replace&quot;:false,&quot;href&quot;:&quot;/dialog&quot;}],[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:170,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-170&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isescapable="" data-open="[[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-dialog-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-dialog-id" phx-hook="Prompt" phx-remove="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-close&quot;}]]"><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-dialog-id-start" tabindex="0" aria-hidden="true"></span><div class="Box d-flex flex-column Box--overlay" data-content=""><div class="overflow-auto">Message</div></div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span></div></div>
             """
             |> format_html()
  end

  test "Attribute: transition_duration" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dialog id="my-dialog-id" transition_duration={500}>
             Message
           </.dialog>
           """)
           |> format_html() ==
             """
             <div data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;set_attr&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:[&quot;style&quot;,&quot;--prompt-transition-duration: 500ms; --prompt-fast-transition-duration: 500ms;&quot;]}],[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:500,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-500&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isescapable="" data-open="[[&quot;set_attr&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:[&quot;style&quot;,&quot;--prompt-transition-duration: 500ms; --prompt-fast-transition-duration: 500ms;&quot;]}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-dialog-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-dialog-id" phx-hook="Prompt"><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-dialog-id-start" tabindex="0" aria-hidden="true"></span><div class="Box d-flex flex-column Box--overlay" data-content=""><div class="overflow-auto">Message</div></div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span></div></div>
             """
             |> format_html()
  end

  test "Attribute: status_callback_selector" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dialog id="my-dialog-id" status_callback_selector="#container">
             Message
           </.dialog>
           """)
           |> format_html() ==
             """
             <div data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;dispatch&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;event&quot;:&quot;prompt:close&quot;,&quot;detail&quot;:{&quot;selector&quot;:&quot;#container&quot;}}],[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:170,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-170&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isescapable="" data-open="[[&quot;dispatch&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;event&quot;:&quot;prompt:open&quot;,&quot;detail&quot;:{&quot;selector&quot;:&quot;#container&quot;}}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-dialog-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-dialog-id" phx-hook="Prompt"><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-dialog-id-start" tabindex="0" aria-hidden="true"></span><div class="Box d-flex flex-column Box--overlay" data-content=""><div class="overflow-auto">Message</div></div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span></div></div>
             """
             |> format_html()
  end

  test "All slots" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dialog id="my-dialog-id">
             Message
             <:header_title>Dialog title</:header_title>
             <:body>Body message</:body>
             <:row>Row 1</:row>
             <:row>Row 2</:row>
             <:footer>Footer</:footer>
           </.dialog>
           """)
           |> format_html() ==
             """
             <div data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:170,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-170&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isescapable="" data-open="[[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-dialog-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-dialog-id" phx-hook="Prompt"><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-dialog-id-start" tabindex="0" aria-hidden="true"></span><div class="Box d-flex flex-column Box--overlay" data-content=""><div class="Box-header d-flex flex-justify-between flex-items-start"><h3 class="Box-title">Dialog title</h3><button aria-label="Close" class="close-button Box-btn-octicon btn-octicon flex-shrink-0" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" type="button"><span class="pl-button__content"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">STRIPPED_SVG_PATHS</svg></span></button></div><div class="overflow-auto">Message<div class="Box-body">Body message</div><div class="Box-row">Row 1</div><div class="Box-row">Row 2</div></div><div class="Box-footer">Footer</div></div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span></div></div>
             """
             |> format_html()
  end

  test "Classes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dialog
             id="my-dialog-id"
             class="my-dialog"
             classes={
               %{
                 dialog_wrapper: "dialog-wrapper-x",
                 toggle: "toggle-x",
                 dialog: "dialog-x",
                 box: "box-x",
                 header: "header-x",
                 row: "row-x",
                 body: "body-x",
                 footer: "footer-x",
                 header_title: "header_title-x",
                 link: "link-x"
               }
             }
           >
             Message
             <:header_title class="my-header-title">Dialog title</:header_title>
             <:body class="my-body">Body message</:body>
             <:row class="my-row">Row 1</:row>
             <:row>Row 2</:row>
             <:footer class="my-footer">Footer</:footer>
           </.dialog>
           """)
           |> format_html() ==
             """
             <div class="dialog-wrapper-x my-dialog" data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:170,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-170&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isescapable="" data-open="[[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-dialog-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="my-dialog-id" phx-hook="Prompt"><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-my-dialog-id-start" tabindex="0" aria-hidden="true"></span><div class="Box d-flex flex-column box-x Box--overlay dialog-x" data-content=""><div class="Box-header header-x d-flex flex-justify-between flex-items-start"><h3 class="Box-title header_title-x my-header-title">Dialog title</h3><button aria-label="Close" class="close-button Box-btn-octicon btn-octicon flex-shrink-0" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" type="button"><span class="pl-button__content"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">STRIPPED_SVG_PATHS</svg></span></button></div><div class="overflow-auto">Message<div class="Box-body body-x my-body">Body message</div><div class="Box-row row-x my-row">Row 1</div><div class="Box-row row-x">Row 2</div></div><div class="Box-footer footer-x my-footer">Footer</div></div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span></div></div>
             """
             |> format_html()
  end
end
