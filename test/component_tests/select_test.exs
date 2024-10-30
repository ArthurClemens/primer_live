defmodule PrimerLive.TestComponents.SelectTest do
  @moduledoc false

  use PrimerLive.TestBase
  alias PrimerLive.TestHelpers.Repo.Todos

  test "Simple select" do
    assigns = %{}

    run_test(
      ~H"""
      <.select name="age" options={25..30} />
      """,
      __ENV__
    )
  end

  test "Attribute: id" do
    assigns = %{}

    run_test(
      ~H"""
      <.select name="age" options={25..30} id="my-select" />
      """,
      __ENV__
    )
  end

  test "Attribute: is_monospace" do
    assigns = %{}

    run_test(
      ~H"""
      <.select name="age" options={25..27} is_monospace />
      """,
      __ENV__
    )
  end

  test "Attribute: is_small" do
    assigns = %{}

    run_test(
      ~H"""
      <.select name="age" options={25..27} is_small />
      """,
      __ENV__
    )
  end

  test "Attribute: is_large" do
    assigns = %{}

    run_test(
      ~H"""
      <.select name="age" options={25..27} is_large />
      """,
      __ENV__
    )
  end

  test "Attribute: is_full_width" do
    assigns = %{}

    run_test(
      ~H"""
      <.select name="age" options={25..27} is_full_width />
      """,
      __ENV__
    )
  end

  test "Attribute: selected" do
    assigns = %{}

    run_test(
      ~H"""
      <.select name="age" options={25..30} selected="27" />
      """,
      __ENV__
    )
  end

  test "With form data: options as list" do
    changeset = Todos.init()

    assigns = %{
      changeset: changeset,
      field: :statuses
    }

    run_test(
      ~H"""
      <.form :let={f} for={@changeset}>
        <.select form={f} field={@field} options={["admin", "editor"]} />
      </.form>
      """,
      __ENV__
    )
  end

  test "With form data: options as keyword list" do
    changeset = Todos.init()

    assigns = %{
      changeset: changeset,
      field: :statuses
    }

    run_test(
      ~H"""
      <.form :let={f} for={@changeset}>
        <.select form={f} field={@field} options={[Admin: "admin", User: "user"]} />
      </.form>
      """,
      __ENV__
    )
  end

  test "With form data: options as nested keyword list" do
    changeset = Todos.init()

    assigns = %{
      changeset: changeset,
      field: :statuses
    }

    run_test(
      ~H"""
      <.form :let={f} for={@changeset}>
        <.select
          form={f}
          field={@field}
          options={[[key: "Admin", value: "admin", disabled: true], [key: "User", value: "user"]]}
        />
      </.form>
      """,
      __ENV__
    )
  end

  test "Attribute: input_id" do
    changeset = Todos.init()

    assigns = %{
      changeset: changeset,
      field: :statuses
    }

    run_test(
      ~H"""
      <.form :let={f} for={@changeset}>
        <.select form={f} field={@field} options={[Admin: "admin", User: "user"]} input_id="xyz" />
      </.form>
      """,
      __ENV__
    )
  end

  test "Attribute: prompt" do
    changeset = Todos.init()

    assigns = %{
      changeset: changeset,
      field: :statuses
    }

    run_test(
      ~H"""
      <.form :let={f} for={@changeset}>
        <.select
          form={f}
          field={@field}
          options={[Admin: "admin", User: "user"]}
          prompt="Choose your role"
        />
      </.form>
      """,
      __ENV__
    )
  end

  test "Attribute: prompt (disabled)" do
    changeset = Todos.init()

    assigns = %{
      changeset: changeset,
      field: :statuses
    }

    run_test(
      ~H"""
      <.form :let={f} for={@changeset}>
        <.select
          form={f}
          field={@field}
          options={[Admin: "admin", User: "user"]}
          prompt={[key: "Choose your role", disabled: true]}
        />
      </.form>
      """,
      __ENV__
    )
  end

  test "Attribute: caption" do
    assigns = %{}

    run_test(
      ~H"""
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
      """,
      __ENV__
    )
  end

  test "Attribute: is_multiple" do
    changeset = Todos.init()

    assigns = %{
      changeset: changeset,
      field: :statuses
    }

    run_test(
      ~H"""
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
      """,
      __ENV__
    )
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

    run_test(
      ~H"""
      <.form :let={f} for={@changeset}>
        <.select
          form={f}
          field={@field}
          options={[Admin: "admin", User: "user"]}
          prompt={[key: "Choose your role", disabled: true]}
          is_multiple
        />
      </.form>
      """,
      __ENV__
    )
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

    run_test(
      ~H"""
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
          aria-label="Role"
          classes={@classes}
          form_control={@form_control_attrs}
          class={@class}
          caption={fn -> "Caption" end}
        />
      </.form>
      """,
      __ENV__
    )
  end

  test "Other attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.select name="age" options={25..30} aria-label="Age" dir="rtl" />
      """,
      __ENV__
    )
  end
end
