defmodule PrimerLiveTestWeb.ButtonLiveTest do
  use PrimerLiveTestWeb.ConnCase

  import Phoenix.LiveViewTest

  # This is a limited test, intended to get LiveView tests up and running

  describe "button component" do
    test "Variants", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/test/button")

      assert view
             |> element("[data-testid=variants-plain] button[type=button].btn", "Plain")
             |> has_element?()

      assert view
             |> element(
               "[data-testid=variants-outline] button[type=button].btn.btn-outline",
               "Outline"
             )
             |> has_element?()

      assert view
             |> element(
               "[data-testid=variants-primary] button[type=button].btn.btn-primary",
               "Primary"
             )
             |> has_element?()

      assert view
             |> element(
               "[data-testid=variants-danger] button[type=button].btn.btn-danger",
               "Danger"
             )
             |> has_element?()

      assert view
             |> element(
               "[data-testid=variants-invisible] button[type=button].btn.btn-invisible",
               "Invisible"
             )
             |> has_element?()

      assert view
             |> element(
               "[data-testid=variants-disabled] button[type=button][aria-disabled].btn",
               "Disabled"
             )
             |> has_element?()
    end

    test "Selected", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/test/button")

      assert view
             |> element(
               "[data-testid=is-selected-plain] button[type=button][aria-selected].btn",
               "Plain"
             )
             |> has_element?()

      assert view
             |> element(
               "[data-testid=is-selected-outline] button[type=button][aria-selected].btn.btn-outline",
               "Outline"
             )
             |> has_element?()

      assert view
             |> element(
               "[data-testid=is-selected-primary] button[type=button][aria-selected].btn.btn-primary",
               "Primary"
             )
             |> has_element?()

      assert view
             |> element(
               "[data-testid=is-selected-danger] button[type=button][aria-selected].btn.btn-danger",
               "Danger"
             )
             |> has_element?()

      assert view
             |> element(
               "[data-testid=is-selected-invisible] button[type=button][aria-selected].btn.btn-invisible",
               "Invisible"
             )
             |> has_element?()

      assert view
             |> element(
               "[data-testid=is-selected-disabled] button[type=button][aria-disabled][aria-selected].btn",
               "Disabled"
             )
             |> has_element?()
    end

    test "Small", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/test/button")

      assert view
             |> element("[data-testid=is-small-plain] button[type=button].btn.btn-sm", "Plain")
             |> has_element?()

      assert view
             |> element(
               "[data-testid=is-small-outline] button[type=button].btn.btn-outline.btn-sm",
               "Outline"
             )
             |> has_element?()

      assert view
             |> element(
               "[data-testid=is-small-primary] button[type=button].btn.btn-primary.btn-sm",
               "Primary"
             )
             |> has_element?()

      assert view
             |> element(
               "[data-testid=is-small-danger] button[type=button].btn.btn-danger.btn-sm",
               "Danger"
             )
             |> has_element?()

      assert view
             |> element(
               "[data-testid=is-small-invisible] button[type=button].btn.btn-invisible.btn-sm",
               "Invisible"
             )
             |> has_element?()

      assert view
             |> element(
               "[data-testid=is-small-disabled] button[type=button][aria-disabled].btn.btn-sm",
               "Disabled"
             )
             |> has_element?()
    end

    test "Large", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/test/button")

      assert view
             |> element("[data-testid=is-large-plain] button[type=button].btn.btn-large", "Plain")
             |> has_element?()

      assert view
             |> element(
               "[data-testid=is-large-outline] button[type=button].btn.btn-outline.btn-large",
               "Outline"
             )
             |> has_element?()

      assert view
             |> element(
               "[data-testid=is-large-primary] button[type=button].btn.btn-primary.btn-large",
               "Primary"
             )
             |> has_element?()

      assert view
             |> element(
               "[data-testid=is-large-danger] button[type=button].btn.btn-danger.btn-large",
               "Danger"
             )
             |> has_element?()

      assert view
             |> element(
               "[data-testid=is-large-invisible] button[type=button].btn.btn-invisible.btn-large",
               "Invisible"
             )
             |> has_element?()

      assert view
             |> element(
               "[data-testid=is-large-disabled] button[type=button][aria-disabled].btn.btn-large",
               "Disabled"
             )
             |> has_element?()
    end
  end
end
