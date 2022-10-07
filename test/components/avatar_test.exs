defmodule PrimerLive.TestComponents.AvatarTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Without size attribute" do
    assigns = []

    assert rendered_to_string(~H"""
           <.avatar src="user.jpg" />
           """)
           |> format_html() ==
             """
             <img class="avatar avatar-3" src="user.jpg" />
             """
             |> format_html()
  end

  test "Attribute: size" do
    assigns = []

    assert rendered_to_string(~H"""
           <.avatar src="user.jpg" size={1} />
           <.avatar src="user.jpg" size="2" />
           <.avatar src="user.jpg" size={3} />
           <.avatar src="user.jpg" size={4} />
           <.avatar src="user.jpg" size={5} />
           <.avatar src="user.jpg" size={6} />
           <.avatar src="user.jpg" size={7} />
           <.avatar src="user.jpg" size={8} />
           """)
           |> format_html() ==
             """
             <img class="avatar avatar-1" src="user.jpg" />
             <img class="avatar avatar-2" src="user.jpg" />
             <img class="avatar avatar-3" src="user.jpg" />
             <img class="avatar avatar-4" src="user.jpg" />
             <img class="avatar avatar-5" src="user.jpg" />
             <img class="avatar avatar-6" src="user.jpg" />
             <img class="avatar avatar-7" src="user.jpg" />
             <img class="avatar avatar-8" src="user.jpg" />
             """
             |> format_html()
  end

  test "Attribute: size (unsupported values)" do
    assigns = []

    assert rendered_to_string(~H"""
           <.avatar src="user.jpg" size={nil} />
           <.avatar src="user.jpg" size="test" />
           <.avatar src="user.jpg" size={0} />
           <.avatar src="user.jpg" size={9} />
           <.avatar src="user.jpg" size="9" />
           """)
           |> format_html() ==
             """
             <img class="avatar avatar-3" src="user.jpg" />
             <img class="avatar avatar-3" src="user.jpg" />
             <img class="avatar avatar-3" src="user.jpg" />
             <img class="avatar avatar-3" src="user.jpg" />
             <img class="avatar avatar-3" src="user.jpg" />
             """
             |> format_html()
  end

  test "Attribute: size plus width or height" do
    assigns = []

    assert rendered_to_string(~H"""
           <.avatar src="user.jpg" width="40" size={1} />
           <.avatar src="user.jpg" height="40" size={1} />
           <.avatar src="user.jpg" width="40" height="40" />
           """)
           |> format_html() ==
             """
             <img class="avatar" src="user.jpg" width="40" />
             <img class="avatar" height="40" src="user.jpg" />
             <img class="avatar" height="40" src="user.jpg" width="40" />
             """
             |> format_html()
  end

  test "Class" do
    assigns = []

    assert rendered_to_string(~H"""
           <.avatar src="user.jpg" class="my-avatar" />
           """)
           |> format_html() ==
             """
             <img class="avatar avatar-3 my-avatar" src="user.jpg" />
             """
             |> format_html()
  end

  test "parent_child_avatar" do
    assigns = []

    assert rendered_to_string(~H"""
           <.parent_child_avatar>
             <:parent src="parent.jpg" size="7" />
             <:child src="child.jpg" size="2" />
           </.parent_child_avatar>
           """)
           |> format_html() ==
             """
             <div class="avatar-parent-child d-inline-flex">
             <img class="avatar avatar-7" src="parent.jpg" />
             <img class="avatar avatar-2 avatar-child" src="child.jpg" />
             </div>
             """
             |> format_html()
  end

  test "parent_child_avatar: classes" do
    assigns = []

    assert rendered_to_string(~H"""
           <.parent_child_avatar class="my-parent-child">
             <:parent src="parent.jpg" size="7" class="my-parent" />
             <:child src="child.jpg" size="2" class="my-child" />
           </.parent_child_avatar>
           """)
           |> format_html() ==
             """
             <div class="avatar-parent-child d-inline-flex my-parent-child">
             <img class="avatar avatar-7 my-parent" src="parent.jpg" />
             <img class="avatar avatar-2 avatar-child my-child" src="child.jpg" />
             </div>
             """
             |> format_html()
  end
end
