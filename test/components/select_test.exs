defmodule PrimerLive.TestComponents.SelectTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  @default_form %Phoenix.HTML.Form{
    id: "user",
    name: "user",
    params: %{"role" => ""},
    source: %Ecto.Changeset{
      action: :validate,
      changes: %{},
      errors: [],
      data: nil,
      valid?: true
    }
  }

  @error_changeset %Ecto.Changeset{
    action: :validate,
    changes: %{},
    errors: [
      role: {"can't be blank", [validation: :required]}
    ],
    data: nil,
    valid?: false
  }

  test "Simple select" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.select name="age" options={25..30} />
           """)
           |> format_html() ==
             """
             <select class="form-select" id="_age" name="age" phx-feedback-for="_age">
             <option value="25">25</option>
             <option value="26">26</option>
             <option value="27">27</option>
             <option value="28">28</option>
             <option value="29">29</option>
             <option value="30">30</option>
             </select>
             """
             |> format_html()
  end

  test "Attribute: id" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.select name="age" options={25..30} id="my-select" />
           """)
           |> format_html() ==
             """
             <select class="form-select" id="my-select" name="age" phx-feedback-for="my-select">
             <option value="25">25</option>
             <option value="26">26</option>
             <option value="27">27</option>
             <option value="28">28</option>
             <option value="29">29</option>
             <option value="30">30</option>
             </select>
             """
             |> format_html()
  end

  test "Attribute: is_small" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.select name="age" options={25..30} is_small />
           """)
           |> format_html() ==
             """
             <select class="form-select select-sm" id="_age" name="age" phx-feedback-for="_age">
             <option value="25">25</option>
             <option value="26">26</option>
             <option value="27">27</option>
             <option value="28">28</option>
             <option value="29">29</option>
             <option value="30">30</option>
             </select>
             """
             |> format_html()
  end

  test "Attribute: selected" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.select name="age" options={25..30} selected="27" />
           """)
           |> format_html() ==
             """
             <select class="form-select" id="_age" name="age" phx-feedback-for="_age">
             <option value="25">25</option>
             <option value="26">26</option>
             <option selected value="27">27</option>
             <option value="28">28</option>
             <option value="29">29</option>
             <option value="30">30</option>
             </select>
             """
             |> format_html()
  end

  test "With form data: options as list" do
    assigns = %{
      form: @default_form
    }

    assert rendered_to_string(~H"""
           <.select form={@form} field={:role} options={["admin", "editor"]} />
           """)
           |> format_html() ==
             """
             <select class="form-select" id="user_role" name="user[role]" phx-feedback-for="user_role">
             <option value="admin">admin</option>
             <option value="editor">editor</option>
             </select>
             """
             |> format_html()
  end

  test "With form data: options as keyword list" do
    assigns = %{
      form: @default_form
    }

    assert rendered_to_string(~H"""
           <.select form={@form} field={:role} options={[Admin: "admin", User: "user"]} />
           """)
           |> format_html() ==
             """
             <select class="form-select" id="user_role" name="user[role]" phx-feedback-for="user_role">
             <option value="admin">Admin</option>
             <option value="user">User</option>
             </select>
             """
             |> format_html()
  end

  test "With form data: options as nested keyword list" do
    assigns = %{
      form: @default_form
    }

    assert rendered_to_string(~H"""
           <.select
             form={@form}
             field={:role}
             options={[[key: "Admin", value: "admin", disabled: true], [key: "User", value: "user"]]}
           />
           """)
           |> format_html() ==
             """
             <select class="form-select" id="user_role" name="user[role]" phx-feedback-for="user_role">
             <option disabled value="admin">Admin</option>
             <option value="user">User</option>
             </select>
             """
             |> format_html()
  end

  test "Attribute: prompt" do
    assigns = %{
      form: @default_form
    }

    assert rendered_to_string(~H"""
           <.select
             form={@form}
             field={:role}
             options={[Admin: "admin", User: "user"]}
             prompt="Choose your role"
           />
           """)
           |> format_html() ==
             """
             <select class="form-select" id="user_role" name="user[role]" phx-feedback-for="user_role">
             <option value="">Choose your role</option>
             <option value="admin">Admin</option>
             <option value="user">User</option>
             </select>
             """
             |> format_html()
  end

  test "Attribute: prompt (disabled)" do
    assigns = %{
      form: @default_form
    }

    assert rendered_to_string(~H"""
           <.select
             form={@form}
             field={:role}
             options={[Admin: "admin", User: "user"]}
             prompt={[key: "Choose your role", disabled: true]}
           />
           """)
           |> format_html() ==
             """
             <select class="form-select" id="user_role" name="user[role]" phx-feedback-for="user_role">
             <option disabled value="">Choose your role</option>
             <option value="admin">Admin</option>
             <option value="user">User</option>
             </select>
             """
             |> format_html()
  end

  test "Default validation" do
    assigns = %{
      form: %{@default_form | source: @error_changeset}
    }

    assert rendered_to_string(~H"""
           <.select
             form={@form}
             field={:role}
             options={[Admin: "admin", User: "user"]}
             prompt={[key: "Choose your role", disabled: true]}
           />
           """)
           |> format_html() ==
             """
             <select aria-describedby="user_role-validation" class="form-select" id="user_role" invalid="" name="user[role]" phx-feedback-for="user_role">
             <option disabled value="">Choose your role</option>
             <option value="admin">Admin</option>
             <option value="user">User</option>
             </select>
             <div class="FormControl-inlineValidation FormControl-inlineValidation--error" id="user_role-validation" phx-feedback-for="user_role">
             <svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 12 12"><path fill-rule="evenodd" d="M4.855.708c.5-.896 1.79-.896 2.29 0l4.675 8.351a1.312 1.312 0 01-1.146 1.954H1.33A1.312 1.312 0 01.183 9.058L4.855.708zM7 7V3H5v4h2zm-1 3a1 1 0 100-2 1 1 0 000 2z"></path></svg>
             <span>can&#39;t be blank</span>
             </div>
             """
             |> format_html()
  end

  test "Attribute: is_multiple" do
    assigns = %{
      form: @default_form
    }

    assert rendered_to_string(~H"""
           <.select
             form={@form}
             field={:role}
             options={[
               Admin: "admin",
               User: "user",
               Editor: "editor",
               Copywriter: "copywriter",
               Tester: "tester",
               "Project owner": "project_owner",
               Developer: "developer"
             ]}
             is_multiple
             is_auto_height
             selected={["user", "tester"]}
           />
           """)
           |> format_html() ==
             """
             <select class="form-select" id="user_role" multiple="" name="user[role][]" phx-feedback-for="user_role" size="7">
             <option value="admin">Admin</option>
             <option value="user">User</option>
             <option value="editor">Editor</option>
             <option value="copywriter">Copywriter</option>
             <option value="tester">Tester</option>
             <option value="project_owner">Project owner</option>
             <option value="developer">Developer</option>
             </select>
             """
             |> format_html()
  end

  test "Classes" do
    assigns = %{
      form: %{@default_form | source: @error_changeset}
    }

    assert rendered_to_string(~H"""
           <.select
             form={@form}
             field={:role}
             options={[
               Admin: "admin",
               User: "user",
               Editor: "editor",
               Copywriter: "copywriter",
               Tester: "tester",
               "Project owner": "project_owner",
               Developer: "developer"
             ]}
             aria_label="Role"
             classes={
               %{
                 select: "select-x",
                 validation_message: "validation_message-x"
               }
             }
             class="my-select"
           />
           """)
           |> format_html() ==
             """
             <select aria-describedby="user_role-validation" aria-label="Role" class="form-select select-x my-select" id="user_role" invalid="" name="user[role]" phx-feedback-for="user_role">
             <option value="admin">Admin</option>
             <option value="user">User</option>
             <option value="editor">Editor</option>
             <option value="copywriter">Copywriter</option>
             <option value="tester">Tester</option>
             <option value="project_owner">Project owner</option>
             <option value="developer">Developer</option>
             </select>
             <div class="FormControl-inlineValidation FormControl-inlineValidation--error validation_message-x" id="user_role-validation" phx-feedback-for="user_role">
             <svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 12 12"><path fill-rule="evenodd" d="M4.855.708c.5-.896 1.79-.896 2.29 0l4.675 8.351a1.312 1.312 0 01-1.146 1.954H1.33A1.312 1.312 0 01.183 9.058L4.855.708zM7 7V3H5v4h2zm-1 3a1 1 0 100-2 1 1 0 000 2z"></path></svg>
             <span>can&#39;t be blank</span>
             </div>
             """
             |> format_html()
  end

  test "Other attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.select name="age" options={25..30} aria_label="Age" dir="rtl" />
           """)
           |> format_html() ==
             """
             <select aria-label="Age" class="form-select" dir="rtl" id="_age" name="age" phx-feedback-for="_age">
             <option value="25">25</option>
             <option value="26">26</option>
             <option value="27">27</option>
             <option value="28">28</option>
             <option value="29">29</option>
             <option value="30">30</option>
             </select>
             """
             |> format_html()
  end
end
