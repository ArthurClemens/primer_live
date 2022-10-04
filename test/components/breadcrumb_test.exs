defmodule PrimerLive.TestComponents.BreadcrumbTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Slot: item" do
    assigns = []

    assert rendered_to_string(~H"""
           <.breadcrumb>
             <:item href="/1">Item 1</:item>
             <:item href="/2">Item 2</:item>
             <:item href="/3">Last item</:item>
           </.breadcrumb>
           """)
           |> format_html() ==
             """
             <div class="Breadcrumb">
             <ol>
             <li class="breadcrumb-item"><a href="/1">Item 1</a></li>
             <li class="breadcrumb-item"><a href="/2">Item 2</a></li>
             <li class="breadcrumb-item breadcrumb-item-selected"><a href="/3">Last item</a></li>
             </ol>
             </div>
             """
             |> format_html()
  end

  test "Slot: item (single item)" do
    assigns = []

    assert rendered_to_string(~H"""
           <.breadcrumb>
             <:item href="#url">First and last item</:item>
           </.breadcrumb>
           """)
           |> format_html() ==
             """
             <div class="Breadcrumb">
             <ol>
             <li class="breadcrumb-item breadcrumb-item-selected"><a href="#url">First and last item</a></li>
             </ol>
             </div>
             """
             |> format_html()
  end

  test "Slot: item (with links)" do
    assigns = []

    assert rendered_to_string(~H"""
           <.breadcrumb>
             <:item href="/home">Home</:item>
             <:item navigate="/account">Account</:item>
             <:item patch="/account/history">History</:item>
           </.breadcrumb>
           """)
           |> format_html() ==
             """
             <div class="Breadcrumb">
             <ol>
             <li class="breadcrumb-item"><a href="/home">Home</a></li>
             <li class="breadcrumb-item"><a href="/account" data-phx-link="redirect" data-phx-link-state="push">Account</a></li>
             <li class="breadcrumb-item breadcrumb-item-selected"><a href="/account/history" data-phx-link="patch"
             data-phx-link-state="push">History</a></li>
             </ol>
             </div>
             """
             |> format_html()
  end

  test "Classes" do
    assigns = []

    assert rendered_to_string(~H"""
           <.breadcrumb
             class="my-breadcrumb"
             classes={
               %{
                 breadcrumb: "breadcrumb-x",
                 item: "item-x",
                 selected_item: "selected_item-x",
                 link: "link-x"
               }
             }
           >
             <:item href="/1" class="my-link-1">Item 1</:item>
             <:item href="/2" class="my-link-2">Last item</:item>
           </.breadcrumb>
           """)
           |> format_html() ==
             """
             <div class="Breadcrumb breadcrumb-x my-breadcrumb">
             <ol>
             <li class="breadcrumb-item item-x"><a href="/1" class="link-x my-link-1">Item 1</a></li>
             <li class="breadcrumb-item item-x breadcrumb-item-selected selected_item-x"><a href="/2"
             class="link-x my-link-2">Last item</a></li>
             </ol>
             </div>
             """
             |> format_html()
  end
end
