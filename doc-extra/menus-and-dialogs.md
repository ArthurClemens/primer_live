# Menus and dialogs

- [Usage](#usage)
  - [Menus](#menus)
  - [Dialogs and drawers](#dialogs-and-drawers)
- [Opening and closing](#opening-and-closing)
- [Attributes](#attributes)
  - [Appearance](#appearance)
  - [Behavior](#behavior)
- [Generated HTML](#generated-html)
- [Conditional state](#conditional-state)
- [Status callbacks](#status-callbacks)
- [Prompt hook](#prompt-hook)
- [CSS](#css)
  - [z-index](#z-index)
  - [Customization](#customization)

## Usage

Menu and dialog components - [`action_menu`](`PrimerLive.Component.action_menu/1`), [`dropdown`](`PrimerLive.Component.dropdown/1`), [`select_menu`](`PrimerLive.Component.select_menu/1`), [`drawer`](`PrimerLive.Component.drawer/1`) and [`dialog`](`PrimerLive.Component.dialog/1`) - share common interaction.

To use these components, CSS and JavaScript must be installed - see [Installation](installation.md).

### Menus

Menus are created with 3 elements: the component wrapper, a toggle button and the menu contents. For example for a dropdown menu:

```
<.dropdown>
  <:toggle>Menu</:toggle>
  Content
</.dropdown>
```

The toggle slot is required for menus. It generates a toggle element (default with button appearance) using the slot content as label.

### Dialogs and drawers

With dialogs and drawers, the toggle element not used as these are usually opened from the outside.

```
<.dialog id="my-dialog">
  <:header_title>Title</:header_title>
  <:body>
    Content
  </:body>
</.dialog>
```

## Opening and closing

- Menus can be opened using the label button created from the `toggle` slot.
- All components can be conditionally opened with `is_open` in combination with Phoenix's `:if` attribute.
- All components can be opened and closed with `open`, `close` and `toggle` functions - (`open_dialog` for dialogs, and so on).

See component documentation for details.

## Attributes

The following attributes are common for all menus and dialogs.

### Appearance

- `is_backdrop` - Generates a backdrop background (default with medium darkness).
- `is_dark_backdrop` - Generates a darker backdrop background color.
- `is_medium_backdrop` - Generates a medium backdrop background color.
- `is_light_backdrop` - Generates a lighter backdrop background color. Default for menus.
- `transition_duration` - The number of milliseconds to fade-in/out the backdrop and content. Adds a CSS style attribute to component HTML.
- `is_fast` - Generates fast fade transitions for backdrop and content.
- `is_dropdown_caret` - For menus: adds a dropdown caret to the toggle button.

### Behavior

- `id` - Used for opening and closing from the outside. Required for `dialog` and `drawer`.
- `is_escapable` - Closes the content when the Escape key is pressed. Default true; set to false to prevent this. When components are stacked (for example a confirmation dialog is shown above a base dialog), Escape will close them one by one.
- `focus_after_opening_selector` - By default, the first interactive element gets focus after opening the component. Use to set focus to a different element after opening.
- `focus_after_closing_selector` - Returns focus to the specified element after closing the component.
- `on_cancel` - `Phoenix.LiveView.JS` command to configure the closing/cancel event of the component, for example: `on_cancel={JS.navigate(~p"/posts")}`.
- `is_show` - Sets the display state of the component. Control conditional display by using Phoenix's `:if` attribute.
- `is_show_on_mount` - Displays the component on mount without fade-in transition. Control conditional display by using Phoenix's `:if` attribute. See [Conditional state](#conditional-state) below for details.
- `show_state` - Use when the component is already displayed, and should be persisted when navigating to another LiveViews (for example to hide the component with a transition after having navigated to a new route). This method does require that the component is available on the other LiveView page, so it is best suited for "global" components such as navigation panels and app header menus.
- `status_callback_selector` - Receiver to get status callback events. Events are passed from the Prompt hook using `pushEventTo`.

## Generated HTML

The HTML that is generated contains these common elements:

- **Component root element:** Contains data attributes with stored `Phoenix.LiveView.JS` commands.
- **Label:** Appears when the component is a menu, created from the `toggle` slot. The label is rendered as button, and opens the menu.
- **Touch layer:** Closes the component when clicked, unless `is_modal` is used.
- **Backdrop layer:** Displayed when `is_backdrop` is used.
- **Focus wrap container:** Encapsulates the component content and includes the Escape key command, unless `is_escapable` is set to `false`.
- **Content:** Based on the content of `inner_block` and other slots and attributes.

## Conditional state

Helper component `PrimerLive.StatefulConditionComponent` takes a condition and compares the initial state with the current state after a re-render. This is useful when the wrapped component should behave differently on initial mount and subsequent updates.

A practical example is to conditionally render a dialog at a specific route.

- When navigating to the route, the dialog should open with a fade-in transition.
- When loading that route directly (through a link or page refresh), the dialog should appear immediately, without any transition.

To make that happen, we can set `is_show_on_mount` to `true` only when the current route (where the dialog opens) is equal to the route the `StatefulConditionComponent` was located from the beginning.

See `PrimerLive.StatefulConditionComponent` for example code, and [primer-live.org/dialog](https://primer-live.org/dialog#conditional-dialog-show-on-mount) for a working example.

## Status callbacks

The opened/closed status of the component can be read using attribute `status_callback_selector` and a LiveComponent that listens for the `"primer_live:prompt"` event.

```
<.live_component id="status_event_component" module={MyAppWeb.StatusEventComponent} />

<.button phx-click={open_dialog("my-dialog")}>Open</.button>

<.dialog id="my-dialog" status_callback_selector="#status_events">
  <:body>Body</:body>
</.dialog>
```

**Example event listener LiveComponent:**

```
defmodule MyAppWeb.StatusEventComponent do
  @moduledoc false
  use MyAppWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div id="status_events">
      <p>Status: <%= @status %></p>
    </div>
    """
  end

  @impl true
  def update(assigns, socket) do
    socket =
      socket
      |> assign(assigns)
      |> assign(:status, "initial")

    {:ok, socket}
  end

  @impl true
  def handle_event("primer_live:prompt", %{"elementId" => prompt_id, "status" => status}, socket)
      when prompt_id == "my-dialog" do
    socket =
      socket
      |> assign(:status, status)

    {:noreply, socket}
  end

end

```

## Prompt hook

The Prompt hook does not expose an API because it operates under the hood.

Functionality:

- Listens for server commands `prompt:open`, `prompt:close` and `prompt:toggle` (enabling the toggle function).
- Sends status event `"primer_live:prompt"` to the server.
- Intercepts the Escape key event to close components one by one.

## CSS

### z-index

Commonly, menu panels are placed close to the page content, while dialogs and drawers are stacked above everything else (except for notifications).

When scrolling the page with a menu panel open, a top bar / app header should cover the menu panel. Using a `z-index` of `100` for a the app header ensures that it sits in between menus and dialogs/drawers. See the default values below for reference.

### Customization

Styles can be modified by overriding default Custom Variables, for example by giving it a higher specificity.

Example:

```css
/* App CSS */

.admin-pages [data-prompt] {
  --prompt-drawer-content-width: 22ch;
}
```

**Default Custom Variables**

```css
[data-prompt] {
  /* Colors and opacity */
  --prompt-background-color-backdrop: black;
  --prompt-background-opacity-backdrop-dark: 0.5;
  --prompt-background-opacity-backdrop-medium: 0.2;
  --prompt-background-opacity-backdrop-light: 0.07;

  /* Transitions */
  --prompt-transition-timing-function: ease-in-out;
  --prompt-transition-duration: 170ms;
  --prompt-fast-transition-duration: 130ms;

  /* Stacking z-index */

  /* - Menus */
  --prompt-z-index-menu-backdrop: 40;
  --prompt-z-index-menu-touch: 41;
  --prompt-z-index-menu-focus-wrap: 42;
  --prompt-z-index-menu-content: 50;

  /* - Dialog and drawer */
  --prompt-z-index-backdrop: 190;
  --prompt-z-index-touch: 191;
  --prompt-z-index-focus-wrap: 192;
  --prompt-z-index-drawer-content: 200;
  --prompt-z-index-dialog-content: 300;

  /* Sizes */

  /* - Dialog max height */
  --prompt-max-height-content: 80;

  /* - Drawer width: defined by child content width */
  --prompt-drawer-content-width: initial;

  /* - Push drawer width */
  --push-drawer-width: 320px;
}
```
