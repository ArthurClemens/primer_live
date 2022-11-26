defmodule PrimerLive.TestComponents.ActionListSectionDividerTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Without slots" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_list_section_divider />
           """)
           |> format_html() ==
             """
             <li class="ActionList-sectionDivider" role="separator" aria-hidden="true"></li>
             """
             |> format_html()
  end

  test "Without slots, attr is_filled" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_list_section_divider is_filled />
           """)
           |> format_html() ==
             """
             <li class="ActionList-sectionDivider ActionList-sectionDivider--filled" role="separator" aria-hidden="true"></li>
             """
             |> format_html()
  end

  test "Title slot" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_list_section_divider>
             <:title>Title</:title>
           </.action_list_section_divider>
           """)
           |> format_html() ==
             """
             <li class="ActionList-sectionDivider">
             <h3 class="ActionList-sectionDivider-title">Title</h3>
             </li>
             """
             |> format_html()
  end

  test "Title slot, attr is_filled" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_list_section_divider is_filled>
             <:title>Title</:title>
           </.action_list_section_divider>
           """)
           |> format_html() ==
             """
             <li class="ActionList-sectionDivider ActionList-sectionDivider--filled">
             <h3 class="ActionList-sectionDivider-title">Title</h3>
             </li>
             """
             |> format_html()
  end

  test "Title with description" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_list_section_divider>
             <:title>Title</:title>
             <:description>Descriptive title</:description>
           </.action_list_section_divider>
           """)
           |> format_html() ==
             """
             <li class="ActionList-sectionDivider">
              <h3 class="ActionList-sectionDivider-title">Title</h3>
              <span class="ActionList-item-description">Descriptive title</span>
             </li>
             """
             |> format_html()
  end

  test "Description without title (draws a line)" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_list_section_divider>
             <:description>Descriptive title</:description>
           </.action_list_section_divider>
           """)
           |> format_html() ==
             """
             <li class="ActionList-sectionDivider" role="separator" aria-hidden="true"></li>
             """
             |> format_html()
  end

  test "Classes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_list_section_divider
             classes={
               %{
                 section_divider: "section_divider-x",
                 title: "title-x",
                 description: "description-x"
               }
             }
             class="my-section-divider"
           >
             <:title class="my-title">Title</:title>
             <:description class="my-description">Descriptive title</:description>
           </.action_list_section_divider>
           """)
           |> format_html() ==
             """
             <li class="ActionList-sectionDivider section_divider-x my-section-divider">
             <h3 class="ActionList-sectionDivider-title title-x my-title">Title</h3>
             <span class="ActionList-item-description description-x my-description">Descriptive title</span>
             </li>
             """
             |> format_html()
  end
end
