defmodule PrimerLive.Components.ToggleSwitchTest do
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

  test "Basic" do
    assigns = %{}

    run_test(
      ~H"""
      <div><.toggle_switch /></div>
      <div><.toggle_switch checked /></div>
      <div><.toggle_switch disabled /></div>
      <div><.toggle_switch checked disabled /></div>
      """,
      __ENV__
    )
  end

  test "Attribute: status_on_label, status_off_label" do
    assigns = %{}

    run_test(
      ~H"""
      <.toggle_switch status_on_label="On" status_off_label="Off" />
      """,
      __ENV__
    )
  end

  test "Attribute: is_label_position_end" do
    assigns = %{}

    run_test(
      ~H"""
      <.toggle_switch status_on_label="On" status_off_label="Off" is_label_position_end />
      """,
      __ENV__
    )
  end

  test "Attribute: is_small" do
    assigns = %{}

    run_test(
      ~H"""
      <.toggle_switch status_on_label="On" status_off_label="Off" is_small />
      """,
      __ENV__
    )
  end

  test "Attribute: is_loading" do
    assigns = %{}

    run_test(
      ~H"""
      <.toggle_switch status_on_label="On" status_off_label="Off" is_loading />
      """,
      __ENV__
    )
  end

  test "Attribute: is_derived_label" do
    assigns = %{
      form: @default_form
    }

    run_test(
      ~H"""
      <.toggle_switch form={@form} field={:available_for_hire} is_derived_label />
      """,
      __ENV__
    )
  end

  test "Extra attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.toggle_switch dir="rtl" />
      """,
      __ENV__
    )
  end

  test "Classes" do
    assigns = %{}

    run_test(
      ~H"""
      <.toggle_switch
        status_on_label="On"
        status_off_label="Off"
        is_loading
        classes={
          %{
            container: "container-x",
            status_icon: "status_icon-x",
            status_labels_container: "status_labels_container-x",
            status_label: "status_label-x",
            status_on_label: "status_on_label-x",
            status_off_label: "status_off_label-x",
            track: "track-x",
            icons_container: "icons_container-x",
            circle_icon: "circle_icon-x",
            line_icon: "line_icon-x",
            loading_icon: "loading_icon-x",
            toggle_knob: "toggle_knob-x"
          }
        }
        class="my-toggle-switch"
      />
      """,
      __ENV__
    )
  end
end
