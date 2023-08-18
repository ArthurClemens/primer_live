defmodule PrimerLive.FieldState do
  @moduledoc """
  State object with validation data for a particular form field.

  Struct fields:
  - `caption` - Field hint message that may be rendered dependent on the field state.
  - `changeset` - `Ecto.Changeset` struct.
  - `field_errors` - Changeset `errors`, filtered for the field.
  - `ignore_errors?` - Changeset has errors but should not be displayed (currently when `changeset.action` is `nil`)
  - `message_id` - Generated id that is used for `aria_describedby`.
  - `message` - Default message derived from changeset `errors`, unless overridden by `validation_message` attribute.
  - `required?` - True if the field is marked as required in the changeset (the `changeset.errors` contains value `[validation: :required]`).
  - `valid?` - True if changeset's `field_errors` is empty for the field.
  """
  defstruct caption: nil,
            changeset: nil,
            field_errors: [],
            ignore_errors?: false,
            message_id: nil,
            message: nil,
            required?: false,
            valid?: false
end
