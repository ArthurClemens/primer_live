defmodule PrimerLive.TestComponents.ButtonTest do
  @moduledoc false

  use PrimerLive.TestBase

  test "Without attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.button>Button</.button>
      """,
      __ENV__
    )
  end

  test "Attribute: type" do
    assigns = %{}

    run_test(
      ~H"""
      <p>
        <.button type="reset">Reset</.button>
      </p>
      <p>
        <.button type="submit">Submit</.button>
      </p>
      <p>
        <.button type="button">Button</.button>
      </p>
      """,
      __ENV__
    )
  end

  test "Anchor link button" do
    assigns = %{}

    run_test(
      ~H"""
      <p>
        <.button href="/home">href link</.button>
      </p>
      <p>
        <.button navigate="/home">navigate link</.button>
      </p>
      <p>
        <.button patch="/home">patch link</.button>
      </p>
      """,
      __ENV__
    )
  end

  test "Modifiers" do
    assigns = %{}

    run_test(
      ~H"""
      <p>
        <.button is_full_width>Button</.button>
      </p>
      <p>
        <.button is_close_button>Button</.button>
      </p>
      <p>
        <.button is_danger>Button</.button>
      </p>
      <p>
        <.button is_disabled>Button</.button>
      </p>
      <p>
        <.button is_invisible>Button</.button>
      </p>
      <p>
        <.button is_large>Button</.button>
      </p>
      <p>
        <.button is_link>Button</.button>
      </p>
      <p>
        <.button is_outline>Button</.button>
      </p>
      <p>
        <.button is_primary>Button</.button>
      </p>
      <p>
        <.button is_selected>Button</.button>
      </p>
      <p>
        <.button is_small>Button</.button>
      </p>
      <p>
        <.button is_submit>Button</.button>
      </p>
      """,
      __ENV__
    )
  end

  test "Attribute: form" do
    assigns = %{}

    run_test(
      ~H"""
      <.button form="my-form" type="submit">
        Submit
      </.button>
      """,
      __ENV__
    )
  end

  test "Attribute: is_aligned_start" do
    assigns = %{}

    run_test(
      ~H"""
      <.button is_full_width is_dropdown_caret is_aligned_start>
        <.octicon name="calendar-16" />
        <span>February 1</span>
      </.button>
      """,
      __ENV__
    )
  end

  test "Button with icon" do
    assigns = %{}

    run_test(
      ~H"""
      <.button><.octicon name="search-16" /></.button>
      """,
      __ENV__
    )
  end

  test "Button with caret" do
    assigns = %{}

    run_test(
      ~H"""
      <.button is_dropdown_caret>
        Menu
      </.button>
      """,
      __ENV__
    )
  end

  test "Option: is_icon_only" do
    assigns = %{}

    run_test(
      ~H"""
      <.button is_icon_only aria-label="Desktop">
        <.octicon name="device-desktop-16" />
      </.button>
      """,
      __ENV__
    )
  end

  test "Option: is_icon_only and is_danger" do
    assigns = %{}

    run_test(
      ~H"""
      <.button is_icon_only is_danger aria-label="Desktop">
        <.octicon name="device-desktop-16" />
      </.button>
      """,
      __ENV__
    )
  end

  test "Option: is_close_button" do
    assigns = %{}

    run_test(
      ~H"""
      <.button is_close_button aria-label="Close">
        <.octicon name="x-16" />
      </.button>
      """,
      __ENV__
    )
  end

  test "Classes" do
    assigns = %{
      myself: nil
    }

    run_test(
      ~H"""
      <.button
        classes={
          %{
            button: "button-x",
            content: "content-x",
            caret: "caret-x"
          }
        }
        class="my-button"
        is_dropdown_caret
      >
        Button
      </.button>
      """,
      __ENV__
    )
  end

  test "RTL" do
    assigns = %{}

    run_test(
      ~H"""
      <p dir="rtl">
        <.button phx-click="remove">Button</.button>
      </p>
      """,
      __ENV__
    )
  end
end
