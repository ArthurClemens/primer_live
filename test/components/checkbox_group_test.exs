defmodule PrimerLive.TestComponents.CheckboxGroupTest do
  use ExUnit.Case
  use PrimerLive

  import PrimerLive.Helpers.TestHelpers
  import Phoenix.Component
  import Phoenix.LiveViewTest

  alias PrimerLive.TestHelpers.Repo.Todos

  test "Simple group" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <form>
             <.checkbox_group>
               <.checkbox name="roles[]" checked_value="admin" />
               <.checkbox name="roles[]" checked_value="editor" />
             </.checkbox_group>
           </form>
           """)
           |> format_html() ==
             """
             <form>
             <div class="FormControl pl-FormControl--input-group">
             <div class="pl-FormControl--input-group__container"><span class="FormControl-checkbox-wrap"><input name="roles[]"
             type="hidden" value="false" /><input class="FormControl-checkbox" id="roles_admin" name="roles[]"
             type="checkbox" value="admin" /><span class="FormControl-checkbox-labelWrap"><label class="FormControl-label"
             for="roles_admin">Admin</label></span></span><span class="FormControl-checkbox-wrap"><input name="roles[]"
             type="hidden" value="false" /><input class="FormControl-checkbox" id="roles_editor" name="roles[]"
             type="checkbox" value="editor" /><span class="FormControl-checkbox-labelWrap"><label class="FormControl-label"
             for="roles_editor">Editor</label></span></span></div>
             </div>
             </form>
             """
             |> format_html()
  end

  test "Disabled" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <form>
             <.checkbox_group is_disabled>
               <.checkbox name="roles[]" checked_value="admin" />
               <.checkbox name="roles[]" checked_value="editor" />
             </.checkbox_group>
           </form>
           """)
           |> format_html() ==
             """
             <form>
             <div class="FormControl pl-FormControl-disabled pl-FormControl--input-group">
               <div class="pl-FormControl--input-group__container"><span class="FormControl-checkbox-wrap"><input name="roles[]"
                     type="hidden" value="false" /><input class="FormControl-checkbox" id="roles_admin" name="roles[]"
                     type="checkbox" value="admin" /><span class="FormControl-checkbox-labelWrap"><label class="FormControl-label"
                       for="roles_admin">Admin</label></span></span><span class="FormControl-checkbox-wrap"><input name="roles[]"
                     type="hidden" value="false" /><input class="FormControl-checkbox" id="roles_editor" name="roles[]"
                     type="checkbox" value="editor" /><span class="FormControl-checkbox-labelWrap"><label class="FormControl-label"
                       for="roles_editor">Editor</label></span></span></div>
             </div>
             </form>
             """
             |> format_html()
  end

  test "Caption" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <form>
             <.checkbox_group label="Role" caption="Select one">
               <.checkbox name="role-caption[]" checked_value="admin" />
               <.checkbox name="role-caption[]" checked_value="editor" />
             </.checkbox_group>
           </form>
           """)
           |> format_html() ==
             """
             <form>
             <div class="FormControl pl-FormControl--input-group">
             <div class="form-group-header"><label class="FormControl-label">Role</label></div>
             <div class="FormControl-caption">Select one</div>
             <div class="pl-FormControl--input-group__container"><span class="FormControl-checkbox-wrap"><input
             name="role-caption[]" type="hidden" value="false" /><input class="FormControl-checkbox"
             id="role-caption_admin" name="role-caption[]" type="checkbox" value="admin" /><span
             class="FormControl-checkbox-labelWrap"><label class="FormControl-label"
             for="role-caption_admin">Admin</label></span></span><span class="FormControl-checkbox-wrap"><input
             name="role-caption[]" type="hidden" value="false" /><input class="FormControl-checkbox"
             id="role-caption_editor" name="role-caption[]" type="checkbox" value="editor" /><span
             class="FormControl-checkbox-labelWrap"><label class="FormControl-label"
             for="role-caption_editor">Editor</label></span></span></div>
             </div>
             </form>
             """
             |> format_html()
  end

  test "Derived label" do
    changeset = Todos.init()
    options = Todos.status_options()
    values = changeset.changes |> Map.get(:statuses) || []

    assigns = %{
      changeset: changeset,
      options: options,
      values: values,
      field: :statuses
    }

    assert rendered_to_string(~H"""
           <.form :let={f} for={@changeset}>
             <.checkbox_group form={f} field={@field}>
               <.checkbox_in_group
                 :for={{_label, value} <- @options}
                 form={f}
                 field={@field}
                 checked_value={value}
               />
             </.checkbox_group>
           </.form>
           """)
           |> format_html() ==
             """
             <form method="post">
             <div class="FormControl pl-FormControl--input-group pl-invalid">
             <div class="form-group-header"><label class="FormControl-label">Statuses</label>
             <span aria-hidden="true">*</span>
             </div>
             <div class="pl-FormControl--input-group__container"><span class="FormControl-checkbox-wrap pl-invalid"><input
             name="todo[statuses][]" type="hidden" value="false" /><input class="FormControl-checkbox"
             id="todo_statuses_in-progress" name="todo[statuses][]" type="checkbox" value="in-progress" /><span
             class="FormControl-checkbox-labelWrap"><label class="FormControl-label"
             for="todo_statuses_in-progress">In-progress</label></span></span><span
             class="FormControl-checkbox-wrap pl-invalid"><input name="todo[statuses][]" type="hidden" value="false" /><input
             class="FormControl-checkbox" id="todo_statuses_needs-review" name="todo[statuses][]" type="checkbox"
             value="needs-review" /><span class="FormControl-checkbox-labelWrap"><label class="FormControl-label"
             for="todo_statuses_needs-review">Needs-review</label></span></span><span
             class="FormControl-checkbox-wrap pl-invalid"><input name="todo[statuses][]" type="hidden" value="false" /><input
             class="FormControl-checkbox" id="todo_statuses_complete" name="todo[statuses][]" type="checkbox"
             value="complete" /><span class="FormControl-checkbox-labelWrap"><label class="FormControl-label"
             for="todo_statuses_complete">Complete</label></span></span></div>
             </div>
             </form>
             """
             |> format_html()
  end

  test "Custom label" do
    changeset = Todos.init()
    options = Todos.status_options()
    values = changeset.changes |> Map.get(:statuses) || []

    assigns = %{
      changeset: changeset,
      options: options,
      values: values,
      field: :statuses
    }

    assert rendered_to_string(~H"""
           <.form :let={f} for={@changeset}>
             <.checkbox_group form={f} field={@field}>
               <.checkbox_in_group
                 :for={{label, value} <- @options}
                 form={f}
                 field={@field}
                 checked_value={value}
               >
                 <:label>
                   <%= label |> String.downcase() %>
                 </:label>
               </.checkbox_in_group>
             </.checkbox_group>
           </.form>
           """)
           |> format_html() ==
             """
             <form method="post">
             <div class="FormControl pl-FormControl--input-group pl-invalid">
             <div class="form-group-header"><label class="FormControl-label">Statuses</label>
             <span aria-hidden="true">*</span>
             </div>
             <div class="pl-FormControl--input-group__container"><span class="FormControl-checkbox-wrap pl-invalid"><input
             name="todo[statuses][]" type="hidden" value="false" /><input class="FormControl-checkbox"
             id="todo_statuses_in-progress" name="todo[statuses][]" type="checkbox" value="in-progress" /><span
             class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="todo_statuses_in-progress">in
             progress</label></span></span><span class="FormControl-checkbox-wrap pl-invalid"><input
             name="todo[statuses][]" type="hidden" value="false" /><input class="FormControl-checkbox"
             id="todo_statuses_needs-review" name="todo[statuses][]" type="checkbox" value="needs-review" /><span
             class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="todo_statuses_needs-review">needs
             review</label></span></span><span class="FormControl-checkbox-wrap pl-invalid"><input
             name="todo[statuses][]" type="hidden" value="false" /><input class="FormControl-checkbox"
             id="todo_statuses_complete" name="todo[statuses][]" type="checkbox" value="complete" /><span
             class="FormControl-checkbox-labelWrap"><label class="FormControl-label"
             for="todo_statuses_complete">complete</label></span></span></div>
             </div>
             </form>
             """
             |> format_html()
  end

  test "Default error" do
    changeset = Todos.init()
    options = Todos.status_options()
    values = changeset.changes |> Map.get(:statuses) || []

    form = %Phoenix.HTML.Form{
      impl: Phoenix.HTML.FormData.Ecto.Changeset,
      id: "user",
      name: "user",
      params: %{"statuses" => ""},
      source: %Ecto.Changeset{changeset | action: :validate}
    }

    assigns = %{
      options: options,
      values: values,
      field: :statuses,
      form: form
    }

    assert rendered_to_string(~H"""
           <.checkbox_group form={@form} field={@field} label="Status" caption="Pick any of these choices">
             <%= for {label, value} <- @options do %>
               <.checkbox_in_group
                 form={@form}
                 field={@field}
                 checked_value={value}
                 checked={value in @values}
               >
                 <:label>
                   <%= label %>
                 </:label>
               </.checkbox_in_group>
             <% end %>
           </.checkbox_group>
           """)
           |> format_html() ==
             """
             <div class="FormControl pl-FormControl--input-group pl-invalid">
             <div class="form-group-header"><label class="FormControl-label">Status</label><span aria-hidden="true">*</span></div>
             <div class="FormControl-caption">Pick any of these choices</div>
             <div class="pl-FormControl--input-group__container"><span class="FormControl-checkbox-wrap pl-invalid"
             phx-feedback-for="user[statuses][]"><input name="user[statuses][]" type="hidden" value="false" /><input
             class="FormControl-checkbox" id="user_statuses_in-progress" invalid="" name="user[statuses][]" type="checkbox"
             value="in-progress" /><span class="FormControl-checkbox-labelWrap"><label class="FormControl-label"
             for="user_statuses_in-progress">In progress</label></span></span><span
             class="FormControl-checkbox-wrap pl-invalid" phx-feedback-for="user[statuses][]"><input name="user[statuses][]"
             type="hidden" value="false" /><input class="FormControl-checkbox" id="user_statuses_needs-review" invalid=""
             name="user[statuses][]" type="checkbox" value="needs-review" /><span
             class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="user_statuses_needs-review">Needs
             review</label></span></span><span class="FormControl-checkbox-wrap pl-invalid"
             phx-feedback-for="user[statuses][]"><input name="user[statuses][]" type="hidden" value="false" /><input
             class="FormControl-checkbox" id="user_statuses_complete" invalid="" name="user[statuses][]" type="checkbox"
             value="complete" /><span class="FormControl-checkbox-labelWrap"><label class="FormControl-label"
             for="user_statuses_complete">Complete</label></span></span>
             <div class="FormControl-inlineValidation FormControl-inlineValidation--error" id="user_statuses-validation"
             phx-feedback-for="user[statuses][]"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="12" height="12"
             viewBox="0 0 12 12">STRIPPED_SVG_PATHS</svg><span>must select a status</span></div>
             </div>
             </div>
             """
             |> format_html()
  end
end
