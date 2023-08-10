defmodule PrimerLive.TestComponents.ProgressTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Default settings" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.progress>
             <:item></:item>
           </.progress>
           """)
           |> format_html() ==
             """
             <span class="Progress"><span class="Progress-item color-bg-success-emphasis" style="width:0%;"></span></span>
             """
             |> format_html()
  end

  test "Attribute: width" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.progress>
             <:item width="50"></:item>
           </.progress>
           <.progress>
             <:item width={50}></:item>
           </.progress>
           """)
           |> format_html() ==
             """
             <span class="Progress"><span class="Progress-item color-bg-success-emphasis" style="width:50%;"></span></span>
             <span class="Progress"><span class="Progress-item color-bg-success-emphasis" style="width:50%;"></span></span>
             """
             |> format_html()
  end

  test "Attribute: aria_label" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.progress aria_label="5 tasks completed">
             <:item width="50"></:item>
           </.progress>
           """)
           |> format_html() ==
             """
             <span aria-label="5 tasks completed" class="Progress"><span class="Progress-item color-bg-success-emphasis"
             style="width:50%;"></span></span>
             """
             |> format_html()
  end

  test "Attribute: state" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <div>
             <.progress>
               <:item width="50"></:item>
             </.progress>
           </div>
           <div>
             <.progress>
               <:item width="50" state="success"></:item>
             </.progress>
           </div>
           <div>
             <.progress>
               <:item width="50" state="info"></:item>
             </.progress>
           </div>
           <div>
             <.progress>
               <:item width="50" state="warning"></:item>
             </.progress>
           </div>
           <div>
             <.progress>
               <:item width="50" state="error"></:item>
             </.progress>
           </div>
           """)
           |> format_html() ==
             """
             <div><span class="Progress"><span class="Progress-item color-bg-success-emphasis" style="width:50%;"></span></span></div>
             <div><span class="Progress"><span class="Progress-item color-bg-success-emphasis" style="width:50%;"></span></span></div>
             <div><span class="Progress"><span class="Progress-item color-bg-accent-emphasis" style="width:50%;"></span></span></div>
             <div><span class="Progress"><span class="Progress-item color-bg-attention-emphasis" style="width:50%;"></span></span></div>
             <div><span class="Progress"><span class="Progress-item color-bg-danger-emphasis" style="width:50%;"></span></span></div>
             """
             |> format_html()
  end

  test "Multiple bars" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.progress>
             <:item width="50" state="success"></:item>
             <:item width="30" state="warning"></:item>
             <:item width="10" state="error"></:item>
             <:item width="5" state="info"></:item>
           </.progress>
           """)
           |> format_html() ==
             """
             <span class="Progress">
              <span class="Progress-item color-bg-success-emphasis" style="width:50%;"></span>
              <span class="Progress-item color-bg-attention-emphasis" style="width:30%;"></span>
              <span class="Progress-item color-bg-danger-emphasis" style="width:10%;"></span>
              <span class="Progress-item color-bg-accent-emphasis" style="width:5%;"></span>
             </span>
             """
             |> format_html()
  end

  test "Attribute: is_large, is_small, is_inline" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <div class="my-3">
             <.progress is_large>
               <:item width="50"></:item>
             </.progress>
           </div>
           <div class="my-3">
             <.progress is_small>
               <:item width="50"></:item>
             </.progress>
           </div>
           <div class="my-3">
             <.progress is_inline style="width: 160px;">
               <:item width="50"></:item>
             </.progress>
           </div>
           """)
           |> format_html() ==
             """
             <div class="my-3"><span class="Progress Progress--large"><span class="Progress-item color-bg-success-emphasis"
             style="width:50%;"></span></span></div>
             <div class="my-3"><span class="Progress Progress--small"><span class="Progress-item color-bg-success-emphasis"
             style="width:50%;"></span></span></div>
             <div class="my-3"><span class="Progress d-inline-flex" style="width: 160px;"><span
             class="Progress-item color-bg-success-emphasis" style="width:50%;"></span></span></div>
             """
             |> format_html()
  end

  test "Extra attribute: style" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.progress>
             <:item width="50" style="height: 10px"></:item>
           </.progress>
           """)
           |> format_html() ==
             """
             <span class="Progress"><span class="Progress-item color-bg-success-emphasis" style="height: 10px; width:50%;"></span></span>
             """
             |> format_html()
  end

  test "Classes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.progress
             classes={
               %{
                 progress: "progress-x",
                 item: "item-x",
                 state_success: "success-x",
                 state_info: "info-x",
                 state_warning: "warning-x",
                 state_error: "error-x"
               }
             }
             class="my-progress"
           >
             <:item class="my-item"></:item>
             <:item width="40" state="success"></:item>
             <:item width="30" state="warning"></:item>
             <:item width="10" state="error"></:item>
             <:item width="5" state="info"></:item>
           </.progress>
           """)
           |> format_html() ==
             """
             <span class="Progress progress-x my-progress">
             <span class="Progress-item color-bg-success-emphasis success-x item-x my-item" style="width:0%;"></span>
             <span class="Progress-item color-bg-success-emphasis success-x item-x" style="width:40%;"></span>
             <span class="Progress-item color-bg-attention-emphasis warning-x item-x" style="width:30%;"></span>
             <span class="Progress-item color-bg-danger-emphasis error-x item-x" style="width:10%;"></span>
             <span class="Progress-item color-bg-accent-emphasis info-x item-x" style="width:5%;"></span>
             </span>
             """
             |> format_html()
  end
end
