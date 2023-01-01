defmodule PrimerLive.TestComponents.ActionMenuTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Basic" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_menu>
             <:toggle>Menu</:toggle>
             <.action_list>
               <.action_list_item>
                 One
               </.action_list_item>
               <.action_list_item>
                 Two
               </.action_list_item>
               <.action_list_item>
                 Three
               </.action_list_item>
             </.action_list>
           </.action_menu>
           """)
           |> format_html() ==
             """
             <details class="details-reset details-overlay" data-prompt="" ontoggle="window.Prompt &amp;&amp; Prompt.init(this)">
             <summary class="btn" aria-haspopup="true">Menu</summary>
             <div data-touch=""></div>
             <div class="ActionMenu">
             <div class="ActionMenu-modal" data-content="" aria-role="menu">
             <div class="SelectMenu-list">
             <ul class="ActionList" role="listbox">
             <li class="ActionList-item"><span class="ActionList-content"><span class="ActionList-item-label">One</span></span></li>
             <li class="ActionList-item"><span class="ActionList-content"><span class="ActionList-item-label">Two</span></span></li>
             <li class="ActionList-item"><span class="ActionList-content"><span class="ActionList-item-label">Three</span></span></li>
             </ul>
             </div>
             </div>
             </div>
             </details>
             """
             |> format_html()
  end

  test "With single select" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_menu is_dropdown_caret>
             <:toggle><.octicon name="number-16" /><span>Number</span></:toggle>
             <.action_list>
               <.action_list_item is_single_select>
                 <.octicon name="typography-16" /><span>Text</span>
               </.action_list_item>
               <.action_list_item is_single_select is_selected>
                 <.octicon name="number-16" /><span>Number</span>
               </.action_list_item>
               <.action_list_item is_single_select>
                 <.octicon name="calendar-16" /><span>Calendar</span>
               </.action_list_item>
               <.action_list_item is_single_select>
                 <.octicon name="iterations-16" /><span>Iteration</span>
               </.action_list_item>
             </.action_list>
           </.action_menu>
           """)
           |> format_html() ==
             """
             <details class="details-reset details-overlay" data-prompt="" ontoggle="window.Prompt &amp;&amp; Prompt.init(this)">
             <summary class="btn" aria-haspopup="true"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">
             <path fill-rule="evenodd"
             d="M5.604.089A.75.75 0 016 .75v4.77h.711a.75.75 0 110 1.5H3.759a.75.75 0 110-1.5H4.5V2.15l-.334.223a.75.75 0 01-.832-1.248l1.5-1a.75.75 0 01.77-.037zM9 4.75A.75.75 0 019.75 4h4a.75.75 0 01.53 1.28l-1.89 1.892c.312.076.604.18.867.319.742.391 1.244 1.063 1.244 2.005 0 .653-.231 1.208-.629 1.627-.386.408-.894.653-1.408.777-1.01.243-2.225.063-3.124-.527a.75.75 0 01.822-1.254c.534.35 1.32.474 1.951.322.306-.073.53-.201.67-.349.129-.136.218-.32.218-.596 0-.308-.123-.509-.444-.678-.373-.197-.98-.318-1.806-.318a.75.75 0 01-.53-1.28l1.72-1.72H9.75A.75.75 0 019 4.75zm-3.587 5.763c-.35-.05-.77.113-.983.572a.75.75 0 11-1.36-.632c.508-1.094 1.589-1.565 2.558-1.425 1 .145 1.872.945 1.872 2.222 0 1.433-1.088 2.192-1.79 2.681-.308.216-.571.397-.772.573H7a.75.75 0 010 1.5H3.75a.75.75 0 01-.75-.75c0-.69.3-1.211.67-1.61.348-.372.8-.676 1.15-.92.8-.56 1.18-.904 1.18-1.474 0-.473-.267-.69-.587-.737z">
             </path>
             </svg><span>Number</span>
             <div class="dropdown-caret"></div>
             </summary>
             <div data-touch=""></div>
             <div class="ActionMenu">
             <div class="ActionMenu-modal" data-content="" aria-role="menu">
             <div class="SelectMenu-list">
             <ul class="ActionList" role="listbox">
             <li class="ActionList-item" aria-selected="false" role="option"><span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><svg width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"
                  focusable="false" class="ActionList-item-singleSelectCheckmark">
                  <path fill-rule="evenodd" clip-rule="evenodd"
                    d="M13.7799 4.22001C13.9203 4.36063 13.9992 4.55126 13.9992 4.75001C13.9992 4.94876 13.9203 5.13938 13.7799 5.28001L6.52985 12.53C6.38922 12.6704 6.1986 12.7493 5.99985 12.7493C5.8011 12.7493 5.61047 12.6704 5.46985 12.53L2.21985 9.28001C2.08737 9.13783 2.01525 8.94979 2.01867 8.75548C2.0221 8.56118 2.10081 8.3758 2.23823 8.23838C2.37564 8.10097 2.56103 8.02226 2.75533 8.01883C2.94963 8.0154 3.13767 8.08753 3.27985 8.22001L5.99985 10.94L12.7199 4.22001C12.8605 4.07956 13.0511 4.00067 13.2499 4.00067C13.4486 4.00067 13.6393 4.07956 13.7799 4.22001Z"
                    fill="#24292F"></path>
                </svg></span><span class="ActionList-item-label"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">
                  <path fill-rule="evenodd"
                    d="M6.21 8.5L4.574 3.594 2.857 8.5H6.21zm.5 1.5l.829 2.487a.75.75 0 001.423-.474L5.735 2.332a1.216 1.216 0 00-2.302-.018l-3.39 9.688a.75.75 0 001.415.496L2.332 10H6.71zm3.13-4.358C10.53 4.374 11.87 4 13 4c1.5 0 3 .939 3 2.601v5.649a.75.75 0 01-1.448.275C13.995 12.82 13.3 13 12.5 13c-.77 0-1.514-.231-2.078-.709-.577-.488-.922-1.199-.922-2.041 0-.694.265-1.411.887-1.944C11 7.78 11.88 7.5 13 7.5h1.5v-.899c0-.54-.5-1.101-1.5-1.101-.869 0-1.528.282-1.84.858a.75.75 0 11-1.32-.716zM14.5 9H13c-.881 0-1.375.22-1.637.444-.253.217-.363.5-.363.806 0 .408.155.697.39.896.249.21.63.354 1.11.354.732 0 1.26-.209 1.588-.449.35-.257.412-.495.412-.551V9z">
                  </path>
                </svg><span>Text</span></span></span></li>
             <li class="ActionList-item" aria-selected="true" role="option"><span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><svg width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"
                  focusable="false" class="ActionList-item-singleSelectCheckmark">
                  <path fill-rule="evenodd" clip-rule="evenodd"
                    d="M13.7799 4.22001C13.9203 4.36063 13.9992 4.55126 13.9992 4.75001C13.9992 4.94876 13.9203 5.13938 13.7799 5.28001L6.52985 12.53C6.38922 12.6704 6.1986 12.7493 5.99985 12.7493C5.8011 12.7493 5.61047 12.6704 5.46985 12.53L2.21985 9.28001C2.08737 9.13783 2.01525 8.94979 2.01867 8.75548C2.0221 8.56118 2.10081 8.3758 2.23823 8.23838C2.37564 8.10097 2.56103 8.02226 2.75533 8.01883C2.94963 8.0154 3.13767 8.08753 3.27985 8.22001L5.99985 10.94L12.7199 4.22001C12.8605 4.07956 13.0511 4.00067 13.2499 4.00067C13.4486 4.00067 13.6393 4.07956 13.7799 4.22001Z"
                    fill="#24292F"></path>
                </svg></span><span class="ActionList-item-label"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">
                  <path fill-rule="evenodd"
                    d="M5.604.089A.75.75 0 016 .75v4.77h.711a.75.75 0 110 1.5H3.759a.75.75 0 110-1.5H4.5V2.15l-.334.223a.75.75 0 01-.832-1.248l1.5-1a.75.75 0 01.77-.037zM9 4.75A.75.75 0 019.75 4h4a.75.75 0 01.53 1.28l-1.89 1.892c.312.076.604.18.867.319.742.391 1.244 1.063 1.244 2.005 0 .653-.231 1.208-.629 1.627-.386.408-.894.653-1.408.777-1.01.243-2.225.063-3.124-.527a.75.75 0 01.822-1.254c.534.35 1.32.474 1.951.322.306-.073.53-.201.67-.349.129-.136.218-.32.218-.596 0-.308-.123-.509-.444-.678-.373-.197-.98-.318-1.806-.318a.75.75 0 01-.53-1.28l1.72-1.72H9.75A.75.75 0 019 4.75zm-3.587 5.763c-.35-.05-.77.113-.983.572a.75.75 0 11-1.36-.632c.508-1.094 1.589-1.565 2.558-1.425 1 .145 1.872.945 1.872 2.222 0 1.433-1.088 2.192-1.79 2.681-.308.216-.571.397-.772.573H7a.75.75 0 010 1.5H3.75a.75.75 0 01-.75-.75c0-.69.3-1.211.67-1.61.348-.372.8-.676 1.15-.92.8-.56 1.18-.904 1.18-1.474 0-.473-.267-.69-.587-.737z">
                  </path>
                </svg><span>Number</span></span></span></li>
             <li class="ActionList-item" aria-selected="false" role="option"><span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><svg width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"
                  focusable="false" class="ActionList-item-singleSelectCheckmark">
                  <path fill-rule="evenodd" clip-rule="evenodd"
                    d="M13.7799 4.22001C13.9203 4.36063 13.9992 4.55126 13.9992 4.75001C13.9992 4.94876 13.9203 5.13938 13.7799 5.28001L6.52985 12.53C6.38922 12.6704 6.1986 12.7493 5.99985 12.7493C5.8011 12.7493 5.61047 12.6704 5.46985 12.53L2.21985 9.28001C2.08737 9.13783 2.01525 8.94979 2.01867 8.75548C2.0221 8.56118 2.10081 8.3758 2.23823 8.23838C2.37564 8.10097 2.56103 8.02226 2.75533 8.01883C2.94963 8.0154 3.13767 8.08753 3.27985 8.22001L5.99985 10.94L12.7199 4.22001C12.8605 4.07956 13.0511 4.00067 13.2499 4.00067C13.4486 4.00067 13.6393 4.07956 13.7799 4.22001Z"
                    fill="#24292F"></path>
                </svg></span><span class="ActionList-item-label"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">
                  <path fill-rule="evenodd"
                    d="M4.75 0a.75.75 0 01.75.75V2h5V.75a.75.75 0 011.5 0V2h1.25c.966 0 1.75.784 1.75 1.75v10.5A1.75 1.75 0 0113.25 16H2.75A1.75 1.75 0 011 14.25V3.75C1 2.784 1.784 2 2.75 2H4V.75A.75.75 0 014.75 0zm0 3.5h8.5a.25.25 0 01.25.25V6h-11V3.75a.25.25 0 01.25-.25h2zm-2.25 4v6.75c0 .138.112.25.25.25h10.5a.25.25 0 00.25-.25V7.5h-11z">
                  </path>
                </svg><span>Calendar</span></span></span></li>
             <li class="ActionList-item" aria-selected="false" role="option"><span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><svg width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"
                  focusable="false" class="ActionList-item-singleSelectCheckmark">
                  <path fill-rule="evenodd" clip-rule="evenodd"
                    d="M13.7799 4.22001C13.9203 4.36063 13.9992 4.55126 13.9992 4.75001C13.9992 4.94876 13.9203 5.13938 13.7799 5.28001L6.52985 12.53C6.38922 12.6704 6.1986 12.7493 5.99985 12.7493C5.8011 12.7493 5.61047 12.6704 5.46985 12.53L2.21985 9.28001C2.08737 9.13783 2.01525 8.94979 2.01867 8.75548C2.0221 8.56118 2.10081 8.3758 2.23823 8.23838C2.37564 8.10097 2.56103 8.02226 2.75533 8.01883C2.94963 8.0154 3.13767 8.08753 3.27985 8.22001L5.99985 10.94L12.7199 4.22001C12.8605 4.07956 13.0511 4.00067 13.2499 4.00067C13.4486 4.00067 13.6393 4.07956 13.7799 4.22001Z"
                    fill="#24292F"></path>
                </svg></span><span class="ActionList-item-label"><svg class="octicon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">
                  <path d="M2.5 7.25a4.75 4.75 0 019.5 0 .75.75 0 001.5 0 6.25 6.25 0 10-6.25 6.25H12v2.146c0 .223.27.335.427.177l2.896-2.896a.25.25 0 000-.354l-2.896-2.896a.25.25 0 00-.427.177V12H7.25A4.75 4.75 0 012.5 7.25z"></path>
                </svg><span>Iteration</span></span></span></li>
             </ul>
             </div>
             </div>
             </div>
             </details>
             """
             |> format_html()
  end

  test "With multiple select" do
    assigns = %{}

    assert rendered_to_string(~H"""
           <.action_menu is_dropdown_caret>
             <:toggle>
               Select
               <.counter>2</.counter>
             </:toggle>
             <.action_list>
               <.action_list_item is_multiple_select is_selected>
                 Option
               </.action_list_item>
               <.action_list_item is_multiple_select is_selected>
                 Option
               </.action_list_item>
               <.action_list_item is_multiple_select>
                 Option
               </.action_list_item>
             </.action_list>
           </.action_menu>
           """)
           |> format_html() ==
             """
             <details class="details-reset details-overlay" data-prompt="" ontoggle="window.Prompt &amp;&amp; Prompt.init(this)">
             <summary class="btn" aria-haspopup="true">Select<span class="Counter">2</span>
             <div class="dropdown-caret"></div>
             </summary>
             <div data-touch=""></div>
             <div class="ActionMenu">
             <div class="ActionMenu-modal" data-content="" aria-role="menu">
             <div class="SelectMenu-list">
             <ul class="ActionList" role="listbox">
             <li class="ActionList-item" aria-selected="true" role="option"><span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><svg width="16" height="16" viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false"
                  class="ActionList-item-multiSelectIcon">
                  <rect x="2" y="2" width="12" height="12" rx="4" class="ActionList-item-multiSelectIconRect"></rect>
                  <path fill-rule="evenodd"
                    d="M4.03231 8.69862C3.84775 8.20646 4.49385 7.77554 4.95539 7.77554C5.41693 7.77554 6.80154 9.85246 6.80154 9.85246C6.80154 9.85246 10.2631 4.314 10.4938 4.08323C10.7246 3.85246 11.8785 4.08323 11.4169 5.00631C11.0081 5.82388 7.26308 11.4678 7.26308 11.4678C7.26308 11.4678 6.80154 12.1602 6.34 11.4678C5.87846 10.7755 4.21687 9.19077 4.03231 8.69862Z"
                    class="ActionList-item-multiSelectCheckmark"></path>
                </svg></span><span class="ActionList-item-label">Option</span></span></li>
             <li class="ActionList-item" aria-selected="true" role="option"><span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><svg width="16" height="16" viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false"
                  class="ActionList-item-multiSelectIcon">
                  <rect x="2" y="2" width="12" height="12" rx="4" class="ActionList-item-multiSelectIconRect"></rect>
                  <path fill-rule="evenodd"
                    d="M4.03231 8.69862C3.84775 8.20646 4.49385 7.77554 4.95539 7.77554C5.41693 7.77554 6.80154 9.85246 6.80154 9.85246C6.80154 9.85246 10.2631 4.314 10.4938 4.08323C10.7246 3.85246 11.8785 4.08323 11.4169 5.00631C11.0081 5.82388 7.26308 11.4678 7.26308 11.4678C7.26308 11.4678 6.80154 12.1602 6.34 11.4678C5.87846 10.7755 4.21687 9.19077 4.03231 8.69862Z"
                    class="ActionList-item-multiSelectCheckmark"></path>
                </svg></span><span class="ActionList-item-label">Option</span></span></li>
             <li class="ActionList-item" aria-selected="false" role="option"><span class="ActionList-content"><span class="ActionList-item-visual ActionList-item-visual--leading"><svg width="16" height="16" viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false"
                  class="ActionList-item-multiSelectIcon">
                  <rect x="2" y="2" width="12" height="12" rx="4" class="ActionList-item-multiSelectIconRect"></rect>
                  <path fill-rule="evenodd"
                    d="M4.03231 8.69862C3.84775 8.20646 4.49385 7.77554 4.95539 7.77554C5.41693 7.77554 6.80154 9.85246 6.80154 9.85246C6.80154 9.85246 10.2631 4.314 10.4938 4.08323C10.7246 3.85246 11.8785 4.08323 11.4169 5.00631C11.0081 5.82388 7.26308 11.4678 7.26308 11.4678C7.26308 11.4678 6.80154 12.1602 6.34 11.4678C5.87846 10.7755 4.21687 9.19077 4.03231 8.69862Z"
                    class="ActionList-item-multiSelectCheckmark"></path>
                </svg></span><span class="ActionList-item-label">Option</span></span></li>
             </ul>
             </div>
             </div>
             </div>
             </details>
             """
             |> format_html()
  end
end
