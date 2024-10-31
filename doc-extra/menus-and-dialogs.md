# Menus and dialogs

- [Introduction](#introduction)
- [Usage](#usage)
- [Component structure](#component-structure)
  - [Menus](#menus)
  - [Dialogs and drawers](#dialogs-and-drawers)
- [Opening and closing](#opening-and-closing)
- [Attributes](#attributes)
  - [Appearance](#appearance)
  - [Behavior](#behavior)
- [Generated HTML](#generated-html)
- [State](#state)
  - [Conditional state](#conditional-state)
  - [Persisting dialogs and drawers](#persisting-dialogs-and-drawers)
  - [Refinements](#refinements)
  - [Status callbacks](#status-callbacks)
- [Prompt hook](#prompt-hook)
- [CSS](#css)
  - [z-index](#z-index)
  - [Customization](#customization)


## Introduction
This page explains the structure and attributes for menu and dialog components - [`action_menu`](`PrimerLive.Component.action_menu/1`), [`dropdown`](`PrimerLive.Component.dropdown/1`), [`select_menu`](`PrimerLive.Component.select_menu/1`), [`drawer`](`PrimerLive.Component.drawer/1`) and [`dialog`](`PrimerLive.Component.dialog/1`).

## Usage
To use these components, CSS and JavaScript must be installed - see [Installation](installation.md).

## Component structure

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

- `is_backdrop` - Generates a backdrop background with a default strength and tint values. Default backdrop strenght: `"medium"` for dialog and drawer; `"light"` for menus. Default backdrop tint: `"dark"`.
- `backdrop_strength` - Backdrop strenght: stronger is less transparent. Overrides the default value from `is_backdrop`.
- `backdrop_tint` - Backdrop tint: `"dark"` or `"light"`. Overrides the default value from `is_backdrop`.
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
- `show_state` - Use when the component is already displayed, and should be persisted when navigating to another LiveViews. See [Persisting dialogs and drawers](#persisting-dialogs-and-drawers) below.
- `status_callback_selector` - Receiver to get status callback events. Events are passed from the Prompt hook using `pushEventTo`.

## Generated HTML

The HTML that is generated contains these common elements:

- **Component root element:** Contains data attributes with stored `Phoenix.LiveView.JS` commands.
- **Label:** Appears when the component is a menu, created from the `toggle` slot. The label is rendered as button, and opens the menu.
- **Touch layer:** Closes the component when clicked, unless `is_modal` is used.
- **Backdrop layer:** Displayed when `is_backdrop` is used.
- **Focus wrap container:** Encapsulates the component content and includes the Escape key command, unless `is_escapable` is set to `false`.
- **Content:** Based on the content of `inner_block` and other slots and attributes.

## State

### Conditional state

Helper component `PrimerLive.StatefulConditionComponent` takes a condition and compares the initial state with the current state after a re-render. This is useful when the wrapped component should behave differently on initial mount and subsequent updates.

A practical example is to conditionally render a dialog at a specific route.

- When navigating to the route, the dialog should open with a fade-in transition.
- When loading that route directly (through a link or page refresh), the dialog should appear immediately, without any transition.

To make that happen, we can set `is_show_on_mount` to `true` only when the current route (where the dialog opens) is equal to the route the `StatefulConditionComponent` was located from the beginning.

See `PrimerLive.StatefulConditionComponent` for example code, and [primer-live.org/dialog](https://primer-live.org/dialog#conditional-dialog-show-on-mount) for a working example.

### Persisting dialogs and drawers

To keep a dialog or drawer on screen when navigating to a different LiveView (using `navigate` instead of `patch`), the component must be available on the destination route. This approach is best suited for "global" components, such as navigation panels and app header menus.

Attribute `show_state` assists in rendering the component slightly different, depending on the context.

Let's use the side drawer navigation on [primer-live.org](https://primer-live.org) as an example (accessible on smaller screens via the top-right menu button).

The drawer's `show_state` is set using the URL search param "menu":

```
menu_param = assigns.params["menu"]

show_state =
  case menu_param do
    "1" -> "onset"
    "2" -> "hold"
    _ -> "default"
end

assigns =
  assigns
  |> assign(:show_drawer, menu_param in ["1", "2"])
  |> assign(:show_state, show_state)
```

We set the drawer attributes `:if={@show_drawer}`, `is_show`, and `show_state={@show_state}`, and add `on_cancel`, which removes the URL search parameters to hide the drawer.

The top bar menu button sets the search parameter "menu=1":

- `show_state` is "onset": This intermediate state prepares for the "hold" state. It removes the `phx-remove` attribute, ensuring that navigating away doesn't trigger a close transition. Other than that, the drawer's opening behavior remains unchanged.

Drawer links set the search parameter "menu=2":

- `show_state` is "hold": This state removes the `phx-remove` attribute, as well as any opening transitions and the first focus. When navigating to a linked page, the drawer is recreated without transitions.

This will keep the drawer in place when clicking the drawer links. Closing is done by clicking outside (this uses the touch layer).

### Refinements

**Auto closing the drawer**

Clicking a link dispatches a custom event "drawer:selected" that is picked up by the app's JavaScript, which - after a delay - calls the drawer's cancel instruction.

```
# Drawer link
phx-click={JS.dispatch("drawer:selected", to: "##{drawer_id}")}
```

```js
// app.js

window.addEventListener("drawer:selected", (evt) => {
  const id = evt.target.id;
  setTimeout(() => {
    // Get a fresh reference with updated data attributes:
    const el = document.getElementById(id);
    liveSocket.execJS(el, el.dataset.cancel);
  }, 650);
});
```

**Maintaining the scroll position**

When in "hold" state, the drawer is not really persisted; with each click the drawer is recreated, losing the scroll position. Not ideal, when clicking items at the bottom of the list. We need to recreate the scroll position in JavaScript.

This is the behavior we want:

- Open the drawer (`show_state` is "onset"):
  - Restore the last stored scroll position.
  - Find the selected item an scroll the item into view (without animation).
- When clicking a link, the drawer is unmounted. We use a hook to store the scroll position at that point.

Using a hook for all these steps would be the logical choice, but the `onmount` callback turns out to be just a bit too late, resulting in a slight flickering of the drawer contents inbetween the first render and the desired scroll position.

A better choice is the "phx:page-loading-stop" event:

```js
// app.js

window.addEventListener("phx:page-loading-stop", (_info) => {
  setDrawerScrollPosition();
  window.viewReady = true;
});
```

### Status callbacks

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

The Prompt hook is used internally. The hook:

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

  /* - Dark */
  --prompt-background-color-backdrop-dark: black;
  --prompt-background-opacity-backdrop-dark-strong: 0.5;
  --prompt-background-opacity-backdrop-dark-medium: 0.2;
  --prompt-background-opacity-backdrop-dark-light: 0.07;

  /* - Light */
  --prompt-background-color-backdrop-light: white;
  --prompt-background-opacity-backdrop-light-strong: 0.9;
  --prompt-background-opacity-backdrop-light-medium: 0.7;
  --prompt-background-opacity-backdrop-light-light: 0.6;

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
