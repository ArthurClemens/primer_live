defmodule PrimerLive.TestComponents.DialogTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  @default_general_style ~S"""
  details [data-elem=dialog-main] {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, calc(-50% - 15px));
    z-index: 999;
    overflow: auto;
    /* Defaults */
    margin: 0 auto;
    max-height: 80vh;
    max-width: 90vw;
    }
  """

  @default_dialog_style ~S"""
  details[data-dialogid=my-dialog-id] [data-elem=dialog-main] {
    max-height: 80vh;
    max-width: 90vw;
    }
  """

  test "Basic" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dialog id="my-dialog-id">
             <:toggle>Open dialog</:toggle>
             Message
           </.dialog>
           """)
           |> format_html() ==
             """
             <style>
             #{@default_general_style}
             #{@default_dialog_style}
             </style>
             <details id="my-dialog-id" class="details-reset details-overlay" data-dialogid="my-dialog-id">
             <summary class="btn" aria-haspopup="dialog">Open dialog</summary>
             <div id="my-dialog-id" phx-hook="Phoenix.FocusWrap"><span id="my-dialog-id-start" tabindex="0"
                 aria-hidden="true"></span>
               <div class="Box d-flex flex-column Box--overlay anim-fade-in fast" data-elem="dialog-main">
                 <div class="overflow-auto"></div>
               </div><span id="my-dialog-id-end" tabindex="0" aria-hidden="true"></span>
             </div>
             </details>
             """
             |> format_html()
  end

  test "Attribute: is_narrow" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dialog id="my-dialog-id" is_narrow>
             <:toggle>Open dialog</:toggle>
             Message
           </.dialog>
           """)
           |> format_html() ==
             """
             <style>
             #{@default_general_style}
             #{@default_dialog_style}
             </style>
             <details id="my-dialog-id" class="details-reset details-overlay" data-dialogid="my-dialog-id">
             <summary class="btn" aria-haspopup="dialog">Open dialog</summary>
             <div id="my-dialog-id" phx-hook="Phoenix.FocusWrap"><span id="my-dialog-id-start" tabindex="0"
             aria-hidden="true"></span>
             <div class="Box d-flex flex-column Box-overlay--narrow anim-fade-in fast" data-elem="dialog-main">
             <div class="overflow-auto"></div>
             </div><span id="my-dialog-id-end" tabindex="0" aria-hidden="true"></span>
             </div>
             </details>
             """
             |> format_html()
  end

  test "Attribute: is_wide" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dialog id="my-dialog-id" is_wide>
             <:toggle>Open dialog</:toggle>
             Message
           </.dialog>
           """)
           |> format_html() ==
             """
             <style>
             #{@default_general_style}
             #{@default_dialog_style}
             </style>
             <details id="my-dialog-id" class="details-reset details-overlay" data-dialogid="my-dialog-id">
             <summary class="btn" aria-haspopup="dialog">Open dialog</summary>
             <div id="my-dialog-id" phx-hook="Phoenix.FocusWrap"><span id="my-dialog-id-start" tabindex="0"
             aria-hidden="true"></span>
             <div class="Box d-flex flex-column Box-overlay--wide anim-fade-in fast" data-elem="dialog-main">
             <div class="overflow-auto"></div>
             </div><span id="my-dialog-id-end" tabindex="0" aria-hidden="true"></span>
             </div>
             </details>
             """
             |> format_html()
  end

  test "Attribute: is_backdrop" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dialog id="my-dialog-id" is_backdrop>
             <:toggle>Open dialog</:toggle>
             Message
           </.dialog>
           """)
           |> format_html() ==
             """
             <style>
             #{@default_general_style}
             #{@default_dialog_style}
             </style>
             <details id="my-dialog-id" class="details-reset details-overlay details-overlay-dark" data-dialogid="my-dialog-id">
             <summary class="btn" aria-haspopup="dialog">Open dialog</summary>
             <div id="my-dialog-id" phx-hook="Phoenix.FocusWrap"><span id="my-dialog-id-start" tabindex="0"
                 aria-hidden="true"></span>
               <div class="Box d-flex flex-column Box--overlay anim-fade-in fast" data-elem="dialog-main">
                 <div class="overflow-auto"></div>
               </div><span id="my-dialog-id-end" tabindex="0" aria-hidden="true"></span>
             </div>
             </details>
             """
             |> format_html()
  end

  test "Attribute: is_modal" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dialog id="my-dialog-id" is_modal>
             <:toggle>Open dialog</:toggle>
             Message
           </.dialog>
           """)
           |> format_html() ==
             """
             <style>
             #{@default_general_style}
             #{@default_dialog_style}
             details[data-dialogid=my-dialog-id][open]>summary {
             pointer-events: none;
             }
             </style>
             <details id="my-dialog-id" class="details-reset details-overlay" data-dialogid="my-dialog-id">
             <summary class="btn" aria-haspopup="dialog">Open dialog</summary>
             <div id="my-dialog-id" phx-hook="Phoenix.FocusWrap"><span id="my-dialog-id-start" tabindex="0"
             aria-hidden="true"></span>
             <div class="Box d-flex flex-column Box--overlay anim-fade-in fast" data-elem="dialog-main">
             <div class="overflow-auto"></div>
             </div><span id="my-dialog-id-end" tabindex="0" aria-hidden="true"></span>
             </div>
             </details>
             """
             |> format_html()
  end

  test "Attribute: max_height (50%)" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dialog id="my-dialog-id" max_height="50%">
             <:toggle>Open dialog</:toggle>
             Message
           </.dialog>
           """)
           |> format_html() ==
             """
             <style>
             #{@default_general_style}
             details[data-dialogid=my-dialog-id] [data-elem=dialog-main] {
              max-height: 50%;
              max-width: 90vw;
              }
             </style>
             <details id="my-dialog-id" class="details-reset details-overlay" data-dialogid="my-dialog-id">
             <summary class="btn" aria-haspopup="dialog">Open dialog</summary>
             <div id="my-dialog-id" phx-hook="Phoenix.FocusWrap"><span id="my-dialog-id-start" tabindex="0"
             aria-hidden="true"></span>
             <div class="Box d-flex flex-column Box--overlay anim-fade-in fast" data-elem="dialog-main">
             <div class="overflow-auto"></div>
             </div><span id="my-dialog-id-end" tabindex="0" aria-hidden="true"></span>
             </div>
             </details>
             """
             |> format_html()
  end

  test "Attribute: max_height (50vh)" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dialog id="my-dialog-id" max_height="50vh">
             <:toggle>Open dialog</:toggle>
             Message
           </.dialog>
           """)
           |> format_html() ==
             """
             <style>
             #{@default_general_style}
             details[data-dialogid=my-dialog-id] [data-elem=dialog-main] {
              max-height: 50vh;
              max-width: 90vw;
              }
             </style>
             <details id="my-dialog-id" class="details-reset details-overlay" data-dialogid="my-dialog-id">
             <summary class="btn" aria-haspopup="dialog">Open dialog</summary>
             <div id="my-dialog-id" phx-hook="Phoenix.FocusWrap"><span id="my-dialog-id-start" tabindex="0"
             aria-hidden="true"></span>
             <div class="Box d-flex flex-column Box--overlay anim-fade-in fast" data-elem="dialog-main">
             <div class="overflow-auto"></div>
             </div><span id="my-dialog-id-end" tabindex="0" aria-hidden="true"></span>
             </div>
             </details>
             """
             |> format_html()
  end

  test "All slots" do
    assigns = []

    assert rendered_to_string(~H"""
           <.dialog id="my-dialog-id">
             <:toggle>Open dialog</:toggle>
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
             <style>
             #{@default_general_style}
             #{@default_dialog_style}
             </style>
             <details id="my-dialog-id" class="details-reset details-overlay" data-dialogid="my-dialog-id">
             <summary class="btn" aria-haspopup="dialog">Open dialog</summary>
             <div id="my-dialog-id" phx-hook="Phoenix.FocusWrap"><span id="my-dialog-id-start" tabindex="0"
             aria-hidden="true"></span>
             <div class="Box d-flex flex-column Box--overlay anim-fade-in fast" data-elem="dialog-main">
             <div class="Box-header d-flex flex-justify-between flex-items-start">
             <h3 class="Box-title">Dialog title</h3><button class="close-button Box-btn-octicon btn-octicon flex-shrink-0"
             type="button" aria-label="Close"
             phx-click="[[&quot;remove_attr&quot;,{&quot;attr&quot;:&quot;open&quot;,&quot;to&quot;:&quot;[data-dialogid=my-dialog-id]&quot;}]]"><svg
             class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">
             <path fill-rule="evenodd"
              d="M3.72 3.72a.75.75 0 011.06 0L8 6.94l3.22-3.22a.75.75 0 111.06 1.06L9.06 8l3.22 3.22a.75.75 0 11-1.06 1.06L8 9.06l-3.22 3.22a.75.75 0 01-1.06-1.06L6.94 8 3.72 4.78a.75.75 0 010-1.06z">
             </path>
             </svg></button>
             </div>
             <div class="overflow-auto">
             <div class="Box-body">Body message</div>
             <div class="Box-row">Row 1</div>
             <div class="Box-row">Row 2</div>
             </div>
             <div class="Box-footer">Footer</div>
             </div><span id="my-dialog-id-end" tabindex="0" aria-hidden="true"></span>
             </div>
             </details>
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
             <:toggle class="my-toggle">Open dialog</:toggle>
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
             <style>
             #{@default_general_style}
             #{@default_dialog_style}
             </style>
             <details id="my-dialog-id" class="details-reset details-overlay dialog-wrapper-x my-dialog" data-dialogid="my-dialog-id">
             <summary class="toggle-x my-toggle" aria-haspopup="dialog">Open dialog</summary>
             <div id="my-dialog-id" phx-hook="Phoenix.FocusWrap"><span id="my-dialog-id-start" tabindex="0"
             aria-hidden="true"></span>
             <div class="Box d-flex flex-column box-x Box--overlay anim-fade-in fast dialog-x" data-elem="dialog-main">
             <div class="Box-header header-x d-flex flex-justify-between flex-items-start">
             <h3 class="Box-title header_title-x my-header-title">Dialog title</h3><button
             class="close-button Box-btn-octicon btn-octicon flex-shrink-0" type="button" aria-label="Close"
             phx-click="[[&quot;remove_attr&quot;,{&quot;attr&quot;:&quot;open&quot;,&quot;to&quot;:&quot;[data-dialogid=my-dialog-id]&quot;}]]"><svg
             class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">
             <path fill-rule="evenodd"
              d="M3.72 3.72a.75.75 0 011.06 0L8 6.94l3.22-3.22a.75.75 0 111.06 1.06L9.06 8l3.22 3.22a.75.75 0 11-1.06 1.06L8 9.06l-3.22 3.22a.75.75 0 01-1.06-1.06L6.94 8 3.72 4.78a.75.75 0 010-1.06z">
             </path>
             </svg></button>
             </div>
             <div class="overflow-auto">
             <div class="Box-body body-x my-body">Body message</div>
             <div class="Box-row row-x my-row">Row 1</div>
             <div class="Box-row row-x">Row 2</div>
             </div>
             <div class="Box-footer footer-x my-footer">Footer</div>
             </div><span id="my-dialog-id-end" tabindex="0" aria-hidden="true"></span>
             </div>
             </details>
             """
             |> format_html()
  end
end
