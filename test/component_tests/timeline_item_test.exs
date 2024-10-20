defmodule PrimerLive.TestComponents.TimelineItemTest do
  @moduledoc false

  use PrimerLive.TestBase

  test "Called without options: should render the component" do
    assigns = %{}

    run_test(
      ~H"""
      <.timeline_item />
      """,
      __ENV__
    )
  end

  test "Slot: badge" do
    assigns = %{}

    run_test(
      ~H"""
      <.timeline_item>
        <:badge>
          <.octicon name="flame-16" />
        </:badge>
        Everything is fine
      </.timeline_item>
      """,
      __ENV__
    )
  end

  test "Slot: badge (links)" do
    assigns = %{}

    run_test(
      ~H"""
      <div>
        <.timeline_item>
          <:badge href="#url"><.octicon name="flame-16" /></:badge>
        </.timeline_item>
        <.timeline_item>
          <:badge navigate="#url"><.octicon name="flame-16" /></:badge>
        </.timeline_item>
        <.timeline_item>
          <:badge patch="#url"><.octicon name="flame-16" /></:badge>
        </.timeline_item>
      </div>
      """,
      __ENV__
    )
  end

  test "Slot: avatar" do
    assigns = %{}

    run_test(
      ~H"""
      <.timeline_item>
        <:badge>
          <.octicon name="git-commit-16" />
        </:badge>
        <:avatar>
          <.avatar size="6" src="/images/user.jpg" />
        </:avatar>
        Someone's commit
      </.timeline_item>
      """,
      __ENV__
    )
  end

  test "Attribute: state" do
    assigns = %{}

    run_test(
      ~H"""
      <div>
        <.timeline_item>
          <:badge><.octicon name="flame-16" /></:badge>
          Message
        </.timeline_item>
        <.timeline_item state="default">
          <:badge><.octicon name="flame-16" /></:badge>
          Message
        </.timeline_item>
        <.timeline_item state="info">
          <:badge><.octicon name="flame-16" /></:badge>
          Message
        </.timeline_item>
        <.timeline_item state="success">
          <:badge><.octicon name="flame-16" /></:badge>
          Message
        </.timeline_item>
        <.timeline_item state="warning">
          <:badge><.octicon name="flame-16" /></:badge>
          Message
        </.timeline_item>
        <.timeline_item state="error">
          <:badge><.octicon name="flame-16" /></:badge>
          Message
        </.timeline_item>
      </div>
      """,
      __ENV__
    )
  end

  test "Attribute: is_condensed" do
    assigns = %{}

    run_test(
      ~H"""
      <.timeline_item is_condensed>
        <:badge><.octicon name="flame-16" /></:badge>
        Message
      </.timeline_item>
      """,
      __ENV__
    )
  end

  test "Attribute: is_break" do
    assigns = %{}

    run_test(
      ~H"""
      <div>
        <.timeline_item state="error">
          <:badge><.octicon name="flame-16" /></:badge>
          Everything will be fine
        </.timeline_item>
        <.timeline_item is_break>Ignored content</.timeline_item>
        <.timeline_item state="success">
          <:badge><.octicon name="flame-16" /></:badge>
          Everything is fine
        </.timeline_item>
      </div>
      """,
      __ENV__
    )
  end

  test "Classes" do
    assigns = %{}

    run_test(
      ~H"""
      <.timeline_item
        classes={
          %{
            timeline_item: "timeline_item-x",
            badge: "badge-x",
            avatar: "avatar-x",
            body: "body-x",
            state_default: "state_default-x",
            state_info: "state_info-x",
            state_success: "state_success-x",
            state_warning: "state_warning-x",
            state_error: "state_error-x"
          }
        }
        class="my-timeline-item"
      >
        <:badge class="my-badge"><.octicon name="flame-16" /></:badge>
        <:avatar class="my-avatar">
          <.avatar size="6" src="/images/user.jpg" />
        </:avatar>
        <a href="#" class="text-bold Link--primary mr-1">Monalisa</a>
        created one <a href="#" class="text-bold Link--primary">hot potato</a>
        <a href="#" class="Link--secondary">Just now</a>
      </.timeline_item>
      """,
      __ENV__
    )
  end

  test "Extra attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.timeline_item dir="rtl">
        <:badge aria-label="Badge"><.octicon name="flame-16" /></:badge>
        <:avatar aria-label="Avatar"><.avatar size="6" src="/images/user.jpg" /></:avatar>
      </.timeline_item>
      """,
      __ENV__
    )
  end
end
