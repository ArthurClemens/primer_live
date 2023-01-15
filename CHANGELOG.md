# Changelog

## 0.1.17

Rework form controls. This includes using CSS from [Primer ViewComponents](https://primer.style/view-components/) as it is more mature than Primer CSS styles.

Inputs inside a form group no longer have a background color by default; use `is_contrast` to set it explicitly.

- `text_input`:
  - Added attr `is_monospace`
  - Added slots `leading_visual` and `trailing_action`
  - Added attr `is_trailing_action_divider`
- `textarea`:
  - Added attr `is_monospace`
- `checkbox` and `radio_button`
  - Changed internal structure
- `radio_group`
  - Added input styling from Primer ViewComponents radio button (keeping the initial size)
- `select`:
  - Added wrapper element
  - Added attr `is_monospace`
  - Added attr `is_large`
  - Added attr `is_short`
  - Added attr `is_shorter`
  - Added attr `is_full_width`
  - Improved styling for multiple select
- `subnav` with search field:
  - Added attr `is_wrap` to wrap child elements
  - Improved CSS for small screens

Added styling for input elements inside a disabled fieldset.

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
