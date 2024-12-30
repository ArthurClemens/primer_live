# Styling

- [Primer Design System](#primer-design-system)
- [Light and dark theme](#light-and-dark-theme)
- [Customizing components](#customizing-components)
  - [Style attributes](#style-attributes)
  - [Adding classes](#adding-classes)
    - [Writing custom CSS](#writing-custom-css)
    - [Using predefined classes](#using-predefined-classes)
- [Reusing styled components](#reusing-styled-components)
- [Supporting right-to-left (RTL) languages](#supporting-right-to-left-rtl-languages)
- [PrimerLive util classes](#primerlive-util-classes)
  - [Flex and grid gap](#flex-and-grid-gap)
  - [Alignment](#alignment)
  - [Offset](#offset)
  - [Border width](#border-width)
  - [Text](#text)

## Primer Design System

PrimerLive components are based on the styling described in the [Primer Design System](https://primer.style/design/). Primer Design System is created by GitHub and includes 2 implementations: one for React and one for Ruby on Rails. The third implementation, using plain HTML and CSS, has been deprecated by GitHub.

The CSS that comes with PrimerLive includes component styles and utility classes.

## Light and dark theme

PrimerLive contains styles for light and dark color modes and themes, with support for color blindness. See `PrimerLive.Theme` for usage and approaches to persist theme settings.

## Customizing components

### Style attributes

Some components contain attributes to create visual variations. For example, [Box](`PrimerLive.Component.box/1`) rows can be styled using attributes `is_yellow`, `is_blue`, and so on:

```
<.box>
  <:row is_yellow>Row</:row>
</.box>
```

### Adding classes

All PrimerLive components accept the `class` attribute:

```
<.box class="my-box">
  <:row>Row</:row>
</.box>
```

To address inner elements, use the component `classes` attribute, is a key-classname map. The map keys are described in the component documentation.

We can define the styles in 2 ways:

1. Writing custom CSS
2. Using predefined classes

In the next two sections we're creating a custom styled Box. It will have a thicker border, a header row with larger heading and white background, and data rows with gray background.

#### Writing custom CSS

The component with the `classes` attribute map:

```
<.box classes={%{
  box: "my-box",
  header: "my-box__header",
  row: "my-box__row"
}}>
  <:header>Header</:header>
  <:row>Row</:row>
</.box>
```

```css
.Box.my-box {
  border-width: 2px;
}
```

Adding the "root" component class to the custom class in CSS may be needed to create a higher specificity, needed to override the default styles.

```css
.Box.my-box .my-box__header {
  color: rgb(89, 99, 110);
  background-color: #fff;
  font-weight: 500;
  font-size: 16px;
}

.Box.my-box .my-box__row {
  background-color: #f6f6f5;
}
```

Instead of using "hardcoded" color values, a better approach would be to use the Primer's Custom Properties (Variables), which are designed to work with theme settings. For example, in dark mode, a white background automatically changes to a darker shade, preserving the intent of the color rather than applying a fixed hex value. This benefit becomes even more apparent if you are offering additional options for color blindness, such as "high contrast".

Primer's Custom Properties can be found at [Primer Design System: Primitives](https://primer.style/foundations/primitives). Use the Theme dropdowns to compare the color variants for each theme.

The same styles, now with Custom Properties:

```css
.Box.my-box .my-box__header {
  color: var(--fgColor-muted);
  background-color: var(--bgColor-default);
  font-weight: var(--base-text-weight-medium);
  font-size: var(--h4-size);
}

.Box.my-box .my-box__row {
  background-color: var(--bgColor-muted);
}
```

#### Using predefined classes

One step up is to use CSS utility classes. These are documented in [Primer Design System's CSS utilities](https://primer.style/foundations/css-utilities), and using them won't require the creation of a separate CSS file.

```
<.box classes={%{
  box: "pl-border-thick",
  header: "bgColor-default f4 fgColor-muted text-semibold",
  row: "bgColor-muted"
}}>
  <:header>Header</:header>
  <:row>Row</:row>
</.box>
```

Note that the box class "pl-border-thick" is defined by PrimerLive as one of the "custom" utility classes. You can find these below.

## Reusing styled components

Style changes can be encapsulated using a wrapper component:

```
slot :header
slot :row

def styled_box(assigns) do
 ~H"""
 <.box classes={%{
   box: "pl-border-thick",
   header: "bgColor-default f4 fgColor-muted text-semibold",
   row: "bgColor-muted"
 }} {assigns} />
 """
end
```

Then use the wrapper as a regular component:

```
<.styled_box>
  <:header>Header</:header>
  <:row>Row</:row>
  <:row>Row</:row>
  <:row>Row</:row>
</.styled_box>
```

## Supporting right-to-left (RTL) languages

To display components in right-to-left (RTL) languages, set the `dir` attribute of the html element to "rtl".

```
<html dir="rtl">
  ...
</html>
```

## PrimerLive util classes

### Flex and grid gap

Gap (or gutter) between rows and columns.

_Integer values are translated to px values using the Primer Design System's base-8 scale._

| **Class**    | **Gap size in px** |
| ------------ | ------------------ |
| `pl-gap-0`   | `0`                |
| `pl-gap-1`   | `4`                |
| `pl-gap-2`   | `8`                |
| `pl-gap-2_5` | `12`               |
| `pl-gap-3`   | `16`               |
| `pl-gap-4`   | `24`               |
| `pl-gap-5`   | `32`               |
| `pl-gap-6`   | `40`               |
| `pl-gap-7`   | `48`               |
| `pl-gap-8`   | `64`               |
| `pl-gap-9`   | `80`               |
| `pl-gap-10`  | `96`               |
| `pl-gap-11`  | `112`              |
| `pl-gap-12`  | `128`              |

### Alignment

| **Class**          | **Description**                                                                                                                 |
| ------------------ | ------------------------------------------------------------------------------------------------------------------------------- |
| `pl-aligned-start` | (default) Aligns the element at the start (at the left in left-to-right languages and at the right in right-to-left languages). |
| `pl-aligned-end`   | Aligns the element at the end (at the right in left-to-right languages and at the left in right-to-left languages).             |

### Offset

The absolute offset for the element on the horizontal axis. This can be used together with the alignment classes:
class `pl-offset-x-2 pl-aligned-end` will place the element 16px from the right in a left-to-right language.

_Integer values are translated to px values using the Primer Design System's base-8 scale._

| **Class**         | **Offset in px** |
| ----------------- | ---------------- |
| `pl-offset-x-0`   | `0`              |
| `pl-offset-x-1`   | `4`              |
| `pl-offset-x-2`   | `8`              |
| `pl-offset-x-2_5` | `12`             |
| `pl-offset-x-3`   | `16`             |
| `pl-offset-x-4`   | `24`             |
| `pl-offset-x-5`   | `32`             |
| `pl-offset-x-6`   | `40`             |
| `pl-offset-x-7`   | `48`             |
| `pl-offset-x-8`   | `64`             |
| `pl-offset-x-9`   | `80`             |
| `pl-offset-x-10`  | `96`             |
| `pl-offset-x-11`  | `112`            |
| `pl-offset-x-12`  | `128`            |

### Border width

| **Class**           | **Width in px** |
| ------------------- | --------------- |
| `pl-border-thin`    | `1`             |
| `pl-border-thick`   | `2`             |
| `pl-border-thicker` | `4`             |

### Text

| **Class**                 | **Description**           |
| ------------------------- | ------------------------- |
| `pl-text-underline-hover` | Underline text on hover   |
| `pl-text-monospace`       | Use monospace font family |
