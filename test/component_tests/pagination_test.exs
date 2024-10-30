defmodule PrimerLive.TestComponents.PaginationTest do
  @moduledoc false

  use PrimerLive.TestBase

  test "get_pagination_numbers: zeroes" do
    page_count = 0
    current_page = 0
    side_count = 0
    sibling_count = 0
    actual = get_pagination_numbers(page_count, current_page, side_count, sibling_count)
    expected = [1]
    assert actual == expected
  end

  test "get_pagination_numbers: ones" do
    page_count = 1
    current_page = 1
    side_count = 1
    sibling_count = 1
    actual = get_pagination_numbers(page_count, current_page, side_count, sibling_count)
    expected = [1]
    assert actual == expected
  end

  test "get_pagination_numbers: page_count 4, side_count 1 and sibling_count 2" do
    page_count = 4
    side_count = 1
    sibling_count = 2

    actual =
      1..page_count
      |> Enum.map(&get_pagination_numbers(page_count, &1, side_count, sibling_count))

    expected = [[1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 3, 4]]

    assert actual == expected
  end

  test "get_pagination_numbers: page_count 7, side_count 1 and sibling_count 1" do
    page_count = 7
    side_count = 1
    sibling_count = 1

    actual =
      1..page_count
      |> Enum.map(&get_pagination_numbers(page_count, &1, side_count, sibling_count))

    expected = [
      [1, 2, 3, 4, 0, 7],
      [1, 2, 3, 4, 0, 7],
      [1, 2, 3, 4, 0, 7],
      [1, 0, 3, 4, 5, 0, 7],
      [1, 0, 4, 5, 6, 7],
      [1, 0, 4, 5, 6, 7],
      [1, 0, 4, 5, 6, 7]
    ]

    assert actual == expected
  end

  test "get_pagination_numbers: page_count 10, side_count 1 and sibling_count 2" do
    page_count = 10
    side_count = 1
    sibling_count = 2

    actual =
      1..page_count
      |> Enum.map(&get_pagination_numbers(page_count, &1, side_count, sibling_count))

    expected = [
      [1, 2, 3, 4, 5, 6, 0, 10],
      [1, 2, 3, 4, 5, 6, 0, 10],
      [1, 2, 3, 4, 5, 6, 0, 10],
      [1, 2, 3, 4, 5, 6, 0, 10],
      [1, 0, 3, 4, 5, 6, 7, 0, 10],
      [1, 0, 4, 5, 6, 7, 8, 0, 10],
      [1, 0, 5, 6, 7, 8, 9, 10],
      [1, 0, 5, 6, 7, 8, 9, 10],
      [1, 0, 5, 6, 7, 8, 9, 10],
      [1, 0, 5, 6, 7, 8, 9, 10]
    ]

    assert actual == expected
  end

  test "get_pagination_numbers: page_count 10, side_count 2 and sibling_count 2" do
    page_count = 10
    side_count = 2
    sibling_count = 2

    actual =
      1..page_count
      |> Enum.map(&get_pagination_numbers(page_count, &1, side_count, sibling_count))

    expected = [
      [1, 2, 3, 4, 5, 6, 7, 0, 9, 10],
      [1, 2, 3, 4, 5, 6, 7, 0, 9, 10],
      [1, 2, 3, 4, 5, 6, 7, 0, 9, 10],
      [1, 2, 3, 4, 5, 6, 7, 0, 9, 10],
      [1, 2, 3, 4, 5, 6, 7, 0, 9, 10],
      [1, 2, 0, 4, 5, 6, 7, 8, 9, 10],
      [1, 2, 0, 4, 5, 6, 7, 8, 9, 10],
      [1, 2, 0, 4, 5, 6, 7, 8, 9, 10],
      [1, 2, 0, 4, 5, 6, 7, 8, 9, 10],
      [1, 2, 0, 4, 5, 6, 7, 8, 9, 10]
    ]

    assert actual == expected
  end

  test "With page_count 1: should render nothing" do
    assigns = %{}

    run_test(
      ~H"""
      <.pagination page_count={1} current_page={1} link_path={&"/page/#{&1}"} />
      """,
      __ENV__
    )
  end

  test "With page_count 2: should render the component" do
    assigns = %{page_count: 2, current_page: 1}

    run_test(
      ~H"""
      <.pagination
        page_count={@page_count}
        current_page={@current_page}
        link_path={fn page_num -> "/page/#{page_num}" end}
      />
      """,
      __ENV__
    )
  end

  test "Many pages" do
    assigns = %{}

    run_test(
      ~H"""
      <.pagination page_count={99} current_page={9} link_path={&"/page/#{&1}"} />
      """,
      __ENV__
    )
  end

  test "Attribute: side_count" do
    assigns = %{page_count: 10, current_page: 5}

    run_test(
      ~H"""
      <.pagination
        page_count={@page_count}
        current_page={@current_page}
        link_path={fn page_num -> "/page/#{page_num}" end}
        side_count={1}
      />
      """,
      __ENV__
    )
  end

  test "Attribute: sibling_count" do
    assigns = %{page_count: 10, current_page: 5}

    run_test(
      ~H"""
      <.pagination
        page_count={@page_count}
        current_page={@current_page}
        link_path={fn page_num -> "/page/#{page_num}" end}
        sibling_count={1}
      />
      """,
      __ENV__
    )
  end

  test "Attribute: is_numbered false" do
    assigns = %{page_count: 10, current_page: 5}

    run_test(
      ~H"""
      <.pagination
        page_count={@page_count}
        current_page={@current_page}
        link_path={fn page_num -> "/page/#{page_num}" end}
        is_numbered="false"
      />
      """,
      __ENV__
    )
  end

  test "Attribute: class" do
    assigns = %{page_count: 2, current_page: 1}

    run_test(
      ~H"""
      <.pagination
        page_count={@page_count}
        current_page={@current_page}
        link_path={fn page_num -> "/page/#{page_num}" end}
        class="nav"
      />
      """,
      __ENV__
    )
  end

  test "Attribute: classes" do
    assigns = %{page_count: 10, current_page: 5}

    run_test(
      ~H"""
      <.pagination
        page_count={@page_count}
        current_page={@current_page}
        link_path={fn page_num -> "/page/#{page_num}" end}
        classes={
          %{
            gap: "gap-x",
            pagination_container: "pagination_container-x",
            pagination: "pagination-x",
            previous_page: "previous_page-x",
            next_page: "next_page-x",
            page: "page-x",
            current_page: "current_page-x"
          }
        }
      />
      """,
      __ENV__
    )
  end

  test "Attribute: labels" do
    assigns = %{page_count: 10, current_page: 5}

    run_test(
      ~H"""
      <.pagination
        page_count={@page_count}
        current_page={@current_page}
        link_path={fn page_num -> "/page/#{page_num}" end}
        labels={
          %{
            aria_label_container: "A",
            aria_label_next_page: "B",
            aria_label_page: "C",
            aria_label_previous_page: "D",
            gap: "E",
            next_page: "F",
            previous_page: "G"
          }
        }
      />
      """,
      __ENV__
    )
  end

  test "Attribute: link_options" do
    assigns = %{page_count: 2, current_page: 1}

    run_test(
      ~H"""
      <.pagination
        page_count={@page_count}
        current_page={@current_page}
        link_path={fn page_num -> "/page/#{page_num}" end}
        link_options={
          %{
            replace: true
          }
        }
      />
      """,
      __ENV__
    )
  end

  test "Extra attributes" do
    assigns = %{page_count: 2, current_page: 1}

    run_test(
      ~H"""
      <.pagination
        page_count={@page_count}
        current_page={@current_page}
        link_path={fn page_num -> "/page/#{page_num}" end}
        dir="rtl"
      />
      """,
      __ENV__
    )
  end
end
