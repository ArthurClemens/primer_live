defmodule PrimerLive.TestComponents.DialogTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Basic" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dialog id="my-dialog-id">
             Message
           </.dialog>
           """)
           |> format_html() ==
             """
             <div data-isescapable="" data-prompt="" id="my-dialog-id" phx-hook="Prompt" phx-remove="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-close&quot;}]]" data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;phx-remove&quot;}]]" data-open="[[&quot;set_attr&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:[&quot;style&quot;,&quot;--prompt-transition-duration: 180ms; --prompt-fast-transition-duration: 180ms;&quot;]}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-dialog-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}]]" data-close="[[&quot;set_attr&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:[&quot;style&quot;,&quot;--prompt-transition-duration: 180ms; --prompt-fast-transition-duration: 180ms;&quot;]}],[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:180,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-180&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]"><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap" data-focuswrap phx-key="Escape" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"><span id="focus-wrap-my-dialog-id-start" tabindex="0" aria-hidden="true"></span><div class="Box d-flex flex-column Box--overlay" data-content=""><div class="overflow-auto">Message</div></div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span></div></div>
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
             <div data-isescapable="" data-prompt="" id="my-dialog-id" phx-hook="Prompt" phx-remove="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-close&quot;}]]" data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;phx-remove&quot;}]]" data-open="[[&quot;set_attr&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:[&quot;style&quot;,&quot;--prompt-transition-duration: 180ms; --prompt-fast-transition-duration: 180ms;&quot;]}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-dialog-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}]]" data-close="[[&quot;set_attr&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:[&quot;style&quot;,&quot;--prompt-transition-duration: 180ms; --prompt-fast-transition-duration: 180ms;&quot;]}],[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:180,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-180&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]"><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap" data-focuswrap phx-key="Escape" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"><span id="focus-wrap-my-dialog-id-start" tabindex="0" aria-hidden="true"></span><div class="Box d-flex flex-column Box--overlay Box-overlay--narrow" data-content=""><div class="overflow-auto">Message</div></div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span></div></div>
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
             <div data-isescapable="" data-prompt="" id="my-dialog-id" phx-hook="Prompt" phx-remove="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-close&quot;}]]" data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;phx-remove&quot;}]]" data-open="[[&quot;set_attr&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:[&quot;style&quot;,&quot;--prompt-transition-duration: 180ms; --prompt-fast-transition-duration: 180ms;&quot;]}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-dialog-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}]]" data-close="[[&quot;set_attr&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:[&quot;style&quot;,&quot;--prompt-transition-duration: 180ms; --prompt-fast-transition-duration: 180ms;&quot;]}],[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:180,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-180&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]"><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap" data-focuswrap phx-key="Escape" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"><span id="focus-wrap-my-dialog-id-start" tabindex="0" aria-hidden="true"></span><div class="Box d-flex flex-column Box--overlay Box-overlay--wide" data-content=""><div class="overflow-auto">Message</div></div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span></div></div>
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
             <div data-isescapable="" data-isfast="" data-prompt="" id="my-dialog-id" phx-hook="Prompt" phx-remove="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-close&quot;}]]" data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;phx-remove&quot;}]]" data-open="[[&quot;set_attr&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:[&quot;style&quot;,&quot;--prompt-transition-duration: 180ms; --prompt-fast-transition-duration: 180ms;&quot;]}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-dialog-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}]]" data-close="[[&quot;set_attr&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:[&quot;style&quot;,&quot;--prompt-transition-duration: 180ms; --prompt-fast-transition-duration: 180ms;&quot;]}],[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:180,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-180&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]"><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap" data-focuswrap phx-key="Escape" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"><span id="focus-wrap-my-dialog-id-start" tabindex="0" aria-hidden="true"></span><div class="Box d-flex flex-column Box--overlay" data-content=""><div class="overflow-auto">Message</div></div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span></div></div>
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
             <div data-isescapable="" data-prompt="" id="my-dialog-id" phx-hook="Prompt" phx-remove="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-close&quot;}]]" data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;phx-remove&quot;}]]" data-open="[[&quot;set_attr&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:[&quot;style&quot;,&quot;--prompt-transition-duration: 180ms; --prompt-fast-transition-duration: 180ms;&quot;]}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-dialog-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}]]" data-close="[[&quot;set_attr&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:[&quot;style&quot;,&quot;--prompt-transition-duration: 180ms; --prompt-fast-transition-duration: 180ms;&quot;]}],[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:180,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-180&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]"><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap" data-focuswrap phx-key="Escape" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"><span id="focus-wrap-my-dialog-id-start" tabindex="0" aria-hidden="true"></span><div class="Box d-flex flex-column Box--overlay" data-content=""><div class="overflow-auto">Message</div></div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span></div></div>
             """
             |> format_html()
  end

  test "Attribute: focus_after_opening" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.dialog id="my-dialog-id" focus_after_opening="[name=first_name]">
             Message
           </.dialog>
           """)
           |> format_html() ==
             """
             <div data-isescapable="" data-prompt="" id="my-dialog-id" phx-hook="Prompt" phx-remove="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-close&quot;}]]" data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;phx-remove&quot;}]]" data-open="[[&quot;set_attr&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:[&quot;style&quot;,&quot;--prompt-transition-duration: 180ms; --prompt-fast-transition-duration: 180ms;&quot;]}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-dialog-id [data-content]&quot;}],[&quot;focus&quot;,{&quot;to&quot;:&quot;[name=first_name]&quot;}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}]]" data-close="[[&quot;set_attr&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:[&quot;style&quot;,&quot;--prompt-transition-duration: 180ms; --prompt-fast-transition-duration: 180ms;&quot;]}],[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:180,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-180&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]"><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap" data-focuswrap phx-key="Escape" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"><span id="focus-wrap-my-dialog-id-start" tabindex="0" aria-hidden="true"></span><div class="Box d-flex flex-column Box--overlay" data-content=""><div class="overflow-auto">Message</div></div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span></div></div>
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
             <div data-isescapable="" data-prompt="" id="my-dialog-id" phx-hook="Prompt" phx-remove="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-close&quot;}]]" data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;phx-remove&quot;}]]" data-open="[[&quot;set_attr&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:[&quot;style&quot;,&quot;--prompt-transition-duration: 180ms; --prompt-fast-transition-duration: 180ms;&quot;]}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-dialog-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}]]" data-close="[[&quot;set_attr&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:[&quot;style&quot;,&quot;--prompt-transition-duration: 180ms; --prompt-fast-transition-duration: 180ms;&quot;]}],[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:180,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-180&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]"><div data-backdrop=""></div><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap" data-focuswrap phx-key="Escape" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"><span id="focus-wrap-my-dialog-id-start" tabindex="0" aria-hidden="true"></span><div class="Box d-flex flex-column Box--overlay" data-content=""><div class="overflow-auto">Message</div></div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span></div></div>
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
             <div data-isescapable="" data-prompt="" id="my-dialog-id" phx-hook="Prompt" phx-remove="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-close&quot;}]]" data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;phx-remove&quot;}]]" data-open="[[&quot;set_attr&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:[&quot;style&quot;,&quot;--prompt-transition-duration: 180ms; --prompt-fast-transition-duration: 180ms;&quot;]}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-dialog-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}]]" data-close="[[&quot;set_attr&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:[&quot;style&quot;,&quot;--prompt-transition-duration: 180ms; --prompt-fast-transition-duration: 180ms;&quot;]}],[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:180,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-180&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]"><div data-backdrop="" data-isdark=""></div><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap" data-focuswrap phx-key="Escape" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"><span id="focus-wrap-my-dialog-id-start" tabindex="0" aria-hidden="true"></span><div class="Box d-flex flex-column Box--overlay" data-content=""><div class="overflow-auto">Message</div></div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span></div></div>
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
             <div data-isescapable="" data-prompt="" id="my-dialog-id" phx-hook="Prompt" phx-remove="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-close&quot;}]]" data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;phx-remove&quot;}]]" data-open="[[&quot;set_attr&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:[&quot;style&quot;,&quot;--prompt-transition-duration: 180ms; --prompt-fast-transition-duration: 180ms;&quot;]}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-dialog-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}]]" data-close="[[&quot;set_attr&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:[&quot;style&quot;,&quot;--prompt-transition-duration: 180ms; --prompt-fast-transition-duration: 180ms;&quot;]}],[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:180,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-180&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]"><div data-backdrop="" data-islight=""></div><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap" data-focuswrap phx-key="Escape" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"><span id="focus-wrap-my-dialog-id-start" tabindex="0" aria-hidden="true"></span><div class="Box d-flex flex-column Box--overlay" data-content=""><div class="overflow-auto">Message</div></div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span></div></div>
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
             <div data-isescapable="" data-prompt="" id="my-dialog-id" phx-hook="Prompt" phx-remove="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-close&quot;}]]" data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;phx-remove&quot;}]]" data-open="[[&quot;set_attr&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:[&quot;style&quot;,&quot;--prompt-transition-duration: 180ms; --prompt-fast-transition-duration: 180ms;&quot;]}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-dialog-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}]]" data-close="[[&quot;set_attr&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:[&quot;style&quot;,&quot;--prompt-transition-duration: 180ms; --prompt-fast-transition-duration: 180ms;&quot;]}],[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:180,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-180&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]"><div data-touch=""></div><div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap" data-focuswrap phx-key="Escape" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"><span id="focus-wrap-my-dialog-id-start" tabindex="0" aria-hidden="true"></span><div class="Box d-flex flex-column Box--overlay" data-content=""><div class="overflow-auto">Message</div></div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span></div></div>
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
             <div data-isescapable="" data-prompt="" id="my-dialog-id" phx-hook="Prompt" phx-remove="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-close&quot;}]]" data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;phx-remove&quot;}]]" data-open="[[&quot;set_attr&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:[&quot;style&quot;,&quot;--prompt-transition-duration: 180ms; --prompt-fast-transition-duration: 180ms;&quot;]}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-dialog-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}]]" data-close="[[&quot;set_attr&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:[&quot;style&quot;,&quot;--prompt-transition-duration: 180ms; --prompt-fast-transition-duration: 180ms;&quot;]}],[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:180,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-180&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]"><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap" data-focuswrap phx-key="Escape" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"><span id="focus-wrap-my-dialog-id-start" tabindex="0" aria-hidden="true"></span><div class="Box d-flex flex-column Box--overlay" data-content="" style="max-height: 50%; max-width: 90%"><div class="overflow-auto">Message</div></div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span></div></div>
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
             <div data-isescapable="" data-prompt="" id="my-dialog-id" phx-hook="Prompt" phx-remove="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-close&quot;}]]" data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;phx-remove&quot;}]]" data-open="[[&quot;set_attr&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:[&quot;style&quot;,&quot;--prompt-transition-duration: 180ms; --prompt-fast-transition-duration: 180ms;&quot;]}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-dialog-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}]]" data-close="[[&quot;set_attr&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:[&quot;style&quot;,&quot;--prompt-transition-duration: 180ms; --prompt-fast-transition-duration: 180ms;&quot;]}],[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:180,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-180&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]"><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap" data-focuswrap phx-key="Escape" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"><span id="focus-wrap-my-dialog-id-start" tabindex="0" aria-hidden="true"></span><div class="Box d-flex flex-column Box--overlay" data-content="" style="max-height: 50vh; max-width: 80vw"><div class="overflow-auto">Message</div></div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span></div></div>
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
             <div data-isescapable="" data-prompt="" id="my-dialog-id" phx-hook="Prompt" phx-remove="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-close&quot;}]]" data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;phx-remove&quot;}]]" data-open="[[&quot;set_attr&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:[&quot;style&quot;,&quot;--prompt-transition-duration: 180ms; --prompt-fast-transition-duration: 180ms;&quot;]}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-dialog-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}]]" data-close="[[&quot;set_attr&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:[&quot;style&quot;,&quot;--prompt-transition-duration: 180ms; --prompt-fast-transition-duration: 180ms;&quot;]}],[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:180,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-180&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]"><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap" data-focuswrap phx-key="Escape" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"><span id="focus-wrap-my-dialog-id-start" tabindex="0" aria-hidden="true"></span><div class="Box d-flex flex-column Box--overlay" data-content=""><div class="Box-header d-flex flex-justify-between flex-items-start"><h3 class="Box-title">Dialog title</h3><button aria-label="Close" class="close-button Box-btn-octicon btn-octicon flex-shrink-0" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" type="button"><span class="pl-button__content"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">STRIPPED_SVG_PATHS</svg></span></button></div><div class="overflow-auto">Message<div class="Box-body">Body message</div><div class="Box-row">Row 1</div><div class="Box-row">Row 2</div></div><div class="Box-footer">Footer</div></div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span></div></div>
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
             <div class="dialog-wrapper-x my-dialog" data-isescapable="" data-prompt="" id="my-dialog-id" phx-hook="Prompt" phx-remove="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-close&quot;}]]" data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;phx-remove&quot;}]]" data-open="[[&quot;set_attr&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:[&quot;style&quot;,&quot;--prompt-transition-duration: 180ms; --prompt-fast-transition-duration: 180ms;&quot;]}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#my-dialog-id [data-content]&quot;}],[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}]]" data-close="[[&quot;set_attr&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:[&quot;style&quot;,&quot;--prompt-transition-duration: 180ms; --prompt-fast-transition-duration: 180ms;&quot;]}],[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:180,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;transition&quot;:[[&quot;duration-180&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]"><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap" data-focuswrap phx-key="Escape" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"><span id="focus-wrap-my-dialog-id-start" tabindex="0" aria-hidden="true"></span><div class="Box d-flex flex-column box-x Box--overlay dialog-x" data-content=""><div class="Box-header header-x d-flex flex-justify-between flex-items-start"><h3 class="Box-title header_title-x my-header-title">Dialog title</h3><button aria-label="Close" class="close-button Box-btn-octicon btn-octicon flex-shrink-0" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#my-dialog-id&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" type="button"><span class="pl-button__content"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">STRIPPED_SVG_PATHS</svg></span></button></div><div class="overflow-auto">Message<div class="Box-body body-x my-body">Body message</div><div class="Box-row row-x my-row">Row 1</div><div class="Box-row row-x">Row 2</div></div><div class="Box-footer footer-x my-footer">Footer</div></div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span></div></div>
             """
             |> format_html()
  end
end
