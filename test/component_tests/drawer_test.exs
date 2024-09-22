defmodule PrimerLive.TestComponents.DrawerTest do
  @moduledoc false

  use PrimerLive.TestBase

  test "Basic" do
    assigns = %{}

    run_test(
      ~H"""
      <.drawer id="my-drawer-id">
        <:body id="my-drawer-content-id">
          Content
        </:body>
      </.drawer>
      """,
      __ENV__
    )
  end

  test "Attribute: is_far_side" do
    assigns = %{}

    run_test(
      ~H"""
      <.drawer id="my-drawer-id" is_far_side>
        <:body id="my-drawer-content-id">
          Content
        </:body>
      </.drawer>
      """,
      __ENV__
    )
  end

  test "Attribute: width" do
    assigns = %{}

    run_test(
      ~H"""
      <.drawer id="my-drawer-id">
        <:body id="my-drawer-content-id" width="10em">
          Content
        </:body>
      </.drawer>
      """,
      __ENV__
    )
  end

  test "Attribute: is_fast" do
    assigns = %{}

    run_test(
      ~H"""
      <.drawer id="my-drawer-id" is_fast>
        <:body id="my-drawer-content-id">
          Content
        </:body>
      </.drawer>
      """,
      __ENV__
    )
  end

  test "Attribute: is_escapable false" do
    assigns = %{}

    run_test(
      ~H"""
      <.drawer id="my-drawer-id" is_escapable={false}>
        <:body id="my-drawer-content-id">
          Content
        </:body>
      </.drawer>
      """,
      __ENV__
    )
  end

  test "Attribute: focus_after_opening_selector" do
    assigns = %{}

    run_test(
      ~H"""
      <.drawer id="my-drawer-id" focus_after_opening_selector="[name=first_name]">
        <:body id="my-drawer-content-id">
          Content
        </:body>
      </.drawer>
      """,
      __ENV__
    )
  end

  test "Attribute: focus_after_closing_selector" do
    assigns = %{}

    run_test(
      ~H"""
      <.drawer id="my-drawer-id" focus_after_closing_selector="#button">
        <:body id="my-drawer-content-id">
          Content
        </:body>
      </.drawer>
      """,
      __ENV__
    )
  end

  test "Attribute: is_backdrop" do
    assigns = %{}

    run_test(
      ~H"""
      <.drawer id="my-drawer-id" is_backdrop>
        <:body id="my-drawer-content-id">
          Content
        </:body>
      </.drawer>
      """,
      __ENV__
    )
  end

  test "Attribute: backdrop_strength (strong)" do
    assigns = %{}

    run_test(
      ~H"""
      <.drawer id="my-drawer-id" is_backdrop backdrop_strength="strong">
        <:body id="my-drawer-content-id">
          Content
        </:body>
      </.drawer>
      """,
      __ENV__
    )
  end

  test "Attribute: backdrop_strength (light)" do
    assigns = %{}

    run_test(
      ~H"""
      <.drawer id="my-drawer-id" is_backdrop backdrop_strength="light">
        <:body id="my-drawer-content-id">
          Content
        </:body>
      </.drawer>
      """,
      __ENV__
    )
  end

  test "Attribute: is_modal" do
    assigns = %{}

    run_test(
      ~H"""
      <.drawer id="my-drawer-id" is_modal>
        <:body id="my-drawer-content-id">
          Content
        </:body>
      </.drawer>
      """,
      __ENV__
    )
  end

  test "Attribute: is_local" do
    assigns = %{}

    run_test(
      ~H"""
      <div style="position: relative; overflow-x: hidden;">
        Page content
        <.drawer id="my-drawer-id" is_local>
          <:body id="my-drawer-content-id">
            Content
          </:body>
        </.drawer>
      </div>
      """,
      __ENV__
    )
  end

  test "Attribute: is_push" do
    assigns = %{}

    run_test(
      ~H"""
      <div style="position: relative; overflow-x: hidden;">
        <.drawer id="my-drawer-id" is_push>
          Page content
          <:body id="my-drawer-content-id">
            Content
          </:body>
        </.drawer>
      </div>
      """,
      __ENV__
    )
  end

  test "Extra attribute" do
    assigns = %{}

    run_test(
      ~H"""
      <.drawer id="my-drawer-id" class="my-drawer" dir="rtl">
        <:body id="my-drawer-content-id" aria-role="menu" class="my-drawer-content">
          Content
        </:body>
      </.drawer>
      """,
      __ENV__
    )
  end
end
