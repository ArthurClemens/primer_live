defmodule PrimerLive.Components.UnderlineNavTest do
  @moduledoc false

  use PrimerLive.TestBase

  test "Slot: item links" do
    assigns = %{}

    run_test(
      ~H"""
      <.underline_nav aria_label="Tabs">
        <:item href="#url" is_selected>
          href link
        </:item>
        <:item navigate="#url">
          navigate link
        </:item>
        <:item patch="#url">
          patch link
        </:item>
      </.underline_nav>
      """,
      __ENV__
    )
  end

  test "Slot: item links (with various content)" do
    assigns = %{}

    run_test(
      ~H"""
      <.underline_nav>
        <:item href="#url" is_selected>
          <.octicon name="comment-discussion-16" />
          <span>Conversation</span>
          <.counter>2</.counter>
        </:item>
        <:item href="#url">
          <.octicon name="check-circle-16" />
          <span>Done</span>
          <.counter>99</.counter>
        </:item>
      </.underline_nav>
      """,
      __ENV__
    )
  end

  test "Slot: item buttons" do
    assigns = %{}

    run_test(
      ~H"""
      <.underline_nav aria_label="Tabs">
        <:item is_selected>
          Button 1
        </:item>
        <:item>
          Button 2
        </:item>
      </.underline_nav>
      """,
      __ENV__
    )
  end

  test "Slot: position_end" do
    assigns = %{}

    run_test(
      ~H"""
      <.underline_nav>
        <:item href="#url" is_selected>
          One
        </:item>
        <:item href="#url">
          Two
        </:item>
        <:position_end>
          <a class="btn btn-sm" href="#url" role="button">Button</a>
        </:position_end>
      </.underline_nav>
      """,
      __ENV__
    )
  end

  test "Attribute: is_container_width" do
    assigns = %{}

    run_test(
      ~H"""
      <.underline_nav
        is_container_width
        classes={
          %{
            container: "container-sm"
          }
        }
      >
        <:item href="#url" is_selected>
          One
        </:item>
        <:item href="#url">
          Two
        </:item>
      </.underline_nav>
      """,
      __ENV__
    )
  end

  test "Attribute: is_reversed" do
    assigns = %{}

    run_test(
      ~H"""
      <.underline_nav is_reversed>
        <:item href="#url" is_selected>
          One
        </:item>
        <:item href="#url">
          Two
        </:item>
        <:position_end>
          <a class="btn btn-sm" href="#url" role="button">Button</a>
        </:position_end>
      </.underline_nav>
      """,
      __ENV__
    )
  end

  test "Classes" do
    assigns = %{}

    run_test(
      ~H"""
      <.underline_nav
        classes={
          %{
            underline_nav: "underline_nav-x",
            body: "body-x",
            container: "container-x",
            tab: "tab-x",
            position_end: "position_end-x"
          }
        }
        is_container_width
        class="my-underline_nav"
      >
        <:item href="#url" is_selected class="my-tab">
          One
        </:item>
        <:item href="#url">
          Two
        </:item>
        <:position_end class="my-position-end">
          Actions here
        </:position_end>
      </.underline_nav>
      """,
      __ENV__
    )
  end

  test "Extra attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.underline_nav aria_label="Topics navigation" dir="rtl">
        <:item href="#url" is_selected aria-label="View One">
          One
        </:item>
        <:item href="#url">
          Two
        </:item>
        <:position_end aria-label="Actions">
          Actions here
        </:position_end>
      </.underline_nav>
      """,
      __ENV__
    )
  end
end
