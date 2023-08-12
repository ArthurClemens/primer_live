defmodule PrimerLive.TestComponents.ActionListTest do
  use ExUnit.Case
  use PrimerLive

  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  alias PrimerLive.TestHelpers.Repo.Todos

  test "Content slot" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_list>
             content
           </.action_list>
           """)
           |> format_html() ==
             """
             <ul class="ActionList" role="listbox">content</ul>
             """
             |> format_html()
  end

  test "Attributes: aria_label, role" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_list aria_label="Menu" role="list">
             content
           </.action_list>
           """)
           |> format_html() ==
             """
             <ul aria-label="Menu" class="ActionList" role="list">content</ul>
             """
             |> format_html()
  end

  test "Attributes: is_divided, is_full_bleed, is_multiple_select" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_list is_divided>
             content
           </.action_list>
           <.action_list is_full_bleed>
             content
           </.action_list>
           <.action_list is_multiple_select>
             content
           </.action_list>
           """)
           |> format_html() ==
             """
             <ul class="ActionList ActionList--divided" role="listbox">content</ul>
             <ul class="ActionList ActionList--full" role="listbox">content</ul>
             <ul aria-multiselectable="true" class="ActionList" role="listbox">content</ul>
             """
             |> format_html()
  end

  test "Class" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_list class="my-action-list">
             content
           </.action_list>
           """)
           |> format_html() ==
             """
             <ul class="ActionList my-action-list" role="listbox">content</ul>
             """
             |> format_html()
  end

  test "Extra attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_list dir="rtl">
             content
           </.action_list>
           """)
           |> format_html() ==
             """
             <ul class="ActionList" dir="rtl" role="listbox">content</ul>
             """
             |> format_html()
  end

  test "With divider and aria-labelledby" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_list aria-labelledby="title-01">
             <.action_list_section_divider>
               <:title id="title-01">Title</:title>
             </.action_list_section_divider>
             <.action_list_item>
               Item
             </.action_list_item>
           </.action_list>
           """)
           |> format_html() ==
             """
             <ul aria-labelledby="title-01" class="ActionList" role="listbox">
             <li class="ActionList-sectionDivider">
             <h3 class="ActionList-sectionDivider-title" id="title-01">Title</h3>
             </li>
             <li class="ActionList-item"><span class="ActionList-content"><span class="ActionList-item-label">Item</span></span>
             </li>
             </ul>
             """
             |> format_html()
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

    assert rendered_to_string(~H"""
           <.form :let={f} for={@changeset} phx-change="validate" phx-submit="save">
             <.action_list is_multiple_select>
               <%= for {label, value} <- @options do %>
                 <.action_list_item
                   form={f}
                   field={:statuses}
                   checked_value={value}
                   is_selected={value in @values}
                 >
                   <%= label %>
                 </.action_list_item>
               <% end %>
             </.action_list>
           </.form>
           """)
           |> format_html() ==
             """
             <form method="post" phx-submit="save" phx-change="validate">
             <ul aria-multiselectable="true" class="ActionList" role="listbox">
             <li class="ActionList-item"><label class="ActionList-content" for="todo_statuses_in-progress"><span
                    class="ActionList-item-label">In progress</span></label></li>
             <li class="ActionList-item"><label class="ActionList-content" for="todo_statuses_needs-review"><span
                    class="ActionList-item-label">Needs review</span></label></li>
             <li class="ActionList-item"><label class="ActionList-content" for="todo_statuses_complete"><span
                    class="ActionList-item-label">Complete</span></label></li>
             </ul>
             </form>
             """
             |> format_html()
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

    assert rendered_to_string(~H"""
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
                   <%= label %>
                 </.action_list_item>
               <% end %>
             </.action_list>
           </.form>
           """)
           |> format_html() ==
             """
             <form method="post" phx-submit="save" phx-change="validate">
             <ul aria-multiselectable="true" class="ActionList" role="listbox">
             <li class="ActionList-item" role="option"><label class="ActionList-content"
                for="todo_statuses_in-progress"><span
                    class="ActionList-item-visual ActionList-item-visual--leading"><span
                        class="FormControl-checkbox-wrap pl-invalid ActionList-item-multiSelectIcon"><input
                            name="todo[statuses][]" type="hidden" value="false" /><input class="FormControl-checkbox"
                            id="todo_statuses_in-progress" name="todo[statuses][]" type="checkbox"
                            value="in-progress" /></span></span><span class="ActionList-item-label">In
                    progress</span></label></li>
             <li class="ActionList-item" role="option"><label class="ActionList-content"
                for="todo_statuses_needs-review"><span
                    class="ActionList-item-visual ActionList-item-visual--leading"><span
                        class="FormControl-checkbox-wrap pl-invalid ActionList-item-multiSelectIcon"><input
                            name="todo[statuses][]" type="hidden" value="false" /><input class="FormControl-checkbox"
                            id="todo_statuses_needs-review" name="todo[statuses][]" type="checkbox"
                            value="needs-review" /></span></span><span class="ActionList-item-label">Needs
                    review</span></label></li>
             <li class="ActionList-item" role="option"><label class="ActionList-content" for="todo_statuses_complete"><span
                    class="ActionList-item-visual ActionList-item-visual--leading"><span
                        class="FormControl-checkbox-wrap pl-invalid ActionList-item-multiSelectIcon"><input
                            name="todo[statuses][]" type="hidden" value="false" /><input class="FormControl-checkbox"
                            id="todo_statuses_complete" name="todo[statuses][]" type="checkbox"
                            value="complete" /></span></span><span class="ActionList-item-label">Complete</span></label>
             </li>
             </ul>
             </form>
             """
             |> format_html()
  end
end
