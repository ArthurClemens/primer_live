defmodule PrimerLive.TestComponents.TextInputTest do
  @moduledoc false

  use PrimerLive.TestBase
  alias PrimerLive.TestHelpers.Repo.Users

  test "Called without options or inner_block: should render the component" do
    assigns = %{}

    run_test(
      ~H"""
      <.text_input />
      """,
      __ENV__
    )
  end

  test "Called with invalid form value" do
    assigns = %{}

    run_test(
      ~H"""
      <.text_input form="x" />
      """,
      __ENV__
    )
  end

  test "Attribute: form and field (atoms)" do
    assigns = %{}

    run_test(
      ~H"""
      <.text_input form={:user} field={:first_name} />
      """,
      __ENV__
    )
  end

  test "Attribute: name, value" do
    assigns = %{}

    run_test(
      ~H"""
      <.text_input name="first_name" value="Greta" />
      """,
      __ENV__
    )
  end

  test "Attribute: field as string" do
    assigns = %{}

    run_test(
      ~H"""
      <.text_input form={:user} field="first_name" />
      """,
      __ENV__
    )
  end

  test "Attribute: name only" do
    assigns = %{}

    run_test(
      ~H"""
      <.text_input name="first_name" />
      """,
      __ENV__
    )
  end

  test "Attribute: size" do
    assigns = %{}

    run_test(
      ~H"""
      <.text_input size="3" />
      <.text_input size={3} />
      """,
      __ENV__
    )
  end

  test "Attribute: types" do
    assigns = %{}

    run_test(
      ~H"""
      <.text_input type={:x} />
      <.text_input type="color" />
      <.text_input type="date" />
      <.text_input type="datetime-local" />
      <.text_input type="email" />
      <.text_input type="file" />
      <.text_input type="hidden" />
      <.text_input type="number" />
      <.text_input type="password" />
      <.text_input type="range" />
      <.text_input type="search" />
      <.text_input type="telephone" />
      <.text_input type="text" />
      <.text_input type="textarea" />
      <.text_input type="time" />
      <.text_input type="url" />
      """,
      __ENV__
    )
  end

  test "Attributes: is_monospace, is_contrast, is_full_width, is_hide_webkit_autofill, is_large, is_small" do
    assigns = %{}

    run_test(
      ~H"""
      <.text_input is_monospace />
      <.text_input is_contrast />
      <.text_input is_full_width />
      <.text_input is_hide_webkit_autofill />
      <.text_input is_large />
      <.text_input is_small />
      """,
      __ENV__
    )
  end

  test "Attribute: caption" do
    assigns = %{}

    run_test(
      ~H"""
      <.text_input caption="Caption" />
      <.text_input
        caption={
          fn ->
            ~H'''
            Caption
            '''
          end
        }
        is_form_control
      />
      <.text_input caption={
        fn field_state ->
          if !field_state.valid?,
            # Hide this text because the error validation message will show similar content
            do: nil
        end
      } />
      """,
      __ENV__
    )
  end

  test "Attribute: is_form_control" do
    assigns = %{}

    run_test(
      ~H"""
      <.text_input form={:user} name="first_name" is_form_control />
      """,
      __ENV__
    )
  end

  test "Attribute: is_form_group (deprecatd)" do
    assigns = %{}

    run_test(
      ~H"""
      <.text_input form={:user} name="first_name" is_form_group />
      """,
      __ENV__
    )
  end

  test "Attribute: is_form_group with input_id" do
    assigns = %{}

    run_test(
      ~H"""
      <.text_input form={:user} name="first_name" is_form_group input_id="xyz" />
      """,
      __ENV__
    )
  end

  test "Attribute: form_control (label)" do
    assigns = %{}

    run_test(
      ~H"""
      <.text_input
        form={:user}
        field="first_name"
        form_control={
          %{
            label: "Some label"
          }
        }
      />
      """,
      __ENV__
    )
  end

  test "Attribute: form_group (label) (deprecated)" do
    assigns = %{}

    run_test(
      ~H"""
      <.text_input
        form={:user}
        field="first_name"
        form_group={
          %{
            label: "Some label"
          }
        }
      />
      """,
      __ENV__
    )
  end

  test "Default validation message" do
    changeset = Users.init()

    validate_changeset = %Ecto.Changeset{
      changeset
      | action: :validate,
        changes: %{first_name: nil}
    }

    assigns = %{
      changeset: validate_changeset,
      field: :first_name
    }

    run_test(
      ~H"""
      <.form :let={f} for={@changeset}>
        <.text_input form={f} field={@field} />
      </.form>
      """,
      __ENV__
    )
  end

  test "Attribute: validation_message (custom error message)" do
    changeset = Users.init()

    validate_changeset = %Ecto.Changeset{
      changeset
      | action: :validate,
        changes: %{first_name: nil}
    }

    assigns = %{
      changeset: validate_changeset,
      field: :first_name
    }

    run_test(
      ~H"""
      <.form :let={f} for={@changeset}>
        <.text_input
          form={f}
          field={@field}
          validation_message={
            fn field_state ->
              if !field_state.valid?, do: "Please enter your first name"
            end
          }
        />
      </.form>
      """,
      __ENV__
    )
  end

  test "Attribute: validation_message (custom success message)" do
    changeset = Users.init()

    validate_changeset = %Ecto.Changeset{
      changeset
      | action: :validate,
        changes: %{first_name: "anna"},
        errors: [],
        valid?: true
    }

    assigns = %{
      changeset: validate_changeset,
      field: :first_name
    }

    run_test(
      ~H"""
      <.form :let={f} for={@changeset}>
        <.text_input
          form={f}
          field={@field}
          validation_message={
            fn field_state ->
              if field_state.valid?, do: "Available!"
            end
          }
        />
      </.form>
      """,
      __ENV__
    )
  end

  test "Extra attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.text_input name="first_name" />
      """,
      __ENV__
    )
  end

  test "Extra attributes: disabled with is_form_control" do
    assigns = %{}

    run_test(
      ~H"""
      <.text_input name="first_name" disabled is_form_control />
      """,
      __ENV__
    )
  end

  test "Extra attributes: placeholder (and implicit aria-label)" do
    assigns = %{}

    run_test(
      ~H"""
      <.text_input name="first_name" placeholder="Enter your first name" />
      """,
      __ENV__
    )
  end

  test "Extra attributes: explicit aria_label" do
    assigns = %{}

    run_test(
      ~H"""
      <.text_input name="first_name" aria_label="Enter your first name" />
      """,
      __ENV__
    )
  end

  test "Extra attributes: tabindex" do
    assigns = %{}

    run_test(
      ~H"""
      <.text_input name="first_name" tabindex="1" />
      """,
      __ENV__
    )
  end

  test "Attribute: class" do
    assigns = %{}

    run_test(
      ~H"""
      <.text_input class="my-input" />
      """,
      __ENV__
    )
  end

  test "Attribute: classes" do
    changeset = Users.init()

    validate_changeset = %Ecto.Changeset{
      changeset
      | action: :validate,
        changes: %{first_name: nil}
    }

    assigns = %{
      changeset: validate_changeset,
      field: :first_name,
      classes: %{
        input: "input-x",
        input_group: "input_group-x",
        input_group_button: "input_group_button-x",
        validation_message: "validation_message-x",
        input_wrap: "input_wrap-x",
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
      class: "my-text-input"
    }

    run_test(
      ~H"""
      <.form :let={f} for={@changeset}>
        <.text_input
          classes={@classes}
          form_control={@form_control_attrs}
          class={@class}
          caption={fn -> "Caption" end}
          form={f}
          field={@field}
        >
          <:group_button>
            <.button>Send</.button>
          </:group_button>
        </.text_input>

        <.text_input classes={@classes} form_control={@form_control_attrs} class={@class}>
          <:leading_visual class="my-leading-visual">
            <.octicon name="mail-16" />
          </:leading_visual>
        </.text_input>

        <.text_input classes={@classes} form_control={@form_control_attrs} class={@class}>
          <:trailing_action>
            <.button is_icon_only aria-label="Clear">
              <.octicon name="x-16" />
            </.button>
          </:trailing_action>
        </.text_input>
      </.form>
      """,
      __ENV__
    )
  end

  test "Attribute: style" do
    assigns = %{}

    run_test(
      ~H"""
      <.text_input style="border: 1px solid red;" />
      """,
      __ENV__
    )
  end

  test "Slot: leading_visual" do
    assigns = %{}

    run_test(
      ~H"""
      <.text_input>
        <:leading_visual>
          <.octicon name="mail-16" />
        </:leading_visual>
      </.text_input>
      """,
      __ENV__
    )
  end

  test "Slot: trailing_action" do
    assigns = %{}

    run_test(
      ~H"""
      <.text_input>
        <:trailing_action>
          <.button is_icon_only aria-label="Clear">
            <.octicon name="x-16" />
          </.button>
        </:trailing_action>
      </.text_input>
      """,
      __ENV__
    )
  end

  test "Slot: trailing_action, attr is_divider" do
    assigns = %{}

    run_test(
      ~H"""
      <.text_input>
        <:trailing_action is_divider>
          <.button is_icon_only aria-label="Clear">
            <.octicon name="x-16" />
          </.button>
        </:trailing_action>
      </.text_input>
      """,
      __ENV__
    )
  end

  test "Slot: trailing_action, attr is_visible_with_value" do
    assigns = %{}

    run_test(
      ~H"""
      <.text_input>
        <:trailing_action is_visible_with_value>
          <.button is_icon_only aria-label="Clear">
            <.octicon name="x-16" />
          </.button>
        </:trailing_action>
      </.text_input>
      """,
      __ENV__
    )
  end

  test "Slot: group_button" do
    assigns = %{}

    run_test(
      ~H"""
      <.text_input>
        <:group_button>
          <.button>Send</.button>
        </:group_button>
      </.text_input>
      <.text_input>
        <:group_button>
          <.button aria-label="Copy">
            <.octicon name="paste-16" />
          </.button>
        </:group_button>
      </.text_input>
      """,
      __ENV__
    )
  end

  test "Slot: leading_visual, trailing_action" do
    assigns = %{}

    run_test(
      ~H"""
      <.text_input>
        <:leading_visual>
          <.octicon name="person-16" />
        </:leading_visual>
      </.text_input>
      <.text_input>
        <:trailing_action>
          <.button is_close_button aria-label="Clear">
            <.octicon name="x-16" />
          </.button>
        </:trailing_action>
      </.text_input>
      """,
      __ENV__
    )
  end
end
