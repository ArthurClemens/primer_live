defmodule PrimerLive.TestComponents.TimelineItemTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Called without options: should render the component" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.timeline_item />
           """)
           |> format_html() ==
             """
             <div class="TimelineItem"></div>
             """
             |> format_html()
  end

  test "Slot: badge" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.timeline_item>
             <:badge>
               <.octicon name="flame-16" />
             </:badge>
             Everything is fine
           </.timeline_item>
           """)
           |> format_html() ==
             """
             <div class="TimelineItem">
             <div class="TimelineItem-badge">
             <svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M7.998 14.5c2.832 0 5-1.98 5-4.5 0-1.463-.68-2.19-1.879-3.383l-.036-.037c-1.013-1.008-2.3-2.29-2.834-4.434-.322.256-.63.579-.864.953-.432.696-.621 1.58-.046 2.73.473.947.67 2.284-.278 3.232-.61.61-1.545.84-2.403.633a2.788 2.788 0 01-1.436-.874A3.21 3.21 0 003 10c0 2.53 2.164 4.5 4.998 4.5zM9.533.753C9.496.34 9.16.009 8.77.146 7.035.75 4.34 3.187 5.997 6.5c.344.689.285 1.218.003 1.5-.419.419-1.54.487-2.04-.832-.173-.454-.659-.762-1.035-.454C2.036 7.44 1.5 8.702 1.5 10c0 3.512 2.998 6 6.498 6s6.5-2.5 6.5-6c0-2.137-1.128-3.26-2.312-4.438-1.19-1.184-2.436-2.425-2.653-4.81z"></path></svg>
             </div>
             <div class="TimelineItem-body">Everything is fine</div>
             </div>
             """
             |> format_html()
  end

  test "Slot: badge (links)" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.timeline_item>
             <:badge href="#url">href</:badge>
             href link
           </.timeline_item>
           <.timeline_item>
             <:badge navigate="#url">navigate</:badge>
             navigate link
           </.timeline_item>
           <.timeline_item>
             <:badge patch="#url">patch</:badge>
             patch link
           </.timeline_item>
           """)
           |> format_html() ==
             """
             <div class="TimelineItem"><a href="#url" class="TimelineItem-badge">href</a>
             <div class="TimelineItem-body">href link</div>
             </div>
             <div class="TimelineItem"><a href="#url" data-phx-link="redirect" data-phx-link-state="push" class="TimelineItem-badge">navigate</a>
             <div class="TimelineItem-body">navigate link</div>
             </div>
             <div class="TimelineItem"><a href="#url" data-phx-link="patch" data-phx-link-state="push" class="TimelineItem-badge">patch</a>
             <div class="TimelineItem-body">patch link</div>
             </div>
             """
             |> format_html()
  end

  test "Slot: avatar" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.timeline_item>
             <:badge>
               <.octicon name="git-commit-16" />
             </:badge>
             <:avatar>
               <.avatar size="6" src="user.jpg" />
             </:avatar>
             Someone's commit
           </.timeline_item>
           """)
           |> format_html() ==
             """
             <div class="TimelineItem">
             <div class="TimelineItem-avatar"><img class="avatar avatar-6" src="user.jpg" /></div>
             <div class="TimelineItem-badge">
             <svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M10.5 7.75a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0zm1.43.75a4.002 4.002 0 01-7.86 0H.75a.75.75 0 110-1.5h3.32a4.001 4.001 0 017.86 0h3.32a.75.75 0 110 1.5h-3.32z"></path></svg>
             </div>
             <div class="TimelineItem-body">Someone's commit</div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: state" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.timeline_item>
             <:badge>icon</:badge>
             Message
           </.timeline_item>
           <.timeline_item state="default">
             <:badge>icon</:badge>
             Message
           </.timeline_item>
           <.timeline_item state="info">
             <:badge>icon</:badge>
             Message
           </.timeline_item>
           <.timeline_item state="success">
             <:badge>icon</:badge>
             Message
           </.timeline_item>
           <.timeline_item state="warning">
             <:badge>icon</:badge>
             Message
           </.timeline_item>
           <.timeline_item state="error">
             <:badge>icon</:badge>
             Message
           </.timeline_item>
           """)
           |> format_html() ==
             """
             <div class="TimelineItem">
             <div class="TimelineItem-badge">icon</div>
             <div class="TimelineItem-body">Message</div>
             </div>
             <div class="TimelineItem">
             <div class="TimelineItem-badge">icon</div>
             <div class="TimelineItem-body">Message</div>
             </div>
             <div class="TimelineItem">
             <div class="TimelineItem-badge color-bg-accent-emphasis color-fg-on-emphasis">icon</div>
             <div class="TimelineItem-body">Message</div>
             </div>
             <div class="TimelineItem">
             <div class="TimelineItem-badge color-bg-success-emphasis color-fg-on-emphasis">icon</div>
             <div class="TimelineItem-body">Message</div>
             </div>
             <div class="TimelineItem">
             <div class="TimelineItem-badge color-bg-attention-emphasis color-fg-on-emphasis">icon</div>
             <div class="TimelineItem-body">Message</div>
             </div>
             <div class="TimelineItem">
             <div class="TimelineItem-badge color-bg-danger-emphasis color-fg-on-emphasis">icon</div>
             <div class="TimelineItem-body">Message</div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: is_condensed" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.timeline_item is_condensed>
             <:badge>icon</:badge>
             Message
           </.timeline_item>
           """)
           |> format_html() ==
             """
             <div class="TimelineItem TimelineItem--condensed">
             <div class="TimelineItem-badge">icon</div>
             <div class="TimelineItem-body">Message</div>
             </div>
             """
             |> format_html()
  end

  test "Attribute: is_break" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.timeline_item state="error">
             <:badge>icon</:badge>
             Everything will be fine
           </.timeline_item>
           <.timeline_item is_break>Ignored content</.timeline_item>
           <.timeline_item state="success">
             <:badge>icon</:badge>
             Everything is fine
           </.timeline_item>
           """)
           |> format_html() ==
             """
             <div class="TimelineItem">
             <div class="TimelineItem-badge color-bg-danger-emphasis color-fg-on-emphasis">icon</div>
             <div class="TimelineItem-body">Everything will be fine</div>
             </div>
             <div class="TimelineItem-break"></div>
             <div class="TimelineItem">
             <div class="TimelineItem-badge color-bg-success-emphasis color-fg-on-emphasis">icon</div>
             <div class="TimelineItem-body">Everything is fine</div>
             </div>
             """
             |> format_html()
  end

  test "Classes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.timeline_item
             classes={
               %{
                 timeline_item: "timeline_item-x",
                 badge: "badge-x",
                 avatar: "avatar-x",
                 body: "body-x",
                 state_default: "state_default-x",
                 state_info: "state_info-x",
                 state_success: "state_success-x",
                 state_warning: "state_warning-x",
                 state_error: "state_error-x"
               }
             }
             class="my-timeline-item"
           >
             <:badge class="my-badge">icon</:badge>
             <:avatar class="my-avatar">
               <.avatar size="6" src="user.jpg" />
             </:avatar>
             <a href="#" class="text-bold Link--primary mr-1">Monalisa</a>
             created one <a href="#" class="text-bold Link--primary">hot potato</a>
             <a href="#" class="Link--secondary">Just now</a>
           </.timeline_item>
           """)
           |> format_html() ==
             """
             <div class="TimelineItem timeline_item-x my-timeline-item">
             <div class="TimelineItem-avatar avatar-x my-avatar"><img class="avatar avatar-6" src="user.jpg" /></div>
             <div class="TimelineItem-badge state_default-x badge-x my-badge">icon</div>
             <div class="TimelineItem-body body-x"><a href="#" class="text-bold Link--primary mr-1">Monalisa</a>created one<a href="#" class="text-bold Link--primary">hot potato</a><a href="#" class="Link--secondary">Just now</a></div>
             </div>
             """
             |> format_html()
  end

  test "Extra attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.timeline_item dir="rtl">
             <:badge aria_label="Badge">icon</:badge>
             <:avatar aria_label="Avatar">avatar</:avatar>
           </.timeline_item>
           """)
           |> format_html() ==
             """
             <div dir="rtl" class="TimelineItem">
             <div aria-label="Avatar" class="TimelineItem-avatar">avatar</div>
             <div aria-label="Badge" class="TimelineItem-badge">icon</div>
             <div class="TimelineItem-body"></div>
             </div>
             """
             |> format_html()
  end
end
