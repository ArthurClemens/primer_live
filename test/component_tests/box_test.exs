defmodule PrimerLive.TestComponents.BoxTest do
  @moduledoc false

  use PrimerLive.TestBase

  test "Without attributes or slots" do
    assigns = %{}

    run_test(
      ~H"""
      <.box>
        Content
      </.box>
      """,
      __ENV__
    )
  end

  test "Row slots" do
    assigns = %{}

    run_test(
      ~H"""
      <.box>
        <:row>Row 1</:row>
        <:row>Row 2</:row>
        <:row>Row 3</:row>
      </.box>
      """,
      __ENV__
    )
  end

  test "Slots header, body, row, footer - should be placed in this order" do
    assigns = %{}

    run_test(
      ~H"""
      <.box>
        <:header>
          Header
        </:header>
        <:body>
          Body
        </:body>
        <:row>Row</:row>
        <:footer>
          Footer
        </:footer>
      </.box>
      """,
      __ENV__
    )
  end

  test "Classes" do
    assigns = %{}

    run_test(
      ~H"""
      <.box
        class="box-x"
        classes={
          %{
            box: "box-x",
            header: "header-x",
            row: "row-x",
            body: "body-x",
            footer: "footer-x",
            header_title: "header_title-x",
            link: "link-x"
          }
        }
      >
        <:header class="my-header">
          Header
        </:header>
        <:header_title class="my-header-title">
          Title
        </:header_title>
        <:body class="my-body">
          Body
        </:body>
        <:row class="my-row">Row</:row>
        <:footer class="my-footer">
          Footer
        </:footer>
      </.box>
      """,
      __ENV__
    )
  end

  test "Body slot with alert" do
    assigns = %{show_alert: true}

    run_test(
      ~H"""
      <.box>
        <.alert :if={@show_alert}>Alert message</.alert>
        <:body>
          Body
        </:body>
      </.box>
      """,
      __ENV__
    )
  end

  test "Header title without header slot" do
    assigns = %{}

    run_test(
      ~H"""
      <.box>
        <:header_title>
          Title
        </:header_title>
        Content
      </.box>
      """,
      __ENV__
    )
  end

  test "Header title with header slot" do
    assigns = %{}

    run_test(
      ~H"""
      <.box>
        <:header>Header</:header>
        <:header_title>
          Title
        </:header_title>
        Content
      </.box>
      """,
      __ENV__
    )
  end

  test "Header title with icon button" do
    assigns = %{}

    run_test(
      ~H"""
      <.box>
        <:header class="d-flex flex-justify-between flex-items-start">
          <.button is_close_button aria-label="Close" class="flex-shrink-0 pl-4">
            <.octicon name="x-16" />
          </.button>
        </:header>
        <:header_title>
          A very long title that wraps onto multiple lines without overlapping or wrapping underneath the icon to it's right
        </:header_title>
        <:body>Content</:body>
      </.box>
      """,
      __ENV__
    )
  end

  test "Render result rows" do
    assigns = %{results: ["A", "B", "C"]}

    run_test(
      ~H"""
      <.box>
        <:row :for={result <- @results}>
          {result}
        </:row>
      </.box>
      """,
      __ENV__
    )
  end

  test "Box modifiers" do
    assigns = %{}

    run_test(
      ~H"""
      <.box is_blue>Content</.box>
      <.box is_danger>Content</.box>
      <.box is_border_dashed>Content</.box>
      <.box is_condensed>Content</.box>
      <.box is_spacious>Content</.box>
      """,
      __ENV__
    )
  end

  test "Row modifiers" do
    assigns = %{}

    run_test(
      ~H"""
      <.box>
        <:row is_blue>Content</:row>
        <:row is_gray>Content</:row>
        <:row is_yellow>Content</:row>
        <:row is_hover_blue>Content</:row>
        <:row is_hover_gray>Content</:row>
        <:row is_focus_blue>Content</:row>
        <:row is_focus_gray>Content</:row>
      </.box>
      """,
      __ENV__
    )
  end

  test "Rows as links" do
    assigns = %{}

    run_test(
      ~H"""
      <.box>
        <:row href="#url">
          href link
        </:row>
        <:row navigate="#url">
          navigate link
        </:row>
        <:row patch="#url">
          patch link
        </:row>
      </.box>
      """,
      __ENV__
    )
  end

  test "Attribute: is_scrollable" do
    assigns = %{}

    run_test(
      ~H"""
      <.box is_scrollable style="max-height: 400px">
        <:header>Header</:header>
        <p>General info</p>
        <:body>Body</:body>
        <:row>Row 1</:row>
        <:row>Row 2</:row>
        <:row>Row 3</:row>
        <:row>Row 4</:row>
        <:row>Row 5</:row>
        <:footer>Footer</:footer>
      </.box>
      """,
      __ENV__
    )
  end

  test "Extra attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.box dir="rtl">Content</.box>
      """,
      __ENV__
    )
  end

  test "Attribute: style" do
    assigns = %{}

    run_test(
      ~H"""
      <.box style="border: 1px solid red;">
        Content
      </.box>
      """,
      __ENV__
    )
  end

  test "Stream" do
    assigns = %{
      streams: %{
        __changed__: MapSet.new([:clients]),
        clients: %Phoenix.LiveView.LiveStream{
          name: :clients,
          dom_id: fn {id, _item} -> id end,
          ref: "0",
          inserts: [
            {"clients-1", -1, %{id: "1", first_name: "Ruth", last_name: "Saddlemore"}, nil},
            {"clients-2", -1, %{id: "2", first_name: "John", last_name: "Bishop"}, nil},
            {"clients-3", -1, %{id: "3", first_name: "Laura", last_name: "Manach"}, nil},
            {"clients-4", -1, %{id: "4", first_name: "Julian", last_name: "Newton"}, nil},
            {"clients-5", -1, %{id: "5", first_name: "Melissa", last_name: "Noakes"}, nil},
            {"clients-6", -1, %{id: "6", first_name: "Quincy", last_name: "Pritchard"}, nil},
            {"clients-7", -1, %{id: "7", first_name: "Melinda", last_name: "Crocket"}, nil},
            {"clients-8", -1, %{id: "8", first_name: "Derek", last_name: "Samuel"}, nil}
          ],
          deletes: [],
          reset?: false,
          consumable?: false
        },
        __configured__: %{},
        __ref__: 1
      }
    }

    run_test(
      ~H"""
      <.box stream={@streams.clients} id="client-row-slot">
        <:row :let={{_dom_id, client}}>
          {client.last_name}
        </:row>
        <:row>This row is ignored</:row>
      </.box>
      """,
      __ENV__
    )
  end
end
