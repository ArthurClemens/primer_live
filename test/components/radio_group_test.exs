defmodule PrimerLive.TestComponents.RadioGroupTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "With radio buttons" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.radio_group>
             <:radio_button name="role" value="admin"></:radio_button>
             <:radio_button name="role" value="editor"></:radio_button>
           </.radio_group>
           """)
           |> format_html() ==
             """
             <div class="radio-group">
             <input class="radio-input" id="__admin" name="role" type="radio" value="admin" />
             <label class="radio-label" for="__admin">Admin</label>
             <input class="radio-input" id="__editor" name="role" type="radio" value="editor" />
             <label class="radio-label" for="__editor">Editor</label></div>
             """
             |> format_html()
  end

  test "Called with invalid form value" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.radio_group form="x" />
           """)
           |> format_html() ==
             """
             attr form: invalid value
             """
             |> format_html()
  end

  test "With radio_buttons in inner slot" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.radio_group>
             <:radio_button name="role" value="admin">Some label A</:radio_button>
             <:radio_button name="role" value="editor">Some label B</:radio_button>
           </.radio_group>
           """)
           |> format_html() ==
             """
             <div class="radio-group">
             <input class="radio-input" id="__admin" name="role" type="radio" value="admin" />
             <label class="radio-label" for="__admin">Some label A</label>
             <input class="radio-input" id="__editor" name="role" type="radio" value="editor" />
             <label class="radio-label" for="__editor">Some label B</label></div>
             """
             |> format_html()
  end

  test "Attribute: form and field (atoms)" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.radio_group form={:user} field={:role}>
             <:radio_button value="admin"></:radio_button>
             <:radio_button value="editor"></:radio_button>
           </.radio_group>
           """)
           |> format_html() ==
             """
             <div class="radio-group">
             <input class="radio-input" id="user_role_admin" name="user[role]" type="radio" value="admin" />
             <label class="radio-label" for="user_role_admin">Admin</label>
             <input class="radio-input" id="user_role_editor" name="user[role]" type="radio" value="editor" />
             <label class="radio-label" for="user_role_editor">Editor</label>
             </div>
             """
             |> format_html()
  end

  test "Attribute: field as string" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.radio_group form={:user} field="role">
             <:radio_button value="admin"></:radio_button>
             <:radio_button value="editor"></:radio_button>
           </.radio_group>
           """)
           |> format_html() ==
             """
             <div class="radio-group">
             <input class="radio-input" id="user_role_admin" name="user[role]" type="radio" value="admin" />
             <label class="radio-label" for="user_role_admin">Admin</label>
             <input class="radio-input" id="user_role_editor" name="user[role]" type="radio" value="editor" />
             <label class="radio-label" for="user_role_editor">Editor</label>
             </div>
             """
             |> format_html()
  end

  test "Attribute: id_prefix" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.radio_group form={:user} field={:role} id_prefix="custom">
             <:radio_button value="admin"></:radio_button>
             <:radio_button value="editor"></:radio_button>
           </.radio_group>
           """)
           |> format_html() ==
             """
             <div class="radio-group">
             <input class="radio-input" id="custom-user_role_admin" name="user[role]" type="radio" value="admin" />
             <label class="radio-label" for="custom-user_role_admin">Admin</label>
             <input class="radio-input" id="custom-user_role_editor" name="user[role]" type="radio" value="editor" />
             <label class="radio-label" for="custom-user_role_editor">Editor</label>
             </div>
             """
             |> format_html()
  end

  test "Classes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.radio_group
             classes={
               %{
                 radio_group: "radio-group-x",
                 label: "label-x",
                 radio_input: "radio-input-x"
               }
             }
             class="my-radio-group"
           >
             <:radio_button class="my-radio-button-a" name="role" value="admin">Some label A</:radio_button>
             <:radio_button class="my-radio-button-b" name="role" value="editor">Some label B</:radio_button>
           </.radio_group>
           """)
           |> format_html() ==
             """
             <div class="radio-group radio-group-x my-radio-group">
             <input class="my-radio-button-a" class="radio-input radio-input-x my-radio-button-a" id="__admin" name="role" type="radio" value="admin" />
             <label class="radio-label label-x" for="__admin">Some label A</label>
             <input class="my-radio-button-b" class="radio-input radio-input-x my-radio-button-b" id="__editor" name="role" type="radio" value="editor" />
             <label class="radio-label label-x" for="__editor">Some label B</label>
             </div>
             """
             |> format_html()
  end

  test "Extra attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.radio_group dir="rtl">
             <:radio_button name="role" value="admin"></:radio_button>
             <:radio_button name="role" value="editor"></:radio_button>
           </.radio_group>
           """)
           |> format_html() ==
             """
             <div class="radio-group" dir="rtl">
             <input class="radio-input" id="__admin" name="role" type="radio" value="admin" />
             <label class="radio-label" for="__admin">Admin</label>
             <input class="radio-input" id="__editor" name="role" type="radio" value="editor" />
             <label class="radio-label" for="__editor">Editor</label></div>
             """
             |> format_html()
  end
end
