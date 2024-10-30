defmodule PrimerLive.TestComponents.AvatarTest do
  @moduledoc false

  use PrimerLive.TestBase

  test "Without size attribute" do
    assigns = %{}

    run_test(
      ~H"""
      <.avatar src="/images/user.jpg" />
      """,
      __ENV__
    )
  end

  test "Attribute: size" do
    assigns = %{}

    run_test(
      ~H"""
      <div><.avatar src="/images/user.jpg" size={1} /></div>
      <div><.avatar src="/images/user.jpg" size={2} /></div>
      <div><.avatar src="/images/user.jpg" size={3} /></div>
      <div><.avatar src="/images/user.jpg" size={4} /></div>
      <div><.avatar src="/images/user.jpg" size={5} /></div>
      <div><.avatar src="/images/user.jpg" size={6} /></div>
      <div><.avatar src="/images/user.jpg" size={7} /></div>
      <div><.avatar src="/images/user.jpg" size={8} /></div>
      """,
      __ENV__
    )
  end

  test "Attribute: size plus width or height" do
    assigns = %{}

    run_test(
      ~H"""
      <div><.avatar src="/images/user.jpg" width="40" size={1} /></div>
      <div><.avatar src="/images/user.jpg" height="40" size={1} /></div>
      <div><.avatar src="/images/user.jpg" width="40" height="40" /></div>
      """,
      __ENV__
    )
  end

  test "Attribute: is_round" do
    assigns = %{}

    run_test(
      ~H"""
      <.avatar src="/images/user.jpg" is_round />
      """,
      __ENV__
    )
  end

  test "Class" do
    assigns = %{}

    run_test(
      ~H"""
      <.avatar src="/images/user.jpg" class="my-avatar" />
      """,
      __ENV__
    )
  end

  test "Attribute: style" do
    assigns = %{}

    run_test(
      ~H"""
      <.avatar src="/images/user.jpg" style="border: 1px solid red;" />
      """,
      __ENV__
    )
  end
end
