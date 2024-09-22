defmodule PrimerLive.TestComponents.DialogTest do
  @moduledoc false

  use PrimerLive.TestBase
  alias Phoenix.LiveView.JS

  test "Basic" do
    assigns = %{}

    run_test(
      ~H"""
      <.dialog id="my-dialog-id">
        Message
      </.dialog>
      """,
      __ENV__
    )
  end

  test "Attribute: is_narrow" do
    assigns = %{}

    run_test(
      ~H"""
      <.dialog id="my-dialog-id" is_narrow>
        Message
      </.dialog>
      """,
      __ENV__
    )
  end

  test "Attribute: is_wide" do
    assigns = %{}

    run_test(
      ~H"""
      <.dialog id="my-dialog-id" is_wide>
        Message
      </.dialog>
      """,
      __ENV__
    )
  end

  test "Attribute: is_fast" do
    assigns = %{}

    run_test(
      ~H"""
      <.dialog id="my-dialog-id" is_fast>
        Message
      </.dialog>
      """,
      __ENV__
    )
  end

  test "Attribute: is_escapable" do
    assigns = %{}

    run_test(
      ~H"""
      <.dialog id="my-dialog-id" is_escapable>
        Message
      </.dialog>
      """,
      __ENV__
    )
  end

  test "Attribute: focus_after_opening_selector" do
    assigns = %{}

    run_test(
      ~H"""
      <.dialog id="my-dialog-id" focus_after_opening_selector="[name=first_name]">
        Message
      </.dialog>
      """,
      __ENV__
    )
  end

  test "Attribute: focus_after_closing_selector" do
    assigns = %{}

    run_test(
      ~H"""
      <.dialog id="my-dialog-id" focus_after_closing_selector="#button">
        Message
      </.dialog>
      """,
      __ENV__
    )
  end

  test "Attribute: is_backdrop" do
    assigns = %{}

    run_test(
      ~H"""
      <.dialog id="my-dialog-id" is_backdrop>
        Message
      </.dialog>
      """,
      __ENV__
    )
  end

  test "Attribute: backdrop_strength (strong)" do
    assigns = %{}

    run_test(
      ~H"""
      <.dialog id="my-dialog-id" is_backdrop backdrop_strength="strong">
        Message
      </.dialog>
      """,
      __ENV__
    )
  end

  test "Attribute: backdrop_strength (light)" do
    assigns = %{}

    run_test(
      ~H"""
      <.dialog id="my-dialog-id" is_backdrop backdrop_strength="light">
        Message
      </.dialog>
      """,
      __ENV__
    )
  end

  test "Attribute: backdrop_tint (light)" do
    assigns = %{}

    run_test(
      ~H"""
      <.dialog id="my-dialog-id" is_backdrop backdrop_strength="strong" backdrop_tint="light">
        Message
      </.dialog>
      """,
      __ENV__
    )
  end

  test "Attribute: is_modal" do
    assigns = %{}

    run_test(
      ~H"""
      <.dialog id="my-dialog-id" is_modal>
        Message
      </.dialog>
      """,
      __ENV__
    )
  end

  test "Attribute: max_height and max_width (%)" do
    assigns = %{}

    run_test(
      ~H"""
      <.dialog id="my-dialog-id" max_height="50%" max_width="90%">
        Message
      </.dialog>
      """,
      __ENV__
    )
  end

  test "Attribute: max_height and max_width (vh, vw)" do
    assigns = %{}

    run_test(
      ~H"""
      <.dialog id="my-dialog-id" max_height="50vh" max_width="80vw">
        Message
      </.dialog>
      """,
      __ENV__
    )
  end

  test "Attribute: on_cancel" do
    assigns = %{}

    run_test(
      ~H"""
      <.dialog id="my-dialog-id" on_cancel={JS.patch("/dialog")}>
        Message
      </.dialog>
      """,
      __ENV__
    )
  end

  test "Attribute: transition_duration" do
    assigns = %{}

    run_test(
      ~H"""
      <.dialog id="my-dialog-id" transition_duration={500}>
        Message
      </.dialog>
      """,
      __ENV__
    )
  end

  test "Attribute: status_callback_selector" do
    assigns = %{}

    run_test(
      ~H"""
      <.dialog id="my-dialog-id" status_callback_selector="#container">
        Message
      </.dialog>
      """,
      __ENV__
    )
  end

  test "Attribute: is_show_on_mount" do
    assigns = %{
      condition: true,
      equals_initial_condition: true
    }

    run_test(
      ~H"""
      <.dialog
        :if={@condition}
        id="my-dialog-id"
        is_show
        is_show_on_mount={@equals_initial_condition}
        on_cancel={JS.patch("/dialog")}
      >
        Message
      </.dialog>
      """,
      __ENV__
    )
  end

  test "All slots" do
    assigns = %{}

    run_test(
      ~H"""
      <.dialog id="my-dialog-id">
        Message
        <:header_title>Dialog title</:header_title>
        <:body>Body message</:body>
        <:row>Row 1</:row>
        <:row>Row 2</:row>
        <:footer>Footer</:footer>
      </.dialog>
      """,
      __ENV__
    )
  end

  test "Classes" do
    assigns = %{}

    run_test(
      ~H"""
      <.dialog
        id="my-dialog-id"
        class="my-dialog"
        classes={
          %{
            dialog_wrapper: "dialog-wrapper-x",
            toggle: "toggle-x",
            dialog: "dialog-x",
            box: "box-x",
            header: "header-x",
            row: "row-x",
            body: "body-x",
            footer: "footer-x",
            header_title: "header_title-x",
            link: "link-x"
          }
        }
      >
        Message
        <:header_title class="my-header-title">Dialog title</:header_title>
        <:body class="my-body">Body message</:body>
        <:row class="my-row">Row 1</:row>
        <:row>Row 2</:row>
        <:footer class="my-footer">Footer</:footer>
      </.dialog>
      """,
      __ENV__
    )
  end
end
