defmodule PrimerLive.TestComponents.ActionListTest do
  @moduledoc false

  use PrimerLive.TestBase
  alias PrimerLive.TestHelpers.Repo.Todos

  test "Content slot" do
    assigns = %{}

    run_test(
      ~H"""
      <.action_list>
        <.action_list_item>content</.action_list_item>
      </.action_list>
      """,
      __ENV__
    )
  end

  test "Attributes: aria_label, role" do
    assigns = %{}

    run_test(
      ~H"""
      <.action_list aria_label="Menu" role="list">
        <.action_list_item>content</.action_list_item>
      </.action_list>
      """,
      __ENV__
    )
  end

  test "Attributes: is_divided, is_full_bleed, is_multiple_select" do
    assigns = %{}

    run_test(
      ~H"""
      <.action_list is_divided>
        <.action_list_item>content</.action_list_item>
      </.action_list>
      <.action_list is_full_bleed>
        <.action_list_item>content</.action_list_item>
      </.action_list>
      <.action_list is_multiple_select>
        <.action_list_item>content</.action_list_item>
      </.action_list>
      """,
      __ENV__
    )
  end

  test "Class" do
    assigns = %{}

    run_test(
      ~H"""
      <.action_list class="my-action-list">
        <.action_list_item>content</.action_list_item>
      </.action_list>
      """,
      __ENV__
    )
  end

  test "Extra attributes" do
    assigns = %{}

    run_test(
      ~H"""
      <.action_list dir="rtl">
        <.action_list_item>content</.action_list_item>
      </.action_list>
      """,
      __ENV__
    )
  end

  test "With divider and aria-labelledby" do
    assigns = %{}

    run_test(
      ~H"""
      <.action_list aria-labelledby="title-01">
        <.action_list_section_divider>
          <:title id="title-01">Title</:title>
        </.action_list_section_divider>
        <.action_list_item>
          Item
        </.action_list_item>
      </.action_list>
      """,
      __ENV__
    )
  end

  test "With form" do
    changeset = Todos.init()
    options = Todos.status_options()
    values = changeset.changes |> Map.get(:statuses) || []

    assigns = %{
      changeset: changeset,
      options: options,
      values: values
    }

    run_test(
      ~H"""
      <.form :let={f} for={@changeset} phx-change="validate" phx-submit="save">
        <.action_list is_multiple_select>
          <%= for {label, value} <- @options do %>
            <.action_list_item
              form={f}
              field={:statuses}
              checked_value={value}
              is_selected={value in @values}
            >
              {label}
            </.action_list_item>
          <% end %>
        </.action_list>
      </.form>
      """,
      __ENV__
    )
  end

  test "With form, is_multiple_select" do
    changeset = Todos.init()
    options = Todos.status_options()
    values = changeset.changes |> Map.get(:statuses) || []

    assigns = %{
      changeset: changeset,
      options: options,
      values: values
    }

    run_test(
      ~H"""
      <.form :let={f} for={@changeset} phx-change="validate" phx-submit="save">
        <.action_list is_multiple_select>
          <%= for {label, value} <- @options do %>
            <.action_list_item
              form={f}
              field={:statuses}
              checked_value={value}
              is_multiple_select
              is_selected={value in @values}
            >
              {label}
            </.action_list_item>
          <% end %>
        </.action_list>
      </.form>
      """,
      __ENV__
    )
  end
end
