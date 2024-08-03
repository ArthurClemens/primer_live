defmodule PrimerLive.Helpers.DeclarationHelpers do
  @moduledoc false

  defmacro class do
    quote do
      attr(:class, :any, default: nil, doc: "Additional classname.")
    end
  end

  defmacro slot_class do
    quote do
      attr(:class, :any, doc: "Additional classname.")
    end
  end

  defmacro slot_style do
    quote do
      attr(:style, :string,
        doc: """
        Additional CSS styles.
        """
      )
    end
  end

  defmacro slot_phx do
    quote do
      attr(:"phx-click", :string)
    end
  end

  defmacro input_id do
    quote do
      attr(:input_id, :string,
        default: nil,
        doc:
          "When using form/field. Custom input ID to be used in case the generated IDs cause \"Multiple IDs detected\" errors."
      )
    end
  end

  defmacro form do
    quote do
      attr(:form, :any,
        default: nil,
        doc:
          "Either a [Phoenix.HTML.Form](https://hexdocs.pm/phoenix_html/Phoenix.HTML.Form.html) or an atom."
      )
    end
  end

  defmacro field do
    quote do
      attr(:field, :any, default: nil, doc: "Field name (atom or string).")
    end
  end

  defmacro name do
    quote do
      attr(:name, :string, doc: "Input name attribute (when not using `form` and `field`).")
    end
  end

  defmacro validation_message do
    quote do
      attr(:validation_message, :any,
        default: nil,
        doc: """
        Function to write a custom validation message (in case of error or success).

        The function receives a `PrimerLive.FieldState` struct and returns a validation message or nil.

        A validation message is shown:
        - If form is a `Phoenix.HTML.Form`, containing a `changeset`
        - The `validation_message` function does not return nil

        Function signatures:
        - `fun () -> string | nil`
        - `fun (field_state) -> string | nil`

        Conditional error message:
        ```
        fn field_state ->
          if !field_state.valid?, do: "Please enter your first name"
        end
        ```

        Conditional success message, only shown when `changeset.action` is `:validate`:
        ```
        fn field_state ->
          if field_state.valid? && field_state.changeset.action == :validate, do: "Is available"
        end
        ```
        """
      )
    end
  end

  defmacro validation_message_id do
    quote do
      attr(:validation_message_id, :any,
        doc: """
        Message ID that is usually passed from the form element component to `input_validation_message`. If not used, the ID will be generated.
        """
      )
    end
  end

  defmacro form_control(the_input_name) do
    quote do
      attr(:form_control, :map,
        doc:
          """
          Form control attributes. Places {the_input_name} inside a `form_control/1` component with given attributes, alongside `form` and `field` to generate a form control label.

          If only a automatically generated label is required, use convenience attr `is_form_control` instead.
          """
          |> String.replace("{the_input_name}", unquote(the_input_name))
      )
    end
  end

  defmacro deprecated_form_group(_the_input_name) do
    quote do
      attr(:form_group, :map,
        doc: """
        Deprecated: use `form_control`. Since `0.5.0`.
        """
      )
    end
  end

  defmacro is_form_control(the_input_name) do
    quote do
      attr(:is_form_control, :boolean,
        default: false,
        doc:
          """
          Places {the_input_name} inside a `form_control/1` component. Attributes `form` and `field` are automatically passed to `form_control` to generate a form control label. If the field is required, its label will show a required marker.

          To configure the form control and label, use attr `form_control`.
          """
          |> String.replace("{the_input_name}", unquote(the_input_name))
      )
    end
  end

  defmacro deprecated_is_form_group(_the_input_name) do
    quote do
      attr(:is_form_group, :boolean,
        default: false,
        doc: """
        Deprecated: use `is_form_control`. Since `0.5.0`.
        """
      )
    end
  end

  defmacro caption(the_element) do
    quote do
      attr(:caption, :any,
        default: nil,
        doc:
          """
          Hint message below {the_element}.

          Pass a string, or a function that returns a string.

          The function receives a `PrimerLive.FieldState` struct and returns a message or nil (which omits the caption element).

          Function signatures:
          - `fun () -> string | nil`
          - `fun (field_state) -> string | nil`

          To conditionally show a caption, use `field_state`. To show the caption when field state is valid:
          ```
          fn field_state ->
            if !field_state.valid?, do: nil, else: "Caption"
          end
          ```

          For additional markup, use the `H` sigil:
          ```
          fn ->
            ~H'''
            Caption with <a href="/">link</a>
            '''
          end
          ```
          """
          |> String.replace("{the_element}", unquote(the_element))
      )
    end
  end

  defmacro is_aligned_end(the_element) do
    quote do
      attr(:is_aligned_end, :boolean,
        default: false,
        doc:
          """
          Aligns {the_element} to the end (at the right in left-to-right languages).
          """
          |> String.replace("{the_element}", unquote(the_element))
      )
    end
  end

  # link attr

  defmacro href do
    quote do
      attr(:href, :any,
        doc: """
        Link attribute. The link is created with `Phoenix.Component.link/1`, passing all other attributes to the link.
        """
      )
    end
  end

  defmacro slot_href do
    quote do
      attr(:href, :any,
        doc: """
        Link attribute. The link is created with `Phoenix.Component.link/1`, passing all other slot attributes to the link.
        """
      )
    end
  end

  defmacro patch do
    quote do
      attr(:patch, :string,
        doc: """
        Link attribute - see `href`.
        """
      )
    end
  end

  defmacro navigate do
    quote do
      attr(:navigate, :string,
        doc: """
        Link attribute - see `href`.
        """
      )
    end
  end

  # rest attr

  defmacro rest(opts) do
    quote do
      attr(:rest, :global, unquote(opts))
    end
  end

  defmacro rest do
    quote do
      attr(:rest, :global)
    end
  end

  defmacro slot_rest do
    quote do
      attr(:rest, :any)
    end
  end

  # form_control attrs

  defmacro form_control_label do
    quote do
      attr(:label, :string,
        default: nil,
        doc: "Custom label. Note that a label is automatically generated when using `field`."
      )
    end
  end

  defmacro form_control_is_hide_label do
    quote do
      attr(:is_hide_label, :boolean,
        default: false,
        doc: "Omits the automatically generated label (when using `field`)."
      )
    end
  end

  defmacro form_control_is_disabled do
    quote do
      attr(:is_disabled, :boolean,
        default: false,
        doc: "Adjusts the styling to indicate disabled state."
      )
    end
  end

  defmacro form_control_deprecated_has_form_group do
    quote do
      attr(:deprecated_has_form_group, :boolean,
        default: false,
        doc:
          "Internal use: detects if deprecated `form_group` or `is_form_group` is used. Used to maintain consistent styling."
      )
    end
  end

  defmacro form_control_required_marker do
    quote do
      attr(:required_marker, :string,
        default: "*",
        doc:
          "Required field marking. This will be shown for all required fields (when using `Phoenix.HTML.Form`). Pass an empty string to remove the indicator."
      )
    end
  end

  defmacro form_control_for do
    quote do
      attr(:for, :string,
        default: nil,
        doc:
          "Internally used by `text_input/1` and `textarea/1` when using `is_form_control` or `form_control`. Label attribute to associate the label with the input. `for` should be the same as the input's `id`."
      )
    end
  end

  defmacro form_control_is_input_group do
    quote do
      attr(:is_input_group, :boolean,
        default: false,
        doc:
          "Creates styling for `checkbox_group/1` and `radio_group/1`: a larger label font size, and layout for inputs, captions and validation."
      )
    end
  end

  defmacro form_control_classes(component_name) do
    quote do
      attr(:classes, :map,
        default: %{
          control: nil,
          group: nil,
          header: nil,
          label: nil,
          input_group_container: nil,
          caption: nil
        },
        doc:
          """
          Additional classnames for {component_name} elements.

          Any provided value will be appended to the default classname.

          Default map:
          ```
          %{
            control: "",               # {component_name_title} wrapper
            group: "",                 # Deprecation support: identical to "control"
            header: "",                # Header element containing the group label
            label: "",                 # {component_name_title} label
            input_group_container: "", # Input group container (for checkbox_group and radio_group)
            caption: "",               # {component_name_title} caption
          }
          ```
          """
          |> String.replace(
            "{component_name_title}",
            unquote(component_name) |> Macro.camelize()
          )
          |> String.replace("{component_name}", unquote(component_name |> String.downcase()))
      )
    end
  end

  defmacro form_control_slot_inner_block(component_name) do
    quote do
      slot(:inner_block,
        required: true,
        doc:
          """
          {component_name} content.
          """
          |> String.replace("{component_name}", unquote(component_name))
          |> Macro.camelize()
      )
    end
  end

  # checkbox attrs

  defmacro checkbox_checked(the_component) do
    quote do
      attr(:checked, :boolean,
        doc:
          """
          The state of {the_component} (when not using `form` and `field`).
          """
          |> String.replace("{the_component}", unquote(the_component))
      )
    end
  end

  defmacro checkbox_checked_value(the_component) do
    quote do
      attr(:checked_value, :string,
        default: nil,
        doc:
          """
          The value to be sent when {the_component} is checked. If `checked_value` equals `value`, {the_component} is marked checked. Defaults to "true".
          """
          |> String.replace("{the_component}", unquote(the_component))
      )
    end
  end

  defmacro checkbox_hidden_input do
    quote do
      attr(:hidden_input, :string,
        default: "true",
        doc: """
        Controls if the component will generate a hidden input to submit the unchecked checkbox value or not. Defaults to "true".
        """
      )
    end
  end

  defmacro checkbox_value(component_name) do
    quote do
      attr(:value, :string,
        doc:
          """
          {component_name} value attribute (overrides field value when using `form` and `field`).
          """
          |> String.replace("{component_name}", unquote(component_name))
          |> Macro.camelize()
      )
    end
  end

  defmacro checkbox_is_multiple do
    quote do
      attr(:is_multiple, :boolean,
        default: false,
        doc: """
        When creating a list of checkboxes. Appends `[]` to the input name so that a list of values is passed to the form events.

        Alternatively, use `checkbox_in_group/1` to set this automatically.
        """
      )
    end
  end

  defmacro checkbox_is_emphasised_label do
    quote do
      attr(:is_emphasised_label, :boolean, default: false, doc: "Adds emphasis to the label.")
    end
  end

  defmacro checkbox_is_omit_label do
    quote do
      attr(:is_omit_label, :boolean, default: false, doc: "Omits the label.")
    end
  end

  defmacro checkbox_classes(component_name) do
    quote do
      attr(:classes, :map,
        default: %{
          container: nil,
          label_container: nil,
          label: nil,
          input: nil,
          caption: nil,
          hint: nil,
          disclosure: nil
        },
        doc:
          """
          Additional classnames for {component_name} elements.

          Any provided value will be appended to the default classname.

          Default map:
          ```
          %{
            container: "",       # {component_name_title} container
            label_container: "", # Input label container
            label: "",           # Input label
            input: "",           # {component_name_title} input element
            caption: "",         # Hint message element
            hint: "",            # Deprecation support: identical to "caption"
            disclosure: ""       # Disclosure container (inline)
          }
          ```
          """
          |> String.replace(
            "{component_name_title}",
            unquote(component_name) |> Macro.camelize()
          )
          |> String.replace("{component_name}", unquote(component_name |> String.downcase()))
      )
    end
  end

  defmacro checkbox_slot_label(component_name) do
    quote do
      alias PrimerLive.Helpers.DeclarationHelpers

      slot :label,
        doc:
          """
          Custom {component_name} label. Overides the derived label when using a `form` and `field`.
          """
          |> String.replace("{component_name}", unquote(component_name)) do
        DeclarationHelpers.slot_class()
        DeclarationHelpers.slot_style()
        DeclarationHelpers.slot_rest()
      end
    end
  end

  defmacro checkbox_slot_caption(the_component) do
    quote do
      alias PrimerLive.Helpers.DeclarationHelpers

      slot :caption,
        doc:
          """
          Adds text below {the_component} label. Enabled when a label is displayed.
          """
          |> String.replace("{the_component}", unquote(the_component)) do
        DeclarationHelpers.slot_class()
        DeclarationHelpers.slot_style()
        DeclarationHelpers.slot_rest()
      end
    end
  end

  defmacro checkbox_slot_hint do
    quote do
      alias PrimerLive.Helpers.DeclarationHelpers

      slot :hint,
        doc: """
        Deprecated: use `caption`. As of 0.5.0.
        """ do
        DeclarationHelpers.slot_class()
        DeclarationHelpers.slot_style()
        DeclarationHelpers.slot_rest()
      end
    end
  end

  defmacro checkbox_slot_disclosure(the_component) do
    quote do
      alias PrimerLive.Helpers.DeclarationHelpers

      slot :disclosure,
        doc:
          """
          Extra label content to be revealed when {the_component} is checked. Enabled when a label is displayed.

          Note that the label element can only contain inline child elements.
          """
          |> String.replace("{the_component}", unquote(the_component)) do
        DeclarationHelpers.slot_class()
        DeclarationHelpers.slot_style()
        DeclarationHelpers.slot_rest()
      end
    end
  end
end
