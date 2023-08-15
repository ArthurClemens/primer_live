defmodule PrimerLive.TestComponents.SelectTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  @default_form %Phoenix.HTML.Form{
    impl: Phoenix.HTML.FormData.Atom,
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
             <div class="FormControl-select-wrap">
             <select class="FormControl-select FormControl-medium" id="age" name="age">
             <option value="25">25</option>
             <option value="26">26</option>
             <option value="27">27</option>
             <option value="28">28</option>
             <option value="29">29</option>
             <option value="30">30</option>
             </select>
             </div>
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
             <div class="FormControl-select-wrap">
             <select class="FormControl-select FormControl-medium" id="my-select" name="age">
             <option value="25">25</option>
             <option value="26">26</option>
             <option value="27">27</option>
             <option value="28">28</option>
             <option value="29">29</option>
             <option value="30">30</option>
             </select>
             </div>
             """
             |> format_html()
  end

  test "Attribute: is_monospace" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.select name="age" options={25..27} is_monospace />
           """)
           |> format_html() ==
             """
             <div class="FormControl-select-wrap">
             <select class="FormControl-select FormControl-medium FormControl-monospace" id="age" name="age">
             <option value="25">25</option>
             <option value="26">26</option>
             <option value="27">27</option>
             </select>
             </div>
             """
             |> format_html()
  end

  test "Attribute: is_small" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.select name="age" options={25..27} is_small />
           """)
           |> format_html() ==
             """
             <div class="FormControl-select-wrap">
             <select class="FormControl-select FormControl-small" id="age" name="age">
             <option value="25">25</option>
             <option value="26">26</option>
             <option value="27">27</option>
             </select>
             </div>
             """
             |> format_html()
  end

  test "Attribute: is_large" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.select name="age" options={25..27} is_large />
           """)
           |> format_html() ==
             """
             <div class="FormControl-select-wrap">
             <select class="FormControl-select FormControl-large" id="age" name="age">
             <option value="25">25</option>
             <option value="26">26</option>
             <option value="27">27</option>
             </select>
             </div>
             """
             |> format_html()
  end

  test "Attribute: is_full_width" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.select name="age" options={25..27} is_full_width />
           """)
           |> format_html() ==
             """
             <div class="FormControl-select-wrap FormControl--fullWidth">
             <select class="FormControl-select FormControl-medium" id="age" name="age">
             <option value="25">25</option>
             <option value="26">26</option>
             <option value="27">27</option>
             </select>
             </div>
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
             <div class="FormControl-select-wrap">
             <select class="FormControl-select FormControl-medium" id="age" name="age">
             <option value="25">25</option>
             <option value="26">26</option>
             <option selected value="27">27</option>
             <option value="28">28</option>
             <option value="29">29</option>
             <option value="30">30</option>
             </select>
             </div>
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
             <div class="FormControl-select-wrap pl-neutral">
             <select class="FormControl-select FormControl-medium" id="user_role" name="user[role]">
             <option value="admin">admin</option>
             <option value="editor">editor</option>
             </select>
             </div>
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
             <div class="FormControl-select-wrap pl-neutral">
             <select class="FormControl-select FormControl-medium" id="user_role" name="user[role]">
             <option value="admin">Admin</option>
             <option value="user">User</option>
             </select>
             </div>
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
             <div class="FormControl-select-wrap pl-neutral">
             <select class="FormControl-select FormControl-medium" id="user_role" name="user[role]">
             <option disabled value="admin">Admin</option>
             <option value="user">User</option>
             </select>
             </div>
             """
             |> format_html()
  end

  test "Attribute: input_id" do
    assigns = %{
      form: @default_form
    }

    assert rendered_to_string(~H"""
           <.select form={@form} field={:role} options={[Admin: "admin", User: "user"]} input_id="xyz" />
           """)
           |> format_html() ==
             """
             <div class="FormControl-select-wrap pl-neutral">
             <select class="FormControl-select FormControl-medium" id="xyz" name="user[role]">
             <option value="admin">Admin</option>
             <option value="user">User</option>
             </select>
             </div>
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
             <div class="FormControl-select-wrap pl-neutral">
             <select class="FormControl-select FormControl-medium" id="user_role" name="user[role]">
             <option value="">Choose your role</option>
             <option value="admin">Admin</option>
             <option value="user">User</option>
             </select>
             </div>
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
             <div class="FormControl-select-wrap pl-neutral">
             <select class="FormControl-select FormControl-medium" id="user_role" name="user[role]">
               <option disabled value="">Choose your role</option>
               <option value="admin">Admin</option>
               <option value="user">User</option>
             </select>
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
             <div class="FormControl-select-wrap pl-multiple-select pl-neutral">
             <select class="FormControl-select FormControl-medium" id="user_role" multiple=""
             name="user[role][]" size="7">
             <option value="admin">Admin</option>
             <option value="user">User</option>
             <option value="editor">Editor</option>
             <option value="copywriter">Copywriter</option>
             <option value="tester">Tester</option>
             <option value="project_owner">Project owner</option>
             <option value="developer">Developer</option>
             </select>
             </div>
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
             is_multiple
           />
           """)
           |> format_html() ==
             """
             <div class="FormControl-select-wrap pl-multiple-select pl-invalid" phx-feedback-for="user[role][]"><select
             aria-describedby="user_role-validation" class="FormControl-select FormControl-medium" id="user_role" invalid=""
             multiple="" name="user[role][]">
             <option value="admin">Admin</option>
             <option value="user">User</option>
             </select></div>
             <div class="FormControl-inlineValidation FormControl-inlineValidation--error" id="user_role-validation"
             phx-feedback-for="user[role][]"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="12" height="12"
             viewBox="0 0 12 12">STRIPPED_SVG_PATHS</svg><span>can&#39;t be blank</span></div>
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
                 select_container: "select_container-x",
                 select: "select-x",
                 validation_message: "validation_message-x"
               }
             }
             class="my-select-container"
           />
           """)
           |> format_html() ==
             """
             <div class="FormControl-select-wrap pl-invalid select_container-x my-select-container" phx-feedback-for="user[role]">
             <select aria-describedby="user_role-validation" aria-label="Role"
             class="FormControl-select FormControl-medium select-x" id="user_role" invalid="" name="user[role]">
             <option value="admin">Admin</option>
             <option value="user">User</option>
             <option value="editor">Editor</option>
             <option value="copywriter">Copywriter</option>
             <option value="tester">Tester</option>
             <option value="project_owner">Project owner</option>
             <option value="developer">Developer</option>
             </select></div>
             <div class="FormControl-inlineValidation FormControl-inlineValidation--error validation_message-x"
             id="user_role-validation" phx-feedback-for="user[role]"><svg class="octicon" xmlns="http://www.w3.org/2000/svg"
             width="12" height="12" viewBox="0 0 12 12">STRIPPED_SVG_PATHS</svg><span>can&#39;t be blank</span></div>
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
             <div class="FormControl-select-wrap">
             <select aria-label="Age" class="FormControl-select FormControl-medium" dir="rtl" id="age" name="age">
             <option value="25">25</option>
             <option value="26">26</option>
             <option value="27">27</option>
             <option value="28">28</option>
             <option value="29">29</option>
             <option value="30">30</option>
             </select>
             </div>
             """
             |> format_html()
  end
end
