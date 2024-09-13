defmodule PrimerLive.TestComponents.SubheadTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Without attributes or slots" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.subhead>Heading</.subhead>
           """)
           |> format_html() ==
             """
             <div class="Subhead">
             <h2 class="Subhead-heading">Heading</h2>
             </div>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Attributes: is_spacious" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.subhead is_spacious>Heading</.subhead>
           """)
           |> format_html() ==
             """
             <div class="Subhead Subhead--spacious">
             <h2 class="Subhead-heading">Heading</h2>
             </div>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Attributes: is_danger" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.subhead is_danger>Heading</.subhead>
           """)
           |> format_html() ==
             """
             <div class="Subhead">
             <h2 class="Subhead-heading Subhead-heading--danger">Heading</h2>
             </div>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Slot: description" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.subhead>
             Heading
             <:description>
               Description
             </:description>
           </.subhead>
           """)
           |> format_html() ==
             """
             <div class="Subhead">
             <h2 class="Subhead-heading">Heading</h2>
             <div class="Subhead-description">Description</div>
             </div>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Slot: actions" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.subhead>
             Heading
             <:actions>
               <.button is_primary>Action</.button>
             </:actions>
           </.subhead>
           """)
           |> format_html() ==
             """
             <div class="Subhead">
             <h2 class="Subhead-heading">Heading</h2>
             <div class="Subhead-actions"><button class="btn btn-primary" type="button"><span class="pl-button__content">Action</span></button></div>
             </div>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Classes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.subhead
             class="my-subhead"
             classes={
               %{
                 subhead: "subhead-x",
                 heading: "heading-x",
                 description: "description-x",
                 actions: "actions-x"
               }
             }
           >
             Heading
             <:actions class="my-action">
               <.button is_primary>Action</.button>
             </:actions>
             <:description class="my-description">
               Description
             </:description>
           </.subhead>
           """)
           |> format_html() ==
             """
             <div class="Subhead subhead-x my-subhead">
             <h2 class="Subhead-heading heading-x">Heading</h2>
             <div class="Subhead-description description-x my-description">Description</div>
             <div class="Subhead-actions actions-x my-action"><button class="btn btn-primary" type="button"><span class="pl-button__content">Action</span></button></div>
             </div>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end
end
