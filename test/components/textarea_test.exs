defmodule PrimerLive.TestComponents.TextareaTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Called without options: should render the component" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.textarea />
           """)
           |> format_html() ==
             """
             <textarea class="form-control" id="_" name="[]"></textarea>
             """
             |> format_html()
  end

  test "Attribute: is_large" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.textarea is_large />
           """)
           |> format_html() ==
             """
             <textarea class="form-control input-lg" id="_" name="[]"></textarea>
             """
             |> format_html()
  end

  test "Attribute: is_small" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.textarea is_small />
           """)
           |> format_html() ==
             """
             <textarea class="form-control input-sm" id="_" name="[]"></textarea>
             """
             |> format_html()
  end

  test "Attribute: class" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.textarea class="x" />
           """)
           |> format_html() ==
             """
             <textarea class="form-control x" id="_" name="[]"></textarea>
             """
             |> format_html()
  end
end
