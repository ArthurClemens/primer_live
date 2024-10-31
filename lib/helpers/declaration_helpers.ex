defmodule PrimerLive.Helpers.DeclarationHelpers do
  @moduledoc false

  defmacro id do
    quote do
      attr(:id, :string, default: nil, doc: "Component DOM id.")
    end
  end

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

  defmacro slot_tabindex do
    quote do
      attr(:tabindex, :string, doc: "Tab index. Default \"0\".")
    end
  end

  defmacro slot_phx_click_and_target do
    quote do
      attr(:"phx-click", :string)
      attr(:"phx-target", :any)
    end
  end

  defmacro slot_phx_value_item(item) do
    quote do
      attr(:"phx-value-item", :any,
        doc:
          """
          The payload parameter for the selected value to be sent with an event.

          Examples:
          """ <>
            case unquote(item) do
              :menu_item ->
                """
                ```
                <:item :for={{label, role_id} <- @options}
                  phx-click="set_role"
                  phx-value-item={role_id}>
                  ...

                def handle_event(
                  "set_role", %{"item" => role_id, "value" => ""}, socket
                ) do
                  ...
                ```
                """

              :tab_item ->
                """
                ```
                <:item
                  :for={%{label: label, id: tab_id} <- @tabs}
                  is_selected={id == @selected_tab}
                  phx-click="set_tab"
                  phx-value-item={tab_id}
                >     
                  ...

                def handle_event(
                  "set_tab", %{"item" => tab_id}, socket) do
                  ...
                ```
                """

              :row ->
                """
                ```
                <:row
                  phx-click="select_row"
                  phx-value-item={row_id}
                >     
                  ...

                def handle_event(
                  "select_row", %{"item" => row_id}, socket) do
                  ...
                ```
                """

              :header_item ->
                """
                ```
                <:item
                  phx-click="set_preference"
                  phx-value-item={preference_id}
                >
                  ...

                def handle_event(
                  "set_preference", %{"item" => preference_id}, socket) do
                  ...
                ```
                """

              _ ->
                ""
            end
      )
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

  defmacro common_input_attrs do
    quote do
      attr(:common_input_attrs, :map,
        default: nil,
        doc: "Used to pass calculated attributes from an input component to the form control."
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
      attr(:validation_message_id, :string,
        default: nil,
        doc: """
        Message ID that is usually passed from the form element component to `input_validation_message`. If not used, the ID will be generated.
        """
      )
    end
  end

  defmacro form_control(the_input_name) do
    quote do
      attr(:form_control, :map,
        default: nil,
        doc:
          """
          Form control attributes. Places {the_input_name} inside a `form_control/1` component with given attributes, alongside `form` and `field` to generate a form control label.

          If only a automatically generated label is required, use convenience attr `is_form_control` instead.
          """
          |> String.replace("{the_input_name}", unquote(the_input_name))
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
          Aligns {the_element} at the end (at the right in left-to-right languages and at the left in right-to-left languages).
          """
          |> String.replace("{the_element}", unquote(the_element))
      )
    end
  end

  defmacro offset_x(the_element) do
    quote do
      attr(:offset_x, :integer,
        values: [nil, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
        default: nil,
        doc:
          """
          The absolute offset for the {the_element} on the horizontal axis. By default this is the start offset (at the left in left-to-right languages and at the right in right-to-left languages), unless `is_aligned_end` is used, in which case the value defines the end offset.
          Integer values are translated to px values using the Primer Design System's base-8 scale, as documented in [CSS Utilities: Margin](https://primer.style/foundations/css-utilities/margin):
          - `0`: `0`
          - `1`: `4px`
          - `2`: `8px`
          - `3`: `16px`
          - `4`: `24px`
          - `5`: `32px`
          - `6`: `40px`
          - `7`: `48px`
          - `8`: `64px`
          - `9`: `80px`
          - `10`: `96px`
          - `11`: `112px`
          - `12`: `128px`
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

  defmacro form_control_legend_label do
    quote do
      attr(:label, :string,
        default: nil,
        doc: "Fieldset legend label."
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
          caption: nil,
          fieldset: nil,
          legend: nil
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
            fieldset: "",              # Fieldset wrapper (for checkbox_group and radio_group) 
            legend: "",                # Legend (for checkbox_group and radio_group)
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

  defmacro form_control_attrs do
    quote do
      alias PrimerLive.Helpers.DeclarationHelpers

      DeclarationHelpers.caption("the form control label")
      DeclarationHelpers.checkbox_is_multiple()
      DeclarationHelpers.class()
      DeclarationHelpers.common_input_attrs()
      DeclarationHelpers.field()
      DeclarationHelpers.form_control_classes("form control")
      DeclarationHelpers.form_control_for()
      DeclarationHelpers.form_control_is_disabled()
      DeclarationHelpers.form_control_is_hide_label()
      DeclarationHelpers.form_control_is_input_group()
      DeclarationHelpers.form_control_label()
      DeclarationHelpers.form_control_required_marker()
      DeclarationHelpers.form_control_slot_inner_block("The form control")
      DeclarationHelpers.form()
      DeclarationHelpers.input_id()
      DeclarationHelpers.rest()
      DeclarationHelpers.validation_message_id()
      DeclarationHelpers.validation_message()
      attr :is_wrap_in_fieldset, :boolean, default: false
      attr(:is_full_width, :boolean, default: false, doc: "Full width control.")
    end
  end
end
