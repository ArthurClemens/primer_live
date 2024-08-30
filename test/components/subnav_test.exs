defmodule PrimerLive.Components.SubnavTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Attribute is_wrap" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.subnav is_wrap>
             Content
           </.subnav>
           """)
           |> format_html() ==
             """
             <div class="subnav pl-subnav--wrap">Content</div>
             """
             |> format_html()
  end

  test "Subnav with component subnav_links" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.subnav aria-label="Menu">
             <.subnav_links>
               <:item href="#url" is_selected>
                 href link
               </:item>
               <:item navigate="#url">
                 navigate link
               </:item>
               <:item patch="#url">
                 patch link
               </:item>
               <:item>
                 Other content
               </:item>
             </.subnav_links>
           </.subnav>
           """)
           |> format_html() ==
             """
             <div aria-label="Menu" class="subnav">
             <nav class="subnav-links"><a href="#url" class="subnav-item" aria-current="page">href link</a><a href="#url"
             data-phx-link="redirect" data-phx-link-state="push" class="subnav-item">navigate link</a><a href="#url"
             data-phx-link="patch" data-phx-link-state="push" class="subnav-item">patch link</a>Other content</nav>
             </div>
             """
             |> format_html()
  end

  test "Subnav with component subnav_search" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.subnav>
             <.subnav_search>
               <.text_input type="search" name="site-search" />
             </.subnav_search>
           </.subnav>
           """)
           |> format_html() ==
             """
             <div class="subnav">
             <div class="subnav-search float-left">
             <input class="FormControl-input FormControl-medium" id="site-search" name="site-search" type="search" />
             <svg class="octicon subnav-search-icon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M11.5 7a4.499 4.499 0 11-8.998 0A4.499 4.499 0 0111.5 7zm-.82 4.74a6 6 0 111.06-1.06l3.04 3.04a.75.75 0 11-1.06 1.06l-3.04-3.04z"></path></svg>
             </div>
             </div>
             """
             |> format_html()
  end

  test "Subnav with component subnav_search_context" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.subnav>
             <.subnav_search_context>
               <.select_menu is_dropdown_caret id="querty">
                 <:toggle>Menu</:toggle>
                 <:item>Item 1</:item>
                 <:item>Item 2</:item>
                 <:item>Item 3</:item>
               </.select_menu>
             </.subnav_search_context>
             <.subnav_search>
               <.text_input type="search" />
             </.subnav_search>
           </.subnav>
           """)
           |> format_html() ==
             """
             <div class="subnav"><div class="subnav-search-context float-left"><div data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#querty&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:130,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#querty&quot;,&quot;transition&quot;:[[&quot;duration-130&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isescapable="" data-isfast="" data-open="[[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#querty&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#querty [data-content]&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#querty&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="querty" phx-hook="Prompt"><label aria-haspopup="true" class="btn" for="querty-toggle" phx-click="[[&quot;dispatch&quot;,{&quot;to&quot;:&quot;#querty&quot;,&quot;event&quot;:&quot;prompt:toggle&quot;}]]">Menu<div class="dropdown-caret"></div></label><div data-prompt-content=""><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#querty&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div class="SelectMenu"><div aria-role="menu" class="SelectMenu-modal" data-content=""><div id="focus-wrap-querty" phx-hook="Phoenix.FocusWrap" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#querty&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-querty-start" tabindex="0" aria-hidden="true"></span><div class="SelectMenu-list"><button class="SelectMenu-item" role="menuitem">Item 1</button><button class="SelectMenu-item" role="menuitem">Item 2</button><button class="SelectMenu-item" role="menuitem">Item 3</button></div><span id="focus-wrap-querty-end" tabindex="0" aria-hidden="true"></span></div></div></div></div></div></div><div class="subnav-search float-left"><input class="FormControl-input FormControl-medium" type="search" /><svg class="octicon subnav-search-icon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">STRIPPED_SVG_PATHS</svg></div></div>
             """
             |> format_html()
  end

  test "Attribute: classes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.subnav class="my-links-subnav">
             <.subnav_links class="my-subnav-links">
               <:item href="#url" is_selected>
                 Link 1
               </:item>
               <:item navigate="#url">
                 Link 2
               </:item>
             </.subnav_links>
           </.subnav>
           <.subnav class="my-search-subnav">
             <.subnav_search_context class="my-subnav-search-context">
               <.select_menu is_dropdown_caret id="querty">
                 <:toggle>Menu</:toggle>
                 <:item>Item 1</:item>
                 <:item>Item 2</:item>
                 <:item>Item 3</:item>
               </.select_menu>
             </.subnav_search_context>
             <.subnav_search class="my-subnav-search">
               <.text_input type="search" name="site-search" />
             </.subnav_search>
           </.subnav>
           """)
           |> format_html() ==
             """
             <div class="subnav my-links-subnav"><nav class="subnav-links my-subnav-links"><a href="#url" class="subnav-item" aria-current="page">Link 1</a><a href="#url" data-phx-link="redirect" data-phx-link-state="push" class="subnav-item">Link 2</a></nav></div><div class="subnav my-search-subnav"><div class="subnav-search-context float-left my-subnav-search-context"><div data-cancel="[[&quot;exec&quot;,{&quot;attr&quot;:&quot;data-close&quot;}]]" data-close="[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#querty&quot;}],[&quot;remove_class&quot;,{&quot;time&quot;:130,&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#querty&quot;,&quot;transition&quot;:[[&quot;duration-130&quot;],[&quot;&quot;],[&quot;&quot;]]}],[&quot;pop_focus&quot;,{}]]" data-isescapable="" data-isfast="" data-open="[[&quot;add_class&quot;,{&quot;names&quot;:[&quot;is-open&quot;],&quot;to&quot;:&quot;#querty&quot;}],[&quot;focus_first&quot;,{&quot;to&quot;:&quot;#querty [data-content]&quot;}],[&quot;add_class&quot;,{&quot;time&quot;:30,&quot;names&quot;:[&quot;is-showing&quot;],&quot;to&quot;:&quot;#querty&quot;,&quot;transition&quot;:[[&quot;duration-30&quot;],[&quot;&quot;],[&quot;&quot;]]}]]" data-prompt="" id="querty" phx-hook="Prompt"><label aria-haspopup="true" class="btn" for="querty-toggle" phx-click="[[&quot;dispatch&quot;,{&quot;to&quot;:&quot;#querty&quot;,&quot;event&quot;:&quot;prompt:toggle&quot;}]]">Menu<div class="dropdown-caret"></div></label><div data-prompt-content=""><div data-touch="" phx-click="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#querty&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]"></div><div class="SelectMenu"><div aria-role="menu" class="SelectMenu-modal" data-content=""><div id="focus-wrap-querty" phx-hook="Phoenix.FocusWrap" phx-window-keydown="[[&quot;exec&quot;,{&quot;to&quot;:&quot;#querty&quot;,&quot;attr&quot;:&quot;data-cancel&quot;}]]" phx-key="Escape" data-focuswrap=""><span id="focus-wrap-querty-start" tabindex="0" aria-hidden="true"></span><div class="SelectMenu-list"><button class="SelectMenu-item" role="menuitem">Item 1</button><button class="SelectMenu-item" role="menuitem">Item 2</button><button class="SelectMenu-item" role="menuitem">Item 3</button></div><span id="focus-wrap-querty-end" tabindex="0" aria-hidden="true"></span></div></div></div></div></div></div><div class="subnav-search float-left my-subnav-search"><input class="FormControl-input FormControl-medium" id="site-search" name="site-search" type="search" /><svg class="octicon subnav-search-icon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">STRIPPED_SVG_PATHS</svg></div></div>
             """
             |> format_html()
  end
end
