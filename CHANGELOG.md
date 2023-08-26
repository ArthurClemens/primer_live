# Changelog

## 0.5.1

### Deprecated

- Renamed `parent_child_avatar` to `avatar_pair`.

### Updated components

- `avatar`: Added attr `is_round`.
- `avatar_pair`: Improved styling: support display inside flex container, add inner border to child avatar.
- `button`
  - Improved dimensions according to Primer Style specs, including placing a trailing icon.
  - Added attr `is_aligned_start`. Aligns contents to the start (at the left in left-to-right languages), while the dropdown caret (if any) is placed at the far end.

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

- The open state of menus and dialogs can now be maintained when used inside forms - see [Menus and dialogs](doc-extra/menus-and-dialogs.md).
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
- `select`: attr `prompt` is ignored when `is_multiple` is also used. This prevents `Phoenix.HTML.Form.multiple_select/4` from raising an error.

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
