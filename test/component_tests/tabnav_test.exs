defmodule PrimerLive.Components.TabnavTest do
  @moduledoc false

  use PrimerLive.TestBase

  test "Slot: item links" do
    assigns = %{}

    run_test(
      ~H"""
      <.tabnav aria_label="Tabs">
        <:item href="#url" is_selected>
          href link
        </:item>
        <:item navigate="#url">
          navigate link
        </:item>
        <:item patch="#url">
          patch link
        </:item>
      </.tabnav>
      """,
      __ENV__
    )
  end

  test "Attribute: is_small" do
    assigns = %{}

    run_test(
      ~H"""
      <.tabnav aria_label="Tabs">
        <:item is_small is_selected>
          One
        </:item>
        <:item is_small>
          Two
        </:item>
      </.tabnav>
      """,
      __ENV__
    )
  end

  test "Slot: item links (with various content)" do
    assigns = %{}

    run_test(
      ~H"""
      <.tabnav>
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
      </.tabnav>
      """,
      __ENV__
    )
  end

  test "Slot: item buttons" do
    assigns = %{}

    run_test(
      ~H"""
      <.tabnav aria_label="Tabs">
        <:item is_selected>
          Button 1
        </:item>
        <:item>
          Button 2
        </:item>
      </.tabnav>
      """,
      __ENV__
    )
  end

  test "Slot: position_end" do
    assigns = %{}

    run_test(
      ~H"""
      <.tabnav>
        <:item href="#url" is_selected>
          One
        </:item>
        <:item href="#url">
          Two
        </:item>
        <:item href="#url">
          Three
        </:item>
        <:position_end>
          <a class="btn btn-sm" href="#url" role="button">Button</a>
        </:position_end>
      </.tabnav>
      """,
      __ENV__
    )
  end

  test "Slot: position_end, is_extra" do
    assigns = %{}

    run_test(
      ~H"""
      <.tabnav aria_label="Tabs">
        <:item href="#url" is_selected>
          One
        </:item>
        <:item href="#url">
          Two
        </:item>
        <:item href="#url">
          Three
        </:item>
        <:position_end is_extra>
          Tabnav widget text here.
        </:position_end>
      </.tabnav>
      """,
      __ENV__
    )
  end

  test "Classes" do
    assigns = %{}

    run_test(
      ~H"""
      <.tabnav
        classes={
          %{
            tabnav: "tabnav-x",
            nav: "nav-x",
            tab: "tab-x",
            position_end: "position_end-x"
          }
        }
        class="my-tabnav"
      >
        <:item href="#url" is_selected class="my-tab">
          One
        </:item>
        <:item href="#url">
          Two
        </:item>
        <:position_end class="my-position-end">
          Tabnav widget text here.
        </:position_end>
      </.tabnav>
      """,
      __ENV__
    )
  end

  test "Extra attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.tabnav aria_label="Topics navigation" dir="rtl">
        <:item href="#url" is_selected aria-label="View One">
          One
        </:item>
        <:item href="#url">
          Two
        </:item>
        <:position_end aria-label="End content">
          Tabnav widget text here.
        </:position_end>
      </.tabnav>
      """,
      __ENV__
    )
  end
end
