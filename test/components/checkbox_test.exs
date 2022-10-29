defmodule PrimerLive.TestComponents.CheckboxTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  @default_form %Phoenix.HTML.Form{
    id: "user",
    name: "user",
    params: %{"available_for_hire" => ""},
    source: %Ecto.Changeset{
      action: :validate,
      changes: %{},
      errors: [
        available_for_hire: {"can't be blank", [validation: :required]}
      ],
      data: nil,
      valid?: false
    }
  }

  @default_changeset %Ecto.Changeset{
    action: nil,
    changes: %{},
    errors: [],
    data: nil,
    valid?: true
  }

  test "Called without options or inner_block: should render the component" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.checkbox />
           """)
           |> format_html() ==
             """
             <input name="[]" type="hidden" value="false" />
             <input class="form-checkbox" id="_" name="[]" type="checkbox" value="true" />
             """
             |> format_html()
  end

  test "Called with invalid form value" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.checkbox form="x" />
           """)
           |> format_html() ==
             """
             attr form: invalid value
             """
             |> format_html()
  end

  test "Attribute: is_group" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.checkbox form={:user} field={:available_for_hire} is_group />
           """)
           |> format_html() ==
             """
             <div class="form-group">
             <div class="form-group-header"><label for="user_available_for_hire">Available for hire</label></div>
             <div class="form-group-body"><input name="user[available_for_hire]" type="hidden" value="false" />
             <input class="form-checkbox" id="user_available_for_hire" name="user[available_for_hire]" type="checkbox" value="true" />
             </div>
             </div>
             """
             |> format_html()
  end

  test "Group slot with label, without inner_block" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.checkbox form={:user} field={:available_for_hire}>
             <:group label="Some label"></:group>
           </.checkbox>
           """)
           |> format_html() ==
             """
             <div class="form-group">
             <div class="form-group-header"><label for="user_available_for_hire">Some label</label></div>
             <div class="form-group-body">
             <input name="user[available_for_hire]" type="hidden" value="false" />
             <input class="form-checkbox" id="user_available_for_hire" name="user[available_for_hire]" type="checkbox" value="true" />
             </div>
             </div>
             """
             |> format_html()
  end

  test "Group slot with label and inner_block" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.checkbox form={:user} field={:available_for_hire}>
             <:group :let={field} label="Some label">
               <h2><%= field.label %></h2>
             </:group>
           </.checkbox>
           """)
           |> format_html() ==
             """
             <div class="form-group">
             <div class="form-group-header">
             <h2><label for="user_available_for_hire">Some label</label></h2>
             </div>
             <div class="form-group-body">
             <input name="user[available_for_hire]" type="hidden" value="false" />
             <input class="form-checkbox" id="user_available_for_hire" name="user[available_for_hire]" type="checkbox" value="true" />
             </div>
             </div>
             """
             |> format_html()
  end

  test "Group slot with field_state" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.checkbox form={:user} field={:available_for_hire}>
             <:group :let={field} label="Some label">
               <h2>
                 <%= if !field.field_state.valid? do %>
                   <div>Please correct your input</div>
                 <% end %>

                 <%= field.label %>
               </h2>
             </:group>
           </.checkbox>
           """)
           |> format_html() ==
             """
             <div class="form-group">
             <div class="form-group-header">
             <h2>
             <div>Please correct your input</div><label for="user_available_for_hire">Some label</label>
             </h2>
             </div>
             <div class="form-group-body">
             <input name="user[available_for_hire]" type="hidden" value="false" />
             <input class="form-checkbox" id="user_available_for_hire" name="user[available_for_hire]" type="checkbox" value="true" />
             </div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: form and field (atoms)" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.checkbox form={:user} field={:available_for_hire} />
           """)
           |> format_html() ==
             """
             <input name="user[available_for_hire]" type="hidden" value="false" />
             <input class="form-checkbox" id="user_available_for_hire" name="user[available_for_hire]" type="checkbox" value="true" />
             """
             |> format_html()
  end

  test "Attribute: field as string" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.checkbox form={:user} field="available_for_hire" />
           """)
           |> format_html() ==
             """
             <input name="user[available_for_hire]" type="hidden" value="false" />
             <input class="form-checkbox" id="user_available_for_hire" name="user[available_for_hire]" type="checkbox" value="true" />
             """
             |> format_html()
  end

  test "Attribute: name only" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.checkbox name="available_for_hire" />
           """)
           |> format_html() ==
             """
             <input name="available_for_hire" type="hidden" value="false" />
             <input class="form-checkbox" id="_" name="available_for_hire" type="checkbox" value="true" />
             """
             |> format_html()
  end

  test "Attribute: types" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.checkbox type={:x} />
           <.checkbox type="color" />
           <.checkbox type="date" />
           <.checkbox type="datetime-local" />
           <.checkbox type="email" />
           <.checkbox type="file" />
           <.checkbox type="hidden" />
           <.checkbox type="number" />
           <.checkbox type="password" />
           <.checkbox type="range" />
           <.checkbox type="search" />
           <.checkbox type="telephone" />
           <.checkbox type="text" />
           <.checkbox type="textarea" />
           <.checkbox type="time" />
           <.checkbox type="url" />
           """)
           |> format_html() ==
             """
             <input name="[]" type="hidden" value="false" />
             <input class="form-checkbox" id="_" name="[]" type="checkbox" value="true" />
             <input name="[]" type="hidden" value="false" />
             <input class="form-checkbox" id="_" name="[]" type="checkbox" value="true" />
             <input name="[]" type="hidden" value="false" />
             <input class="form-checkbox" id="_" name="[]" type="checkbox" value="true" />
             <input name="[]" type="hidden" value="false" />
             <input class="form-checkbox" id="_" name="[]" type="checkbox" value="true" />
             <input name="[]" type="hidden" value="false" />
             <input class="form-checkbox" id="_" name="[]" type="checkbox" value="true" />
             <input name="[]" type="hidden" value="false" />
             <input class="form-checkbox" id="_" name="[]" type="checkbox" value="true" />
             <input name="[]" type="hidden" value="false" />
             <input class="form-checkbox" id="_" name="[]" type="checkbox" value="true" />
             <input name="[]" type="hidden" value="false" />
             <input class="form-checkbox" id="_" name="[]" type="checkbox" value="true" />
             <input name="[]" type="hidden" value="false" />
             <input class="form-checkbox" id="_" name="[]" type="checkbox" value="true" />
             <input name="[]" type="hidden" value="false" />
             <input class="form-checkbox" id="_" name="[]" type="checkbox" value="true" />
             <input name="[]" type="hidden" value="false" />
             <input class="form-checkbox" id="_" name="[]" type="checkbox" value="true" />
             <input name="[]" type="hidden" value="false" />
             <input class="form-checkbox" id="_" name="[]" type="checkbox" value="true" />
             <input name="[]" type="hidden" value="false" />
             <input class="form-checkbox" id="_" name="[]" type="checkbox" value="true" />
             <input name="[]" type="hidden" value="false" />
             <input class="form-checkbox" id="_" name="[]" type="checkbox" value="true" />
             <input name="[]" type="hidden" value="false" />
             <input class="form-checkbox" id="_" name="[]" type="checkbox" value="true" />
             <input name="[]" type="hidden" value="false" />
             <input class="form-checkbox" id="_" name="[]" type="checkbox" value="true" />
             """
             |> format_html()
  end

  test "Attribute: label" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.checkbox name="available_for_hire" label="Some label" />
           """)
           |> format_html() ==
             """
             label
             """
             |> format_html()
  end

  test "Attribute: is_checked" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.checkbox name="available_for_hire" is_checked />
           """)
           |> format_html() ==
             """
             <input name="available_for_hire" type="hidden" value="false" />
             <input checked="checked" class="form-checkbox" id="_" name="available_for_hire" type="checkbox" value="true" />
             """
             |> format_html()
  end
end
