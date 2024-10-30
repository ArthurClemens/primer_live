defmodule PrimerLive.TestComponents.LayoutTest do
  @moduledoc false

  use PrimerLive.TestBase

  defp layout_with_slots(assigns) do
    ~H"""
    <.layout {assigns}>
      <:main>
        Main content
      </:main>
      <:divider></:divider>
      <:sidebar>
        Sidebar content
      </:sidebar>
    </.layout>
    """
  end

  test "Without attributes or slots" do
    assigns = %{}

    run_test(
      ~H"""
      <.layout></.layout>
      """,
      __ENV__
    )
  end

  test "Slots" do
    assigns = %{}

    run_test(
      ~H"""
      <.layout>
        <:main>
          Main content
        </:main>
        <:sidebar>
          Sidebar content
        </:sidebar>
      </.layout>
      """,
      __ENV__
    )
  end

  test "Specific order of slots: should maintain order" do
    # Test number string, string and integer
    assigns = %{}

    run_test(
      ~H"""
      <.layout>
        <:sidebar order="1">
          Sidebar content
        </:sidebar>
        <:divider order="x"></:divider>
        <:main order={2}>
          Main content
        </:main>
      </.layout>
      """,
      __ENV__
    )
  end

  test "Slot attribute: order" do
    # Test number string, string and integer
    assigns = %{}

    run_test(
      ~H"""
      <.layout>
        <:sidebar order={2}>
          Sidebar content
        </:sidebar>
        <:divider></:divider>
        <:main order={1}>
          Main content
        </:main>
      </.layout>

      <.layout>
        <:sidebar order={1}>
          Sidebar content
        </:sidebar>
        <:divider></:divider>
        <:main order={2}>
          Main content
        </:main>
      </.layout>
      """,
      __ENV__
    )
  end

  test "Nested layout 1" do
    assigns = %{}

    run_test(
      ~H"""
      <.layout>
        <:main>
          <.layout is_sidebar_position_end is_narrow_sidebar>
            <:main>
              Main content
            </:main>
            <:sidebar>
              Metadata sidebar
            </:sidebar>
          </.layout>
        </:main>
        <:sidebar>
          Default sidebar
        </:sidebar>
      </.layout>
      """,
      __ENV__
    )
  end

  test "Nested layout 2" do
    assigns = %{}

    run_test(
      ~H"""
      <.layout>
        <:main>
          <.layout is_sidebar_position_end is_flow_row_until_lg is_narrow_sidebar>
            <:main>
              Main content
            </:main>
            <:sidebar>
              Metadata sidebar
            </:sidebar>
          </.layout>
        </:main>
        <:sidebar>
          Default sidebar
        </:sidebar>
      </.layout>
      """,
      __ENV__
    )
  end

  test "Modifiers" do
    assigns = %{}

    run_test(
      ~H"""
      <.layout is_narrow_sidebar></.layout>
      <.layout is_wide_sidebar></.layout>
      <.layout is_divided></.layout>
      <.layout is_gutter_none></.layout>
      <.layout is_gutter_condensed></.layout>
      <.layout is_gutter_spacious></.layout>
      <.layout is_sidebar_position_start></.layout>
      <.layout is_sidebar_position_end></.layout>
      <.layout is_sidebar_position_flow_row_start></.layout>
      <.layout is_sidebar_position_flow_row_end></.layout>
      <.layout is_sidebar_position_flow_row_none></.layout>
      <.layout is_flow_row_until_md></.layout>
      <.layout is_flow_row_until_lg></.layout>
      """,
      __ENV__
    )
  end

  test "Modifiers: is_centered_md, is_centered_lg, is_centered_xl" do
    assigns = %{}

    run_test(
      ~H"""
      <.layout_with_slots is_centered_md />
      <.layout_with_slots is_centered_lg />
      <.layout_with_slots is_centered_xl />
      """,
      __ENV__
    )
  end

  test "Modifiers: is_flow_row_shallow, is_flow_row_hidden" do
    assigns = %{}

    run_test(
      ~H"""
      <.layout_with_slots is_divided is_flow_row_shallow />
      <.layout_with_slots is_divided is_flow_row_hidden />
      """,
      __ENV__
    )
  end

  test "Attribute: classes" do
    assigns = %{}

    run_test(
      ~H"""
      <.layout_with_slots
        is_centered_md
        class="my-layout"
        classes={
          %{
            layout: "layout-x",
            main: "main-x",
            main_center_wrapper: "main_center_wrapper-x",
            sidebar: "sidebar-x",
            divider: "divider-x"
          }
        }
      />
      """,
      __ENV__
    )
  end

  test "Extra attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.layout dir="rtl"></.layout>
      """,
      __ENV__
    )
  end
end
