defmodule PrimerLive.TestComponents.SelectTest do
  use ExUnit.Case
  use PrimerLive

  import PrimerLive.Helpers.TestHelpers
  import Phoenix.Component
  import Phoenix.LiveViewTest

  alias PrimerLive.TestHelpers.Repo.Todos

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
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
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
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
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
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
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
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
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
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
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
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
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
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "With form data: options as list" do
    changeset = Todos.init()

    assigns = %{
      changeset: changeset,
      field: :statuses
    }

    assert rendered_to_string(~H"""
           <.form :let={f} for={@changeset}>
             <.select form={f} field={@field} options={["admin", "editor"]} />
           </.form>
           """)
           |> format_html() ==
             """
             <form method="post"><div class="FormControl-select-wrap pl-invalid"><select class="FormControl-select FormControl-medium" id="todo-statuses" name="todo[statuses]"><option value="admin">admin</option><option value="editor">editor</option></select></div></form>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "With form data: options as keyword list" do
    changeset = Todos.init()

    assigns = %{
      changeset: changeset,
      field: :statuses
    }

    assert rendered_to_string(~H"""
           <.form :let={f} for={@changeset}>
             <.select form={f} field={@field} options={[Admin: "admin", User: "user"]} />
           </.form>
           """)
           |> format_html() ==
             """
             <form method="post"><div class="FormControl-select-wrap pl-invalid"><select class="FormControl-select FormControl-medium" id="todo-statuses" name="todo[statuses]"><option value="admin">Admin</option><option value="user">User</option></select></div></form>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "With form data: options as nested keyword list" do
    changeset = Todos.init()

    assigns = %{
      changeset: changeset,
      field: :statuses
    }

    assert rendered_to_string(~H"""
           <.form :let={f} for={@changeset}>
             <.select
               form={f}
               field={@field}
               options={[[key: "Admin", value: "admin", disabled: true], [key: "User", value: "user"]]}
             />
           </.form>
           """)
           |> format_html() ==
             """
             <form method="post"><div class="FormControl-select-wrap pl-invalid"><select class="FormControl-select FormControl-medium" id="todo-statuses" name="todo[statuses]"><option disabled value="admin">Admin</option><option value="user">User</option></select></div></form>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Attribute: input_id" do
    changeset = Todos.init()

    assigns = %{
      changeset: changeset,
      field: :statuses
    }

    assert rendered_to_string(~H"""
           <.form :let={f} for={@changeset}>
             <.select form={f} field={@field} options={[Admin: "admin", User: "user"]} input_id="xyz" />
           </.form>
           """)
           |> format_html() ==
             """
             <form method="post">
             <div class="FormControl-select-wrap pl-invalid">
             <select class="FormControl-select FormControl-medium" id="xyz" name="todo[statuses]">
             <option value="admin">Admin</option>
             <option value="user">User</option>
             </select>
             </div>
             </form>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Attribute: prompt" do
    changeset = Todos.init()

    assigns = %{
      changeset: changeset,
      field: :statuses
    }

    assert rendered_to_string(~H"""
           <.form :let={f} for={@changeset}>
             <.select
               form={f}
               field={@field}
               options={[Admin: "admin", User: "user"]}
               prompt="Choose your role"
             />
           </.form>
           """)
           |> format_html() ==
             """
             <form method="post"><div class="FormControl-select-wrap pl-invalid"><select class="FormControl-select FormControl-medium" id="todo-statuses" name="todo[statuses]"><option value="">Choose your role</option><option value="admin">Admin</option><option value="user">User</option></select></div></form>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Attribute: prompt (disabled)" do
    changeset = Todos.init()

    assigns = %{
      changeset: changeset,
      field: :statuses
    }

    assert rendered_to_string(~H"""
           <.form :let={f} for={@changeset}>
             <.select
               form={f}
               field={@field}
               options={[Admin: "admin", User: "user"]}
               prompt={[key: "Choose your role", disabled: true]}
             />
           </.form>
           """)
           |> format_html() ==
             """
             <form method="post"><div class="FormControl-select-wrap pl-invalid"><select class="FormControl-select FormControl-medium" id="todo-statuses" name="todo[statuses]"><option disabled value="">Choose your role</option><option value="admin">Admin</option><option value="user">User</option></select></div></form>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Attribute: caption" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.select
             name="count"
             options={["One", "Two", "Three"]}
             caption={
               fn ->
                 "Caption"
               end
             }
           />
           <.select
             name="count"
             options={["One", "Two", "Three"]}
             caption={fn -> "Caption" end}
             is_form_control
           />
           <.select
             name="count"
             options={["One", "Two", "Three"]}
             caption={
               fn field_state ->
                 if !field_state.valid?,
                   # Hide this text because the error validation message will show similar content
                   do: nil
               end
             }
           />
           """)
           |> format_html() ==
             """
             <div class="FormControl-select-wrap"><select class="FormControl-select FormControl-medium" id="count" name="count">
             <option value="One">One</option>
             <option value="Two">Two</option>
             <option value="Three">Three</option>
             </select></div>
             <div class="FormControl-caption">Caption</div>
             <div class="FormControl">
             <div class="form-group-header"><label class="FormControl-label" for="count">Count</label></div>
             <div class="FormControl-select-wrap"><select class="FormControl-select FormControl-medium" id="count" name="count">
             <option value="One">One</option>
             <option value="Two">Two</option>
             <option value="Three">Three</option>
             </select></div>
             <div class="FormControl-caption">Caption</div>
             </div>
             <div class="FormControl-select-wrap"><select class="FormControl-select FormControl-medium" id="count" name="count">
             <option value="One">One</option>
             <option value="Two">Two</option>
             <option value="Three">Three</option>
             </select></div>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Attribute: is_multiple" do
    changeset = Todos.init()

    assigns = %{
      changeset: changeset,
      field: :statuses
    }

    assert rendered_to_string(~H"""
           <.form :let={f} for={@changeset}>
             <.select
               form={f}
               field={@field}
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
           </.form>
           """)
           |> format_html() ==
             """
             <form method="post"><div class="FormControl-select-wrap pl-multiple-select pl-invalid"><select class="FormControl-select FormControl-medium" id="todo-statuses" multiple="" name="todo[statuses][]" size="7"><option value="admin">Admin</option><option selected value="user">User</option><option value="editor">Editor</option><option value="copywriter">Copywriter</option><option selected value="tester">Tester</option><option value="project_owner">Project owner</option><option value="developer">Developer</option></select></div></form>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Default validation" do
    changeset = Todos.init()

    validate_changeset = %Ecto.Changeset{
      changeset
      | action: :validate,
        changes: %{statuses: nil}
    }

    assigns = %{
      changeset: validate_changeset,
      field: :statuses
    }

    assert rendered_to_string(~H"""
           <.form :let={f} for={@changeset}>
             <.select
               form={f}
               field={@field}
               options={[Admin: "admin", User: "user"]}
               prompt={[key: "Choose your role", disabled: true]}
               is_multiple
             />
           </.form>
           """)
           |> format_html() ==
             """
             <form method="post"><div class="FormControl-select-wrap pl-multiple-select pl-invalid" phx-feedback-for="todo[statuses][]"><select aria-describedby="todo-statuses-validation" class="FormControl-select FormControl-medium" id="todo-statuses" invalid="" multiple="" name="todo[statuses][]"><option value="admin">Admin</option><option value="user">User</option></select></div><div class="FormControl-inlineValidation FormControl-inlineValidation--error" id="todo-statuses-validation" phx-feedback-for="todo[statuses][]"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 12 12">STRIPPED_SVG_PATHS</svg><span>must select a status</span></div></form>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Classes" do
    changeset = Todos.init()

    assigns = %{
      changeset: changeset,
      field: :statuses,
      classes: %{
        select_container: "select_container-x",
        select: "select-x",
        validation_message: "validation_message-x",
        caption: "caption-x"
      },
      form_control_attrs: %{
        classes: %{
          control: "control-x",
          group: "group-x",
          header: "header-x",
          label: "label-x"
        }
      },
      class: "my-select-container"
    }

    assert rendered_to_string(~H"""
           <.form :let={f} for={@changeset}>
             <.select
               form={f}
               field={@field}
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
               classes={@classes}
               form_control={@form_control_attrs}
               class={@class}
               caption={fn -> "Caption" end}
             />
           </.form>
           """)
           |> format_html() ==
             """
             <form method="post"><div class="FormControl group-x control-x pl-invalid"><div class="form-group-header header-x"><label class="FormControl-label label-x" for="todo-statuses">Statuses</label><span aria-hidden="true">*</span></div><div class="FormControl-select-wrap pl-invalid select_container-x my-select-container"><select aria-label="Role" class="FormControl-select FormControl-medium select-x" id="todo-statuses" name="todo[statuses]"><option value="admin">Admin</option><option value="user">User</option><option value="editor">Editor</option><option value="copywriter">Copywriter</option><option value="tester">Tester</option><option value="project_owner">Project owner</option><option value="developer">Developer</option></select></div><div class="FormControl-caption caption-x">Caption</div></div></form>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
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
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end
end
