defmodule PrimerLive.TestComponents.CheckboxTest do
  @moduledoc false

  use PrimerLive.TestBase

  @default_form %Phoenix.HTML.Form{
    impl: Phoenix.HTML.FormData.Ecto.Changeset,
    id: "user",
    name: "user",
    params: %{"available_for_hire" => "true"},
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
      <.checkbox />
      """,
      __ENV__
    )
  end

  test "Called with invalid form value" do
    assigns = %{}

    run_test(
      ~H"""
      <.checkbox form="x" />
      """,
      __ENV__
    )
  end

  test "Attribute: form and field (atoms)" do
    assigns = %{}

    run_test(
      ~H"""
      <.checkbox form={:user} field={:available_for_hire} />
      """,
      __ENV__
    )
  end

  test "Attribute: field as string" do
    assigns = %{}

    run_test(
      ~H"""
      <.checkbox field="available_for_hire" />
      """,
      __ENV__
    )
  end

  test "Attribute: input_id" do
    assigns = %{}

    run_test(
      ~H"""
      <.checkbox form={:user} field={:available_for_hire} input_id="xyz" />
      """,
      __ENV__
    )
  end

  test "Attribute: name only" do
    assigns = %{}

    run_test(
      ~H"""
      <.checkbox name="available_for_hire" />
      """,
      __ENV__
    )
  end

  test "Attribute: is_multiple" do
    assigns = %{
      form: @default_form
    }

    run_test(
      ~H"""
      <.checkbox form={:user} field={:available_for_hire} checked_value="coding" is_multiple />
      <.checkbox form={:user} field={:available_for_hire} checked_value="music" is_multiple />
      """,
      __ENV__
    )
  end

  test "Attribute: checked" do
    assigns = %{}

    run_test(
      ~H"""
      <.checkbox name="available_for_hire" checked />
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
      <.checkbox
        class="my-checkbox"
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
        field={:available_for_hire}
      >
        <:label class="my-label">Some label</:label>
        <:hint class="my-hint">Some hint</:hint>
        <:caption class="my-caption">Some caption</:caption>
        <:disclosure class="my-disclosure">Disclosed</:disclosure>
      </.checkbox>
      """,
      __ENV__
    )
  end

  test "Extra attributes: value" do
    assigns = %{}

    run_test(
      ~H"""
      <.checkbox name="role" value="editor" />
      """,
      __ENV__
    )
  end

  test "Extra attributes: checked_value" do
    assigns = %{}

    run_test(
      ~H"""
      <.checkbox name="role" checked_value="editor" />
      <.checkbox name="role" checked_value="editor" value="editor" />
      """,
      __ENV__
    )
  end

  test "Extra attributes: tabindex" do
    assigns = %{}

    run_test(
      ~H"""
      <.checkbox name="available_for_hire" tabindex="1" />
      """,
      __ENV__
    )
  end

  test "Label slot" do
    assigns = %{}

    run_test(
      ~H"""
      <.checkbox name="available_for_hire">
        <:label>Some label</:label>
      </.checkbox>
      """,
      __ENV__
    )
  end

  test "Label slot with attribute is_emphasised_label" do
    assigns = %{}

    run_test(
      ~H"""
      <.checkbox name="available_for_hire" is_emphasised_label>
        <:label>Some label</:label>
      </.checkbox>
      """,
      __ENV__
    )
  end

  test "Disclosure slot" do
    assigns = %{}

    run_test(
      ~H"""
      <.checkbox name="available_for_hire">
        <:label>Some label</:label>
        <:disclosure>
          <span>disclosure content</span>
        </:disclosure>
      </.checkbox>
      """,
      __ENV__
    )
  end

  test "Hint slot (deprecated)" do
    assigns = %{}

    run_test(
      ~H"""
      <.checkbox name="available_for_hire">
        <:label>
          Some label
        </:label>
        <:hint>
          Add your <strong>resume</strong> below
        </:hint>
      </.checkbox>
      """,
      __ENV__
    )
  end

  test "Hint slot without label (not shown) (deprecated)" do
    assigns = %{}

    run_test(
      ~H"""
      <.checkbox name="available_for_hire">
        <:hint>
          Add your <strong>resume</strong> below
        </:hint>
      </.checkbox>
      """,
      __ENV__
    )
  end

  test "Caption slot" do
    assigns = %{}

    run_test(
      ~H"""
      <.checkbox name="available_for_hire">
        <:label>
          Some label
        </:label>
        <:caption>
          Add your <strong>resume</strong> below
        </:caption>
      </.checkbox>
      """,
      __ENV__
    )
  end

  test "Caption slot without label (not shown)" do
    assigns = %{}

    run_test(
      ~H"""
      <.checkbox name="available_for_hire">
        <:caption>
          Add your <strong>resume</strong> below
        </:caption>
      </.checkbox>
      """,
      __ENV__
    )
  end
end
