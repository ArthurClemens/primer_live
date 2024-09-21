defmodule PrimerLive.TestComponents.AvatarTest do
  @moduledoc false

  use PrimerLive.TestBase

  test "Without size attribute" do
    assigns = %{}

    run_test(
      ~H"""
      <.avatar src="user.jpg" />
      """,
      __ENV__
    )
  end

  test "Attribute: size" do
    assigns = %{}

    run_test(
      ~H"""
      <.avatar src="user.jpg" size={1} />
      <.avatar src="user.jpg" size="2" />
      <.avatar src="user.jpg" size={3} />
      <.avatar src="user.jpg" size={4} />
      <.avatar src="user.jpg" size={5} />
      <.avatar src="user.jpg" size={6} />
      <.avatar src="user.jpg" size={7} />
      <.avatar src="user.jpg" size={8} />
      """,
      __ENV__
    )
  end

  test "Attribute: size (unsupported values)" do
    assigns = %{}

    run_test(
      ~H"""
      <.avatar src="user.jpg" size={nil} />
      <.avatar src="user.jpg" size="test" />
      <.avatar src="user.jpg" size={0} />
      <.avatar src="user.jpg" size={9} />
      <.avatar src="user.jpg" size="9" />
      """,
      __ENV__
    )
  end

  test "Attribute: size plus width or height" do
    assigns = %{}

    run_test(
      ~H"""
      <.avatar src="user.jpg" width="40" size={1} />
      <.avatar src="user.jpg" height="40" size={1} />
      <.avatar src="user.jpg" width="40" height="40" />
      """,
      __ENV__
    )
  end

  test "Attribute: is_round" do
    assigns = %{}

    run_test(
      ~H"""
      <.avatar src="user.jpg" is_round />
      """,
      __ENV__
    )
  end

  test "Class" do
    assigns = %{}

    run_test(
      ~H"""
      <.avatar src="user.jpg" class="my-avatar" />
      """,
      __ENV__
    )
  end

  test "Attribute: style" do
    assigns = %{}

    run_test(
      ~H"""
      <.avatar src="user.jpg" style="border: 1px solid red;" />
      """,
      __ENV__
    )
  end
end
