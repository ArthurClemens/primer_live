defmodule PrimerLive.TestComponents.ParentChildAvatarTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Parent and child slots" do
    assigns = %{}

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

  test "Classes" do
    assigns = %{}

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
