defmodule PrimerLive.TestComponents.AsLinkTest do
  @moduledoc false

  use PrimerLive.TestBase

  test "Without link attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.as_link>label</.as_link>
      """,
      __ENV__
    )
  end

  test "With link attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.as_link href="/home">label</.as_link>
      <.as_link navigate="/account">label</.as_link>
      <.as_link patch="/history">label</.as_link>
      """,
      __ENV__
    )
  end

  test "Attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.as_link is_primary>label</.as_link>
      <.as_link is_secondary>label</.as_link>
      <.as_link is_no_underline>label</.as_link>
      <.as_link is_muted>label</.as_link>
      <.as_link is_on_hover>label</.as_link>
      """,
      __ENV__
    )
  end

  test "Class" do
    assigns = %{}

    run_test(
      ~H"""
      <.as_link class="my-link">label</.as_link>
      <.as_link href="/home" class="my-link">label</.as_link>
      """,
      __ENV__
    )
  end

  test "Other attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.as_link rel="next">label</.as_link>
      <.as_link rel="next" href="/home">label</.as_link>
      """,
      __ENV__
    )
  end
end
