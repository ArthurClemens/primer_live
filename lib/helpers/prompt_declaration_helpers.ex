defmodule PrimerLive.Helpers.PromptDeclarationHelpers do
  defmacro id(name_element_id) do
    quote do
      attr(:id, :string,
        doc:
          """
          {name_element_id}. Use to toggle from the outside, and to get consistent IDs in tests. If not set, an id is generated, either based on `form` and `field`, or otherwise randomly.
          """
          |> String.replace("{name_element_id}", unquote(name_element_id))
      )
    end
  end

  defmacro form(the_menu_element) do
    quote do
      attr :form, :any,
        doc:
          """
          To maintain the open state when using the menu inside a form, pass the form surrounding {the_menu_element}.
          Either a [Phoenix.HTML.Form](https://hexdocs.pm/phoenix_html/Phoenix.HTML.Form.html) or an atom.
          """
          |> String.replace("{the_menu_element}", unquote(the_menu_element))
    end
  end

  defmacro field(the_menu) do
    quote do
      attr :field, :any,
        doc:
          """
          Field name (atom or string). Use an atom when used with a form.
          To maintain the open state when using {the_menu} inside a form, see: [Menus and dialogs](doc-extra/menus-and-dialogs.md).
          """
          |> String.replace("{the_menu}", unquote(the_menu))
    end
  end

  defmacro is_dropdown_caret(default) do
    quote do
      attr :is_dropdown_caret, :boolean,
        default: unquote(default),
        doc: "Adds a dropdown caret to the prompt button."
    end
  end

  defmacro is_backdrop() do
    quote do
      attr :is_backdrop, :boolean,
        default: false,
        doc: """
        Generates a backdrop background (default with medium darkness).
        """
    end
  end

  defmacro is_dark_backdrop() do
    quote do
      attr :is_dark_backdrop, :boolean,
        default: false,
        doc: """
        Generates a darker backdrop background color.
        """
    end
  end

  defmacro is_medium_backdrop() do
    quote do
      attr :is_medium_backdrop, :boolean,
        default: false,
        doc: """
        Generates a medium backdrop background color.
        """
    end
  end

  defmacro is_light_backdrop() do
    quote do
      attr :is_light_backdrop, :boolean,
        default: false,
        doc: """
        Generates a lighter backdrop background color (default).
        """
    end
  end

  defmacro is_fast(default_value) do
    quote do
      attr :is_fast, :boolean,
        default: unquote(default_value),
        doc: """
        Generates fast fade transitions for backdrop and content.
        """
    end
  end

  defmacro prompt_options() do
    quote do
      attr(:prompt_options, :string,
        doc: """
        JavaScript state callback functions as string. For example:

        ```
        "{
          willShow: function(elements) { console.log('willShow', elements) },
          didShow: function(elements) { console.log('didShow', elements) },
          willHide: function(elements) { console.log('willHide', elements) },
          didHide: function(elements) { console.log('didHide', elements) }
        }"
        ```
        """
      )
    end
  end

  defmacro toggle_slot() do
    quote do
      slot :toggle,
        required: true,
        doc: """
        Generates a toggle element (default with button appearance) using the slot content as label.

        Any custom class will override the default class "btn".
        """ do
        attr(:options, :string,
          doc: """
          Deprecated: pass the attrs to the action_menu as `prompt_options`.
          """
        )

        attr(:class, :string,
          doc: """
          Additional classname.
          """
        )

        attr(:style, :string,
          doc: """
          Additional CSS styles.
          """
        )

        attr(:rest, :any,
          doc: """
          Additional HTML attributes added to the item element.
          """
        )
      end
    end
  end
end