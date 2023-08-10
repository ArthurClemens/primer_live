defmodule PrimerLive.TestComponents.PaginationTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

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

  test "get_pagination_numbers: page_count 3, side_count 1 and sibling_count 1" do
    page_count = 3
    side_count = 1
    sibling_count = 1

    actual =
      1..page_count
      |> Enum.map(&get_pagination_numbers(page_count, &1, side_count, sibling_count))

    expected = [[1, 2, 3], [1, 2, 3], [1, 2, 3]]

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

    assert rendered_to_string(~H"""
           <.pagination page_count={1} current_page={1} link_path={&"/page/#{&1}"} />
           """)
           |> format_html() ==
             """
             """
             |> format_html()
  end

  test "With page_count 2: should render the component" do
    assigns = %{page_count: 2, current_page: 1}

    assert rendered_to_string(~H"""
           <.pagination
             page_count={@page_count}
             current_page={@current_page}
             link_path={fn page_num -> "/page/#{page_num}" end}
           />
           """)
           |> format_html() ==
             """
             <nav aria-label="Navigation" class="paginate-container">
             <div class="pagination"><span class="previous_page" aria-disabled="true">Previous</span><em
             aria-current="page">1</em><a href="/page/2" data-phx-link="redirect" data-phx-link-state="push"
             aria-label="Page 2">2</a><a href="/page/2" data-phx-link="redirect" data-phx-link-state="push" rel="next"
             class="next_page" aria-label="Next page">Next</a></div>
             </nav>
             """
             |> format_html()
  end

  test "Many pages" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.pagination page_count={99} current_page={9} link_path={&"/page/#{&1}"} />
           """)
           |> format_html() ==
             """
             <nav aria-label="Navigation" class="paginate-container">
             <div class="pagination"><a href="/page/8" data-phx-link="redirect" data-phx-link-state="push" rel="previous"
             class="previous_page" aria-label="Previous page">Previous</a><a href="/page/1" data-phx-link="redirect"
             data-phx-link-state="push" aria-label="Page 1">1</a><span class="gap">…</span><a href="/page/7"
             data-phx-link="redirect" data-phx-link-state="push" aria-label="Page 7">7</a><a href="/page/8"
             data-phx-link="redirect" data-phx-link-state="push" aria-label="Page 8">8</a><em aria-current="page">9</em><a
             href="/page/10" data-phx-link="redirect" data-phx-link-state="push" aria-label="Page 10">10</a><a href="/page/11"
             data-phx-link="redirect" data-phx-link-state="push" aria-label="Page 11">11</a><span class="gap">…</span><a
             href="/page/99" data-phx-link="redirect" data-phx-link-state="push" aria-label="Page 99">99</a><a href="/page/10"
             data-phx-link="redirect" data-phx-link-state="push" rel="next" class="next_page" aria-label="Next page">Next</a>
             </div>
             </nav>
             """
             |> format_html()
  end

  test "Attribute: side_count" do
    assigns = %{page_count: 10, current_page: 5}

    assert rendered_to_string(~H"""
           <.pagination
             page_count={@page_count}
             current_page={@current_page}
             link_path={fn page_num -> "/page/#{page_num}" end}
             side_count="1"
           />
           """)
           |> format_html() ==
             """
             <nav aria-label="Navigation" class="paginate-container">
             <div class="pagination"><a href="/page/4" data-phx-link="redirect" data-phx-link-state="push" rel="previous"
             class="previous_page" aria-label="Previous page">Previous</a><a href="/page/1" data-phx-link="redirect"
             data-phx-link-state="push" aria-label="Page 1">1</a><span class="gap">…</span><a href="/page/3"
             data-phx-link="redirect" data-phx-link-state="push" aria-label="Page 3">3</a><a href="/page/4"
             data-phx-link="redirect" data-phx-link-state="push" aria-label="Page 4">4</a><em aria-current="page">5</em><a
             href="/page/6" data-phx-link="redirect" data-phx-link-state="push" aria-label="Page 6">6</a><a href="/page/7"
             data-phx-link="redirect" data-phx-link-state="push" aria-label="Page 7">7</a><span class="gap">…</span><a
             href="/page/10" data-phx-link="redirect" data-phx-link-state="push" aria-label="Page 10">10</a><a href="/page/6"
             data-phx-link="redirect" data-phx-link-state="push" rel="next" class="next_page" aria-label="Next page">Next</a>
             </div>
             </nav>
             """
             |> format_html()
  end

  test "Attribute: sibling_count" do
    assigns = %{page_count: 10, current_page: 5}

    assert rendered_to_string(~H"""
           <.pagination
             page_count={@page_count}
             current_page={@current_page}
             link_path={fn page_num -> "/page/#{page_num}" end}
             sibling_count="1"
           />
           """)
           |> format_html() ==
             """
             <nav aria-label="Navigation" class="paginate-container">
             <div class="pagination"><a href="/page/4" data-phx-link="redirect" data-phx-link-state="push" rel="previous"
             class="previous_page" aria-label="Previous page">Previous</a><a href="/page/1" data-phx-link="redirect"
             data-phx-link-state="push" aria-label="Page 1">1</a><span class="gap">…</span><a href="/page/4"
             data-phx-link="redirect" data-phx-link-state="push" aria-label="Page 4">4</a><em aria-current="page">5</em><a
             href="/page/6" data-phx-link="redirect" data-phx-link-state="push" aria-label="Page 6">6</a><span
             class="gap">…</span><a href="/page/10" data-phx-link="redirect" data-phx-link-state="push"
             aria-label="Page 10">10</a><a href="/page/6" data-phx-link="redirect" data-phx-link-state="push" rel="next"
             class="next_page" aria-label="Next page">Next</a></div>
             </nav>
             """
             |> format_html()
  end

  test "Attribute: is_numbered false" do
    assigns = %{page_count: 10, current_page: 5}

    assert rendered_to_string(~H"""
           <.pagination
             page_count={@page_count}
             current_page={@current_page}
             link_path={fn page_num -> "/page/#{page_num}" end}
             is_numbered="false"
           />
           """)
           |> format_html() ==
             """
             <nav aria-label="Navigation" class="paginate-container">
             <div class="pagination"><a href="/page/4" data-phx-link="redirect" data-phx-link-state="push" rel="previous"
             class="previous_page" aria-label="Previous page">Previous</a><a href="/page/6" data-phx-link="redirect"
             data-phx-link-state="push" rel="next" class="next_page" aria-label="Next page">Next</a></div>
             </nav>
             """
             |> format_html()
  end

  test "Attribute: class" do
    assigns = %{page_count: 2, current_page: 1}

    assert rendered_to_string(~H"""
           <.pagination
             page_count={@page_count}
             current_page={@current_page}
             link_path={fn page_num -> "/page/#{page_num}" end}
             class="nav"
           />
           """)
           |> format_html() ==
             """
             <nav aria-label="Navigation" class="paginate-container nav">
             <div class="pagination"><span class="previous_page" aria-disabled="true">Previous</span><em
             aria-current="page">1</em><a href="/page/2" data-phx-link="redirect" data-phx-link-state="push"
             aria-label="Page 2">2</a><a href="/page/2" data-phx-link="redirect" data-phx-link-state="push" rel="next"
             class="next_page" aria-label="Next page">Next</a></div>
             </nav>
             """
             |> format_html()
  end

  test "Attribute: classes" do
    assigns = %{page_count: 10, current_page: 5}

    assert rendered_to_string(~H"""
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
                 page: "page-x"
               }
             }
           />
           """)
           |> format_html() ==
             """
             <nav aria-label="Navigation" class="paginate-container pagination_container-x">
             <div class="pagination pagination-x"><a href="/page/4" data-phx-link="redirect" data-phx-link-state="push"
             rel="previous" class="previous_page previous_page-x" aria-label="Previous page">Previous</a><a href="/page/1"
             data-phx-link="redirect" data-phx-link-state="push" class="page-x" aria-label="Page 1">1</a><span
             class="gap gap-x">…</span><a href="/page/3" data-phx-link="redirect" data-phx-link-state="push" class="page-x"
             aria-label="Page 3">3</a><a href="/page/4" data-phx-link="redirect" data-phx-link-state="push" class="page-x"
             aria-label="Page 4">4</a><em aria-current="page">5</em><a href="/page/6" data-phx-link="redirect"
             data-phx-link-state="push" class="page-x" aria-label="Page 6">6</a><a href="/page/7" data-phx-link="redirect"
             data-phx-link-state="push" class="page-x" aria-label="Page 7">7</a><span class="gap gap-x">…</span><a
             href="/page/10" data-phx-link="redirect" data-phx-link-state="push" class="page-x" aria-label="Page 10">10</a><a
             href="/page/6" data-phx-link="redirect" data-phx-link-state="push" rel="next" class="next_page next_page-x"
             aria-label="Next page">Next</a></div>
             </nav>
             """
             |> format_html()
  end

  test "Attribute: labels" do
    assigns = %{page_count: 10, current_page: 5}

    assert rendered_to_string(~H"""
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
           """)
           |> format_html() ==
             """
             <nav aria-label="A" class="paginate-container">
             <div class="pagination"><a href="/page/4" data-phx-link="redirect" data-phx-link-state="push" rel="previous"
             class="previous_page" aria-label="D">G</a><a href="/page/1" data-phx-link="redirect" data-phx-link-state="push"
             aria-label="C">1</a><span class="gap">E</span><a href="/page/3" data-phx-link="redirect"
             data-phx-link-state="push" aria-label="C">3</a><a href="/page/4" data-phx-link="redirect"
             data-phx-link-state="push" aria-label="C">4</a><em aria-current="page">5</em><a href="/page/6"
             data-phx-link="redirect" data-phx-link-state="push" aria-label="C">6</a><a href="/page/7" data-phx-link="redirect"
             data-phx-link-state="push" aria-label="C">7</a><span class="gap">E</span><a href="/page/10"
             data-phx-link="redirect" data-phx-link-state="push" aria-label="C">10</a><a href="/page/6"
             data-phx-link="redirect" data-phx-link-state="push" rel="next" class="next_page" aria-label="B">F</a></div>
             </nav>
             """
             |> format_html()
  end

  test "Attribute: link_options" do
    assigns = %{page_count: 2, current_page: 1}

    assert rendered_to_string(~H"""
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
           """)
           |> format_html() ==
             """
             <nav aria-label="Navigation" class="paginate-container">
             <div class="pagination"><span class="previous_page" aria-disabled="true">Previous</span><em
             aria-current="page">1</em><a href="/page/2" data-phx-link="redirect" data-phx-link-state="replace"
             aria-label="Page 2">2</a><a href="/page/2" data-phx-link="redirect" data-phx-link-state="replace" rel="next"
             class="next_page" aria-label="Next page">Next</a></div>
             </nav>
             """
             |> format_html()
  end

  test "Extra attributes" do
    assigns = %{page_count: 2, current_page: 1}

    assert rendered_to_string(~H"""
           <.pagination
             page_count={@page_count}
             current_page={@current_page}
             link_path={fn page_num -> "/page/#{page_num}" end}
             dir="rtl"
           />
           """)
           |> format_html() ==
             """
             <nav aria-label="Navigation" class="paginate-container" dir="rtl">
             <div class="pagination"><span class="previous_page" aria-disabled="true">Previous</span><em
             aria-current="page">1</em><a href="/page/2" data-phx-link="redirect" data-phx-link-state="push"
             aria-label="Page 2">2</a><a href="/page/2" data-phx-link="redirect" data-phx-link-state="push" rel="next"
             class="next_page" aria-label="Next page">Next</a></div>
             </nav>
             """
             |> format_html()
  end
end
