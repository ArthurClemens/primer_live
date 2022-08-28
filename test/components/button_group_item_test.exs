defmodule PrimerLive.Components.ButtonGroupItemTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.LiveView.Helpers
  import Phoenix.LiveViewTest

  test "Called without options or inner_block: should render an error message" do
    assigns = []

    assert rendered_to_string(~H"""
           <.button_group_item />
           """)
           |> format_html() ==
             """
             <div class="flash flash-error"><p>button_group_item component received invalid options:</p><p>inner_block: can&#39;t be blank</p></div>
             """
             |> format_html()
  end

  test "Called without options: should render the button group item" do
    assigns = []

    assert rendered_to_string(~H"""
           <.button_group_item>Button</.button_group_item>
           """)
           |> format_html() ==
             """
             <button class="btn BtnGroup-item" type="button"> Button </button>
             """
             |> format_html()
  end

  test "Option: class" do
    assigns = []

    assert rendered_to_string(~H"""
           <.button_group_item class="x">Button</.button_group_item>
           """)
           |> format_html() ==
             """
             <button class="btn BtnGroup-item x" type="button">Button</button>
             """
             |> format_html()
  end

  test "Extra attributes" do
    assigns = []

    assert rendered_to_string(~H"""
           <.button_group_item dir="rtl">Button</.button_group_item>
           """)
           |> format_html() ==
             """
             <button class="btn BtnGroup-item" type="button" dir="rtl"> Button </button>
             """
             |> format_html()
  end
end
