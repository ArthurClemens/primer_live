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
             <form>
             <div class="FormControl pl-FormControl--input-group">
             <div class="pl-FormControl--input-group__container"><span class="FormControl-radio-wrap"><input
             class="FormControl-radio" id="role_admin" name="role" type="radio" value="admin" /><span
             class="FormControl-radio-labelWrap"><label class="FormControl-label"
             for="role_admin">Admin</label></span></span><span class="FormControl-radio-wrap"><input
             class="FormControl-radio" id="role_editor" name="role" type="radio" value="editor" /><span
             class="FormControl-radio-labelWrap"><label class="FormControl-label"
             for="role_editor">Editor</label></span></span></div>
             </div>
             </form>
             """
             |> format_html()
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
             <form>
             <div class="FormControl pl-FormControl-disabled pl-FormControl--input-group">
             <div class="pl-FormControl--input-group__container"><span class="FormControl-radio-wrap"><input
             class="FormControl-radio" id="role_admin" name="role" type="radio" value="admin" /><span
             class="FormControl-radio-labelWrap"><label class="FormControl-label"
             for="role_admin">Admin</label></span></span><span class="FormControl-radio-wrap"><input
             class="FormControl-radio" id="role_editor" name="role" type="radio" value="editor" /><span
             class="FormControl-radio-labelWrap"><label class="FormControl-label"
             for="role_editor">Editor</label></span></span></div>
             </div>
             </form>
             """
             |> format_html()
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
             <form>
             <div class="FormControl pl-FormControl--input-group">
             <div class="form-group-header"><label class="FormControl-label">Role</label></div>
             <div class="FormControl-caption">Select one</div>
             <div class="pl-FormControl--input-group__container"><span class="FormControl-radio-wrap"><input
             class="FormControl-radio" id="role-caption_admin" name="role-caption" type="radio" value="admin" /><span
             class="FormControl-radio-labelWrap"><label class="FormControl-label"
             for="role-caption_admin">Admin</label></span></span><span class="FormControl-radio-wrap"><input
             class="FormControl-radio" id="role-caption_editor" name="role-caption" type="radio" value="editor" /><span
             class="FormControl-radio-labelWrap"><label class="FormControl-label"
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
             <form method="post">
             <div class="FormControl pl-FormControl--input-group pl-invalid">
             <div class="form-group-header"><label class="FormControl-label">Statuses</label>
             </div>
             <div class="pl-FormControl--input-group__container"><span class="FormControl-radio-wrap pl-invalid"><input
             class="FormControl-radio" id="in-progress-derived-label" name="todo[statuses]" type="radio"
             value="in-progress" /><span class="FormControl-radio-labelWrap"><label class="FormControl-label"
             for="in-progress-derived-label">In-progress</label></span></span><span
             class="FormControl-radio-wrap pl-invalid"><input class="FormControl-radio" id="needs-review-derived-label"
             name="todo[statuses]" type="radio" value="needs-review" /><span class="FormControl-radio-labelWrap"><label
             class="FormControl-label" for="needs-review-derived-label">Needs-review</label></span></span><span
             class="FormControl-radio-wrap pl-invalid"><input class="FormControl-radio" id="complete-derived-label"
             name="todo[statuses]" type="radio" value="complete" /><span class="FormControl-radio-labelWrap"><label
             class="FormControl-label" for="complete-derived-label">Complete</label></span></span></div>
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
             <form method="post">
             <div class="FormControl pl-FormControl--input-group pl-invalid">
             <div class="form-group-header"><label class="FormControl-label">Statuses</label>
             </div>
             <div class="pl-FormControl--input-group__container"><span class="FormControl-radio-wrap pl-invalid"><input
             class="FormControl-radio" id="in-progress-custom-label" name="todo[statuses]" type="radio"
             value="in-progress" /><span class="FormControl-radio-labelWrap"><label class="FormControl-label"
             for="in-progress-custom-label">in progress</label></span></span><span
             class="FormControl-radio-wrap pl-invalid"><input class="FormControl-radio" id="needs-review-custom-label"
             name="todo[statuses]" type="radio" value="needs-review" /><span class="FormControl-radio-labelWrap"><label
             class="FormControl-label" for="needs-review-custom-label">needs review</label></span></span><span
             class="FormControl-radio-wrap pl-invalid"><input class="FormControl-radio" id="complete-custom-label"
             name="todo[statuses]" type="radio" value="complete" /><span class="FormControl-radio-labelWrap"><label
             class="FormControl-label" for="complete-custom-label">complete</label></span></span></div>
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
      impl: Phoenix.HTML.FormData.Atom,
      id: "user",
      name: "user",
      params: %{"statuses" => ""},
      source: %Ecto.Changeset{
        action: :validate,
        changes: %{},
        errors: [
          statuses: {"can't be blank", [validation: :required]}
        ],
        data: nil,
        valid?: false
      }
    }

    assigns = %{
      options: options,
      values: values,
      field: :statuses,
      form: form
    }

    assert rendered_to_string(~H"""
           <.radio_group form={@form} field={@field} caption="Select one">
             <%= for {label, value} <- @options do %>
               <.radio_button form={@form} field={@field} value={value} id={value <> "-default-error"}>
                 <:label>
                   <%= label %>
                 </:label>
               </.radio_button>
             <% end %>
           </.radio_group>
           """)
           |> format_html() ==
             """
             <div class="FormControl pl-FormControl--input-group pl-invalid">
             <div class="form-group-header"><label class="FormControl-label">Statuses</label><span aria-hidden="true">*</span>
             </div>
             <div class="FormControl-caption">Select one</div>
             <div class="pl-FormControl--input-group__container"><span class="FormControl-radio-wrap pl-invalid"
             phx-feedback-for="user[statuses]"><input class="FormControl-radio" id="in-progress-default-error" invalid=""
             name="user[statuses]" type="radio" value="in-progress" /><span class="FormControl-radio-labelWrap"><label
             class="FormControl-label" for="in-progress-default-error">In progress</label></span></span><span
             class="FormControl-radio-wrap pl-invalid" phx-feedback-for="user[statuses]"><input class="FormControl-radio"
             id="needs-review-default-error" invalid="" name="user[statuses]" type="radio" value="needs-review" /><span
             class="FormControl-radio-labelWrap"><label class="FormControl-label" for="needs-review-default-error">Needs
             review</label></span></span><span class="FormControl-radio-wrap pl-invalid"
             phx-feedback-for="user[statuses]"><input class="FormControl-radio" id="complete-default-error" invalid=""
             name="user[statuses]" type="radio" value="complete" /><span class="FormControl-radio-labelWrap"><label
             class="FormControl-label" for="complete-default-error">Complete</label></span></span>
             <div class="FormControl-inlineValidation FormControl-inlineValidation--error" id="user_statuses-validation"
             phx-feedback-for="user[statuses]"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="12" height="12"
             viewBox="0 0 12 12">STRIPPED_SVG_PATHS</svg><span>can&#39;t be blank</span></div>
             </div>
             </div>
             """
             |> format_html()
  end
end
