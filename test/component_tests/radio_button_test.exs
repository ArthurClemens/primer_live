defmodule PrimerLive.TestComponents.RadioButtonTest do
  @moduledoc false

  use PrimerLive.TestBase

  @default_form %Phoenix.HTML.Form{
    impl: Phoenix.HTML.FormData.Ecto.Changeset,
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

  test "Called without options or inner_block: should render the component" do
    assigns = %{}

    run_test(
      ~H"""
      <.radio_button />
      """,
      __ENV__
    )
  end

  test "Called with invalid form value" do
    assigns = %{}

    run_test(
      ~H"""
      <.radio_button form="x" />
      """,
      __ENV__
    )
  end

  test "Extra attributes: value" do
    assigns = %{}

    run_test(
      ~H"""
      <.radio_button name="role" value="admin" />
      <.radio_button name="role" value="editor" />
      """,
      __ENV__
    )
  end

  test "Attribute: form, field and value" do
    assigns = %{}

    run_test(
      ~H"""
      <.radio_button form={:user} field={:role} value="admin" />
      <.radio_button form={:user} field={:role} value="editor" />
      """,
      __ENV__
    )
  end

  test "Attribute: field as string" do
    assigns = %{}

    run_test(
      ~H"""
      <.radio_button form={:user} field="role" value="admin" />
      <.radio_button form={:user} field="role" value="editor" />
      """,
      __ENV__
    )
  end

  test "Attribute: name only" do
    assigns = %{}

    run_test(
      ~H"""
      <.radio_button name="role" value="admin" />
      <.radio_button name="role" value="editor" />
      """,
      __ENV__
    )
  end

  test "Attribute: checked" do
    assigns = %{}

    run_test(
      ~H"""
      <.radio_button name="role" value="admin" />
      <.radio_button name="role" value="editor" checked />
      """,
      __ENV__
    )
  end

  test "Attribute: classes" do
    assigns = %{
      form: @default_form
    }

    run_test(
      ~H"""
      <.radio_button
        class="my-radio-button"
        classes={
          %{
            container: "container-x",
            label_container: "label_container-x",
            label: "label-x",
            input: "input-x",
            caption: "caption-x",
            hint: "hint-x",
            disclosure: "disclosure-x"
          }
        }
        form={@form}
        field={:role}
      >
        <:label class="my-label">Some label</:label>
        <:hint class="my-hint">Some hint</:hint>
        <:caption class="my-caption">Some caption</:caption>
        <:disclosure class="my-disclosure">Disclosed</:disclosure>
      </.radio_button>
      """,
      __ENV__
    )
  end

  test "Extra attributes: tabindex" do
    assigns = %{}

    run_test(
      ~H"""
      <.radio_button name="role" tabindex="1" />
      """,
      __ENV__
    )
  end

  test "Label slot" do
    assigns = %{}

    run_test(
      ~H"""
      <.radio_button name="role">
        <:label>Some label</:label>
      </.radio_button>
      """,
      __ENV__
    )
  end

  test "Label slot with attribute is_emphasised_label" do
    assigns = %{}

    run_test(
      ~H"""
      <.radio_button name="role" is_emphasised_label>
        <:label>Some label</:label>
      </.radio_button>
      """,
      __ENV__
    )
  end

  test "Disclosure slot" do
    assigns = %{}

    run_test(
      ~H"""
      <.radio_button name="role">
        <:label>Some label</:label>
        <:disclosure>
          <span>disclosure content</span>
        </:disclosure>
      </.radio_button>
      """,
      __ENV__
    )
  end

  test "Hint slot (deprecated)" do
    assigns = %{}

    run_test(
      ~H"""
      <.radio_button name="role">
        <:label>
          Some label
        </:label>
        <:hint>
          Add your <strong>resume</strong> below
        </:hint>
      </.radio_button>
      """,
      __ENV__
    )
  end

  test "Caption slot" do
    assigns = %{}

    run_test(
      ~H"""
      <.radio_button name="role">
        <:label>
          Some label
        </:label>
        <:caption>
          Add your <strong>resume</strong> below
        </:caption>
      </.radio_button>
      """,
      __ENV__
    )
  end

  test "Hint slot without label (not shown)" do
    assigns = %{}

    run_test(
      ~H"""
      <.radio_button name="role">
        <:hint>
          Add your <strong>resume</strong> below
        </:hint>
      </.radio_button>
      """,
      __ENV__
    )
  end
end
