defmodule PrimerLiveTestWeb.ActionListLiveTest do
  use PrimerLiveTestWeb.ConnCase

  import Phoenix.LiveViewTest

  describe "action_list component" do
    test "Basic", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/test/action_list")

      assert view
             |> element("[data-testid=action-list-basic] ul[role=listbox].ActionList")
             |> has_element?()

      assert view
             |> element(
               "[data-testid=action-list-basic] ul[role=listbox].ActionList li[data-testid=test-basic-item-1]",
               "Item 1"
             )
             |> has_element?()

      assert view
             |> element(
               "[data-testid=action-list-basic] ul[role=listbox].ActionList li[data-testid=test-basic-item-2]",
               "Item 2"
             )
             |> has_element?()

      assert view
             |> element(
               "[data-testid=action-list-basic] ul[role=listbox].ActionList li[data-testid=test-basic-item-3]",
               "Item 3"
             )
             |> has_element?()
    end

    test "Single select", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/test/action_list")

      assert view
             |> element("form")
             |> has_element?()

      # -- Display value
      assert view
             |> element("[data-testid=single-select-value]", "-")
             |> has_element?()

      # Select Admin
      assert view
             |> element("[data-testid=data-testid=action-list-single-select] form")
             |> render_change(%{
               _target: ["job_description", "roles"],
               job_description: %{"roles" => ["false", "admin", "false", "false"]},
               role: ""
             })

      # -- Display value
      assert view
             |> element("[data-testid=single-select-value]", "Admin")
             |> has_element?()

      # -- Checked checkbox
      assert view
             |> element(
               "[data-testid=action-list-single-select] li:nth-child(1) input[type=checkbox]:checked"
             )
             |> has_element?()

      # Select Editor
      assert view
             |> element("[data-testid=data-testid=action-list-single-select] form")
             |> render_change(%{
               _target: ["job_description", "roles"],
               job_description: %{"roles" => ["false", "admin", "editor", "false"]},
               role: "admin"
             })

      # -- Display value
      assert view
             |> element("[data-testid=single-select-value]", "Editor")
             |> has_element?()

      # -- Unchecked checkbox
      assert view
             |> element(
               "[data-testid=action-list-single-select] li:nth-child(1) input[type=checkbox]:not(:checked)"
             )
             |> has_element?()

      # -- Checked checkbox
      assert view
             |> element(
               "[data-testid=action-list-single-select] li:nth-child(2) input[type=checkbox]:checked"
             )
             |> has_element?()

      # Deselect Editor
      assert view
             |> element("[data-testid=data-testid=action-list-single-select] form")
             |> render_change(%{
               _target: ["job_description", "roles"],
               job_description: %{"roles" => ["false", "false", "false"]},
               role: "editor"
             })

      # -- Display value
      assert view
             |> element("[data-testid=single-select-value]", "-")
             |> has_element?()
    end

    test "Multiple select", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/test/action_list")

      assert view
             |> element("[data-testid=data-testid=action-list-multiple-select] form")
             |> has_element?()

      # -- Display value
      assert view
             |> element("[data-testid=multiple-select-value]", "-")
             |> has_element?()

      # Select Admin
      assert view
             |> element("[data-testid=data-testid=action-list-multiple-select] form")
             |> render_change(%{
               _target: ["job_description", "roles"],
               job_description: %{"roles" => ["false", "admin", "false", "false"]}
             })

      # -- Display value
      assert view
             |> element("[data-testid=multiple-select-value]", "Admin")
             |> has_element?()

      # -- Checked checkbox
      assert view
             |> element(
               "[data-testid=action-list-multiple-select] li:nth-child(1) input[type=checkbox]:checked"
             )
             |> has_element?()

      # Select Editor
      assert view
             |> element("[data-testid=data-testid=action-list-multiple-select] form")
             |> render_change(%{
               _target: ["job_description", "roles"],
               job_description: %{"roles" => ["false", "admin", "editor", "false"]}
             })

      # -- Display value
      assert view
             |> element("[data-testid=single-select-value]", "Admin, Editor")
             |> has_element?()

      # -- Checked checkboxes
      assert view
             |> element(
               "[data-testid=action-list-multiple-select] li:nth-child(1) input[type=checkbox]:checked"
             )
             |> has_element?()

      assert view
             |> element(
               "[data-testid=action-list-multiple-select] li:nth-child(2) input[type=checkbox]:checked"
             )
             |> has_element?()

      # Deselect Admin
      assert view
             |> element("[data-testid=data-testid=action-list-multiple-select] form")
             |> render_change(%{
               _target: ["job_description", "roles"],
               job_description: %{"roles" => ["false", "false", "editor", "false"]}
             })

      # -- Display value
      assert view
             |> element("[data-testid=single-select-value]", "Editor")
             |> has_element?()

      # Deselect Editor
      assert view
             |> element("[data-testid=data-testid=action-list-multiple-select] form")
             |> render_change(%{
               _target: ["job_description", "roles"],
               job_description: %{"roles" => ["false", "false", "false"]}
             })

      # -- Display value
      assert view
             |> element("[data-testid=single-select-value]", "-")
             |> has_element?()

      # -- Unchecked checkboxes
      assert view
             |> element(
               "[data-testid=action-list-multiple-select] li:nth-child(1) input[type=checkbox]:not(:checked)"
             )
             |> has_element?()

      assert view
             |> element(
               "[data-testid=action-list-multiple-select] li:nth-child(2) input[type=checkbox]:not(:checked)"
             )
             |> has_element?()
    end
  end
end
