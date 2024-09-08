defmodule PrimerLive.Components.BlankslateTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Render component" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.blankslate />
           """)
           |> format_html() ==
             """
             <div class="blankslate"></div>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Slot: inner_block" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.blankslate>
             <p>Use it to provide information when no dynamic content exists.</p>
           </.blankslate>
           """)
           |> format_html() ==
             """
             <div class="blankslate">
             <p>Use it to provide information when no dynamic content exists.</p>
             </div>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Slot: heading" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.blankslate>
             <:heading>
               This is a blank slate
             </:heading>
           </.blankslate>
           """)
           |> format_html() ==
             """
             <div class="blankslate">
             <h3 class="blankslate-heading">This is a blank slate</h3>
             </div>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Slot: heading with attr tag" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.blankslate>
             <:heading tag="h2">
               This is a blank slate
             </:heading>
           </.blankslate>
           """)
           |> format_html() ==
             """
             <div class="blankslate">
             <h2 class="blankslate-heading">This is a blank slate</h2>
             </div>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Slot: octicon" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.blankslate>
             <:octicon name="rocket-24" />
           </.blankslate>
           """)
           |> format_html() ==
             """
             <div class="blankslate">
             <svg class="octicon blankslate-icon" xmlns="http://www.w3.org/2000/svg" width="24" height="24"
             viewBox="0 0 24 24">
             <path fill-rule="evenodd"
             d="M20.322.75a10.75 10.75 0 00-7.373 2.926l-1.304 1.23A23.743 23.743 0 0010.103 6.5H5.066a1.75 1.75 0 00-1.5.85l-2.71 4.514a.75.75 0 00.49 1.12l4.571.963c.039.049.082.096.129.14L8.04 15.96l1.872 1.994c.044.047.091.09.14.129l.963 4.572a.75.75 0 001.12.488l4.514-2.709a1.75 1.75 0 00.85-1.5v-5.038a23.741 23.741 0 001.596-1.542l1.228-1.304a10.75 10.75 0 002.925-7.374V2.499A1.75 1.75 0 0021.498.75h-1.177zM16 15.112c-.333.248-.672.487-1.018.718l-3.393 2.262.678 3.223 3.612-2.167a.25.25 0 00.121-.214v-3.822zm-10.092-2.7L8.17 9.017c.23-.346.47-.685.717-1.017H5.066a.25.25 0 00-.214.121l-2.167 3.612 3.223.679zm8.07-7.644a9.25 9.25 0 016.344-2.518h1.177a.25.25 0 01.25.25v1.176a9.25 9.25 0 01-2.517 6.346l-1.228 1.303a22.248 22.248 0 01-3.854 3.257l-3.288 2.192-1.743-1.858a.764.764 0 00-.034-.034l-1.859-1.744 2.193-3.29a22.248 22.248 0 013.255-3.851l1.304-1.23zM17.5 8a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0zm-11 13c.9-.9.9-2.6 0-3.5-.9-.9-2.6-.9-3.5 0-1.209 1.209-1.445 3.901-1.49 4.743a.232.232 0 00.247.247c.842-.045 3.534-.281 4.743-1.49z">
             </path>
             </svg>
             </div>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Slot: img" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.blankslate>
             <:img src="https://ghicons.github.com/assets/images/blue/png/Pull%20request.png" alt="" />
           </.blankslate>
           """)
           |> format_html() ==
             """
             <div class="blankslate"><img alt="" class="blankslate-image"
             src="https://ghicons.github.com/assets/images/blue/png/Pull%20request.png" /></div>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Slot: action" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.blankslate>
             <:action>
               <.button is_primary>New project</.button>
             </:action>
             <:action>
               <.button is_link>Learn more</.button>
             </:action>
           </.blankslate>
           """)
           |> format_html() ==
             """
             <div class="blankslate">
             <div class="blankslate-action"><button class="btn btn-primary" type="button"><span class="pl-button__content">New project</span></button></div>
             <div class="blankslate-action"><button class="btn-link" type="button"><span class="pl-button__content">Learn more</span></button></div>
             </div>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Attributes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.blankslate is_narrow />
           <.blankslate is_large />
           <.blankslate is_spacious />
           """)
           |> format_html() ==
             """
             <div class="blankslate blankslate-narrow"></div>
             <div class="blankslate blankslate-large"></div>
             <div class="blankslate blankslate-spacious"></div>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Classes" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.blankslate
             class="my-blankslate"
             classes={
               %{
                 blankslate: "blankslate-x",
                 octicon: "octicon-x",
                 img: "img-x",
                 heading: "heading-x",
                 action: "action-x"
               }
             }
           >
             <:heading class="my-heading">
               This is a blank slate
             </:heading>
             <:octicon name="rocket-24" class="my-octicon" />
             <:img
               src="https://ghicons.github.com/assets/images/blue/png/Pull%20request.png"
               alt=""
               class="my-img"
             />
             <:action class="my-action">
               <.button is_primary>New project</.button>
             </:action>
             <p>Use it to provide information when no dynamic content exists.</p>
           </.blankslate>
           """)
           |> format_html() ==
             """
             <div class="blankslate blankslate-x my-blankslate"><svg class="octicon blankslate-icon octicon-x my-octicon"
             xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">STRIPPED_SVG_PATHS</svg><img alt=""
             class="blankslate-image img-x my-img" src="https://ghicons.github.com/assets/images/blue/png/Pull%20request.png" />
             <h3 class="blankslate-heading heading-x my-heading">This is a blank slate</h3>
             <p>Use it to provide information when no dynamic content exists.</p>
             <div class="blankslate-action action-x my-action"><button class="btn btn-primary" type="button"><span class="pl-button__content">New project</span></button>
             </div>
             </div>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end

  test "Attribute: style" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.blankslate style="border: 1px solid red;" />
           """)
           |> format_html() ==
             """
             <div class="blankslate" style="border: 1px solid red;"></div>
             """
             |> format_html()
  rescue
    e in ExUnit.AssertionError ->
      %{expr: {:assert, [line: line], _}} = e
      to_file(e.left, __ENV__.file, line + 2)
      reraise e, __STACKTRACE__
  end
end
