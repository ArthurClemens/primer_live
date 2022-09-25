defmodule PrimerLive.TestComponents.PaginationTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "get_pagination_numbers: zeroes" do
    page_count = 0
    current_page = 0
    boundary_count = 0
    sibling_count = 0
    actual = get_pagination_numbers(page_count, current_page, boundary_count, sibling_count)
    expected = [1]
    assert actual == expected
  end

  test "get_pagination_numbers: ones" do
    page_count = 1
    current_page = 1
    boundary_count = 1
    sibling_count = 1
    actual = get_pagination_numbers(page_count, current_page, boundary_count, sibling_count)
    expected = [1]
    assert actual == expected
  end

  test "get_pagination_numbers: page_count 3, boundary_count 1 and sibling_count 1" do
    page_count = 3
    boundary_count = 1
    sibling_count = 1

    actual =
      1..page_count
      |> Enum.map(&get_pagination_numbers(page_count, &1, boundary_count, sibling_count))

    expected = [[1, 2, 3], [1, 2, 3], [1, 2, 3]]

    assert actual == expected
  end

  test "get_pagination_numbers: page_count 10, boundary_count 1 and sibling_count 2" do
    page_count = 10
    boundary_count = 1
    sibling_count = 2

    actual =
      1..page_count
      |> Enum.map(&get_pagination_numbers(page_count, &1, boundary_count, sibling_count))

    expected = [
      [1, 0, 10],
      [1, 2, 3, 4, 5, 0, 10],
      [1, 2, 3, 4, 5, 6, 0, 10],
      [1, 0, 3, 4, 5, 6, 7, 0, 10],
      [1, 0, 4, 5, 6, 7, 8, 0, 10],
      [1, 0, 5, 6, 7, 8, 9, 10],
      [1, 0, 6, 7, 8, 9, 10],
      [1, 0, 7, 8, 9, 10],
      [1, 0, 8, 9, 10],
      [1, 0, 9, 10]
    ]

    assert actual == expected
  end

  test "get_pagination_numbers: page_count 10, boundary_count 2 and sibling_count 2" do
    page_count = 10
    boundary_count = 2
    sibling_count = 2

    actual =
      1..page_count
      |> Enum.map(&get_pagination_numbers(page_count, &1, boundary_count, sibling_count))

    expected = [
      [1, 2, 0, 9, 10],
      [1, 2, 3, 4, 5, 0, 9, 10],
      [1, 2, 3, 4, 5, 6, 0, 9, 10],
      [1, 2, 3, 4, 5, 6, 7, 0, 9, 10],
      [1, 2, 0, 4, 5, 6, 7, 8, 9, 10],
      [1, 2, 0, 5, 6, 7, 8, 9, 10],
      [1, 2, 0, 6, 7, 8, 9, 10],
      [1, 2, 0, 7, 8, 9, 10],
      [1, 2, 0, 8, 9, 10],
      [1, 2, 0, 9, 10]
    ]

    assert actual == expected
  end

  test "With page_count 1: should render nothing" do
    assigns = []

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
             <nav class="paginate-container" aria-label="Navigation">
             <div class="pagination"><span class="previous_page" aria-disabled="true">Previous</span><em
             aria-current="page">1</em><a href="/page/2" data-phx-link="redirect" data-phx-link-state="push"
             aria-label="Page 2">2</a><a href="/page/2" data-phx-link="redirect" data-phx-link-state="push"
             aria-label="Next page" class="next_page" rel="next">Next</a></div>
             </nav>
             """
             |> format_html()
  end

  test "Many pages" do
    assigns = []

    assert rendered_to_string(~H"""
           <.pagination page_count={99} current_page={9} link_path={&"/page/#{&1}"} />
           """)
           |> format_html() ==
             """
             <nav class="paginate-container" aria-label="Navigation">
             <div class="pagination"><a href="/page/8" data-phx-link="redirect" data-phx-link-state="push"
             aria-label="Previous page" class="previous_page" rel="previous">Previous</a><a href="/page/1"
             data-phx-link="redirect" data-phx-link-state="push" aria-label="Page 1">1</a><a href="/page/2"
             data-phx-link="redirect" data-phx-link-state="push" aria-label="Page 2">2</a><span class="gap">…</span><a
             href="/page/8" data-phx-link="redirect" data-phx-link-state="push" aria-label="Page 8">8</a><em
             aria-current="page">9</em><a href="/page/10" data-phx-link="redirect" data-phx-link-state="push"
             aria-label="Page 10">10</a><a href="/page/11" data-phx-link="redirect" data-phx-link-state="push"
             aria-label="Page 11">11</a><a href="/page/12" data-phx-link="redirect" data-phx-link-state="push"
             aria-label="Page 12">12</a><span class="gap">…</span><a href="/page/98" data-phx-link="redirect"
             data-phx-link-state="push" aria-label="Page 98">98</a><a href="/page/99" data-phx-link="redirect"
             data-phx-link-state="push" aria-label="Page 99">99</a><a href="/page/10" data-phx-link="redirect"
             data-phx-link-state="push" aria-label="Next page" class="next_page" rel="next">Next</a></div>
             </nav>
             """
             |> format_html()
  end

  test "Attribute: boundary_count" do
    assigns = %{page_count: 10, current_page: 5}

    assert rendered_to_string(~H"""
           <.pagination
             page_count={@page_count}
             current_page={@current_page}
             link_path={fn page_num -> "/page/#{page_num}" end}
             boundary_count="1"
           />
           """)
           |> format_html() ==
             """
             <nav class="paginate-container" aria-label="Navigation">
             <div class="pagination"><a href="/page/4" data-phx-link="redirect" data-phx-link-state="push"
             aria-label="Previous page" class="previous_page" rel="previous">Previous</a><a href="/page/1"
             data-phx-link="redirect" data-phx-link-state="push" aria-label="Page 1">1</a><span class="gap">…</span><a
             href="/page/4" data-phx-link="redirect" data-phx-link-state="push" aria-label="Page 4">4</a><em
             aria-current="page">5</em><a href="/page/6" data-phx-link="redirect" data-phx-link-state="push"
             aria-label="Page 6">6</a><a href="/page/7" data-phx-link="redirect" data-phx-link-state="push"
             aria-label="Page 7">7</a><a href="/page/8" data-phx-link="redirect" data-phx-link-state="push"
             aria-label="Page 8">8</a><span class="gap">…</span><a href="/page/10" data-phx-link="redirect"
             data-phx-link-state="push" aria-label="Page 10">10</a><a href="/page/6" data-phx-link="redirect"
             data-phx-link-state="push" aria-label="Next page" class="next_page" rel="next">Next</a></div>
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
             <nav class="paginate-container" aria-label="Navigation">
             <div class="pagination"><a href="/page/4" data-phx-link="redirect" data-phx-link-state="push"
             aria-label="Previous page" class="previous_page" rel="previous">Previous</a><a href="/page/1"
             data-phx-link="redirect" data-phx-link-state="push" aria-label="Page 1">1</a><a href="/page/2"
             data-phx-link="redirect" data-phx-link-state="push" aria-label="Page 2">2</a><span class="gap">…</span><em
             aria-current="page">5</em><a href="/page/6" data-phx-link="redirect" data-phx-link-state="push"
             aria-label="Page 6">6</a><a href="/page/7" data-phx-link="redirect" data-phx-link-state="push"
             aria-label="Page 7">7</a><span class="gap">…</span><a href="/page/9" data-phx-link="redirect"
             data-phx-link-state="push" aria-label="Page 9">9</a><a href="/page/10" data-phx-link="redirect"
             data-phx-link-state="push" aria-label="Page 10">10</a><a href="/page/6" data-phx-link="redirect"
             data-phx-link-state="push" aria-label="Next page" class="next_page" rel="next">Next</a></div>
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
             <nav class="paginate-container" aria-label="Navigation">
             <div class="pagination"><a href="/page/4" data-phx-link="redirect" data-phx-link-state="push"
             aria-label="Previous page" class="previous_page" rel="previous">Previous</a><a href="/page/6"
             data-phx-link="redirect" data-phx-link-state="push" aria-label="Next page" class="next_page" rel="next">Next</a>
             </div>
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
             <nav class="paginate-container nav" aria-label="Navigation">
             <div class="pagination"><span class="previous_page" aria-disabled="true">Previous</span><em
             aria-current="page">1</em><a href="/page/2" data-phx-link="redirect" data-phx-link-state="push"
             aria-label="Page 2">2</a><a href="/page/2" data-phx-link="redirect" data-phx-link-state="push"
             aria-label="Next page" class="next_page" rel="next">Next</a></div>
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
             <nav class="paginate-container pagination_container-x" aria-label="Navigation">
             <div class="pagination pagination-x"><a href="/page/4" data-phx-link="redirect" data-phx-link-state="push"
                 aria-label="Previous page" class="previous_page previous_page-x" rel="previous">Previous</a><a href="/page/1"
                 data-phx-link="redirect" data-phx-link-state="push" aria-label="Page 1" class="page-x">1</a><a href="/page/2"
                 data-phx-link="redirect" data-phx-link-state="push" aria-label="Page 2" class="page-x">2</a><span
                 class="gap gap-x">…</span><a href="/page/4" data-phx-link="redirect" data-phx-link-state="push"
                 aria-label="Page 4" class="page-x">4</a><em aria-current="page">5</em><a href="/page/6" data-phx-link="redirect"
                 data-phx-link-state="push" aria-label="Page 6" class="page-x">6</a><a href="/page/7" data-phx-link="redirect"
                 data-phx-link-state="push" aria-label="Page 7" class="page-x">7</a><a href="/page/8" data-phx-link="redirect"
                 data-phx-link-state="push" aria-label="Page 8" class="page-x">8</a><a href="/page/9" data-phx-link="redirect"
                 data-phx-link-state="push" aria-label="Page 9" class="page-x">9</a><a href="/page/10" data-phx-link="redirect"
                 data-phx-link-state="push" aria-label="Page 10" class="page-x">10</a><a href="/page/6" data-phx-link="redirect"
                 data-phx-link-state="push" aria-label="Next page" class="next_page next_page-x" rel="next">Next</a></div>
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
             <nav class="paginate-container" aria-label="A">
             <div class="pagination"><a href="/page/4" data-phx-link="redirect" data-phx-link-state="push" aria-label="D"
             class="previous_page" rel="previous">G</a><a href="/page/1" data-phx-link="redirect" data-phx-link-state="push"
             aria-label="C">1</a><a href="/page/2" data-phx-link="redirect" data-phx-link-state="push"
             aria-label="C">2</a><span class="gap">E</span><a href="/page/4" data-phx-link="redirect"
             data-phx-link-state="push" aria-label="C">4</a><em aria-current="page">5</em><a href="/page/6"
             data-phx-link="redirect" data-phx-link-state="push" aria-label="C">6</a><a href="/page/7" data-phx-link="redirect"
             data-phx-link-state="push" aria-label="C">7</a><a href="/page/8" data-phx-link="redirect"
             data-phx-link-state="push" aria-label="C">8</a><a href="/page/9" data-phx-link="redirect"
             data-phx-link-state="push" aria-label="C">9</a><a href="/page/10" data-phx-link="redirect"
             data-phx-link-state="push" aria-label="C">10</a><a href="/page/6" data-phx-link="redirect"
             data-phx-link-state="push" aria-label="B" class="next_page" rel="next">F</a></div>
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
             <nav class="paginate-container" aria-label="Navigation">
             <div class="pagination"><span class="previous_page" aria-disabled="true">Previous</span><em
             aria-current="page">1</em><a href="/page/2" data-phx-link="redirect" data-phx-link-state="replace"
             aria-label="Page 2">2</a><a href="/page/2" data-phx-link="redirect" data-phx-link-state="replace"
             aria-label="Next page" class="next_page" rel="next">Next</a></div>
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
             <nav class="paginate-container" dir="rtl" aria-label="Navigation">
             <div class="pagination"><span class="previous_page" aria-disabled="true">Previous</span><em
             aria-current="page">1</em><a href="/page/2" data-phx-link="redirect" data-phx-link-state="push"
             aria-label="Page 2">2</a><a href="/page/2" data-phx-link="redirect" data-phx-link-state="push"
             aria-label="Next page" class="next_page" rel="next">Next</a></div>
             </nav>
             """
             |> format_html()
  end
end
