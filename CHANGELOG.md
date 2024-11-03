# Changelog

## 0.9.0 (not released)

### Changes

- [Text input](`PrimerLive.Component.text_input/1`): Set disabled color on read-only field with inset style.
- [Checkbox group](`PrimerLive.Component.checkbox_group/1`) and [Radio group](`PrimerLive.Component.radio_group/1`): Show required marker in legend.
- [Action menu](`PrimerLive.Component.action_menu/1`) and [Select menu](`PrimerLive.Component.select_menu/1`): Added attribute `offset_x` to define the absolute offset for the menu on the horizontal axis.
- [Header](`PrimerLive.Component.header/1`): added attributes `variant="base"` to create a light colored header, and `is_compact` for a smaller vertical height.
- Updated upstream Primer Design System libraries. This update includes a number of changes to modified CSS Custom Properties.
  - Updated upstream dependency `@primer/css` to `21.5.0`.
  - Added `@primer/view-components` version `0.34.0`. This is the Rails version of Primer Design, which is the most developed so far.
  - Updated [Octicon](`PrimerLive.Component.octicon/1`) icons to version `v19.12.0`.
- Added support for right-to-left languages.
- Added support for `@scope`, allowing PrimerLive to be used alongside other CSS libraries. See usage instructions in [Installation](doc-extra/installation.md#scoped-css).
- Added documentation [Styling](doc-extra/styling.md). This contains notes about styling with custom CSS and pre-made classes, reusing styled components and support for right-to-left languages.

### Depreciations

Standalone `form_control` as wrapper is soft-deprecated.

The use of `form_control` as wrapper component around a form input component was causing compatibility issues with displaying validation messages. Since input components should be able to display a validation message even when not wrapped inside a `form_control`, it became difficult to distinguish between a validation messages originating from the `form_control` and one originating from the nested input.

With the introduction of `checkbox_group` and `radio_group` in version 0.5, there has been less need for a standalone form control wrapper.

Overall, moving `form_control` to the background and using it only as an internal component resolves a range of problems.

See "Updating to 0.9" below.

### Removals

- `form_group` was soft-deprecated in 0.5.0 and has been removed, along with component attributes `form_group` and `is_form_group`.

### Bug fixes

- [Checkbox group](`PrimerLive.Component.checkbox_group/1`) and [Radio group](`PrimerLive.Component.radio_group/1`): Restored display of validation message.
- [Textarea](`PrimerLive.Component.textarea/1`): Set correct success color when displaying success feedback.

### Updating to 0.9

#### form_control

There have 2 ways to create a form control: as a wrapper, and as an input attribute. If you've been using `form_control` as wrapper around inputs, change:

```
<.form :let={f} for={@changeset}>
  <.form_control form={f} field={:first_name} for="first-name">
    <.text_input form={f} field={:first_name} id="first-name" />
  </.form_control>
</.form>
```

to

```
<.form :let={f} for={@changeset}>
  <.text_input form={f} field={:first_name} id="first-name" is_form_control />
</.form>
```

#### CSS Custom Properties (Variables)

If you are using CSS Custom Properties from the Primer Design System, these may need to be updated. Verify the current available options in [primer-live.css](https://github.com/ArthurClemens/primer_live/blob/development/priv/static/primer-live.css).

## 0.8.0

### Refactoring of dialogs, drawers, and menus

This refactoring builds on the `Phoenix.LiveView.JS` API - taking example from `CoreComponent`'s modal component. These changes reduce reliance on additional JavaScript, improve alignment with standard practice, and include accessibility improvements.

Overview:

- [Menus and dialogs](doc-extra/menus-and-dialogs.md)

See component documentation for further details:

- [Action menu](`PrimerLive.Component.action_menu/1`)
- [Dialog](`PrimerLive.Component.dialog/1`)
- [Drawer](`PrimerLive.Component.drawer/1`)
- [Dropdown](`PrimerLive.Component.dropdown/1`)
- [Select menu](`PrimerLive.Component.select_menu/1`)

#### Additions

- Dialogs, drawers and menus can now be shown conditionally, for example on a `live_action` route:

```
<.dialog
  :if={@live_action == :create}
  is_show
  id="new-post-dialog"
  on_cancel={JS.patch(~p"/posts")}
>
  ...
</.dialog>
```

- Added `PrimerLive.StatefulConditionComponent`.
- Dialog state is now preserved on form updates.
- Added attribute `focus_after_closing_selector`, mirroring the (renamed) `focus_after_opening_selector`.
- Added attribute `on_cancel`.
- Added attribute `transition_duration`.
- Added attribute `show_state` to persist dialogs, drawers and menus across different LiveViews.
- Added `backdrop_tint` with values "dark" (default) and "light". The latter (combined with `backdrop_strength="strong"`) (see below) creates a backdrop that is similar to the CoreComponent's modal.
- Added focus trap.

#### Changes and removals

See for update instructions: "Updating to 0.8" below.

- Prompt functions `show` and `hide` are replaced with `open_dialog`, `close_dialog` and `cancel_dialog`.
- Replaced attribute `prompt_options` for status callbacks with `status_callback_selector` that sends status events to the component, so that state changes can be used in Elixir code.
- Removed attribute `phx_click_touch` in favor of using `status_callback_selector`, because closing can be initiated in several ways, not only through backdrop clicks, and we can't assume that the event handler always hosts the dialog/drawer as well.
- Renamed attribute `focus_first` to `focus_after_opening_selector`. Focus on the first interactive element is now default; with `focus_after_opening_selector` a specific element can be appointed.
- Removed attrs `form` and `field` from all prompt components.
- Added separate `z-index` settings for menus, so that the menu panel (and optional backdrop) are closer to the page, allowing them to be covered by other elements such as top bars. Using a `z-index` of `100` for a top bar ensures that it sits in between menus and dialogs/drawers.
- Replaced backdrop attributes `is_dark_backdrop`, `is_medium_backdrop` and `is_light_backdrop` with `backdrop_strength` and values `"strong"`, `"medium"` and `"light"`.
- Menus and dialogs can now be closed with Escape by default.

### Other changes

#### Box with streams

The [box](`PrimerLive.Component.box/1`) component now supports streams:

```
<.box stream={@streams.clients} id="clients">
  <:row :let={{_dom_id, data}}>
    <%= data.name %>
  </:row>
</.box>
```

This includes a breaking change: `let` is now reserved for stream data, so the callback data no longer contains `classes`.

#### Event attributes for slots

Slots now accept these "all-purpose" event attributes:

- `phx-click`
- `phx-target`
- `phx-value-item`

Components:

- `box`: slot `row`
- `breadcrumb`: slot `item`
- `dialog`: slot `row`
- `dropdown`: slot `item`
- `filter_list`: slot `item`
- `header`: slot `item`
- `menu`: slot `item`
- `select_menu`: slot `item`
- `side_nav`: slot `item`
- `subnav_links`: slot `item`
- `tabnav`: slot `item`
- `truncate`: slot `item`
- `underline_nav`: slot `item`

Example with `tabnav`:

```
<:item
  :for={%{label: label, id: tab_id} <- @tabs}
  is_selected={id == @selected_tab}
  phx-click="set_tab"
  phx-value-item={tab_id}
>
  ...

def handle_event(
  "set_tab", %{"item" => tab_id}, socket) do
  ...
```

#### Fieldset wrapper for checkbox_group and radio_group

The form group created by [checkbox_group](`PrimerLive.Component.checkbox_group/1`) and [radio_group](`PrimerLive.Component.radio_group/1`) is now automatically wrapped in a fieldset. The `label` attribute generates a `legend` element.

#### Updated Octicons

This update to version `19.11.0` includes around 50 additions. See [primer-live.org/octicon](https://primer-live.org/octicon) for a visual list.

#### Accessibility

- Added ARIA tags `aria-haspopup` and `aria-owns`.
- DOM ids are reformatted to a DOM-safe ID string.

### Updating to 0.8

- Replace `Promp.show` and `Prompt.hide`:

  - For example:

        onclick="Prompt.show('#my-dialog')"
        onclick="Prompt.hide('#my-dialog')"

  - Becomes:

        phx-click={open_dialog("my-dialog")}
        phx-click={close_dialog("my-dialog")}

- Replace backdrop darkness attributes:
  - `is_dark_backdrop` becomes `backdrop_strength="strong"`
  - `is_medium_backdrop` becomes `backdrop_strength="medium"`
  - `is_light_backdrop` becomes `backdrop_strength="light"`
- Attribute `is_escapable` can be removed because this is now the default. If the component should not be removed using Escape, use `is_escapable={false}`.

#### Less used attributes

- Form state: the previous method to preserve state, using "a fictitious and unique field name" can be removed.
  - Remove `form` and `field` from menu and dialog component attributes.
- Because `focus_first` (without a selector) is now the default, nothing needs to be changed when using this attribute.
  - If in existing code a selector value is used, rename the attribute to `focus_after_opening_selector`.
- Replace `prompt_options` and `phx_click_touch` with `status_callback_selector`. There's no simple way to replace `prompt_options`, because passing JavaScript functions is no longer supported. A solution could be very similar to the previous `phx_click_touch` method. See [Status callbacks](menus-and-dialogs.html#status-callbacks) for an example.
- If you use `checkbox_group` or `radio_group` inside a `fieldset`, remove the fieldset as it is now redundant.
- If you are using `box` with a `:let` callback:

  - Previous:

        <:row :let={classes}>
          <.link href="/" class={classes.link}>Home</.link>
        </:row>

  - Becomes:

        <:row>
          <.link href="/" class="Box-row-link">Home</.link>
        </:row>

## 0.7.2

### Changes

- Fixes support for Ash 3. Thanks @ademenev!
- Internal improvements

## 0.7.1

### Changes

- Added dialog attr `is_show_on_mount`.
- Downgraded dependency @primer/css to 21.0.7 due to regressions.

## 0.7.0

Updated dependencies:

- `phoenix_ecto` to `4.5`
- `phoenix_html` to `4.1`
  - Added `phoenix_html_helpers`
- `phoenix_live_view` to `0.20`
- `@primer/css` to `21.2.2`

Removed support for Ash Framework due to incompatible dependencies.

## 0.6.4

Reverted dependency `@primer/css` to `21.0.9` because of an excessively increased file size in later versions.

## 0.6.3

### Changes

- Class attrs now support class notation from [Surface](https://github.com/surface-ui/surface). Thanks @tunchamroeun!
- Component `pagination`: added class entry for "current_page" which now can receive a custom class.

## 0.6.2

### Bug fixes

- Pagination: fixes the calculation when a gap between page numbers should be shown.

### Other changes

- Pagination: added `role` and improved ARIA labels.

## 0.6.1

Bug fixes:

- Fixes reading the required state of input fields.

## 0.6.0

Added support for forms created with [Ash Framework](https://www.ash-hq.org/). See [test/frameworks/ash/form_test.exs](https://github.com/ArthurClemens/primer_live/tree/development/test/frameworks/ash/form_test.exs) for an example.

## 0.5.4

Fixed a bug where the required marker would always be displayed, regardless of the field's required state.

## 0.5.3

Downgraded `phoenix_live_view` version to `0.19`; both `0.19` and `0.20` should be compatible.

## 0.5.2

Added JS and CSS exports for Prompt functionality only. This is useful when you want to use menu/dialog/drawer behavior without Primer Design CSS. See the installation documentation for details.

## 0.5.1

### Deprecated

- Component `avatar_pair`: renamed `parent_child_avatar` to `avatar_pair`.
- Components `action_menu` and `select_menu`: renamed `is_right_aligned` to `is_aligned_end` (added RTL support).
- Component `spinner`: renamed `gap_color` to `highlight_color`.

### New component

- `toggle_switch`: Toggle switch is used to immediately toggle a setting on or off.

### Updated components

- `avatar`: Added attr `is_round`.
- `avatar_pair`: Improved styling: support display inside flex container, add inner border to child avatar.
- `button`
  - Improved dimensions according to Primer Style specs, including placing a trailing icon.
  - Added attr `is_aligned_start`. Aligns contents to the start (at the left in left-to-right languages), while the dropdown caret (if any) is placed at the far end.
- `spinner`: Updated to latest Primer Style design.

## 0.5.0

Form elements have been revamped and aligned with the most recent [form element documentation at Primer Style](https://primer.style/design/ui-patterns/forms/overview).

### Deprecated

For all listed deprecations below: existing syntax will keep working, but log warnings will inform about the deprecation.

- `form_group` is replaced by `form_control` (and `is_form_group` is replaced by `is_form_control`). When updating your code:
  - You may need to add styling to correct the missing whitespace at top and bottom, because class "form-group" (which is also added when using attrs `form_group` and `is_form_group`) contains a top and bottom margin.
  - Without a form group, text inputs (as well as selects) [will be given a default width by the browser](https://primer.style/design/components/text-input#width) and will probably be displayed smaller than they currently are.
- The horizontal "tab-row" layout of `radio_group` is not mentioned in the Primer Design specification, while "Radio group" is (with vertical layout).
  - The current `radio_group` has been renamed to `radio_tabs`.
  - The new component `radio_group` uses a vertical layout.
- `checkbox` and `radio_button` slot `hint` has been renamed to `caption`.
- `button_group` slot `button` is replaced by `button` components as children.
- For consistency, attr `is_full` has been renamed to `is_full_width` (in `alert` and `header` slot: `item`).

### Improvements

- Added component `checkbox_group`.
- Added convenience component `checkbox_in_group` for checkboxes inside a `checkbox_group`.
- Added component `radio_group` (with vertical layout).
- Added attr `caption` to show **hint message** below the form fields.
  - Implemented for `select`, `text_input` and `textarea`.
  - Implemented for `checkbox_group` and `radio_group` to show a hint below the group label.
- Added a **required marker** to `form_control`, `checkbox_group` and `radio_group`. The form control label will show a required marker if the field is required.
  - Added `is_required?` to `FieldState`, so it can also be queried in `validation_message` and `caption` callbacks.
- Added **disabled state** to `form_control`:
  - With components `select`, `text_input` and `textarea`: the attribute `disabled` is automatically passed to `form_control`.
  - When using component `form_control` on its own: set explicitly with attr `is_disabled`.

### Removed

- Form element width variation attrs `is_short` and `is_shorter`. These are no longer supported by Primer System.
- `form_control` class `body`: this extra div is removed to simplify the styling of validation states.

## 0.4.0

### Improvements

- The open state of menus and dialogs can now be maintained when used inside forms.
- Improved validation message logic.
- Updated components:
  - `theme_menu_options`: added attr `update_theme_event`: the event name to be called for updating the theme.
  - `radio_group`: added to slot `radio_button` the attr `label` to set a custom label.
- Updated `@primer/css` to `21.0.7`.

### Breaking changes

- Removed functions related to using session for theme state - see `PrimerLive.Theme` for alternatives. Removed:
  - `ThemeSessionController`
  - `ThemeEvent`
  - Theme hook
- IDs of checkboxes and radio buttons have been updated to only include valid characters.

### Deprecated

- For all menu components, including 'dialog' and 'drawer': passing prompt options to the `toggle` slot is replaced by passing `prompt_options` to the main component.
- In the `drawer` component, replace the subcomponent `drawer_content` with the slot `body`.
  - This allows the focus wrap ID to be derived from the drawer's 'id' attribute, similar to how it is done for 'dialog'.
  - When using the previous syntax, a warning message will be shown in the shell.

### Other changes

- The HTML structure and some of the CSS classes of `action_menu`, `dropdown_menu` and `select_menu` have changed. Instead of `<details>` and `<summary>` elements, the open state is now controlled with `<input type="checkbox">` and `<label>`.
- HTML attributes are sorted alphabetically.

## 0.3.1

Replaced underscores in HTML element attributes with dashes because Phoenix LiveView 0.19 no longer does automatic substitution.

Updated components:

- `select`: attr `prompt` is ignored when `is_multiple` is also used. This prevents `Phoenix.HTML.Form.multiple_select` from raising an error.

## 0.3.0

Breaking change: `action_list_item` now always renders a checkbox group, also when `is_multiple_select` is set on the list items. This change makes handling form data in events more consistent: the data will always consist of a list of checkbox values.

## 0.2.7

Fixes a bug introduced in `0.2.6` where single select `action_list_item`s did not get unique ids.

## 0.2.6

- Fixes a bug where `FormHelpers.field_state` did not handle forms without a changeset.
- Updated components:
  - `text_input`: added attrs `name` and `value`
  - `checkbox`: add attrs `checked`, `checked_value`, `hidden_input`
- Update `@primer/css` to `21.0.0`.

## 0.2.5

Updated components:

- `action_menu` and `select_menu`:
  - Added `prompt` slot attr `options` to pass Prompt options. This enables (for example) to postpone submitting a form in the menu by calling `submit` event in the Prompt functions `willHide` or `didHide`.

## 0.2.4

- Fixes a bug where variables in error messages where not interpolated.
- Update to `phoenix_html` `3.3.x`

## 0.2.3

- Clarified `layout` attributes to change the rendered order of slots.
- Improve field name and id generation.
- Use checkboxes and radio buttons in action lists.

Updated component:

- `checkbox`:
  - Added attr `is_multiple`: When creating a list of checkboxes. Appends `[]` to the input name so that a list of values is passed to the form events.
  - Added attr `is_omit_label`: Omits any label.

## 0.2.2

Updated component:

- `text_input`:
  - Moved attr `is_trailing_action_divider` to slot `trailing_action` as `is_divider`
  - Added attr `is_visible_with_value` to slot `trailing_action` to only show the trailing action when the input has a value. Use this cor example to show a clear button only when the input has a value to clear.

## 0.2.1

### Rework of form controls

The rework includes styles from [Primer ViewComponents](https://primer.style/view-components/). The form styles from this flavor of Primer is more mature than the generally used Primer CSS.

Updated components:

- `text_input`:
  - Added attr `is_monospace`
  - Added slots `leading_visual` and `trailing_action`
  - Added attr `is_trailing_action_divider`
  - Inputs inside a form group no longer have a background color by default; use `is_contrast` to set it explicitly
  - Removed validation message for hidden inputs
- `textarea`:
  - Added attr `is_monospace`
  - Use `is_contrast` to explicitly set a contrasting background color
- `checkbox` and `radio_button`
  - Have a clearer (more colorful) appearance
  - Changed the HTML structure
- `radio_group`
  - For consistency, added input styling from Primer ViewComponents radio button (keeping the initial size)
- `select`:
  - Added wrapper HTML element
  - Added attr `is_monospace`
  - Added attr `is_large`
  - Added attr `is_short`
  - Added attr `is_shorter`
  - Added attr `is_full_width`
  - Improved styling for multiple select
- `subnav` with search field:
  - Added attr `is_wrap` to wrap child elements
  - Improved CSS for small screens

Added component:

- `input_validation_message` - can be used as standalone message component for inputs where the position of the validation feedback is not so obvious, for example lists of checkboxes or radio buttons

Additional:

- Added styling for input elements inside a disabled fieldset

### Integration of npm dependencies

JavaScript and CSS dependencies (from npm library `primer-live`) are now incorporated in the Elixir package. The installation instructions are slightly simplified (see the documentation) and are recommended for a fresh setup. The previous installation method works just fine for existing projects.

## 0.1.16

Added anchor link attributes to `button` to create a link that looks like a button.

## 0.1.15

Removed Octicon builder template files from distribution.

## 0.1.14

- Updated `octicons` dependency to `17.10.1`
- Code quality refactoring
- Documentation updates

## 0.1.13

Added:

- `theme_menu_options` to create a theme menu
- `Theme.html_attributes` to set theme attributes on elements
- Theme functions for persistent theme data in the session

## 0.1.12

Fixes an issue where validation messages did not show.

## 0.1.11

Added:

- `theme`

## 0.1.10

Updated:

- Prevent attribute open on select menu

## 0.1.9

Added:

- `styled_html`

## 0.1.8

Updated:

- Removed requirement for Elixir version

## 0.1.7

Updated:

- Added `is_small` for `tabnav` items

## 0.1.6

Updated:

- `oticon` icons

## 0.1.5

Added:

- `drawer`

## 0.1.4

Bug fix:

- Improve `action_menu` on mobile

## 0.1.3

Added:

- `action_menu`

## 0.1.2

Bug fix:

- `action_link_item`: pass class to `link` slot.

## 0.1.1

First release.

```

```
