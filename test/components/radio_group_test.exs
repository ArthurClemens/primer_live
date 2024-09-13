defmodule PrimerLive.TestComponents.RadioGroupTest do
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
             <.radio_group>
               <.radio_button name="role" value="admin" />
               <.radio_button name="role" value="editor" />
             </.radio_group>
           </form>
           """)
           |> format_html() ==
             """
             <form><fieldset><div class="FormControl"><div class="FormControl-radio-wrap"><input class="FormControl-radio" id="role-admin" name="role" type="radio" value="admin" /><div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="role-admin">Admin</label></div></div><div class="FormControl-radio-wrap"><input class="FormControl-radio" id="role-editor" name="role" type="radio" value="editor" /><div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="role-editor">Editor</label></div></div></div></fieldset></form>
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
             <.radio_group is_disabled>
               <.radio_button name="role" value="admin" />
               <.radio_button name="role" value="editor" />
             </.radio_group>
           </form>
           """)
           |> format_html() ==
             """
             <form><fieldset disabled><div class="FormControl pl-FormControl-disabled"><div class="FormControl-radio-wrap"><input class="FormControl-radio" id="role-admin" name="role" type="radio" value="admin" /><div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="role-admin">Admin</label></div></div><div class="FormControl-radio-wrap"><input class="FormControl-radio" id="role-editor" name="role" type="radio" value="editor" /><div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="role-editor">Editor</label></div></div></div></fieldset></form>
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
             <.radio_group label="Role" caption="Select one">
               <.radio_button name="role-caption" value="admin" />
               <.radio_button name="role-caption" value="editor" />
             </.radio_group>
           </form>
           """)
           |> format_html() ==
             """
             <form><fieldset><legend class="FormControl-label">Role</legend><div class="FormControl"><div class="FormControl-caption">Select one</div><div class="FormControl-radio-wrap"><input class="FormControl-radio" id="role-caption-admin" name="role-caption" type="radio" value="admin" /><div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="role-caption-admin">Admin</label></div></div><div class="FormControl-radio-wrap"><input class="FormControl-radio" id="role-caption-editor" name="role-caption" type="radio" value="editor" /><div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="role-caption-editor">Editor</label></div></div></div></fieldset></form>
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
             <.radio_group form={f} field={@field}>
               <.radio_button
                 :for={{_label, value} <- @options}
                 form={f}
                 field={@field}
                 value={value}
                 id={value <> "-derived-label"}
               />
             </.radio_group>
           </.form>
           """)
           |> format_html() ==
             """
             <form method="post"><fieldset><legend class="FormControl-label">Statuses</legend><div class="FormControl pl-invalid"><div class="FormControl-radio-wrap pl-invalid"><input class="FormControl-radio" id="in-progress-derived-label" name="todo[statuses]" type="radio" value="in-progress" /><div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="in-progress-derived-label">In-progress</label></div></div><div class="FormControl-radio-wrap pl-invalid"><input class="FormControl-radio" id="needs-review-derived-label" name="todo[statuses]" type="radio" value="needs-review" /><div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="needs-review-derived-label">Needs-review</label></div></div><div class="FormControl-radio-wrap pl-invalid"><input class="FormControl-radio" id="complete-derived-label" name="todo[statuses]" type="radio" value="complete" /><div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="complete-derived-label">Complete</label></div></div></div></fieldset></form>
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
             <.radio_group form={f} field={@field}>
               <.radio_button
                 :for={{label, value} <- @options}
                 form={f}
                 field={@field}
                 value={value}
                 id={value <> "-custom-label"}
               >
                 <:label>
                   <%= label |> String.downcase() %>
                 </:label>
               </.radio_button>
             </.radio_group>
           </.form>
           """)
           |> format_html() ==
             """
             <form method="post"><fieldset><legend class="FormControl-label">Statuses</legend><div class="FormControl pl-invalid"><div class="FormControl-radio-wrap pl-invalid"><input class="FormControl-radio" id="in-progress-custom-label" name="todo[statuses]" type="radio" value="in-progress" /><div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="in-progress-custom-label">in progress</label></div></div><div class="FormControl-radio-wrap pl-invalid"><input class="FormControl-radio" id="needs-review-custom-label" name="todo[statuses]" type="radio" value="needs-review" /><div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="needs-review-custom-label">needs review</label></div></div><div class="FormControl-radio-wrap pl-invalid"><input class="FormControl-radio" id="complete-custom-label" name="todo[statuses]" type="radio" value="complete" /><div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="complete-custom-label">complete</label></div></div></div></fieldset></form>
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

    validate_changeset = %Ecto.Changeset{
      changeset
      | action: :validate,
        changes: %{statuses: nil}
    }

    options = Todos.status_options()
    values = changeset.changes |> Map.get(:statuses) || []

    assigns = %{
      changeset: validate_changeset,
      options: options,
      values: values,
      field: :statuses
    }

    assert rendered_to_string(~H"""
           <.form :let={f} for={@changeset}>
             <.radio_group form={f} field={@field} caption="Select one">
               <%= for {label, value} <- @options do %>
                 <.radio_button form={f} field={@field} value={value} id={value <> "-default-error"}>
                   <:label>
                     <%= label %>
                   </:label>
                 </.radio_button>
               <% end %>
             </.radio_group>
           </.form>
           """)
           |> format_html() ==
             """
             <form method="post"><fieldset><legend class="FormControl-label">Statuses</legend><div class="FormControl pl-invalid"><div class="FormControl-caption">Select one</div><div class="FormControl-radio-wrap pl-invalid" phx-feedback-for="todo[statuses]"><input class="FormControl-radio" id="in-progress-default-error" invalid="" name="todo[statuses]" type="radio" value="in-progress" /><div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="in-progress-default-error">In progress</label></div></div><div class="FormControl-radio-wrap pl-invalid" phx-feedback-for="todo[statuses]"><input class="FormControl-radio" id="needs-review-default-error" invalid="" name="todo[statuses]" type="radio" value="needs-review" /><div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="needs-review-default-error">Needs review</label></div></div><div class="FormControl-radio-wrap pl-invalid" phx-feedback-for="todo[statuses]"><input class="FormControl-radio" id="complete-default-error" invalid="" name="todo[statuses]" type="radio" value="complete" /><div class="FormControl-radio-labelWrap"><label class="FormControl-label" for="complete-default-error">Complete</label></div></div></div></fieldset></form>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end
end
