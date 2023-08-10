defmodule PrimerLive.TestComponents.ButtonTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Without attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.button>Button</.button>
           """)
           |> format_html() ==
             """
             <button class="btn" type="button"> Button </button>
             """
             |> format_html()
  end

  test "Anchor link button" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.button href="/home">href link</.button>
           <.button navigate="/home">navigate link</.button>
           <.button patch="/home">patch link</.button>
           """)
           |> format_html() ==
             """
             <a href="/home" class="btn">href link</a>
             <a href="/home" data-phx-link="redirect" data-phx-link-state="push" class="btn">navigate link</a>
             <a href="/home" data-phx-link="patch" data-phx-link-state="push" class="btn">patch link</a>
             """
             |> format_html()
  end

  test "Modifiers" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.button is_full_width>Button</.button>
           <.button is_close_button>Button</.button>
           <.button is_danger>Button</.button>
           <.button is_disabled>Button</.button>
           <.button is_icon_only>Button</.button>
           <.button is_invisible>Button</.button>
           <.button is_large>Button</.button>
           <.button is_link>Button</.button>
           <.button is_outline>Button</.button>
           <.button is_primary>Button</.button>
           <.button is_selected>Button</.button>
           <.button is_small>Button</.button>
           <.button is_submit>Button</.button>
           """)
           |> format_html() ==
             """
             <button class="btn btn-block" type="button">Button</button>
             <button class="close-button" type="button">Button</button>
             <button class="btn btn-danger" type="button">Button</button>
             <button aria-disabled="true" class="btn" type="button">Button</button>
             <button class="btn-octicon" type="button">Button</button>
             <button class="btn btn-invisible" type="button">Button</button>
             <button class="btn btn-large" type="button">Button</button>
             <button class="btn-link" type="button">Button</button>
             <button class="btn btn-outline" type="button">Button</button>
             <button class="btn btn-primary" type="button">Button</button>
             <button aria-selected="true" class="btn" type="button">Button</button>
             <button class="btn btn-sm" type="button">Button</button>
             <button class="btn" type="submit">Button</button>
             """
             |> format_html()
  end

  test "Button with icon" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.button><.octicon name="search-16" /></.button>
           """)
           |> format_html() ==
             """
             <button class="btn" type="button"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M11.5 7a4.499 4.499 0 11-8.998 0A4.499 4.499 0 0111.5 7zm-.82 4.74a6 6 0 111.06-1.06l3.04 3.04a.75.75 0 11-1.06 1.06l-3.04-3.04z"></path></svg></button>
             """
             |> format_html()
  end

  test "Button with caret" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.button is_dropdown_caret>
             Menu
           </.button>
           """)
           |> format_html() ==
             """
             <button class="btn" type="button">Menu<span class="dropdown-caret"></span></button>
             """
             |> format_html()
  end

  test "Option: is_icon_only" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.button is_icon_only aria-label="Desktop">
             <.octicon name="device-desktop-16" />
           </.button>
           """)
           |> format_html() ==
             """
             <button aria-label="Desktop" class="btn-octicon" type="button"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M1.75 2.5h12.5a.25.25 0 01.25.25v7.5a.25.25 0 01-.25.25H1.75a.25.25 0 01-.25-.25v-7.5a.25.25 0 01.25-.25zM14.25 1H1.75A1.75 1.75 0 000 2.75v7.5C0 11.216.784 12 1.75 12h3.727c-.1 1.041-.52 1.872-1.292 2.757A.75.75 0 004.75 16h6.5a.75.75 0 00.565-1.243c-.772-.885-1.193-1.716-1.292-2.757h3.727A1.75 1.75 0 0016 10.25v-7.5A1.75 1.75 0 0014.25 1zM9.018 12H6.982a5.72 5.72 0 01-.765 2.5h3.566a5.72 5.72 0 01-.765-2.5z"></path></svg></button>
             """
             |> format_html()
  end

  test "Option: is_icon_only and is_danger" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.button is_icon_only is_danger aria-label="Desktop">
             <.octicon name="device-desktop-16" />
           </.button>
           """)
           |> format_html() ==
             """
             <button aria-label="Desktop" class="btn-octicon btn-octicon-danger" type="button"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M1.75 2.5h12.5a.25.25 0 01.25.25v7.5a.25.25 0 01-.25.25H1.75a.25.25 0 01-.25-.25v-7.5a.25.25 0 01.25-.25zM14.25 1H1.75A1.75 1.75 0 000 2.75v7.5C0 11.216.784 12 1.75 12h3.727c-.1 1.041-.52 1.872-1.292 2.757A.75.75 0 004.75 16h6.5a.75.75 0 00.565-1.243c-.772-.885-1.193-1.716-1.292-2.757h3.727A1.75 1.75 0 0016 10.25v-7.5A1.75 1.75 0 0014.25 1zM9.018 12H6.982a5.72 5.72 0 01-.765 2.5h3.566a5.72 5.72 0 01-.765-2.5z"></path></svg></button>
             """
             |> format_html()
  end

  test "Option: is_close_button" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.button is_close_button aria-label="Close">
             <.octicon name="x-16" />
           </.button>
           """)
           |> format_html() ==
             """
             <button aria-label="Close" class="close-button" type="button"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M3.72 3.72a.75.75 0 011.06 0L8 6.94l3.22-3.22a.75.75 0 111.06 1.06L9.06 8l3.22 3.22a.75.75 0 11-1.06 1.06L8 9.06l-3.22 3.22a.75.75 0 01-1.06-1.06L6.94 8 3.72 4.78a.75.75 0 010-1.06z"></path></svg></button>
             """
             |> format_html()
  end

  test "Extra attributes" do
    assigns = %{
      myself: nil
    }

    assert rendered_to_string(~H"""
           <.button dir="rtl" phx-click="remove">Button</.button>
           """)
           |> format_html() ==
             """
             <button class="btn" dir="rtl" phx-click="remove" type="button">Button</button>
             """
             |> format_html()
  end
end
