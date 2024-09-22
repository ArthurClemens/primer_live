defmodule PrimerLive.TestComponents.ActionListSectionDividerTest do
  @moduledoc false

  use PrimerLive.TestBase

  test "Without slots" do
    assigns = %{}

    run_test(
      ~H"""
      <ul>
        <.action_list_section_divider />
      </ul>
      """,
      __ENV__
    )
  end

  test "Without slots, attr is_filled" do
    assigns = %{}

    run_test(
      ~H"""
      <ul>
        <.action_list_section_divider is_filled />
      </ul>
      """,
      __ENV__
    )
  end

  test "Title slot" do
    assigns = %{}

    run_test(
      ~H"""
      <ul>
        <.action_list_section_divider>
          <:title>Title</:title>
        </.action_list_section_divider>
      </ul>
      """,
      __ENV__
    )
  end

  test "Title slot, attr is_filled" do
    assigns = %{}

    run_test(
      ~H"""
      <ul>
        <.action_list_section_divider is_filled>
          <:title>Title</:title>
        </.action_list_section_divider>
      </ul>
      """,
      __ENV__
    )
  end

  test "Title with description" do
    assigns = %{}

    run_test(
      ~H"""
      <ul>
        <.action_list_section_divider>
          <:title>Title</:title>
          <:description>Descriptive title</:description>
        </.action_list_section_divider>
      </ul>
      """,
      __ENV__
    )
  end

  test "Description without title (draws a line)" do
    assigns = %{}

    run_test(
      ~H"""
      <ul>
        <.action_list_section_divider>
          <:description>Descriptive title</:description>
        </.action_list_section_divider>
      </ul>
      """,
      __ENV__
    )
  end

  test "Classes" do
    assigns = %{}

    run_test(
      ~H"""
      <ul>
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
      </ul>
      """,
      __ENV__
    )
  end
end
