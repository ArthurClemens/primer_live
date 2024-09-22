defmodule PrimerLive.Components.SubnavTest do
  @moduledoc false

  use PrimerLive.TestBase

  test "Attribute is_wrap" do
    assigns = %{}

    run_test(
      ~H"""
      <.subnav is_wrap>
        Content
      </.subnav>
      """,
      __ENV__
    )
  end

  test "Subnav with component subnav_links" do
    assigns = %{}

    run_test(
      ~H"""
      <.subnav aria-label="Menu">
        <.subnav_links>
          <:item href="#url" is_selected>
            href link
          </:item>
          <:item navigate="#url">
            navigate link
          </:item>
          <:item patch="#url">
            patch link
          </:item>
          <:item>
            Other content
          </:item>
        </.subnav_links>
      </.subnav>
      """,
      __ENV__
    )
  end

  test "Subnav with component subnav_search" do
    assigns = %{}

    run_test(
      ~H"""
      <.subnav>
        <.subnav_search>
          <.text_input type="search" name="site-search" />
        </.subnav_search>
      </.subnav>
      """,
      __ENV__
    )
  end

  test "Subnav with component subnav_search_context" do
    assigns = %{}

    run_test(
      ~H"""
      <.subnav>
        <.subnav_search_context>
          <.select_menu is_dropdown_caret id="querty">
            <:toggle>Menu</:toggle>
            <:item>Item 1</:item>
            <:item>Item 2</:item>
            <:item>Item 3</:item>
          </.select_menu>
        </.subnav_search_context>
        <.subnav_search>
          <.text_input type="search" />
        </.subnav_search>
      </.subnav>
      """,
      __ENV__
    )
  end

  test "Attribute: classes" do
    assigns = %{}

    run_test(
      ~H"""
      <.subnav class="my-links-subnav">
        <.subnav_links class="my-subnav-links">
          <:item href="#url" is_selected>
            Link 1
          </:item>
          <:item navigate="#url">
            Link 2
          </:item>
        </.subnav_links>
      </.subnav>
      <.subnav class="my-search-subnav">
        <.subnav_search_context class="my-subnav-search-context">
          <.select_menu is_dropdown_caret id="querty">
            <:toggle>Menu</:toggle>
            <:item>Item 1</:item>
            <:item>Item 2</:item>
            <:item>Item 3</:item>
          </.select_menu>
        </.subnav_search_context>
        <.subnav_search class="my-subnav-search">
          <.text_input type="search" name="site-search" />
        </.subnav_search>
      </.subnav>
      """,
      __ENV__
    )
  end
end
