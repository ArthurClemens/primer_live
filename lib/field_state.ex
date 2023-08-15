defmodule PrimerLive.FieldState do
  @moduledoc """
  State object with validation data for a particular form field.

  Struct fields:
  - `changeset` - `Ecto.Changeset` struct.
  - `field_errors` - Changeset `errors`, filtered for the field.
  - `valid?` - True if changeset's `field_errors` is empty for the field.
  - `ignore_errors?` - Changeset has errors but should not be displayed (currently when `changeset.action` is `nil`)
  - `message` - Default message derived from changeset `errors`, unless overridden by `validation_message` attribute.
  - `message_id` - Generated id that is used for `aria_describedby`.
  - `caption` - Field hint message that may be rendered dependent on the field state.
  """
  defstruct valid?: false,
            ignore_errors?: false,
            changeset: nil,
            message: nil,
            message_id: nil,
            field_errors: [],
            caption: nil
end
