defmodule PrimerLive.Helpers.PromptDeclarationHelpers do
  @moduledoc false

  alias Phoenix.LiveView.JS

  defmacro id(name_element_id, the_element, is_required) do
    quote do
      attr(:id, :string,
        required: unquote(is_required),
        doc:
          if unquote(is_required) do
            """
            {name_element_id}, used for opening and closing from the outside.
            """
            |> String.replace("{name_element_id}", unquote(name_element_id))
          else
            """
            {name_element_id}. While passing the ID is optional, it is required:
            - For referencing {the_element} from other functions or components, such as for opening and closing.
            - For maintaining an open state after making selections.
            - To get consistent IDs in tests.
            If not set, an ID is derived from `form` and `field`, or otherwise generated randomly.
            """
            |> String.replace("{name_element_id}", unquote(name_element_id))
            |> String.replace("{the_element}", unquote(the_element))
          end
      )
    end
  end

  defmacro is_dropdown_caret(default) do
    quote do
      attr :is_dropdown_caret, :boolean,
        default: unquote(default),
        doc: "Adds a dropdown caret icon to the toggle button."
    end
  end

  defmacro is_backdrop do
    quote do
      attr :is_backdrop, :boolean,
        default: false,
        doc: """
        Generates a backdrop background with a default strength and tint values. 

        Default backdrop strenght:
        - dialog and drawer: `"medium"`
        - menus: `"light"`

        Default tint: "dark".
        """
    end
  end

  defmacro backdrop_strength do
    quote do
      attr :backdrop_strength, :string,
        values: ["medium", "strong", "light", nil],
        default: nil,
        doc: """
        Backdrop strenght. Overrides the default value from `is_backdrop`.
        """
    end
  end

  defmacro backdrop_tint do
    quote do
      attr :backdrop_tint, :string,
        values: ["dark", "light", nil],
        default: nil,
        doc: """
        Backdrop tint. Overrides the default value from `is_backdrop`.
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

  defmacro toggle_slot do
    quote do
      slot :toggle,
        required: true,
        doc: """
        Generates a toggle element (default with button appearance) using the slot content as label.
        A `phx-click` attribute is added automatically if it is not passed in the slot attributes.

        Any custom class will override the default class "btn".
        """ do
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

        attr(:"phx-click", :any,
          doc: """
          Phoenix click function. Overrides the default toggle function.
          """
        )

        attr(:"phx-target", :any)

        attr(:"aria-label", :string)

        attr(:rest, :any,
          doc: """
          Additional HTML attributes added to the item element.
          """
        )
      end
    end
  end

  # Dialog, drawer and menu specific

  defmacro is_show(the_element, component_tag) do
    quote do
      attr :is_show, :boolean,
        default: false,
        doc:
          """
          Sets the display state of {the_element}. Control conditional display by using Phoenix's `:if` attribute.

          Example:

          ```
          <{component_tag} is_show :if={@live_action in [:new, :edit]}>
            ...
          </{component_tag}>
          ```
          """
          |> String.replace("{the_element}", unquote(the_element))
          |> String.replace("{component_tag}", unquote(component_tag))
    end
  end

  defmacro show_state(the_element) do
    quote do
      attr :show_state, :string,
        values: ~w(default onset hold),
        default: "default",
        doc:
          """
          Use when {the_element} is already displayed, and should be persisted when navigating to another LiveViews (for example to hide {the_element} with a transition after having navigated to a new route). This method does require that {the_element} is available on the other LiveView page, so it is best suited for "global" components such as navigation panels and app header menus.

          Use together with `is_show`.

          Values:
          - "default": No change.
          - "onset": Preparation for the "hold" state. Removes the "phx-remove" attribute so that navigating away doesn't cause a close transition.
          - "hold": Removes the "phx-remove" attribute as well as opening transitions and first focus.
          """
          |> String.replace("{the_element}", unquote(the_element))
    end
  end

  defmacro is_show_on_mount(the_element, component_tag) do
    quote do
      attr(:is_show_on_mount, :boolean,
        default: false,
        doc:
          """
          Displays {the_element} on mount without fade-in transition. Control conditional display by using Phoenix's `:if` attribute.

          Example:

          ```
          <{component_tag} is_show is_show_on_mount :if={@live_action in [:new, :edit]}>
            ...
          </{component_tag}>
          ```
          """
          |> String.replace("{the_element}", unquote(the_element))
          |> String.replace("{component_tag}", unquote(component_tag))
      )
    end
  end

  defmacro on_cancel(the_element) do
    quote do
      attr :on_cancel, JS,
        default: nil,
        doc:
          """
          `Phoenix.LiveView.JS` command to configure the closing/cancel event of {the_element}, for example: `on_cancel={JS.navigate(~p"/posts")}`.
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
          The number of milliseconds to fade-in/out {the_element}. Adds a CSS style attribute to {the_element} HTML.
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
          Sets modal behavior: {the_element} can only be closed with Escape or by clicking a close button.
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

  defmacro focus_after_opening_selector(the_element) do
    quote do
      attr :focus_after_opening_selector, :string,
        default: nil,
        doc:
          """
          By default, the first interactive element gets focus after opening {the_element}.
          Use to set focus to a different element after opening. Pass the element selector.
          """
          |> String.replace("{the_element}", unquote(the_element))
    end
  end

  defmacro focus_after_closing_selector(the_element) do
    quote do
      attr :focus_after_closing_selector, :string,
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
            "selector" => "",  # callback selector
            "elementId" => "", # {the_element} id
            "status" => ""     # possible values: "opening", "opened", "closing", "closed"
          }
          ```
          """
          |> String.replace("{the_element}", unquote(the_element))
    end
  end
end
