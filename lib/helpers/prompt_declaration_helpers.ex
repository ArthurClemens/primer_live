defmodule PrimerLive.Helpers.PromptDeclarationHelpers do
  @moduledoc false

  alias Phoenix.LiveView.JS

  defmacro id(name_element_id, is_required) do
    quote do
      attr(:id, :string,
        required: unquote(is_required),
        doc:
          if unquote(is_required) do
            """
            {name_element_id}. Use to toggle from the outside. Required in order to derive a consistent focus wrap ID.
            """
            |> String.replace("{name_element_id}", unquote(name_element_id))
          else
            """
            {name_element_id}. Use to toggle from the outside, and to get consistent IDs in tests.
            If not set, an id is generated, either based on `form` and `field`, or otherwise randomly.
            """
            |> String.replace("{name_element_id}", unquote(name_element_id))
          end
      )
    end
  end

  defmacro form(the_menu_element) do
    quote do
      attr :form, :any,
        doc:
          """
          To maintain the open state when using {the_menu_element} inside a form, pass the form surrounding {the_menu_element}.
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

  defmacro is_backdrop do
    quote do
      attr :is_backdrop, :boolean,
        default: false,
        doc: """
        Generates a backdrop background (default with medium darkness).
        """
    end
  end

  defmacro is_dark_backdrop do
    quote do
      attr :is_dark_backdrop, :boolean,
        default: false,
        doc: """
        Generates a darker backdrop background color.
        """
    end
  end

  defmacro is_medium_backdrop do
    quote do
      attr :is_medium_backdrop, :boolean,
        default: false,
        doc: """
        Generates a medium backdrop background color.
        """
    end
  end

  defmacro is_light_backdrop do
    quote do
      attr :is_light_backdrop, :boolean,
        default: false,
        doc: """
        Generates a lighter backdrop background color. Default for menus.
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

  defmacro prompt_options do
    quote do
      attr(:prompt_options, :string,
        default: nil,
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

  defmacro phx_click_touch do
    quote do
      attr :phx_click_touch, :any,
        required: false,
        doc: """
        `phx-click` event binding to assign an event callback on clicking the touch layer.
        Ignored if `is_modal` is true.
        """
    end
  end

  defmacro toggle_slot(the_element) do
    quote do
      slot :toggle,
        required: true,
        doc: """
        Generates a toggle element (default with button appearance) using the slot content as label.

        Any custom class will override the default class "btn".
        """ do
        attr(:options, :string,
          doc:
            """
            Deprecated: pass the attrs to {the_element} as `prompt_options`.
            """
            |> String.replace("{the_element}", unquote(the_element))
        )

        attr(:class, :any,
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

  # Dialog, drawer and menu specific

  defmacro is_show(the_element) do
    quote do
      attr :is_show, :boolean,
        default: false,
        doc:
          """
          Sets the display state of {the_element}. Control conditional display by using the regular `:if={}` attribute.
          """
          |> String.replace("{the_element}", unquote(the_element))
    end
  end

  defmacro on_cancel(the_element) do
    quote do
      attr :on_cancel, JS,
        default: nil,
        doc:
          """
          JS command to configure the closing/cancel event of {the_element}, for example: `on_cancel={JS.navigate(~p\"/posts\")}`.
          """
          |> String.replace("{the_element}", unquote(the_element))
    end
  end

  defmacro transition_duration(the_element, default_value) do
    quote do
      attr :transition_duration, :integer,
        default: unquote(default_value),
        doc:
          """
          The number of milliseconds to fade-in/out {the_element}.
          """
          |> String.replace("{the_element}", unquote(the_element))
    end
  end

  # Dialog and drawer specific

  defmacro is_modal(the_element) do
    quote do
      attr :is_modal, :boolean,
        default: false,
        doc:
          """
          Generates a modal {the_element}; clicking the backdrop (if used) or outside of {the_element} will not close {the_element}.
          """
          |> String.replace("{the_element}", unquote(the_element))
    end
  end

  defmacro is_escapable do
    quote do
      attr :is_escapable, :boolean,
        default: true,
        doc: """
        Closes the content when the Escape key is pressed. Set to false to prevent this.
        """
    end
  end

  defmacro focus_after_opening(the_element) do
    quote do
      attr :focus_after_opening, :string,
        default: nil,
        doc:
          """
          Gives focus to the specified element after opening {the_element}. Pass the element selector.
          """
          |> String.replace("{the_element}", unquote(the_element))
    end
  end

  defmacro focus_after_closing(the_element) do
    quote do
      attr :focus_after_closing, :string,
        default: nil,
        doc:
          """
          Returns focus to the specified element after closing {the_element}. Pass the element selector.
          Improve accessibility by implementing this [ARIA Dialog Pattern](https://www.w3.org/WAI/ARIA/apg/patterns/dialog-modal/).
          """
          |> String.replace("{the_element}", unquote(the_element))
    end
  end

  defmacro status_callback_selector(the_element) do
    quote do
      attr :status_callback_selector, :string,
        default: nil,
        doc:
          """
          Receiver to get status callback events. Events are passed from the Prompt hook using `pushEventTo`.
          Pass the HTML selector of the receiver of the LiveComponent or LiveView the element is defined in.

          The event sends the object named "primer_live:prompt" with payload:
          ```
          %{
            "elementId" => "",  # {the_element} id
            "status" => ""      # possible values: "opening", "open", "closing", "closed"
          }
          ```
          """
          |> String.replace("{the_element}", unquote(the_element))
    end
  end
end
