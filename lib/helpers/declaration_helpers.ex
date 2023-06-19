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
end
