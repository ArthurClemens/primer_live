# Menus and dialogs

Menu and dialog components - [`action_menu`](`PrimerLive.Component.action_menu/1`), [`dropdown`](`PrimerLive.Component.dropdown/1`), [`select_menu`](`PrimerLive.Component.select_menu/1`), [`drawer`](`PrimerLive.Component.drawer/1`) and [`dialog`](`PrimerLive.Component.dialog/1`) - share common interaction and appearance.

To use these components, CSS and JavaScript hook must be installed - see [Installation](installation.md).

## Usage

Menus are created with 3 elements: the component wrapper, a toggle button and the menu contents. For example for a dropdown menu:

```
<.dropdown>
  <:toggle>Menu</:toggle>
  <:item href="#url">Item 1</:item>
  <:item href="#url">Item 2</:item>
</.dropdown>
```

With dialogs and drawers, the toggle element is omitted - they are usually opened from the outside.

```
<.dialog>
  <:header_title>Title</:header_title>
  <:body>
    Content
  </:body>
</.dialog>
```

### Attrs

The following (optional) attributes are common for all menus and dialogs.

- `is_backdrop` - Generates a backdrop background (default with medium darkness).
- `is_light_backdrop` - Generates a light backdrop background color.
- `is_medium_backdrop` - Generates a medium backdrop background color.
- `is_dark_backdrop` - Generates a dark backdrop background color.
- `is_dropdown_caret` - Adds a dropdown caret to the prompt button.
- `is_fast` - Generates fast fade transitions for backdrop and content.
- `prompt_options` - JavaScript state callback functions.
- `id` - Element id. Use to toggle from the outside, and to get consistent IDs in tests.
- `form` - The surrounding form, if any.
- `field` - See below at [Maintaining state in forms](#maintaining-state-in-forms).

Dialog and drawer specific:

- `is_modal` - Generates a modal dialog/drawer; clicking the backdrop (if used) or outside of the dialog/drawer will not close it.
- `is_escapable` - Closes the content when pressing the Escape key.
- `focus_first` - Focus the first element after opening dialog/drawer. Pass a selector to match the element.

### Slots

The toggle slot is required for menus.

- `toggle` - Generates a toggle element (default with button appearance) using the slot content as label.

## Prompt

The menu `toggle` is an HTML label element that is connected to the checkbox that holds the state; clicking will toggle the checkbox state.

To control the open state from the outside, use either:
- `Prompt.show(selectorOrElement)`
- `Prompt.hide(selectorOrElement)`
- `Prompt.toggle(selectorOrElement)`

where `selectorOrElement` is either an HTML element, `this` (when used within the component), or a selector string.

```
<.button is_primary onclick="Prompt.show('#my-menu')">
  Show menu from outside
</.button>

<.action_menu id="my-menu">
  <:toggle>Show menu</:toggle>
  <.action_list>
    <.action_list_item>
      One
    </.action_list_item>
    <.action_list_item>
      Two
    </.action_list_item>
    <.action_list_item onclick="Prompt.hide(this)">
      Hide from inside
    </.action_list_item>
  </.action_list>
</.action_menu>
```

### Status callbacks

Use attr `prompt_options` to pass JavaScript state callback functions.

```
<.action_menu prompt_options="{
  willShow: function(elements) { console.log('willShow', elements) },
  didShow: function(elements) { console.log('didShow', elements) },
  willHide: function(elements) { console.log('willHide', elements) },
  didHide: function(elements) { console.log('didHide', elements) }
}">
  ...
</.action_menu>
```


## CSS

Prompt CSS mainly defines behavior and can be modified by providing different values to the default CSS Variables:

```
[data-prompt] {
  /* colors */
  --prompt-background-color-backdrop: black;
  --prompt-background-opacity-backdrop-dark: 0.5;

  /* - default: */
  --prompt-background-opacity-backdrop-medium: 0.2;
  --prompt-background-opacity-backdrop-light: 0.07;

  /* transitions */
  --prompt-transition-timing-function-backdrop: ease-in-out;
  --prompt-transition-timing-function-content: ease-in-out;
  --prompt-transition-duration-content: 180ms;
  --prompt-fast-transition-duration-content: 140ms;
  --prompt-transition-duration-backdrop: var(--prompt-transition-duration-content);
  --prompt-fast-transition-duration-backdrop: var(--prompt-fast-transition-duration-content);

  /* drawer */
  --drawer-width: 320px;

  /* z-index */
  --prompt-z-index-backdrop: 98;
  --prompt-z-index-touch: 99;
  --prompt-z-index-menu-content: 100;
  --prompt-z-index-drawer-content: 200;
  --prompt-z-index-dialog-content: 300;
}
```

### App header

Take note of the `z-index` values: if the application uses a fixed header, you may want to ensure that its z-index is below dialogs/drawers and above menus, so between `101` and `199`.

## Maintaining state in forms

Under the hood, menu behavior is implemented through the Prompt hook that retrieves the open state and other relevant attributes from a hidden toggle checkbox.
By using a checkbox, we are able to preserve the open state when they are used within a form and updated by user actions.

Normally after an update to the LiveView state, the menu/dialog/drawer is redrawn, resulting in it being rendered closed.

To preserve the open state of the menu, you can pass the form along with a *fictitious and unique field name* (not used in the data model). This field name is then used in event handlers.

For example:

```
<.form :let={f} for={@changeset} phx-change="save">
  <.action_menu
    form={f}
    field={:user_job_toggle}>
    ...
```

The implementation of menu behavior from a user's perspective is determined by the event handler, where you have two options for updating the model state:

1. Update the model state after closing the menu.
2. Update the model state after each selection.

### Approach 1: Update after closing the menu

Ignore the event while the the menu is open (the toggle checkbox value is "true"):

```
def handle_event("save", %{"user" => %{"user_job_toggle" => "true"}}, socket) do
  # Ignore
  {:noreply, socket}
end

def handle_event("save", %{"user" => params}, socket) do
  # user_job_toggle is "false", so process normally
  case User.update(socket.assigns.user, params) do
    ...
```

### Approach 2: Update with each selection

Process the event as usual and re-insert the fictitious field value:

```
# First iteration, unoptimised
# LiveView 

def handle_event("save", %{"user" => params}, socket) do
  case User.update(socket.assigns.user, params) do
    {:ok, user} ->
      # Re-insert user_job_toggle value
      changeset =
        User.changeset(
          user,
          params |> Map.take(["user_job_toggle"])
        )

      socket =
        socket
        |> assign(:user, user)
        |> assign(:changeset, changeset)

      {:noreply, socket}

    {:error, %Ecto.Changeset{} = changeset} ->
      # Re-insert user_job_toggle value
      changeset =
        User.changeset(
          changeset.data,
          params |> Map.take(["user_job_toggle"])
        )

      socket =
        socket
        |> assign(:changeset, changeset)

      {:noreply, socket}
  end
end
```

This feels a bit ad hoc and can improved with a custom and reusable replacement for the model `update` function:
```
# Model

def update_with_ui(%User{} = user, attrs, ui_values \\\\ %{}) do
  result =
    user
    |> User.changeset(attrs)
    |> Repo.update()

  case result do
    {:ok, user} ->
      changeset = change(user, ui_values)
      {:ok, user, changeset}

    {:error, changeset} ->
      changeset = changeset |> Map.merge(ui_values)
      {:error, nil, changeset}
  end
end
```

And now the event handler becomes:
```
# Second iteration
# LiveView 

def handle_event("save", %{"user" => params}, socket) do
  case User.update_with_ui(
    socket.assigns.user,
    params,                                 # Model params
    params |> Map.take(["user_job_toggle"]) # UI params
  ) do
    {:ok, user, changeset} ->
      socket =
        socket
        |> assign(:user, user)
        |> assign(:changeset, changeset)

      {:noreply, socket}

    {:error, nil, %Ecto.Changeset{} = changeset} ->
      socket =
        socket
        |> assign(:changeset, changeset)

      {:noreply, socket}
  end
end
```