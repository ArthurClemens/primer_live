defmodule PrimerLive.TestComponents.SelectMenuTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Slot: item (various types)" do
    assigns = []

    assert rendered_to_string(~H"""
           <.select_menu>
             <:toggle>Menu</:toggle>
             <:item>
               Button
             </:item>
             <:item is_divider>
               Divider
             </:item>
             <:item href="#url">
               href ink
             </:item>
             <:item navigate="#url">
               navigate lLink
             </:item>
             <:item patch="#url">
               patch link
             </:item>
             <:item is_divider />
             <:item>
               Button
             </:item>
           </.select_menu>
           """)
           |> format_html() ==
             """
             <details class="details-reset details-overlay">
             <summary class="btn" aria-haspopup="true">Menu</summary>
             <div class="SelectMenu SelectMenu--hasFilter">
             <div class="SelectMenu-modal">
             <div class="SelectMenu-list"><button class="SelectMenu-item" role="menuitem">Button</button>
             <div class="SelectMenu-divider" role="separator">Divider</div>
             <a href="#url" class="SelectMenu-item" role="menuitem">href ink</a>
             <a href="#url" data-phx-link="redirect" data-phx-link-state="push" class="SelectMenu-item"
             role="menuitem">navigate lLink</a>
             <a href="#url" data-phx-link="patch" data-phx-link-state="push" class="SelectMenu-item" role="menuitem">patch
             link</a>
             <hr class="SelectMenu-divider" /><button class="SelectMenu-item" role="menuitem">Button</button>
             </div>
             </div>
             </div>
             </details>
             """
             |> format_html()
  end

  test "Slot: item (various types, is_disabled)" do
    assigns = []

    assert rendered_to_string(~H"""
           <.select_menu>
             <:toggle>Menu</:toggle>
             <:item is_disabled>
               Button
             </:item>
             <:item href="#url" is_disabled>
               Link
             </:item>
           </.select_menu>
           """)
           |> format_html() ==
             """
             <details class="details-reset details-overlay">
             <summary class="btn" aria-haspopup="true">Menu</summary>
             <div class="SelectMenu SelectMenu--hasFilter">
             <div class="SelectMenu-modal">
             <div class="SelectMenu-list"><button class="SelectMenu-item" role="menuitem" disabled="true">Button</button><a
             href="#url" aria-disabled="true" class="SelectMenu-item" role="menuitem">Link</a></div>
             </div>
             </div>
             </details>
             """
             |> format_html()
  end

  test "Slot: item (is_selected)" do
    assigns = []

    assert rendered_to_string(~H"""
           <.select_menu>
             <:toggle>Menu</:toggle>
             <:item is_selected>
               Button
             </:item>
             <:item is_divider>
               Divider
             </:item>
             <:item href="#url" is_selected>
               Link
             </:item>
             <:item is_divider />
             <:item>
               Button
             </:item>
           </.select_menu>
           """)
           |> format_html() ==
             """
             <details class="details-reset details-overlay">
             <summary class="btn" aria-haspopup="true">Menu</summary>
             <div class="SelectMenu SelectMenu--hasFilter">
             <div class="SelectMenu-modal">
             <div class="SelectMenu-list"><button class="SelectMenu-item" role="menuitemcheckbox" aria-checked="true"><svg
             class="octicon SelectMenu-icon SelectMenu-icon--check" xmlns="http://www.w3.org/2000/svg" width="16"
             height="16" viewBox="0 0 16 16">
             <path fill-rule="evenodd"
              d="M13.78 4.22a.75.75 0 010 1.06l-7.25 7.25a.75.75 0 01-1.06 0L2.22 9.28a.75.75 0 011.06-1.06L6 10.94l6.72-6.72a.75.75 0 011.06 0z">
             </path>
             </svg>Button</button>
             <div class="SelectMenu-divider" role="separator">Divider</div><a href="#url" aria-checked="true"
             class="SelectMenu-item" role="menuitemcheckbox"><svg class="octicon SelectMenu-icon SelectMenu-icon--check"
             xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">
             <path fill-rule="evenodd"
              d="M13.78 4.22a.75.75 0 010 1.06l-7.25 7.25a.75.75 0 01-1.06 0L2.22 9.28a.75.75 0 011.06-1.06L6 10.94l6.72-6.72a.75.75 0 011.06 0z">
             </path>
             </svg>Link</a>
             <hr class="SelectMenu-divider" /><button class="SelectMenu-item" role="menuitem"><svg
             class="octicon SelectMenu-icon SelectMenu-icon--check" xmlns="http://www.w3.org/2000/svg" width="16"
             height="16" viewBox="0 0 16 16">
             <path fill-rule="evenodd"
              d="M13.78 4.22a.75.75 0 010 1.06l-7.25 7.25a.75.75 0 01-1.06 0L2.22 9.28a.75.75 0 011.06-1.06L6 10.94l6.72-6.72a.75.75 0 011.06 0z">
             </path>
             </svg>Button</button>
             </div>
             </div>
             </div>
             </details>
             """
             |> format_html()
  end

  test "Slot: menu with title" do
    assigns = []

    assert rendered_to_string(~H"""
           <.select_menu id="my-menu-id">
             <:toggle>Menu</:toggle>
             <:menu title="Title" />
             <:item>
               Item 1
             </:item>
             <:item>
               Item 2
             </:item>
           </.select_menu>
           """)
           |> format_html() ==
             """
             <details id="my-menu-id" class="details-reset details-overlay" data-menu-id="my-menu-id">
             <summary class="btn" aria-haspopup="true">Menu</summary>
             <div class="SelectMenu SelectMenu--hasFilter">
             <div class="SelectMenu-modal">
             <header class="SelectMenu-header">
             <h3 class="SelectMenu-title">Title</h3><button class="SelectMenu-closeButton" type="button"
             phx-click="[[&quot;remove_attr&quot;,{&quot;attr&quot;:&quot;open&quot;,&quot;to&quot;:&quot;[data-menu-id=my-menu-id]&quot;}]]"><svg
             class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">
             <path fill-rule="evenodd"
              d="M3.72 3.72a.75.75 0 011.06 0L8 6.94l3.22-3.22a.75.75 0 111.06 1.06L9.06 8l3.22 3.22a.75.75 0 11-1.06 1.06L8 9.06l-3.22 3.22a.75.75 0 01-1.06-1.06L6.94 8 3.72 4.78a.75.75 0 010-1.06z">
             </path>
             </svg></button>
             </header>
             <div class="SelectMenu-list"><button class="SelectMenu-item" role="menuitem">Item 1</button><button
             class="SelectMenu-item" role="menuitem">Item 2</button></div>
             </div>
             </div>
             </details>
             """
             |> format_html()
  end

  test "Slot: footer" do
    assigns = []

    assert rendered_to_string(~H"""
           <.select_menu>
             <:toggle>Menu</:toggle>
             <:item>
               Item 1
             </:item>
             <:item>
               Item 2
             </:item>
             <:footer>Footer</:footer>
           </.select_menu>
           """)
           |> format_html() ==
             """
             <details class="details-reset details-overlay">
             <summary class="btn" aria-haspopup="true">Menu</summary>
             <div class="SelectMenu SelectMenu--hasFilter">
             <div class="SelectMenu-modal">
             <div class="SelectMenu-list"><button class="SelectMenu-item" role="menuitem">Item 1</button><button
             class="SelectMenu-item" role="menuitem">Item 2</button></div>
             <div class="SelectMenu-footer">Footer</div>
             </div>
             </div>
             </details>
             """
             |> format_html()
  end

  test "Slot: filter" do
    assigns = []

    assert rendered_to_string(~H"""
           <.select_menu>
             <:toggle>Menu</:toggle>
             <:filter>
               <form>
                 <.text_input class="SelectMenu-input" type="search" name="q" placeholder="Filter" />
               </form>
             </:filter>
             <:item>
               Item 1
             </:item>
             <:item>
               Item 2
             </:item>
           </.select_menu>
           """)
           |> format_html() ==
             """
             <details class="details-reset details-overlay">
             <summary class="btn" aria-haspopup="true">Menu</summary>
             <div class="SelectMenu SelectMenu--hasFilter">
             <div class="SelectMenu-modal">
             <div class="SelectMenu-filter">
             <form><input aria-label="Filter" class="form-control SelectMenu-input" id="_" name="q" placeholder="Filter"
             type="search" /></form>
             </div>
             <div class="SelectMenu-list"><button class="SelectMenu-item" role="menuitem">Item 1</button><button
             class="SelectMenu-item" role="menuitem">Item 2</button></div>
             </div>
             </div>
             </details>
             """
             |> format_html()
  end

  test "Slot: loading" do
    assigns = []

    assert rendered_to_string(~H"""
           <.select_menu>
             <:toggle>Menu</:toggle>
             <:loading><.octicon name="copilot-48" class="anim-pulse" /></:loading>
           </.select_menu>
           """)
           |> format_html() ==
             """
             <details class="details-reset details-overlay">
             <summary class="btn" aria-haspopup="true">Menu</summary>
             <div class="SelectMenu SelectMenu--hasFilter">
             <div class="SelectMenu-modal">
             <div class="SelectMenu-loading"><svg class="octicon anim-pulse" xmlns="http://www.w3.org/2000/svg" width="48"
             height="48" viewBox="0 0 48 48">
             <path d="M21 29.5a1.5 1.5 0 00-3 0v4a1.5 1.5 0 003 0v-4zm9 0a1.5 1.5 0 00-3 0v4a1.5 1.5 0 003 0v-4z"></path>
             <path fill-rule="evenodd"
             d="M34.895 8.939c1.89.602 3.378 1.472 4.41 2.73 1.397 1.703 1.736 3.837 1.55 6.19l.016.032 1.684 3.79.964.193a3.5 3.5 0 012.161 1.398l1.668 2.335A3.5 3.5 0 0148 27.64v4.86c0 1.058-.619 1.973-1.129 2.585-.56.673-1.273 1.308-1.934 1.836a26.506 26.506 0 01-2.597 1.824l-.048.029h-.001l-.012.008-.021.014-.058.035a27.766 27.766 0 01-1.358.773 37.77 37.77 0 01-3.883 1.79C33.69 42.69 29.123 44 24 44c-5.123 0-9.69-1.311-12.959-2.605a38.242 38.242 0 01-3.884-1.79 27.695 27.695 0 01-1.357-.773 9.58 9.58 0 01-.08-.05l-.011-.007-.001-.001-.048-.03c-.041-.025-.1-.06-.173-.107a26.538 26.538 0 01-2.424-1.716c-.66-.528-1.373-1.163-1.934-1.836C.619 34.473 0 33.558 0 32.5v-4.86c0-.729.228-1.44.652-2.033l1.668-2.335a3.5 3.5 0 012.161-1.398l.964-.193 1.684-3.79.015-.032c-.185-2.353.154-4.487 1.55-6.19 1.033-1.258 2.52-2.128 4.411-2.73C15.84 6.82 19.71 5.5 24 5.5c4.29 0 8.16 1.321 10.895 3.439zm2.913 9.285c-.21 1.875-.621 2.956-1.283 3.586-.169.16-.376.312-.636.445-.78.4-2.034.631-4.145.447a9.143 9.143 0 01-.389-.043c-1.889-.245-2.93-1.005-3.568-1.948a4.634 4.634 0 01-.192-.31c-.607-1.066-.897-2.503-.968-4.24-.095-2.368.35-3.665 1.021-4.31.623-.599 1.877-1.034 4.506-.514 2.668.527 4.082 1.322 4.832 2.235.721.88 1.047 2.144.869 4.174-.014.165-.03.324-.047.478zM23.643 20.5a70.806 70.806 0 00.714 0c.238.666.547 1.304.946 1.894 1.263 1.866 3.286 3.044 6.18 3.297 3.115.273 5.498-.171 7.11-1.707.439-.418.792-.89 1.078-1.404l.329.74v13.327c-.163.092-.353.197-.57.312a35.236 35.236 0 01-3.576 1.647C32.809 39.811 28.627 41 24 41c-4.627 0-8.81-1.189-11.854-2.395a35.236 35.236 0 01-3.577-1.647c-.216-.115-.406-.22-.569-.312V23.318l.329-.74c.286.515.639.987 1.077 1.405 1.613 1.536 3.996 1.98 7.111 1.707 2.894-.253 4.917-1.431 6.18-3.297.4-.59.708-1.228.946-1.894zm-12.514.907c.107.152.222.286.346.404.675.643 1.966 1.138 4.78.892 2.139-.187 3.277-.985 3.958-1.99.067-.1.131-.203.192-.31.607-1.067.897-2.504.968-4.242.095-2.367-.35-3.664-1.021-4.309-.623-.599-1.877-1.034-4.506-.514-2.668.527-4.082 1.322-4.832 2.235-.721.88-1.047 2.144-.869 4.174.157 1.796.474 2.934.984 3.66zM22.5 17a1 1 0 011-1h1a1 1 0 110 2h-1a1 1 0 01-1-1z">
             </path>
             </svg></div>
             <div class="SelectMenu-list"></div>
             </div>
             </div>
             </details>
             """
             |> format_html()
  end

  test "Slot: blankslate" do
    assigns = []

    assert rendered_to_string(~H"""
           <.select_menu>
             <:toggle>Menu</:toggle>
             <:blankslate>Blankslate content</:blankslate>
           </.select_menu>
           """)
           |> format_html() ==
             """
             <details class="details-reset details-overlay">
             <summary class="btn" aria-haspopup="true">Menu</summary>
             <div class="SelectMenu SelectMenu--hasFilter">
             <div class="SelectMenu-modal">
             <div class="SelectMenu-list">
             <div class="SelectMenu-blankslate">Blankslate content</div>
             </div>
             </div>
             </div>
             </details>
             """
             |> format_html()
  end

  test "Attribute: is_borderless" do
    assigns = []

    assert rendered_to_string(~H"""
           <.select_menu is_borderless>
             <:toggle>Menu</:toggle>
             <:item>
               Item 1
             </:item>
             <:item>
               Item 2
             </:item>
           </.select_menu>
           """)
           |> format_html() ==
             """
             <details class="details-reset details-overlay">
             <summary class="btn" aria-haspopup="true">Menu</summary>
             <div class="SelectMenu SelectMenu--hasFilter">
             <div class="SelectMenu-modal">
             <div class="SelectMenu-list SelectMenu-list--borderless"><button class="SelectMenu-item" role="menuitem">Item
             1</button><button class="SelectMenu-item" role="menuitem">Item 2</button></div>
             </div>
             </div>
             </details>
             """
             |> format_html()
  end

  test "Attribute: is_right_aligned" do
    assigns = []

    assert rendered_to_string(~H"""
           <.select_menu is_right_aligned>
             <:toggle>Menu</:toggle>
             <:item>
               Item 1
             </:item>
             <:item>
               Item 2
             </:item>
           </.select_menu>
           """)
           |> format_html() ==
             """
             <details class="details-reset details-overlay">
             <summary class="btn" aria-haspopup="true">Menu</summary>
             <div class="SelectMenu right-0 SelectMenu--hasFilter">
             <div class="SelectMenu-modal">
             <div class="SelectMenu-list"><button class="SelectMenu-item" role="menuitem">Item 1</button><button
             class="SelectMenu-item" role="menuitem">Item 2</button></div>
             </div>
             </div>
             </details>
             """
             |> format_html()
  end
end
