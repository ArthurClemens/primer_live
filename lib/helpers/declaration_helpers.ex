defmodule PrimerLive.Helpers.DeclarationHelpers do
  @moduledoc false

  defmacro class() do
    quote do
      attr(:class, :string, default: nil, doc: "Additional classname.")
    end
  end

  defmacro slot_class() do
    quote do
      attr(:class, :string, doc: "Additional classname.")
    end
  end

  defmacro slot_style() do
    quote do
      attr(:style, :string,
        doc: """
        Additional CSS styles.
        """
      )
    end
  end

  defmacro input_id() do
    quote do
      attr(:input_id, :string,
        default: nil,
        doc:
          "When using form/field. Custom input ID to be used in case the generated IDs cause \"Multiple IDs detected\" errors."
      )
    end
  end

  defmacro form() do
    quote do
      attr(:form, :any,
        doc:
          "Either a [Phoenix.HTML.Form](https://hexdocs.pm/phoenix_html/Phoenix.HTML.Form.html) or an atom."
      )
    end
  end

  defmacro field() do
    quote do
      attr(:field, :any, doc: "Field name (atom or string).")
    end
  end

  defmacro name() do
    quote do
      attr(:name, :string, doc: "Input name attribute (when not using `form` and `field`).")
    end
  end

  defmacro validation_message() do
    quote do
      attr(:validation_message, :any,
        doc: """
        Function to write a custom validation message (in case of error or success).

        The function receives a `PrimerLive.FieldState` struct and returns a validation message.

        A validation message is shown:
        - If form is a `Phoenix.HTML.Form`, containing a `changeset`
        - And either:
          - `changeset.action` is `:validate`
          - `validation_message` returns a string

        Function signature: `fun field_state -> string | nil`.

        Example error message:

        ```
        fn field_state ->
          if !field_state.valid?, do: "Please enter your first name"
        end
        ```

        Example success message, only shown when `changeset.action` is `:validate`:

        ```
        fn field_state ->
          if field_state.valid? && field_state.changeset.action == :validate, do: "Is available"
        end
        ```
        """
      )
    end
  end

  defmacro validation_message_id() do
    quote do
      attr(:validation_message_id, :any,
        doc: """
        Message ID that is usually passed from the form element component to `input_validation_message`. If not used, the ID will be generated.
        """
      )
    end
  end

  defmacro href() do
    quote do
      attr(:href, :any,
        doc: """
        Link attribute. The link is created with `Phoenix.Component.link/1`, passing all other attributes to the link.
        """
      )
    end
  end

  defmacro slot_href() do
    quote do
      attr(:href, :any,
        doc: """
        Link attribute. The link is created with `Phoenix.Component.link/1`, passing all other slot attributes to the link.
        """
      )
    end
  end

  defmacro patch() do
    quote do
      attr(:patch, :string,
        doc: """
        Link attribute - see `href`.
        """
      )
    end
  end

  defmacro navigate() do
    quote do
      attr(:navigate, :string,
        doc: """
        Link attribute - see `href`.
        """
      )
    end
  end

  defmacro rest(opts) do
    quote do
      attr(:rest, :global, unquote(opts))
    end
  end

  defmacro rest() do
    quote do
      attr(:rest, :global)
    end
  end

  defmacro slot_rest() do
    quote do
      attr(:rest, :any)
    end
  end
end
