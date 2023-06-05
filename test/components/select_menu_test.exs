defmodule PrimerLive.TestComponents.SelectMenuTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Slot: item (various types)" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.select_menu id="querty">
             <:toggle>Menu</:toggle>
             <:item>
               Button
             </:item>
             <:item is_divider>
               Divider
             </:item>
             <:item href="#url">
               href link
             </:item>
             <:item navigate="#url">
               navigate link
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
             <div data-prompt="" id="querty" phx-hook="Prompt" data-isfast=""><label class="btn" aria-haspopup="true"
             for="querty-toggle">Menu</label><input aria-hidden="true" id="querty-toggle" name="[]"
             onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-touch="" onclick="window.Prompt &amp;&amp; Prompt.hide(this)"></div>
             <div class="SelectMenu">
             <div class="SelectMenu-modal" data-content="" aria-role="menu">
                <div class="SelectMenu-list"><button class="SelectMenu-item" role="menuitem">Button</button>
                    <div class="SelectMenu-divider" role="separator">Divider</div><a href="#url" class="SelectMenu-item"
                        role="menuitem">href link</a><a href="#url" data-phx-link="redirect" data-phx-link-state="push"
                        class="SelectMenu-item" role="menuitem">navigate link</a><a href="#url" data-phx-link="patch"
                        data-phx-link-state="push" class="SelectMenu-item" role="menuitem">patch link</a>
                    <hr class="SelectMenu-divider" /><button class="SelectMenu-item" role="menuitem">Button</button>
                </div>
             </div>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Slot: item (various types, is_disabled)" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.select_menu id="querty">
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
             <div data-prompt="" id="querty" phx-hook="Prompt" data-isfast=""><label class="btn" aria-haspopup="true"
             for="querty-toggle">Menu</label><input aria-hidden="true" id="querty-toggle" name="[]"
             onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-touch="" onclick="window.Prompt &amp;&amp; Prompt.hide(this)"></div>
             <div class="SelectMenu">
             <div class="SelectMenu-modal" data-content="" aria-role="menu">
                <div class="SelectMenu-list"><button class="SelectMenu-item" role="menuitem"
                        disabled="true">Button</button><a href="#url" aria-disabled="true" class="SelectMenu-item"
                        role="menuitem">Link</a></div>
             </div>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Slot: item (is_selected)" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.select_menu id="querty">
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
             <div data-prompt="" id="querty" phx-hook="Prompt" data-isfast=""><label class="btn" aria-haspopup="true"
             for="querty-toggle">Menu</label><input aria-hidden="true" id="querty-toggle" name="[]"
             onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-touch="" onclick="window.Prompt &amp;&amp; Prompt.hide(this)"></div>
             <div class="SelectMenu">
             <div class="SelectMenu-modal" data-content="" aria-role="menu">
                <div class="SelectMenu-list"><button class="SelectMenu-item" role="menuitemcheckbox"
                        aria-checked="true"><svg class="octicon SelectMenu-icon SelectMenu-icon--check"
                            xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                            viewBox="0 0 16 16">STRIPPED_SVG_PATHS</svg>Button</button>
                    <div class="SelectMenu-divider" role="separator">Divider</div><a href="#url" aria-checked="true"
                        class="SelectMenu-item" role="menuitemcheckbox"><svg
                            class="octicon SelectMenu-icon SelectMenu-icon--check" xmlns="http://www.w3.org/2000/svg"
                            width="16" height="16" viewBox="0 0 16 16">STRIPPED_SVG_PATHS</svg>Link</a>
                    <hr class="SelectMenu-divider" /><button class="SelectMenu-item" role="menuitem"><svg
                            class="octicon SelectMenu-icon SelectMenu-icon--check" xmlns="http://www.w3.org/2000/svg"
                            width="16" height="16" viewBox="0 0 16 16">STRIPPED_SVG_PATHS</svg>Button</button>
                </div>
             </div>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Slot: menu with title" do
    assigns = %{}

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
             <div data-prompt="" id="my-menu-id" phx-hook="Prompt" data-isfast=""><label class="btn" aria-haspopup="true"
             for="my-menu-id-toggle">Menu</label><input aria-hidden="true" id="my-menu-id-toggle" name="[]"
             onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-touch="" onclick="window.Prompt &amp;&amp; Prompt.hide(this)"></div>
             <div class="SelectMenu">
             <div class="SelectMenu-modal" data-content="" aria-role="menu">
                <header class="SelectMenu-header">
                    <h3 class="SelectMenu-title">Title</h3><button class="SelectMenu-closeButton" type="button"
                        onclick="Prompt.hide(this)"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16"
                            height="16" viewBox="0 0 16 16">STRIPPED_SVG_PATHS</svg></button>
                </header>
                <div class="SelectMenu-list"><button class="SelectMenu-item" role="menuitem">Item 1</button><button
                        class="SelectMenu-item" role="menuitem">Item 2</button></div>
             </div>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Slot: footer" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.select_menu id="querty">
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
             <div data-prompt="" id="querty" phx-hook="Prompt" data-isfast=""><label class="btn" aria-haspopup="true"
             for="querty-toggle">Menu</label><input aria-hidden="true" id="querty-toggle" name="[]"
             onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-touch="" onclick="window.Prompt &amp;&amp; Prompt.hide(this)"></div>
             <div class="SelectMenu">
             <div class="SelectMenu-modal" data-content="" aria-role="menu">
                <div class="SelectMenu-list"><button class="SelectMenu-item" role="menuitem">Item 1</button><button
                        class="SelectMenu-item" role="menuitem">Item 2</button></div>
                <div class="SelectMenu-footer">Footer</div>
             </div>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Slot: filter" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.select_menu id="querty">
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
             <div data-prompt="" id="querty" phx-hook="Prompt" data-isfast=""><label class="btn" aria-haspopup="true"
             for="querty-toggle">Menu</label><input aria-hidden="true" id="querty-toggle" name="[]"
             onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-touch="" onclick="window.Prompt &amp;&amp; Prompt.hide(this)"></div>
             <div class="SelectMenu SelectMenu--hasFilter">
                 <div class="SelectMenu-modal" data-content="" aria-role="menu">
                     <div class="SelectMenu-filter">
                         <form><input aria-label="Filter" class="FormControl-input FormControl-medium SelectMenu-input"
                                 id="q" name="q" placeholder="Filter" type="search" /></form>
                     </div>
                     <div class="SelectMenu-list"><button class="SelectMenu-item" role="menuitem">Item 1</button><button
                             class="SelectMenu-item" role="menuitem">Item 2</button></div>
                 </div>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Slot: tab" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.select_menu id="querty">
             <:toggle>Menu</:toggle>
             <:tab is_selected>
               Selected tab
             </:tab>
             <:tab>
               Other tab
             </:tab>
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
             <div data-prompt="" id="querty" phx-hook="Prompt" data-isfast=""><label class="btn" aria-haspopup="true"
             for="querty-toggle">Menu</label><input aria-hidden="true" id="querty-toggle" name="[]"
             onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-touch="" onclick="window.Prompt &amp;&amp; Prompt.hide(this)"></div>
             <div class="SelectMenu">
             <div class="SelectMenu-modal" data-content="" aria-role="menu">
                <div class="SelectMenu-tabs"><button class="SelectMenu-tab" role="tab" aria-selected="true">Selected
                        tab</button><button class="SelectMenu-tab" role="tab">Other tab</button></div>
                <div class="SelectMenu-list"><button class="SelectMenu-item" role="menuitem">Item 1</button><button
                        class="SelectMenu-item" role="menuitem">Item 2</button></div>
             </div>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Slot: loading" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.select_menu id="querty">
             <:toggle>Menu</:toggle>
             <:loading><.octicon name="copilot-48" class="anim-pulse" /></:loading>
           </.select_menu>
           """)
           |> format_html() ==
             """
             <div data-prompt="" id="querty" phx-hook="Prompt" data-isfast=""><label class="btn" aria-haspopup="true"
             for="querty-toggle">Menu</label><input aria-hidden="true" id="querty-toggle" name="[]"
             onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-touch="" onclick="window.Prompt &amp;&amp; Prompt.hide(this)"></div>
             <div class="SelectMenu">
             <div class="SelectMenu-modal" data-content="" aria-role="menu">
                <div class="SelectMenu-loading"><svg class="octicon anim-pulse" xmlns="http://www.w3.org/2000/svg"
                        width="48" height="48" viewBox="0 0 48 48">STRIPPED_SVG_PATHSSTRIPPED_SVG_PATHS</svg></div>
                <div class="SelectMenu-list"></div>
             </div>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Slot: blankslate" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.select_menu id="querty">
             <:toggle>Menu</:toggle>
             <:blankslate>Blankslate content</:blankslate>
           </.select_menu>
           """)
           |> format_html() ==
             """
             <div data-prompt="" id="querty" phx-hook="Prompt" data-isfast=""><label class="btn" aria-haspopup="true"
             for="querty-toggle">Menu</label><input aria-hidden="true" id="querty-toggle" name="[]"
             onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-touch="" onclick="window.Prompt &amp;&amp; Prompt.hide(this)"></div>
             <div class="SelectMenu">
             <div class="SelectMenu-modal" data-content="" aria-role="menu">
                <div class="SelectMenu-list">
                    <div class="SelectMenu-blankslate">Blankslate content</div>
                </div>
             </div>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Slot: message" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.select_menu id="querty">
             <:toggle>Menu</:toggle>
             <:message class="color-bg-danger color-fg-danger">Message</:message>
           </.select_menu>
           """)
           |> format_html() ==
             """
             <div data-prompt="" id="querty" phx-hook="Prompt" data-isfast=""><label class="btn" aria-haspopup="true"
             for="querty-toggle">Menu</label><input aria-hidden="true" id="querty-toggle" name="[]"
             onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-touch="" onclick="window.Prompt &amp;&amp; Prompt.hide(this)"></div>
             <div class="SelectMenu">
             <div class="SelectMenu-modal" data-content="" aria-role="menu">
                <div class="SelectMenu-message color-bg-danger color-fg-danger">Message</div>
                <div class="SelectMenu-list"></div>
             </div>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: is_borderless" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.select_menu is_borderless id="querty">
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
             <div data-prompt="" id="querty" phx-hook="Prompt" data-isfast=""><label class="btn" aria-haspopup="true"
             for="querty-toggle">Menu</label><input aria-hidden="true" id="querty-toggle" name="[]"
             onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-touch="" onclick="window.Prompt &amp;&amp; Prompt.hide(this)"></div>
             <div class="SelectMenu">
             <div class="SelectMenu-modal" data-content="" aria-role="menu">
                <div class="SelectMenu-list SelectMenu-list--borderless"><button class="SelectMenu-item"
                        role="menuitem">Item 1</button><button class="SelectMenu-item" role="menuitem">Item 2</button>
                </div>
             </div>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: is_right_aligned" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.select_menu is_right_aligned id="querty">
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
             <div data-prompt="" id="querty" phx-hook="Prompt" data-isfast=""><label class="btn" aria-haspopup="true"
             for="querty-toggle">Menu</label><input aria-hidden="true" id="querty-toggle" name="[]"
             onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-touch="" onclick="window.Prompt &amp;&amp; Prompt.hide(this)"></div>
             <div class="SelectMenu right-0">
             <div class="SelectMenu-modal" data-content="" aria-role="menu">
                <div class="SelectMenu-list"><button class="SelectMenu-item" role="menuitem">Item 1</button><button
                        class="SelectMenu-item" role="menuitem">Item 2</button></div>
             </div>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Classes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.select_menu
             classes={
               %{
                 select_menu: "select_menu-x",
                 blankslate: "blankslate-x",
                 caret: "caret-x",
                 divider: "divider-x",
                 filter: "filter-x",
                 footer: "footer-x",
                 header_close_button: "header_close_button-x",
                 header: "header-x",
                 item: "item-x",
                 loading: "loading-x",
                 menu_container: "menu_container-x",
                 menu_list: "menu_list-x",
                 menu_title: "menu_title-x",
                 menu: "menu-x",
                 message: "message-x",
                 tabs: "tabs-x",
                 tab: "tab-x",
                 toggle: "toggle-x"
               }
             }
             class="my-select-menu"
             id="my-menu-id"
             is_dropdown_caret
           >
             <:toggle class="my-toggle">Menu</:toggle>
             <:blankslate class="my-blankslate">Blankslate content</:blankslate>
             <:loading class="my-loading"><.octicon name="copilot-48" class="anim-pulse" /></:loading>
             <:menu title="Title" class="my-menu" />
             <:filter class="my-filter">
               Filter
             </:filter>
             <:item class="my-item">
               Item 1
             </:item>
             <:item>
               Item 2
             </:item>
             <:tab is_selected class="my-tab">
               Selected tab
             </:tab>
             <:tab>
               Other tab
             </:tab>
             <:message class="my-message">Message</:message>
             <:footer class="my-footer">Footer</:footer>
           </.select_menu>
           """)
           |> format_html() ==
             """
             <div class="select_menu-x my-select-menu" data-prompt="" id="my-menu-id" phx-hook="Prompt" data-isfast=""><label
             class="toggle-x my-toggle" aria-haspopup="true" for="my-menu-id-toggle">Menu<div class="dropdown-caret caret-x">
             </div></label><input aria-hidden="true" id="my-menu-id-toggle" name="[]"
             onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-touch="" onclick="window.Prompt &amp;&amp; Prompt.hide(this)"></div>
             <div class="SelectMenu SelectMenu--hasFilter menu-x">
             <div class="SelectMenu-modal menu_container-x" data-content="" aria-role="menu">
                <header class="SelectMenu-header header-x">
                    <h3 class="SelectMenu-title menu_title-x">Title</h3><button
                        class="SelectMenu-closeButton header_close_button-x" type="button"
                        onclick="Prompt.hide(this)"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16"
                            height="16" viewBox="0 0 16 16">STRIPPED_SVG_PATHS</svg></button>
                </header>
                <div class="SelectMenu-message message-x my-message">Message</div>
                <div class="SelectMenu-filter filter-x">Filter</div>
                <div class="SelectMenu-tabs tabs-x"><button class="SelectMenu-tab tab-x my-tab" role="tab"
                        aria-selected="true">Selected tab</button><button class="SelectMenu-tab tab-x" role="tab">Other
                        tab</button></div>
                <div class="SelectMenu-loading loading-x my-loading"><svg class="octicon anim-pulse"
                        xmlns="http://www.w3.org/2000/svg" width="48" height="48"
                        viewBox="0 0 48 48">STRIPPED_SVG_PATHSSTRIPPED_SVG_PATHS</svg></div>
                <div class="SelectMenu-list menu_list-x">
                    <div class="SelectMenu-blankslate blankslate-x my-blankslate">Blankslate content</div><button
                        class="SelectMenu-item item-x my-item" role="menuitem">Item 1</button><button
                        class="SelectMenu-item item-x" role="menuitem">Item 2</button>
                </div>
                <div class="SelectMenu-footer footer-x my-footer">Footer</div>
             </div>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Extra attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.select_menu dir="rtl" id="querty">
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
             <div dir="rtl" data-prompt="" id="querty" phx-hook="Prompt" data-isfast="">
             <label class="btn" aria-haspopup="true" for="querty-toggle">Menu</label>
             <input aria-hidden="true" id="querty-toggle" name="[]" onchange="window.Prompt &amp;&amp; Prompt.change(this)" type="checkbox" value="true" />
             <div data-prompt-content>
             <div data-touch="" onclick="window.Prompt &amp;&amp; Prompt.hide(this)"></div>
             <div class="SelectMenu">
             <div class="SelectMenu-modal" data-content="" aria-role="menu">
                <div class="SelectMenu-list"><button class="SelectMenu-item" role="menuitem">Item 1</button><button
                        class="SelectMenu-item" role="menuitem">Item 2</button></div>
             </div>
             </div>
             </div>
             </div>
             """
             |> format_html()
  end
end
