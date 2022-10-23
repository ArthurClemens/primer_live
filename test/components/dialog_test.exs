defmodule PrimerLive.TestComponents.DialogTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Basic" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dialog id="my-dialog-id">
             Message
           </.dialog>
           """)
           |> format_html() ==
             """
             <div id="my-dialog-id" data-prompt="">
             <div data-touch="">
             <div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap"><span id="focus-wrap-my-dialog-id-start" tabindex="0"
             aria-hidden="true"></span>
             <div class="Box d-flex flex-column Box--overlay" data-content="">
             <div class="overflow-auto">Message</div>
             </div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: is_narrow" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dialog id="my-dialog-id" is_narrow>
             Message
           </.dialog>
           """)
           |> format_html() ==
             """
             <div id="my-dialog-id" data-prompt="">
             <div data-touch="">
             <div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap"><span id="focus-wrap-my-dialog-id-start" tabindex="0"
             aria-hidden="true"></span>
             <div class="Box d-flex flex-column Box--overlay Box-overlay--narrow" data-content="">
             <div class="overflow-auto">Message</div>
             </div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: is_wide" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dialog id="my-dialog-id" is_wide>
             Message
           </.dialog>
           """)
           |> format_html() ==
             """
             <div id="my-dialog-id" data-prompt="">
             <div data-touch="">
             <div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap"><span id="focus-wrap-my-dialog-id-start" tabindex="0"
             aria-hidden="true"></span>
             <div class="Box d-flex flex-column Box--overlay Box-overlay--wide" data-content="">
             <div class="overflow-auto">Message</div>
             </div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: is_fast" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dialog id="my-dialog-id" is_fast>
             Message
           </.dialog>
           """)
           |> format_html() ==
             """
             <div id="my-dialog-id" data-prompt="" data-isfast="">
             <div data-touch="">
             <div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap"><span id="focus-wrap-my-dialog-id-start" tabindex="0"
             aria-hidden="true"></span>
             <div class="Box d-flex flex-column Box--overlay" data-content="">
             <div class="overflow-auto">Message</div>
             </div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: is_escapable" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dialog id="my-dialog-id" is_escapable>
             Message
           </.dialog>
           """)
           |> format_html() ==
             """
             <div id="my-dialog-id" data-prompt="" data-isescapable="">
             <div data-touch="">
             <div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap"><span id="focus-wrap-my-dialog-id-start" tabindex="0"
             aria-hidden="true"></span>
             <div class="Box d-flex flex-column Box--overlay" data-content="">
             <div class="overflow-auto">Message</div>
             </div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: is_backdrop" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dialog id="my-dialog-id" is_backdrop>
             Message
           </.dialog>
           """)
           |> format_html() ==
             """
             <div id="my-dialog-id" data-prompt="">
             <div data-touch="">
             <div data-backdrop="" data-ismedium=""></div>
             <div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap"><span id="focus-wrap-my-dialog-id-start" tabindex="0"
             aria-hidden="true"></span>
             <div class="Box d-flex flex-column Box--overlay" data-content="">
             <div class="overflow-auto">Message</div>
             </div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: is_dark_backdrop" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dialog id="my-dialog-id" is_dark_backdrop>
             Message
           </.dialog>
           """)
           |> format_html() ==
             """
             <div id="my-dialog-id" data-prompt="">
             <div data-touch="">
             <div data-backdrop="" data-isdark=""></div>
             <div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap"><span id="focus-wrap-my-dialog-id-start" tabindex="0"
             aria-hidden="true"></span>
             <div class="Box d-flex flex-column Box--overlay" data-content="">
             <div class="overflow-auto">Message</div>
             </div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: is_light_backdrop" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dialog id="my-dialog-id" is_light_backdrop>
             Message
           </.dialog>
           """)
           |> format_html() ==
             """
             <div id="my-dialog-id" data-prompt="">
             <div data-touch="">
             <div data-backdrop="" data-islight=""></div>
             <div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap"><span id="focus-wrap-my-dialog-id-start" tabindex="0"
             aria-hidden="true"></span>
             <div class="Box d-flex flex-column Box--overlay" data-content="">
             <div class="overflow-auto">Message</div>
             </div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: is_modal" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dialog id="my-dialog-id" is_modal>
             Message
           </.dialog>
           """)
           |> format_html() ==
             """
             <div id="my-dialog-id" data-prompt="" data-ismodal="">
             <div data-touch="">
             <div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap"><span id="focus-wrap-my-dialog-id-start" tabindex="0"
             aria-hidden="true"></span>
             <div class="Box d-flex flex-column Box--overlay" data-content="">
             <div class="overflow-auto">Message</div>
             </div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: max_height and max_width (%)" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dialog id="my-dialog-id" max_height="50%" max_width="90%">
             Message
           </.dialog>
           """)
           |> format_html() ==
             """
             <div id="my-dialog-id" data-prompt="">
             <div data-touch="">
             <div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap"><span id="focus-wrap-my-dialog-id-start" tabindex="0"
             aria-hidden="true"></span>
             <div class="Box d-flex flex-column Box--overlay" data-content="" style="max-height: 50%; max-width: 90%">
             <div class="overflow-auto">Message</div>
             </div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: max_height and max_width (vh, vw)" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dialog id="my-dialog-id" max_height="50vh" max_width="80vw">
             Message
           </.dialog>
           """)
           |> format_html() ==
             """
             <div id="my-dialog-id" data-prompt="">
             <div data-touch="">
             <div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap"><span id="focus-wrap-my-dialog-id-start" tabindex="0"
             aria-hidden="true"></span>
             <div class="Box d-flex flex-column Box--overlay" data-content="" style="max-height: 50vh; max-width: 80vw">
             <div class="overflow-auto">Message</div>
             </div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "All slots" do
    assigns = []

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
             <div id="my-dialog-id" data-prompt="">
             <div data-touch="">
             <div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap"><span id="focus-wrap-my-dialog-id-start" tabindex="0"
             aria-hidden="true"></span>
             <div class="Box d-flex flex-column Box--overlay" data-content="">
             <div class="Box-header d-flex flex-justify-between flex-items-start">
             <h3 class="Box-title">Dialog title</h3><button class="close-button Box-btn-octicon btn-octicon flex-shrink-0"
             type="button" aria-label="Close" onclick="Prompt.hide(this)"><svg class="octicon"
              xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">
              <path fill-rule="evenodd"
                d="M3.72 3.72a.75.75 0 011.06 0L8 6.94l3.22-3.22a.75.75 0 111.06 1.06L9.06 8l3.22 3.22a.75.75 0 11-1.06 1.06L8 9.06l-3.22 3.22a.75.75 0 01-1.06-1.06L6.94 8 3.72 4.78a.75.75 0 010-1.06z">
              </path>
             </svg></button>
             </div>
             <div class="overflow-auto">Message<div class="Box-body">Body message</div>
             <div class="Box-row">Row 1</div>
             <div class="Box-row">Row 2</div>
             </div>
             <div class="Box-footer">Footer</div>
             </div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Classes" do
    assigns = []

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
             <div class="dialog-wrapper-x my-dialog" id="my-dialog-id" data-prompt="">
             <div data-touch="">
             <div id="focus-wrap-my-dialog-id" phx-hook="Phoenix.FocusWrap"><span id="focus-wrap-my-dialog-id-start" tabindex="0"
             aria-hidden="true"></span>
             <div class="Box d-flex flex-column box-x Box--overlay dialog-x" data-content="">
             <div class="Box-header header-x d-flex flex-justify-between flex-items-start">
             <h3 class="Box-title header_title-x my-header-title">Dialog title</h3><button
             class="close-button Box-btn-octicon btn-octicon flex-shrink-0" type="button" aria-label="Close"
             onclick="Prompt.hide(this)"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16"
              viewBox="0 0 16 16">
              <path fill-rule="evenodd"
                d="M3.72 3.72a.75.75 0 011.06 0L8 6.94l3.22-3.22a.75.75 0 111.06 1.06L9.06 8l3.22 3.22a.75.75 0 11-1.06 1.06L8 9.06l-3.22 3.22a.75.75 0 01-1.06-1.06L6.94 8 3.72 4.78a.75.75 0 010-1.06z">
              </path>
             </svg></button>
             </div>
             <div class="overflow-auto">Message<div class="Box-body body-x my-body">Body message</div>
             <div class="Box-row row-x my-row">Row 1</div>
             <div class="Box-row row-x">Row 2</div>
             </div>
             <div class="Box-footer footer-x my-footer">Footer</div>
             </div><span id="focus-wrap-my-dialog-id-end" tabindex="0" aria-hidden="true"></span>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end
end
