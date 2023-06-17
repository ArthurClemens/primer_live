defmodule PrimerLive.TestComponents.CircleBadgeTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Slot: octicon" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.circle_badge>
             <:octicon name="alert-16" />
           </.circle_badge>
           """)
           |> format_html() ==
             """
             <div class="CircleBadge CircleBadge--small">
             <svg class="octicon CircleBadge-icon" xmlns="http://www.w3.org/2000/svg"
             width="16" height="16" viewBox="0 0 16 16">
             <path fill-rule="evenodd"
             d="M8.22 1.754a.25.25 0 00-.44 0L1.698 13.132a.25.25 0 00.22.368h12.164a.25.25 0 00.22-.368L8.22 1.754zm-1.763-.707c.659-1.234 2.427-1.234 3.086 0l6.082 11.378A1.75 1.75 0 0114.082 15H1.918a1.75 1.75 0 01-1.543-2.575L6.457 1.047zM9 11a1 1 0 11-2 0 1 1 0 012 0zm-.25-5.25a.75.75 0 00-1.5 0v2.5a.75.75 0 001.5 0v-2.5z">
             </path>
             </svg>
             </div>
             """
             |> format_html()
  end

  test "Slot: img" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.circle_badge>
             <:img src="https://github.com/travis-ci.png" alt="" />
           </.circle_badge>
           """)
           |> format_html() ==
             """
             <div class="CircleBadge CircleBadge--small">
             <img class="CircleBadge-icon" alt="" src="https://github.com/travis-ci.png" />
             </div>
             """
             |> format_html()
  end

  test "Attribute: size (medium)" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.circle_badge size="medium">
             <:octicon name="alert-16" />
           </.circle_badge>
           """)
           |> format_html() ==
             """
             <div class="CircleBadge CircleBadge--medium">
             <svg class="octicon CircleBadge-icon" xmlns="http://www.w3.org/2000/svg"
             width="16" height="16" viewBox="0 0 16 16">
             <path fill-rule="evenodd"
             d="M8.22 1.754a.25.25 0 00-.44 0L1.698 13.132a.25.25 0 00.22.368h12.164a.25.25 0 00.22-.368L8.22 1.754zm-1.763-.707c.659-1.234 2.427-1.234 3.086 0l6.082 11.378A1.75 1.75 0 0114.082 15H1.918a1.75 1.75 0 01-1.543-2.575L6.457 1.047zM9 11a1 1 0 11-2 0 1 1 0 012 0zm-.25-5.25a.75.75 0 00-1.5 0v2.5a.75.75 0 001.5 0v-2.5z">
             </path>
             </svg>
             </div>
             """
             |> format_html()
  end

  test "Attribute: size (large)" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.circle_badge size="large">
             <:octicon name="alert-16" />
           </.circle_badge>
           """)
           |> format_html() ==
             """
             <div class="CircleBadge CircleBadge--large">
             <svg class="octicon CircleBadge-icon" xmlns="http://www.w3.org/2000/svg"
             width="16" height="16" viewBox="0 0 16 16">
             <path fill-rule="evenodd"
             d="M8.22 1.754a.25.25 0 00-.44 0L1.698 13.132a.25.25 0 00.22.368h12.164a.25.25 0 00.22-.368L8.22 1.754zm-1.763-.707c.659-1.234 2.427-1.234 3.086 0l6.082 11.378A1.75 1.75 0 0114.082 15H1.918a1.75 1.75 0 01-1.543-2.575L6.457 1.047zM9 11a1 1 0 11-2 0 1 1 0 012 0zm-.25-5.25a.75.75 0 00-1.5 0v2.5a.75.75 0 001.5 0v-2.5z">
             </path>
             </svg>
             </div>
             """
             |> format_html()
  end

  test "Links" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.circle_badge href="#url">
             <:octicon name="alert-16" />
           </.circle_badge>
           <.circle_badge navigate="#url">
             <:octicon name="alert-16" />
           </.circle_badge>
           <.circle_badge patch="#url">
             <:octicon name="alert-16" />
           </.circle_badge>
           """)
           |> format_html() ==
             """
             <a href="#url" class="CircleBadge CircleBadge--small">
             <svg class="octicon CircleBadge-icon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">
             <path fill-rule="evenodd"
             d="M8.22 1.754a.25.25 0 00-.44 0L1.698 13.132a.25.25 0 00.22.368h12.164a.25.25 0 00.22-.368L8.22 1.754zm-1.763-.707c.659-1.234 2.427-1.234 3.086 0l6.082 11.378A1.75 1.75 0 0114.082 15H1.918a1.75 1.75 0 01-1.543-2.575L6.457 1.047zM9 11a1 1 0 11-2 0 1 1 0 012 0zm-.25-5.25a.75.75 0 00-1.5 0v2.5a.75.75 0 001.5 0v-2.5z">
             </path>
             </svg>
             </a>
             <a href="#url" data-phx-link="redirect" data-phx-link-state="push" class="CircleBadge CircleBadge--small">
             <svg class="octicon CircleBadge-icon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">
             <path fill-rule="evenodd"
             d="M8.22 1.754a.25.25 0 00-.44 0L1.698 13.132a.25.25 0 00.22.368h12.164a.25.25 0 00.22-.368L8.22 1.754zm-1.763-.707c.659-1.234 2.427-1.234 3.086 0l6.082 11.378A1.75 1.75 0 0114.082 15H1.918a1.75 1.75 0 01-1.543-2.575L6.457 1.047zM9 11a1 1 0 11-2 0 1 1 0 012 0zm-.25-5.25a.75.75 0 00-1.5 0v2.5a.75.75 0 001.5 0v-2.5z">
             </path>
             </svg>
             </a>
             <a href="#url" data-phx-link="patch" data-phx-link-state="push" class="CircleBadge CircleBadge--small">
             <svg class="octicon CircleBadge-icon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">
             <path fill-rule="evenodd"
             d="M8.22 1.754a.25.25 0 00-.44 0L1.698 13.132a.25.25 0 00.22.368h12.164a.25.25 0 00.22-.368L8.22 1.754zm-1.763-.707c.659-1.234 2.427-1.234 3.086 0l6.082 11.378A1.75 1.75 0 0114.082 15H1.918a1.75 1.75 0 01-1.543-2.575L6.457 1.047zM9 11a1 1 0 11-2 0 1 1 0 012 0zm-.25-5.25a.75.75 0 00-1.5 0v2.5a.75.75 0 001.5 0v-2.5z">
             </path>
             </svg>
             </a>
             """
             |> format_html()
  end
end
