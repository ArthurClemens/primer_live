defmodule PrimerLive.Components.TruncateTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Slot: text" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.truncate>
             <:item>
               really-long-text
             </:item>
           </.truncate>
           """)
           |> format_html() ==
             """
             <span class="Truncate">
             <span
             class="Truncate-text">really-long-text</span>
             </span>
             """
             |> format_html()
  end

  test "Custom tags" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.truncate tag="ol">
             <:item tag="li">
               really-long-text
             </:item>
             <:item tag="li">
               really-long-text
             </:item>
           </.truncate>
           """)
           |> format_html() ==
             """
             <ol class="Truncate">
             <li class="Truncate-text">really-long-text</li>
             <li class="Truncate-text">really-long-text</li>
             </ol>
             """
             |> format_html()
  end

  test "Links" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.truncate>
             <:item href="/">
               branch-name
             </:item>
             <:item navigate="/">
               branch-name
             </:item>
             <:item patch="/">
               branch-name
             </:item>
           </.truncate>
           """)
           |> format_html() ==
             """
             <span class="Truncate"><a href="/" name="span" class="Truncate-text">branch-name</a><a href="/" data-phx-link="redirect"
             data-phx-link-state="push" name="span" class="Truncate-text">branch-name</a><a href="/" data-phx-link="patch"
             data-phx-link-state="push" name="span" class="Truncate-text">branch-name</a></span>
             """
             |> format_html()
  end

  test "Slot: text, attribute is_primary" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.truncate>
             <:item>
               really-long-text
             </:item>
             <:item is_primary>
               <span class="text-normal">/</span> really-long-repository-name
             </:item>
           </.truncate>
           """)
           |> format_html() ==
             """
             <span class="Truncate">
             <span class="Truncate-text">really-long-text</span>
             <span
             class="Truncate-text Truncate-text--primary">
             <span
             class="text-normal">/</span>
             really-long-repository-name</span>
             </span>
             """
             |> format_html()
  end

  test "Slot: text, attribute is_expandable" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.truncate>
             <:item tag="a" is_expandable>
               really-long-text
             </:item>
             <:item tag="a" is_expandable>
               really-long-text
             </:item>
           </.truncate>
           """)
           |> format_html() ==
             """
             <span class="Truncate">
             <a class="Truncate-text Truncate-text--expandable">really-long-text</a>
             <a class="Truncate-text Truncate-text--expandable">really-long-text</a>
             </span>
             """
             |> format_html()
  end

  test "Classes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.truncate
             class="my-truncate"
             classes={
               %{
                 truncate: "truncate-x",
                 item: "item-x"
               }
             }
           >
             <:item tag="a" class="my-item">
               really-long-text
             </:item>
           </.truncate>
           """)
           |> format_html() ==
             """
             <span class="Truncate truncate-x my-truncate">
             <a class="Truncate-text item-x my-item">really-long-text</a>
             </span>
             """
             |> format_html()
  end

  test "Attribute: style" do
    assigns = %{}

    # Assert with rendered fragments because .dynamic_tag shuffles the order of attributes
    result =
      rendered_to_string(~H"""
      <.truncate>
        <:item is_expandable style="max-width: 300px;">
          really-long-text
        </:item>
      </.truncate>
      """)
      |> format_html()

    assert String.contains?(result, "<span class=\"Truncate\">")
    assert String.contains?(result, "style=\"max-width: 300px;\"")
    assert String.contains?(result, "class=\"Truncate-text Truncate-text--expandable\"")
  end
end
