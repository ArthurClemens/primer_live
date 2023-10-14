defmodule PrimerLive.Components.ToggleSwitchTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

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

    assert rendered_to_string(~H"""
           <.toggle_switch />
           <.toggle_switch checked />
           <.toggle_switch disabled />
           <.toggle_switch checked disabled />
           """)
           |> format_html() ==
             """
             <label class="ToggleSwitch"><input type="hidden" value="false" /><input type="checkbox" value="true" /><span
             class="ToggleSwitch-track"><span class="ToggleSwitch-icons"><span class="ToggleSwitch-lineIcon"><svg
             viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false" width="16"
             height="16">STRIPPED_SVG_PATHS</svg></span><span class="ToggleSwitch-circleIcon"><svg viewBox="0 0 16 16"
             xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false" width="16"
             height="16">STRIPPED_SVG_PATHS</svg></span></span><span class="ToggleSwitch-knob"></span></span></label><label
             class="ToggleSwitch"><input type="hidden" value="false" /><input checked type="checkbox" value="true" /><span
             class="ToggleSwitch-track"><span class="ToggleSwitch-icons"><span class="ToggleSwitch-lineIcon"><svg
             viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false" width="16"
             height="16">STRIPPED_SVG_PATHS</svg></span><span class="ToggleSwitch-circleIcon"><svg viewBox="0 0 16 16"
             xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false" width="16"
             height="16">STRIPPED_SVG_PATHS</svg></span></span><span class="ToggleSwitch-knob"></span></span></label><label
             class="ToggleSwitch" disabled><input disabled="" type="hidden" value="false" /><input disabled="" type="checkbox"
             value="true" /><span class="ToggleSwitch-track"><span class="ToggleSwitch-icons"><span
             class="ToggleSwitch-lineIcon"><svg viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"
             focusable="false" width="16" height="16">STRIPPED_SVG_PATHS</svg></span><span
             class="ToggleSwitch-circleIcon"><svg viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"
             focusable="false" width="16" height="16">STRIPPED_SVG_PATHS</svg></span></span><span
             class="ToggleSwitch-knob"></span></span></label><label class="ToggleSwitch" disabled><input disabled=""
             type="hidden" value="false" /><input checked disabled="" type="checkbox" value="true" /><span
             class="ToggleSwitch-track"><span class="ToggleSwitch-icons"><span class="ToggleSwitch-lineIcon"><svg
             viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false" width="16"
             height="16">STRIPPED_SVG_PATHS</svg></span><span class="ToggleSwitch-circleIcon"><svg viewBox="0 0 16 16"
             xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false" width="16"
             height="16">STRIPPED_SVG_PATHS</svg></span></span><span class="ToggleSwitch-knob"></span></span></label>
             """
             |> format_html()
  end

  test "Attribute: status_on_label, status_off_label" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.toggle_switch status_on_label="On" status_off_label="Off" />
           """)
           |> format_html() ==
             """
             <label class="ToggleSwitch"><input type="hidden" value="false" /><input type="checkbox" value="true" /><span
             class="pl-ToggleSwitch__status-label-container"><span
             class="ToggleSwitch-status ToggleSwitch-statusOn">On</span><span
             class="ToggleSwitch-status ToggleSwitch-statusOff">Off</span></span><span class="ToggleSwitch-track"><span
             class="ToggleSwitch-icons"><span class="ToggleSwitch-lineIcon"><svg viewBox="0 0 16 16"
             xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false" width="16"
             height="16">STRIPPED_SVG_PATHS</svg></span><span class="ToggleSwitch-circleIcon"><svg viewBox="0 0 16 16"
             xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false" width="16"
             height="16">STRIPPED_SVG_PATHS</svg></span></span><span class="ToggleSwitch-knob"></span></span></label>
             """
             |> format_html()
  end

  test "Attribute: is_label_position_end" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.toggle_switch status_on_label="On" status_off_label="Off" is_label_position_end />
           """)
           |> format_html() ==
             """
             <label class="ToggleSwitch ToggleSwitch--statusAtEnd"><input type="hidden" value="false" /><input type="checkbox"
             value="true" /><span class="pl-ToggleSwitch__status-label-container"><span
             class="ToggleSwitch-status ToggleSwitch-statusOn">On</span><span
             class="ToggleSwitch-status ToggleSwitch-statusOff">Off</span></span><span class="ToggleSwitch-track"><span
             class="ToggleSwitch-icons"><span class="ToggleSwitch-lineIcon"><svg viewBox="0 0 16 16"
             xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false" width="16"
             height="16">STRIPPED_SVG_PATHS</svg></span><span class="ToggleSwitch-circleIcon"><svg viewBox="0 0 16 16"
             xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false" width="16"
             height="16">STRIPPED_SVG_PATHS</svg></span></span><span class="ToggleSwitch-knob"></span></span></label>
             """
             |> format_html()
  end

  test "Attribute: is_small" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.toggle_switch status_on_label="On" status_off_label="Off" is_small />
           """)
           |> format_html() ==
             """
             <label class="ToggleSwitch ToggleSwitch--small"><input type="hidden" value="false" /><input type="checkbox"
             value="true" /><span class="pl-ToggleSwitch__status-label-container"><span
             class="ToggleSwitch-status ToggleSwitch-statusOn">On</span><span
             class="ToggleSwitch-status ToggleSwitch-statusOff">Off</span></span><span class="ToggleSwitch-track"><span
             class="ToggleSwitch-icons"><span class="ToggleSwitch-lineIcon"><svg viewBox="0 0 16 16"
             xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false" width="16"
             height="16">STRIPPED_SVG_PATHS</svg></span><span class="ToggleSwitch-circleIcon"><svg viewBox="0 0 16 16"
             xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false" width="16"
             height="16">STRIPPED_SVG_PATHS</svg></span></span><span class="ToggleSwitch-knob"></span></span></label>
             """
             |> format_html()
  end

  test "Attribute: is_loading" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.toggle_switch status_on_label="On" status_off_label="Off" is_loading />
           """)
           |> format_html() ==
             """
             <label class="ToggleSwitch pl-ToggleSwitch--loading"><input type="hidden" value="false" /><input type="checkbox" value="true" /><svg
             viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false" fill="none"
             class="anim-rotate" height="16" width="16">
             <circle cx="8" cy="8" r="7" stroke="currentColor" stroke-opacity="0.25" stroke-width="2"
             vector-effect="non-scaling-stroke"></circle>STRIPPED_SVG_PATHS
             </svg><span class="pl-ToggleSwitch__status-label-container"><span
             class="ToggleSwitch-status ToggleSwitch-statusOn">On</span><span
             class="ToggleSwitch-status ToggleSwitch-statusOff">Off</span></span><span class="ToggleSwitch-track"><span
             class="ToggleSwitch-icons"><span class="ToggleSwitch-lineIcon"><svg viewBox="0 0 16 16"
             xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false" width="16"
             height="16">STRIPPED_SVG_PATHS</svg></span><span class="ToggleSwitch-circleIcon"><svg viewBox="0 0 16 16"
             xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false" width="16"
             height="16">STRIPPED_SVG_PATHS</svg></span></span><span class="ToggleSwitch-knob"></span></span></label>
             """
             |> format_html()
  end

  test "Attribute: is_derived_label" do
    assigns = %{
      form: @default_form
    }

    assert rendered_to_string(~H"""
           <.toggle_switch form={@form} field={:available_for_hire} is_derived_label />
           """)
           |> format_html() ==
             """
             <label class="ToggleSwitch"><input name="user[available_for_hire]" type="hidden" value="false" /><input checked
             id="user_available_for_hire" name="user[available_for_hire]" type="checkbox" value="true" /><span
             class="pl-ToggleSwitch__status-label-container"><span class="ToggleSwitch-status ToggleSwitch-statusOn">Available
             for hire</span><span class="ToggleSwitch-status ToggleSwitch-statusOff">Available for hire</span></span><span
             class="ToggleSwitch-track"><span class="ToggleSwitch-icons"><span class="ToggleSwitch-lineIcon"><svg
             viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false" width="16"
             height="16">STRIPPED_SVG_PATHS</svg></span><span class="ToggleSwitch-circleIcon"><svg viewBox="0 0 16 16"
             xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false" width="16"
             height="16">STRIPPED_SVG_PATHS</svg></span></span><span class="ToggleSwitch-knob"></span></span></label>
             """
             |> format_html()
  end

  test "Extra attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.toggle_switch dir="rtl" />
           """)
           |> format_html() ==
             """
             <label class="ToggleSwitch" dir="rtl"><input type="hidden" value="false" /><input dir="rtl" type="checkbox"
             value="true" /><span class="ToggleSwitch-track"><span class="ToggleSwitch-icons"><span
             class="ToggleSwitch-lineIcon"><svg viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"
             focusable="false" width="16" height="16">STRIPPED_SVG_PATHS</svg></span><span
             class="ToggleSwitch-circleIcon"><svg viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"
             focusable="false" width="16" height="16">STRIPPED_SVG_PATHS</svg></span></span><span
             class="ToggleSwitch-knob"></span></span></label>
             """
             |> format_html()
  end

  test "Classes" do
    assigns = %{}

    assert rendered_to_string(~H"""
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
           """)
           |> format_html() ==
             """
             <label class="ToggleSwitch pl-ToggleSwitch--loading container-x my-toggle-switch"><input type="hidden"
             value="false" /><input type="checkbox" value="true" /><svg viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg"
             aria-hidden="true" focusable="false" fill="none" class="anim-rotate loading_icon-x" height="16"
             width="16">STRIPPED_SVG_PATHS</svg><span
             class="pl-ToggleSwitch__status-label-container status_labels_container-x"><span
             class="ToggleSwitch-status ToggleSwitch-statusOn status_label-x status_on_label-x">On</span><span
             class="ToggleSwitch-status ToggleSwitch-statusOff status_label-x status_off_label-x">Off</span></span><span
             class="ToggleSwitch-track track-x"><span class="ToggleSwitch-icons icons_container-x"><span
             class="ToggleSwitch-lineIcon line_icon-x"><svg viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg"
             aria-hidden="true" focusable="false" width="16" height="16">STRIPPED_SVG_PATHS</svg></span><span
             class="ToggleSwitch-circleIcon circle_icon-x"><svg viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg"
             aria-hidden="true" focusable="false" width="16" height="16">STRIPPED_SVG_PATHS</svg></span></span><span
             class="ToggleSwitch-knob toggle_knob-x"></span></span></label>
             """
             |> format_html()
  end
end
