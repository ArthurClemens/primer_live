defmodule PrimerLive.TestComponents.BranchNameTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Inner block" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.branch_name>
             some-name
           </.branch_name>
           """)
           |> format_html() ==
             """
             <span class="branch-name">some-name</span>
             """
             |> format_html()
  end

  test "Link" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.branch_name href="#url">
             href
           </.branch_name>
           <.branch_name navigate="#url">
             navigate
           </.branch_name>
           <.branch_name patch="#url">
             patch
           </.branch_name>
           """)
           |> format_html() ==
             """
             <a href="#url" class="branch-name">href</a>
             <a href="#url" data-phx-link="redirect" data-phx-link-state="push" class="branch-name">navigate</a>
             <a href="#url" data-phx-link="patch" data-phx-link-state="push" class="branch-name">patch</a>
             """
             |> format_html()
  end

  test "Icon" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.branch_name class="my-branch-name">
             <.octicon name="git-branch-16" /> some-name
           </.branch_name>
           """)
           |> format_html() ==
             """
             <span class="branch-name my-branch-name">
             <svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">
             <path fill-rule="evenodd"
             d="M11.75 2.5a.75.75 0 100 1.5.75.75 0 000-1.5zm-2.25.75a2.25 2.25 0 113 2.122V6A2.5 2.5 0 0110 8.5H6a1 1 0 00-1 1v1.128a2.251 2.251 0 11-1.5 0V5.372a2.25 2.25 0 111.5 0v1.836A2.492 2.492 0 016 7h4a1 1 0 001-1v-.628A2.25 2.25 0 019.5 3.25zM4.25 12a.75.75 0 100 1.5.75.75 0 000-1.5zM3.5 3.25a.75.75 0 111.5 0 .75.75 0 01-1.5 0z">
             </path>
             </svg>
             some-name
             </span>
             """
             |> format_html()
  end

  test "Class" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.branch_name class="my-branch-name">
             some-name
           </.branch_name>
           """)
           |> format_html() ==
             """
             <span class="branch-name my-branch-name">some-name</span>
             """
             |> format_html()
  end

  test "Extra" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.branch_name dir="rtl" aria-label="Current branch">
             some-name
           </.branch_name>
           """)
           |> format_html() ==
             """
             <span aria-label="Current branch" class="branch-name" dir="rtl">some-name</span>
             """
             |> format_html()
  end
end
