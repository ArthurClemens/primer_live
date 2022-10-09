defmodule PrimerLive.Components.SpinnerTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Render component" do
    assigns = []

    assert rendered_to_string(~H"""
           <.spinner />
           """)
           |> format_html() ==
             """
             <svg class="Toast--spinner" viewBox="0 0 32 32" width="18" height="18">
             <path fill="#959da5" d="M16 0 A16 16 0 0 0 16 32 A16 16 0 0 0 16 0 M16 4 A12 12 0 0 1 16 28 A12 12 0 0 1 16 4"></path>
             <path fill="#ffffff" d="M16 0 A16 16 0 0 1 32 16 L28 16 A12 12 0 0 0 16 4z"></path>
             </svg>
             """
             |> format_html()
  end

  test "Attribute: size" do
    assigns = []

    assert rendered_to_string(~H"""
           <.spinner size="40" />
           <.spinner size={40} />
           """)
           |> format_html() ==
             """
             <svg class="Toast--spinner" viewBox="0 0 32 32" width="40" height="40">
             <path fill="#959da5" d="M16 0 A16 16 0 0 0 16 32 A16 16 0 0 0 16 0 M16 4 A12 12 0 0 1 16 28 A12 12 0 0 1 16 4"></path>
             <path fill="#ffffff" d="M16 0 A16 16 0 0 1 32 16 L28 16 A12 12 0 0 0 16 4z"></path>
             </svg>
             <svg class="Toast--spinner" viewBox="0 0 32 32" width="40" height="40">
             <path fill="#959da5" d="M16 0 A16 16 0 0 0 16 32 A16 16 0 0 0 16 0 M16 4 A12 12 0 0 1 16 28 A12 12 0 0 1 16 4"></path>
             <path fill="#ffffff" d="M16 0 A16 16 0 0 1 32 16 L28 16 A12 12 0 0 0 16 4z"></path>
             </svg>
             """
             |> format_html()
  end

  test "Attribute: color" do
    assigns = []

    assert rendered_to_string(~H"""
           <.spinner color="red" />
           <.spinner color="#ff0000" />
           <.spinner color="rgba(250, 50, 150, 0.5)" />
           """)
           |> format_html() ==
             """
             <svg class="Toast--spinner" viewBox="0 0 32 32" width="18" height="18">
             <path fill="red" d="M16 0 A16 16 0 0 0 16 32 A16 16 0 0 0 16 0 M16 4 A12 12 0 0 1 16 28 A12 12 0 0 1 16 4"></path>
             <path fill="#ffffff" d="M16 0 A16 16 0 0 1 32 16 L28 16 A12 12 0 0 0 16 4z"></path>
             </svg>
             <svg class="Toast--spinner" viewBox="0 0 32 32" width="18" height="18">
             <path fill="#ff0000" d="M16 0 A16 16 0 0 0 16 32 A16 16 0 0 0 16 0 M16 4 A12 12 0 0 1 16 28 A12 12 0 0 1 16 4"></path>
             <path fill="#ffffff" d="M16 0 A16 16 0 0 1 32 16 L28 16 A12 12 0 0 0 16 4z"></path>
             </svg>
             <svg class="Toast--spinner" viewBox="0 0 32 32" width="18" height="18">
             <path fill="rgba(250, 50, 150, 0.5)"
             d="M16 0 A16 16 0 0 0 16 32 A16 16 0 0 0 16 0 M16 4 A12 12 0 0 1 16 28 A12 12 0 0 1 16 4"></path>
             <path fill="#ffffff" d="M16 0 A16 16 0 0 1 32 16 L28 16 A12 12 0 0 0 16 4z"></path>
             </svg>
             """
             |> format_html()
  end

  test "Attribute: gap color" do
    assigns = []

    assert rendered_to_string(~H"""
           <.spinner gap_color="black" />
           <.spinner gap_color="#000000" />
           <.spinner gap_color="rgba(0, 0, 0, 1)" />
           """)
           |> format_html() ==
             """
             <svg class="Toast--spinner" viewBox="0 0 32 32" width="18" height="18">
             <path fill="#959da5" d="M16 0 A16 16 0 0 0 16 32 A16 16 0 0 0 16 0 M16 4 A12 12 0 0 1 16 28 A12 12 0 0 1 16 4"></path>
             <path fill="black" d="M16 0 A16 16 0 0 1 32 16 L28 16 A12 12 0 0 0 16 4z"></path>
             </svg>
             <svg class="Toast--spinner" viewBox="0 0 32 32" width="18" height="18">
             <path fill="#959da5" d="M16 0 A16 16 0 0 0 16 32 A16 16 0 0 0 16 0 M16 4 A12 12 0 0 1 16 28 A12 12 0 0 1 16 4"></path>
             <path fill="#000000" d="M16 0 A16 16 0 0 1 32 16 L28 16 A12 12 0 0 0 16 4z"></path>
             </svg>
             <svg class="Toast--spinner" viewBox="0 0 32 32" width="18" height="18">
             <path fill="#959da5" d="M16 0 A16 16 0 0 0 16 32 A16 16 0 0 0 16 0 M16 4 A12 12 0 0 1 16 28 A12 12 0 0 1 16 4"></path>
             <path fill="rgba(0, 0, 0, 1)" d="M16 0 A16 16 0 0 1 32 16 L28 16 A12 12 0 0 0 16 4z"></path>
             </svg>
             """
             |> format_html()
  end

  test "Other attributes" do
    assigns = []

    assert rendered_to_string(~H"""
           <.spinner class="my-spinner" dir="rtl" />
           """)
           |> format_html() ==
             """
             <svg class="Toast--spinner my-spinner" viewBox="0 0 32 32" width="18" height="18" dir="rtl">
             <path fill="#959da5" d="M16 0 A16 16 0 0 0 16 32 A16 16 0 0 0 16 0 M16 4 A12 12 0 0 1 16 28 A12 12 0 0 1 16 4"></path>
             <path fill="#ffffff" d="M16 0 A16 16 0 0 1 32 16 L28 16 A12 12 0 0 0 16 4z"></path>
             </svg>
             """
             |> format_html()
  end
end
