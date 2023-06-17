# Changelog

## v0.4.1

  * Fix a bug with parsing multiline strings for plural messages
    ([issue](https://github.com/elixir-gettext/expo/issues/108)).

## v0.4.0

  * Strictly require at least one line of text in `msgid` and `msgstr`.
  * Fix `Expo.PO.compose/1` with only top comments and no headers.

## v0.3.0

  * Add `Expo.PluralForms` for functionality related to the `Plural-Forms`
    Gettext header.

## v0.2.0

  * Add support for previous message context (through `#| msgctxt "..."`
    comments).
  * Fix some issues with obsolete comments (`#~`) not parsing correctly in some
    cases.
