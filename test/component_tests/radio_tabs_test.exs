defmodule PrimerLive.TestComponents.RadioTabsTest do
  @moduledoc false

  use PrimerLive.TestBase

  test "With radio buttons" do
    assigns = %{}

    run_test(
      ~H"""
      <.radio_tabs>
        <:radio_button name="role" value="admin"></:radio_button>
        <:radio_button name="role" value="editor"></:radio_button>
      </.radio_tabs>
      """,
      __ENV__
    )
  end

  test "Attribute: id" do
    assigns = %{}

    run_test(
      ~H"""
      <.radio_tabs>
        <:radio_button name="role" value="admin" id="admin-id"></:radio_button>
        <:radio_button name="role" value="editor" id="editor-id"></:radio_button>
      </.radio_tabs>
      """,
      __ENV__
    )
  end

  test "Called with invalid form value" do
    assigns = %{}

    run_test(
      ~H"""
      <.radio_tabs form="x" />
      """,
      __ENV__
    )
  end

  test "With radio_buttons in inner slot" do
    assigns = %{}

    run_test(
      ~H"""
      <.radio_tabs>
        <:radio_button name="role" value="admin">Some label A</:radio_button>
        <:radio_button name="role" value="editor">Some label B</:radio_button>
      </.radio_tabs>
      """,
      __ENV__
    )
  end

  test "With radio_button label" do
    assigns = %{
      options: [
        {"Admin", "admin"},
        {"Editor", "editor"}
      ]
    }

    run_test(
      ~H"""
      <.radio_tabs>
        <:radio_button
          :for={{label, value} <- @options}
          name="role"
          value={value}
          label={label |> String.upcase()}
        >
        </:radio_button>
      </.radio_tabs>
      """,
      __ENV__
    )
  end

  test "Attribute: form and field (atoms)" do
    assigns = %{}

    run_test(
      ~H"""
      <.radio_tabs form={:user} field={:role}>
        <:radio_button value="admin"></:radio_button>
        <:radio_button value="editor"></:radio_button>
      </.radio_tabs>
      """,
      __ENV__
    )
  end

  test "Attribute: field as string" do
    assigns = %{}

    run_test(
      ~H"""
      <.radio_tabs form={:user} field="role">
        <:radio_button value="admin"></:radio_button>
        <:radio_button value="editor"></:radio_button>
      </.radio_tabs>
      """,
      __ENV__
    )
  end

  test "Attribute: id_prefix" do
    assigns = %{}

    run_test(
      ~H"""
      <.radio_tabs form={:user} field={:role} id_prefix="custom">
        <:radio_button value="admin"></:radio_button>
        <:radio_button value="editor"></:radio_button>
      </.radio_tabs>
      """,
      __ENV__
    )
  end

  test "Classes" do
    assigns = %{}

    run_test(
      ~H"""
      <.radio_tabs
        classes={
          %{
            radio_group: "radio-group-x",
            label: "label-x",
            radio_input: "radio-input-x"
          }
        }
        class="my-radio-group"
      >
        <:radio_button class="my-radio-button-a" name="role" value="admin">Some label A</:radio_button>
        <:radio_button class="my-radio-button-b" name="role" value="editor">Some label B</:radio_button>
      </.radio_tabs>
      """,
      __ENV__
    )
  end

  test "Extra attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.radio_tabs dir="rtl">
        <:radio_button name="role" value="admin"></:radio_button>
        <:radio_button name="role" value="editor"></:radio_button>
      </.radio_tabs>
      """,
      __ENV__
    )
  end
end
