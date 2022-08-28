defmodule PrimerLive.Components.PaginationTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.LiveView.Helpers
  import Phoenix.LiveViewTest

  test "Called without options: should render an error message" do
    assigns = []

    assert rendered_to_string(~H"""
           <.pagination />
           """)
           |> format_html() ==
             """
             <div class="flash flash-error"><p>pagination component received invalid options:</p><p>current_page: can&#39;t be blank</p><p>link_path: can&#39;t be blank</p><p>page_count: can&#39;t be blank</p></div>
             """
             |> format_html()
  end

  test "With page_count 1: should not render the control" do
    assigns = []

    assert rendered_to_string(~H"""
           <.pagination page_count={1} current_page={1} link_path={&"/page/#{&1}"} />
           """)
           |> format_html() ==
             """
             """
             |> format_html()
  end

  test "With page_count 2: should render the control" do
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
             <div class="pagination">
             <span class="previous_page" aria-disabled="true">Previous</span>
             <em aria-current="page">1</em>
             <a aria-label="Page 2" data-phx-link="redirect" data-phx-link-state="push" href="/page/2">2</a>
             <a aria-label="Next page" class="next_page" data-phx-link="redirect" data-phx-link-state="push" href="/page/2"
             rel="next">Next</a>
             </div>
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
             <div class="pagination"><a aria-label="Previous page" class="previous_page" data-phx-link="redirect"
             data-phx-link-state="push" href="/page/8" rel="previous"> Previous </a><a aria-label="Page 1"
             data-phx-link="redirect" data-phx-link-state="push" href="/page/1"> 1 </a><a aria-label="Page 2"
             data-phx-link="redirect" data-phx-link-state="push" href="/page/2"> 2 </a><span class="gap">…</span><a
             aria-label="Page 8" data-phx-link="redirect" data-phx-link-state="push" href="/page/8"> 8 </a><em
             aria-current="page">9</em><a aria-label="Page 10" data-phx-link="redirect" data-phx-link-state="push"
             href="/page/10"> 10 </a><a aria-label="Page 11" data-phx-link="redirect" data-phx-link-state="push"
             href="/page/11"> 11 </a><a aria-label="Page 12" data-phx-link="redirect" data-phx-link-state="push"
             href="/page/12"> 12 </a><span class="gap">…</span><a aria-label="Page 98" data-phx-link="redirect"
             data-phx-link-state="push" href="/page/98"> 98 </a><a aria-label="Page 99" data-phx-link="redirect"
             data-phx-link-state="push" href="/page/99"> 99 </a><a aria-label="Next page" class="next_page"
             data-phx-link="redirect" data-phx-link-state="push" href="/page/10" rel="next"> Next </a></div>
             </nav>
             """
             |> format_html()
  end

  test "Option: boundary_count" do
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
             <div class="pagination"><a aria-label="Previous page" class="previous_page" data-phx-link="redirect"
             data-phx-link-state="push" href="/page/4" rel="previous"> Previous </a><a aria-label="Page 1"
             data-phx-link="redirect" data-phx-link-state="push" href="/page/1"> 1 </a><span class="gap">…</span><a
             aria-label="Page 4" data-phx-link="redirect" data-phx-link-state="push" href="/page/4"> 4 </a><em
             aria-current="page">5</em><a aria-label="Page 6" data-phx-link="redirect" data-phx-link-state="push"
             href="/page/6"> 6 </a><a aria-label="Page 7" data-phx-link="redirect" data-phx-link-state="push" href="/page/7"> 7
             </a><a aria-label="Page 8" data-phx-link="redirect" data-phx-link-state="push" href="/page/8"> 8 </a><span
             class="gap">…</span><a aria-label="Page 10" data-phx-link="redirect" data-phx-link-state="push" href="/page/10">
             10 </a><a aria-label="Next page" class="next_page" data-phx-link="redirect" data-phx-link-state="push"
             href="/page/6" rel="next"> Next </a></div>
             </nav>
             """
             |> format_html()
  end

  test "Option: sibling_count" do
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
             <div class="pagination"><a aria-label="Previous page" class="previous_page" data-phx-link="redirect"
             data-phx-link-state="push" href="/page/4" rel="previous"> Previous </a><a aria-label="Page 1"
             data-phx-link="redirect" data-phx-link-state="push" href="/page/1"> 1 </a><a aria-label="Page 2"
             data-phx-link="redirect" data-phx-link-state="push" href="/page/2"> 2 </a><span class="gap">…</span><em
             aria-current="page">5</em><a aria-label="Page 6" data-phx-link="redirect" data-phx-link-state="push"
             href="/page/6"> 6 </a><a aria-label="Page 7" data-phx-link="redirect" data-phx-link-state="push" href="/page/7"> 7
             </a><span class="gap">…</span><a aria-label="Page 9" data-phx-link="redirect" data-phx-link-state="push"
             href="/page/9"> 9 </a><a aria-label="Page 10" data-phx-link="redirect" data-phx-link-state="push" href="/page/10">
             10 </a><a aria-label="Next page" class="next_page" data-phx-link="redirect" data-phx-link-state="push"
             href="/page/6" rel="next"> Next </a></div>
             </nav>
             """
             |> format_html()
  end

  test "Option: is_numbered" do
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
             <div class="pagination"><a aria-label="Previous page" class="previous_page" data-phx-link="redirect"
             data-phx-link-state="push" href="/page/4" rel="previous"> Previous </a><a aria-label="Next page" class="next_page"
             data-phx-link="redirect" data-phx-link-state="push" href="/page/6" rel="next"> Next </a></div>
             </nav>
             """
             |> format_html()
  end

  test "Option: class" do
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
             aria-current="page">1</em><a aria-label="Page 2" data-phx-link="redirect" data-phx-link-state="push"
             href="/page/2"> 2 </a><a aria-label="Next page" class="next_page" data-phx-link="redirect"
             data-phx-link-state="push" href="/page/2" rel="next"> Next </a></div>
             </nav>
             """
             |> format_html()
  end

  test "Option: classes" do
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
             <div class="pagination pagination-x"><a aria-label="Previous page" class="previous_page previous_page-x"
             data-phx-link="redirect" data-phx-link-state="push" href="/page/4" rel="previous"> Previous </a><a
             aria-label="Page 1" class="page-x" data-phx-link="redirect" data-phx-link-state="push" href="/page/1"> 1 </a><a
             aria-label="Page 2" class="page-x" data-phx-link="redirect" data-phx-link-state="push" href="/page/2"> 2 </a><span
             class="gap gap-x">…</span><a aria-label="Page 4" class="page-x" data-phx-link="redirect"
             data-phx-link-state="push" href="/page/4"> 4 </a><em aria-current="page">5</em><a aria-label="Page 6"
             class="page-x" data-phx-link="redirect" data-phx-link-state="push" href="/page/6"> 6 </a><a aria-label="Page 7"
             class="page-x" data-phx-link="redirect" data-phx-link-state="push" href="/page/7"> 7 </a><a aria-label="Page 8"
             class="page-x" data-phx-link="redirect" data-phx-link-state="push" href="/page/8"> 8 </a><a aria-label="Page 9"
             class="page-x" data-phx-link="redirect" data-phx-link-state="push" href="/page/9"> 9 </a><a aria-label="Page 10"
             class="page-x" data-phx-link="redirect" data-phx-link-state="push" href="/page/10"> 10 </a><a
             aria-label="Next page" class="next_page next_page-x" data-phx-link="redirect" data-phx-link-state="push"
             href="/page/6" rel="next"> Next </a></div>
             </nav>
             """
             |> format_html()
  end

  test "Option: labels" do
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
             <div class="pagination"><a aria-label="D" class="previous_page" data-phx-link="redirect" data-phx-link-state="push"
                 href="/page/4" rel="previous"> G </a><a aria-label="C" data-phx-link="redirect" data-phx-link-state="push"
                 href="/page/1">1</a><a aria-label="C" data-phx-link="redirect" data-phx-link-state="push"
                 href="/page/2">2</a><span class="gap">E</span><a aria-label="C" data-phx-link="redirect"
                 data-phx-link-state="push" href="/page/4">4</a><em aria-current="page">5</em><a aria-label="C"
                 data-phx-link="redirect" data-phx-link-state="push" href="/page/6">6</a><a aria-label="C" data-phx-link="redirect"
                 data-phx-link-state="push" href="/page/7">7</a><a aria-label="C" data-phx-link="redirect"
                 data-phx-link-state="push" href="/page/8">8</a><a aria-label="C" data-phx-link="redirect"
                 data-phx-link-state="push" href="/page/9">9</a><a aria-label="C" data-phx-link="redirect"
                 data-phx-link-state="push" href="/page/10">10</a><a aria-label="B" class="next_page" data-phx-link="redirect"
                 data-phx-link-state="push" href="/page/6" rel="next"> F </a></div>
             </nav>
             """
             |> format_html()
  end

  test "Option: link_options" do
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
                 aria-current="page">1</em><a aria-label="Page 2" data-phx-link="redirect" data-phx-link-state="replace"
                 href="/page/2" replace> 2 </a><a aria-label="Next page" class="next_page" data-phx-link="redirect"
                 data-phx-link-state="replace" href="/page/2" rel="next" replace> Next </a></div>
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
             aria-current="page">1</em><a aria-label="Page 2" data-phx-link="redirect" data-phx-link-state="push"
             href="/page/2"> 2 </a><a aria-label="Next page" class="next_page" data-phx-link="redirect"
             data-phx-link-state="push" href="/page/2" rel="next"> Next </a></div>
             </nav>
             """
             |> format_html()
  end
end
