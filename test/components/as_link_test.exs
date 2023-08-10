defmodule PrimerLive.TestComponents.AsLinkTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Without link attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.as_link>label</.as_link>
           """)
           |> format_html() ==
             """
             <span class="Link">label</span>
             """
             |> format_html()
  end

  test "With link attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.as_link href="/home">label</.as_link>
           <.as_link navigate="/account">label</.as_link>
           <.as_link patch="/history">label</.as_link>
           """)
           |> format_html() ==
             """
             <a href="/home" class="Link">label</a>
             <a href="/account" data-phx-link="redirect" data-phx-link-state="push" class="Link">label</a>
             <a href="/history" data-phx-link="patch" data-phx-link-state="push" class="Link">label</a>
             """
             |> format_html()
  end

  test "Attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.as_link is_primary>label</.as_link>
           <.as_link is_secondary>label</.as_link>
           <.as_link is_no_underline>label</.as_link>
           <.as_link is_muted>label</.as_link>
           <.as_link is_on_hover>label</.as_link>
           """)
           |> format_html() ==
             """
             <span class="Link Link--primary">label</span>
             <span class="Link Link--secondary">label</span>
             <span class="Link no-underline">label</span>
             <span class="Link color-fg-muted">label</span>
             <span class="Link Link--onHover">label</span>
             """
             |> format_html()
  end

  test "Class" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.as_link class="my-link">label</.as_link>
           <.as_link href="/home" class="my-link">label</.as_link>
           """)
           |> format_html() ==
             """
             <span class="Link my-link">label</span>
             <a href="/home" class="Link my-link">label</a>
             """
             |> format_html()
  end

  test "Other attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.as_link rel="next">label</.as_link>
           <.as_link rel="next" href="/home">label</.as_link>
           """)
           |> format_html() ==
             """
             <span class="Link" rel="next">label</span>
             <a href="/home" rel="next" class="Link">label</a>
             """
             |> format_html()
  end
end
