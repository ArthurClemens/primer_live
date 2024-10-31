# Styling

- [Primer Design System](#primer-design-system)
- [Customizing components](#customizing-components)
  - [Style attributes](#style-attributes)
  - [Adding classes](#adding-classes)
    - [Writing custom CSS](#writing-custom-css)
    - [Using predefined classes](#using-predefined-classes)

## Primer Design System

PrimerLive components are based on the styling described in the [Primer Design System](https://primer.style/design/). Primer Design System is created by GitHub and includes 2 implementations: one for React and one for Ruby on Rails. The third implementation, using plain HTML and CSS, has been deprecated by GitHub.

The CSS that comes with PrimerLive includes component styles and utility classes.

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

To address inner elements, use the component `classes` attribute, is a key-classname map. The map keys are described in the component documentation, for example for [Box](`PrimerLive.Component.box/1`).

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

#### Using predefined classes 

We can achieve the same result using utility classes.

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

One major benefit of using these classes is that colors adjust to match the user's theme settings. For example, in dark mode, a white background automatically changes to a darker shade, preserving the intent of the color rather than applying a fixed hex value. This benefit becomes even more apparent if you are offering additional options for color blindness, such as "high contrast".

The class names used above are described in [Primer Design System's CSS utilities](https://primer.style/foundations/css-utilities).

Note that the box class "pl-border-thick" is defined by PrimerLive as one of the "custom" utility classes. You can find these in [util.css](https://github.com/ArthurClemens/primer_live/blob/development/assets/css/util.css).