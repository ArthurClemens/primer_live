defmodule PrimerLive.TestComponents.DrawerContentDeprecatedTest do
  @moduledoc false

  use PrimerLive.TestBase

  test "Basic" do
    assigns = %{}

    run_test(
      ~H"""
      <.drawer id="my-drawer-id">
        <.drawer_content id="my-drawer-content-id">
          Content
        </.drawer_content>
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
        <.drawer_content id="my-drawer-content-id">
          Content
        </.drawer_content>
      </.drawer>
      """,
      __ENV__
    )
  end

  test "Attribute: width" do
    assigns = %{}

    run_test(
      ~H"""
      <.drawer id="my-drawer-id" width="10em">
        <.drawer_content id="my-drawer-content-id">
          Content
        </.drawer_content>
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
        <.drawer_content id="my-drawer-content-id">
          Content
        </.drawer_content>
      </.drawer>
      """,
      __ENV__
    )
  end

  test "Attribute: is_escapable" do
    assigns = %{}

    run_test(
      ~H"""
      <.drawer id="my-drawer-id" is_escapable>
        <.drawer_content id="my-drawer-content-id">
          Content
        </.drawer_content>
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
        <.drawer_content id="my-drawer-content-id">
          Content
        </.drawer_content>
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
        <.drawer_content id="my-drawer-content-id">
          Content
        </.drawer_content>
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
        <.drawer_content id="my-drawer-content-id">
          Content
        </.drawer_content>
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
        <.drawer_content id="my-drawer-content-id">
          Content
        </.drawer_content>
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
        <.drawer_content id="my-drawer-content-id">
          Content
        </.drawer_content>
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
          <.drawer_content id="my-drawer-content-id">
            Content
          </.drawer_content>
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
          <.drawer_content id="my-drawer-content-id">
            Content
          </.drawer_content>
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
        <.drawer_content id="my-drawer-content-id" aria-role="menu" class="my-drawer-content">
          Content
        </.drawer_content>
      </.drawer>
      """,
      __ENV__
    )
  end
end
