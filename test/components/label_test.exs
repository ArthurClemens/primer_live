defmodule PrimerLive.TestComponents.LabelTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Without attributes" do
    assigns = []

    assert rendered_to_string(~H"""
           <.label>Label</.label>
           """)
           |> format_html() ==
             """
             <span class="Label">Label</span>
             """
             |> format_html()
  end

  test "Attributes" do
    assigns = []

    assert rendered_to_string(~H"""
           <.label is_primary>Label</.label>
           <.label is_secondary>Label</.label>
           <.label is_accent>Label</.label>
           <.label is_success>Label</.label>
           <.label is_attention>Label</.label>
           <.label is_severe>Label</.label>
           <.label is_danger>Label</.label>
           <.label is_open>Label</.label>
           <.label is_closed>Label</.label>
           <.label is_done>Label</.label>
           <.label is_sponsors>Label</.label>
           <.label is_large>Label</.label>
           <.label is_inline>Label</.label>
           """)
           |> format_html() ==
             """
             <span class="Label Label--primary">Label</span>
             <span class="Label Label--secondary">Label</span>
             <span class="Label Label--accent">Label</span>
             <span class="Label Label--success">Label</span>
             <span class="Label Label--attention">Label</span>
             <span class="Label Label--severe">Label</span>
             <span class="Label Label--danger">Label</span>
             <span class="Label Label--open">Label</span>
             <span class="Label Label--closed">Label</span>
             <span class="Label Label--done">Label</span>
             <span class="Label Label--sponsors">Label</span>
             <span class="Label Label--large">Label</span>
             <span class="Label Label--inline">Label</span>
             """
             |> format_html()
  end

  test "Attribute: class" do
    assigns = []

    assert rendered_to_string(~H"""
           <.label class="my-label">Label</.label>
           """)
           |> format_html() ==
             """
             <span class="Label my-label">Label</span>
             """
             |> format_html()
  end

  test "Other attributes" do
    assigns = []

    assert rendered_to_string(~H"""
           <.label dir="rtl">Label</.label>
           """)
           |> format_html() ==
             """
             <span class="Label" dir="rtl">Label</span>
             """
             |> format_html()
  end
end
