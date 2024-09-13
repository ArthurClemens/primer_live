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
             <form><fieldset><div class="FormControl"><div class="FormControl-checkbox-wrap"><input name="roles[]" type="hidden" value="false" /><input class="FormControl-checkbox" id="roles-admin" name="roles[]" type="checkbox" value="admin" /><div class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="roles-admin">Admin</label></div></div><div class="FormControl-checkbox-wrap"><input name="roles[]" type="hidden" value="false" /><input class="FormControl-checkbox" id="roles-editor" name="roles[]" type="checkbox" value="editor" /><div class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="roles-editor">Editor</label></div></div></div></fieldset></form>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
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
             <form><fieldset disabled><div class="FormControl pl-FormControl-disabled"><div class="FormControl-checkbox-wrap"><input name="roles[]" type="hidden" value="false" /><input class="FormControl-checkbox" id="roles-admin" name="roles[]" type="checkbox" value="admin" /><div class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="roles-admin">Admin</label></div></div><div class="FormControl-checkbox-wrap"><input name="roles[]" type="hidden" value="false" /><input class="FormControl-checkbox" id="roles-editor" name="roles[]" type="checkbox" value="editor" /><div class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="roles-editor">Editor</label></div></div></div></fieldset></form>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
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
             <form><fieldset><legend class="FormControl-label">Role</legend><div class="FormControl"><div class="FormControl-caption">Select one</div><div class="FormControl-checkbox-wrap"><input name="role-caption[]" type="hidden" value="false" /><input class="FormControl-checkbox" id="role-caption-admin" name="role-caption[]" type="checkbox" value="admin" /><div class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="role-caption-admin">Admin</label></div></div><div class="FormControl-checkbox-wrap"><input name="role-caption[]" type="hidden" value="false" /><input class="FormControl-checkbox" id="role-caption-editor" name="role-caption[]" type="checkbox" value="editor" /><div class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="role-caption-editor">Editor</label></div></div></div></fieldset></form>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
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
             <form method="post"><fieldset><legend class="FormControl-label">Statuses</legend><div class="FormControl pl-invalid"><div class="FormControl-checkbox-wrap pl-invalid"><input name="todo[statuses][]" type="hidden" value="false" /><input class="FormControl-checkbox" id="todo-statuses-in-progress" name="todo[statuses][]" type="checkbox" value="in-progress" /><div class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="todo-statuses-in-progress">In-progress</label></div></div><div class="FormControl-checkbox-wrap pl-invalid"><input name="todo[statuses][]" type="hidden" value="false" /><input class="FormControl-checkbox" id="todo-statuses-needs-review" name="todo[statuses][]" type="checkbox" value="needs-review" /><div class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="todo-statuses-needs-review">Needs-review</label></div></div><div class="FormControl-checkbox-wrap pl-invalid"><input name="todo[statuses][]" type="hidden" value="false" /><input class="FormControl-checkbox" id="todo-statuses-complete" name="todo[statuses][]" type="checkbox" value="complete" /><div class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="todo-statuses-complete">Complete</label></div></div></div></fieldset></form>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
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
             <form method="post"><fieldset><legend class="FormControl-label">Statuses</legend><div class="FormControl pl-invalid"><div class="FormControl-checkbox-wrap pl-invalid"><input name="todo[statuses][]" type="hidden" value="false" /><input class="FormControl-checkbox" id="todo-statuses-in-progress" name="todo[statuses][]" type="checkbox" value="in-progress" /><div class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="todo-statuses-in-progress">in progress</label></div></div><div class="FormControl-checkbox-wrap pl-invalid"><input name="todo[statuses][]" type="hidden" value="false" /><input class="FormControl-checkbox" id="todo-statuses-needs-review" name="todo[statuses][]" type="checkbox" value="needs-review" /><div class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="todo-statuses-needs-review">needs review</label></div></div><div class="FormControl-checkbox-wrap pl-invalid"><input name="todo[statuses][]" type="hidden" value="false" /><input class="FormControl-checkbox" id="todo-statuses-complete" name="todo[statuses][]" type="checkbox" value="complete" /><div class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="todo-statuses-complete">complete</label></div></div></div></fieldset></form>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
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
             <fieldset><legend class="FormControl-label">Status</legend><div class="FormControl pl-invalid"><div class="FormControl-caption">Pick any of these choices</div><div class="FormControl-checkbox-wrap pl-invalid" phx-feedback-for="user[statuses][]"><input name="user[statuses][]" type="hidden" value="false" /><input class="FormControl-checkbox" id="user-statuses-in-progress" invalid="" name="user[statuses][]" type="checkbox" value="in-progress" /><div class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="user-statuses-in-progress">In progress</label></div></div><div class="FormControl-checkbox-wrap pl-invalid" phx-feedback-for="user[statuses][]"><input name="user[statuses][]" type="hidden" value="false" /><input class="FormControl-checkbox" id="user-statuses-needs-review" invalid="" name="user[statuses][]" type="checkbox" value="needs-review" /><div class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="user-statuses-needs-review">Needs review</label></div></div><div class="FormControl-checkbox-wrap pl-invalid" phx-feedback-for="user[statuses][]"><input name="user[statuses][]" type="hidden" value="false" /><input class="FormControl-checkbox" id="user-statuses-complete" invalid="" name="user[statuses][]" type="checkbox" value="complete" /><div class="FormControl-checkbox-labelWrap"><label class="FormControl-label" for="user-statuses-complete">Complete</label></div></div></div></fieldset>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end
end
