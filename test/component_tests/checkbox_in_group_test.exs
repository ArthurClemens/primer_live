defmodule PrimerLive.TestComponents.CheckboxInGroupTest do
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

  test "Attribute: field as string: should render with is_multiple" do
    assigns = %{}

    run_test(
      ~H"""
      <.checkbox_in_group field="available_for_hire" />
      """,
      __ENV__
    )
  end

  test "Form atom and field as string: should render with is_multiple" do
    assigns = %{}

    run_test(
      ~H"""
      <.checkbox_in_group form={:user} field="available_for_hire" />
      """,
      __ENV__
    )
  end

  test "Phoenix form: should render with is_multiple" do
    assigns = %{
      form: @default_form
    }

    run_test(
      ~H"""
      <.checkbox_in_group form={:user} field={:available_for_hire} checked_value="coding" />
      <.checkbox_in_group form={:user} field={:available_for_hire} checked_value="music" />
      """,
      __ENV__
    )
  end
end
