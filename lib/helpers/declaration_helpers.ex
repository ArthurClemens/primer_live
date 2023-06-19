defmodule PrimerLive.Helpers.DeclarationHelpers do
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
end
