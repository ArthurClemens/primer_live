defmodule PrimerLive.Helpers.FormHelpers do
  @moduledoc false
  # Helper functions for components that interact with forms and changesets.

  import Phoenix.HTML.Form
  use PhoenixHTMLHelpers

  # Map of input name to atom value that can be used by Phoenix.HTML.Form to render the appropriate input element.
  @text_input_types %{
    "color" => :color_input,
    "date" => :date_input,
    "datetime-local" => :datetime_local_input,
    "email" => :email_input,
    "file" => :file_input,
    "hidden" => :hidden_input,
    "number" => :number_input,
    "password" => :password_input,
    "range" => :range_input,
    "search" => :search_input,
    "telephone" => :telephone_input,
    "text" => :text_input,
    "textarea" => :textarea,
    "time" => :time_input,
    "url" => :url_input
  }

  def text_input_types, do: @text_input_types

  @doc """
  Validates if the input is a form.
  """
  def form?(%Phoenix.HTML.Form{}), do: true

  # Handle other types of forms
  def form?(%_{} = maybe_form)
      when not is_nil(maybe_form.__struct__) do
    form_type = "#{maybe_form.__struct__}"

    String.contains?(form_type, "AshPhoenix.Form")
  end

  def form?(_), do: false

  @doc """
  Returns a `PrimerLive.FieldState` struct to facilitate display logic in component rendering functions.

      iex> PrimerLive.Helpers.FormHelpers.field_state(:f, :first_name, nil, nil)
      %PrimerLive.FieldState{valid?: false, changeset: nil, message: nil, field_errors: [], caption: nil}

      # If validation_message_fn returns a string it will be added to FieldState, regardless of the changeset action value:
      iex> changeset = PrimerLive.TestHelpers.Repo.Users.init()
      ...> update_changeset = %Ecto.Changeset{changeset |
      ...>   action: :update,
      ...>   changes: %{first_name: "annette"}
      ...> }
      ...> PrimerLive.Helpers.FormHelpers.field_state(
      ...>   %Phoenix.HTML.Form{
      ...>     impl: Phoenix.HTML.FormData.Ecto.Changeset,
      ...>     source: update_changeset
      ...>   },
      ...>   :first_name,
      ...>   fn _field_state -> "always" end,
      ...>   nil
      ...> )
      %PrimerLive.FieldState{valid?: false, required?: true, changeset: update_changeset, message: "always", field_errors: ["can't be blank"]}

      # If changeset action is :validate and no validation_message_fn is provided, the default field error is added to FieldState:
      iex> changeset = PrimerLive.TestHelpers.Repo.Users.init()
      ...> validate_changeset = %Ecto.Changeset{changeset |
      ...>   action: :validate,
      ...>   changes: %{first_name: "annette"}
      ...> }
      ...> PrimerLive.Helpers.FormHelpers.field_state(
      ...>   %Phoenix.HTML.Form{
      ...>     impl: Phoenix.HTML.FormData.Ecto.Changeset,
      ...>     source: validate_changeset
      ...>   },
      ...>   :first_name,
      ...>   nil,
      ...>   nil
      ...> )
      %PrimerLive.FieldState{valid?: false, required?: true, changeset: validate_changeset, message: "can't be blank", field_errors: ["can't be blank"]}

      # Custom success message: if changeset action is :update and a validation_message_fn is provided, the resulting message is added to FieldState:
      iex> changeset = PrimerLive.TestHelpers.Repo.Users.init()
      ...> update_changeset = %Ecto.Changeset{changeset |
      ...>   action: :update,
      ...>   changes: %{first_name: "annette"},
      ...>   errors: [],
      ...>   valid?: true,
      ...> }
      ...> PrimerLive.Helpers.FormHelpers.field_state(
      ...>   %Phoenix.HTML.Form{
      ...>     impl: Phoenix.HTML.FormData.Ecto.Changeset,
      ...>     source: update_changeset,
      ...>   },
      ...>   :first_name,
      ...>   fn field_state -> if field_state.valid?, do: "Great!" end,
      ...>   nil
      ...> )
      %PrimerLive.FieldState{valid?: true, required?: true, changeset: update_changeset, message: "Great!", field_errors: []}

      # Caption: return a caption if changeset is nil
      iex> PrimerLive.Helpers.FormHelpers.field_state(nil, nil, nil, fn _field_state -> "Caption" end)
      %PrimerLive.FieldState{required?: false, valid?: false, changeset: nil, message: nil, field_errors: [], caption: "Caption"}

      # Caption: return a static caption
      iex> PrimerLive.Helpers.FormHelpers.field_state(:f, :first_name, nil, "Caption")
      %PrimerLive.FieldState{required?: false, valid?: false, changeset: nil, message: nil, field_errors: [], caption: "Caption"}

      # Caption: return a caption regardless the state
      iex> PrimerLive.Helpers.FormHelpers.field_state(:f, :first_name, nil, fn _field_state -> "Caption" end)
      %PrimerLive.FieldState{required?: false, valid?: false, changeset: nil, message: nil, field_errors: [], caption: "Caption"}

      # Caption: return a caption dependent on the state
      iex> changeset = PrimerLive.TestHelpers.Repo.Users.init()
      ...> validate_changeset = %Ecto.Changeset{changeset |
      ...>   action: :validate,
      ...>   changes: %{first_name: "annette"}
      ...> }
      ...> PrimerLive.Helpers.FormHelpers.field_state(
      ...>   %Phoenix.HTML.Form{
      ...>     impl: Phoenix.HTML.FormData.Ecto.Changeset,
      ...>     source: validate_changeset
      ...>   },
      ...>   :first_name,
      ...>   nil,
      ...>   fn field_state -> if !field_state.valid?, do: "Please select your availability" end
      ...> )
      %PrimerLive.FieldState{caption: "Please select your availability", changeset: validate_changeset, field_errors: ["can't be blank"], ignore_errors?: false, message: "can't be blank", message_id: nil, required?: true, valid?: false}
  """
  def field_state(maybe_form, field, validation_message_fn, caption_fn) do
    form = get_form(maybe_form)
    changeset = get_form_changeset(form)

    get_field_state_for_changeset(
      form,
      changeset,
      %PrimerLive.FieldState{},
      field,
      validation_message_fn,
      caption_fn
    )
  end

  defp get_field_state_for_changeset(
         _form,
         changeset,
         field_state,
         _field,
         _validation_message_fn,
         caption_fn
       )
       when is_nil(changeset) do
    caption = get_caption(field_state, caption_fn)
    %{field_state | caption: caption}
  end

  defp get_field_state_for_changeset(
         form,
         changeset,
         field_state,
         field,
         validation_message_fn,
         caption_fn
       ) do
    with field_errors <- get_field_errors(changeset, field),
         required? <- get_field_required(form, changeset, field),
         valid? <- Enum.empty?(field_errors),
         field_state <- %{
           field_state
           | valid?: valid?,
             ignore_errors?: is_nil(changeset.action) && !valid?,
             field_errors: field_errors,
             changeset: changeset,
             required?: required?
         },
         message <-
           get_message(changeset.action, field_errors, field_state, validation_message_fn),
         caption <-
           get_caption(field_state, caption_fn) do
      %{field_state | message: message, caption: caption}
    end
  end

  # changeset.action is nil
  defp get_message(nil, _field_errors, _field_state, _), do: nil

  # validation_message_fn is nil, field_errors is empty
  defp get_message(_changeset_action, field_errors, _field_state, nil) when field_errors == [],
    do: nil

  # validation_message_fn is nil, field_errors exists
  defp get_message(_changeset_action, field_errors, _field_state, nil) do
    [field_error | _rest] = field_errors
    field_error
  end

  # validation_message_fn exists
  defp get_message(_changeset_action, _field_errors, field_state, validation_message_fn) do
    case :erlang.fun_info(validation_message_fn)[:arity] do
      0 -> validation_message_fn.()
      1 -> validation_message_fn.(field_state)
      _ -> nil
    end
  end

  defp get_caption(_field_state, nil), do: nil
  defp get_caption(_field_state, []), do: nil
  defp get_caption(_field_state, caption_str) when is_binary(caption_str), do: caption_str
  defp get_caption(_field_state, caption_slot) when is_list(caption_slot), do: nil

  defp get_caption(field_state, caption_fn) do
    case :erlang.fun_info(caption_fn)[:arity] do
      0 -> caption_fn.()
      1 -> caption_fn.(field_state)
      _ -> nil
    end
  end

  @doc """
  Extracts the form struct from either a form struct or a nested struct that contains a form.

      iex> changeset = PrimerLive.TestHelpers.Repo.Users.init()
      ...> PrimerLive.Helpers.FormHelpers.get_form(%Phoenix.HTML.Form{
      ...>   impl: Phoenix.HTML.FormData.Ecto.Changeset,
      ...>   source: changeset
      ...> })
      %Phoenix.HTML.Form{source: changeset, impl: Phoenix.HTML.FormData.Ecto.Changeset}

      iex> changeset = PrimerLive.TestHelpers.Repo.Users.init()
      ...> PrimerLive.Helpers.FormHelpers.get_form(%Phoenix.HTML.Form{
      ...>   impl: Phoenix.HTML.FormData.Ecto.Changeset,
      ...>   source: %Phoenix.HTML.Form{
      ...>     impl: Phoenix.HTML.FormData.Ecto.Changeset,
      ...>     source: %Ecto.Changeset{changeset |
      ...>       action: :update,
      ...>       changes: %{first_name: "annette"}
      ...>     }
      ...>   }
      ...> })
      %Phoenix.HTML.Form{source: %Ecto.Changeset{changeset | action: :update, changes: %{first_name: "annette"}}, impl: Phoenix.HTML.FormData.Ecto.Changeset}

      iex> PrimerLive.Helpers.FormHelpers.get_form(%PrimerLive.Helpers.TestForm{
      ...>   impl: Phoenix.HTML.FormData.Ecto.Changeset,
      ...>   source: %PrimerLive.Helpers.TestForm{
      ...>     impl: Phoenix.HTML.FormData.Ecto.Changeset,
      ...>     source: %Phoenix.HTML.Form{
      ...>       impl: Phoenix.HTML.FormData.Ecto.Changeset
      ...>     }
      ...>   }
      ...> })
      %Phoenix.HTML.Form{source: nil, impl: Phoenix.HTML.FormData.Ecto.Changeset, id: nil, name: nil, data: nil, hidden: [], params: %{}, errors: [], options: [], index: nil, action: nil}

      iex> PrimerLive.Helpers.FormHelpers.get_form(:form)
      nil
  """
  # Handle different kinds of forms
  def get_form(%_{source: _} = maybe_form) when not is_nil(maybe_form.source.__struct__) do
    form_type = "#{maybe_form.source.__struct__}"

    if form_type |> String.contains?("Form") do
      # Find a possible nested form
      get_form(maybe_form.source)
    else
      maybe_form
    end
  end

  def get_form(%Phoenix.HTML.Form{} = form) do
    form
  end

  def get_form(_), do: nil

  @doc """
  Gets the form name - either an atom or a string.

      iex> changeset = PrimerLive.TestHelpers.Repo.Users.init()
      ...> PrimerLive.Helpers.FormHelpers.get_form_name(%Phoenix.HTML.Form{
      ...>   impl: Phoenix.HTML.FormData.Ecto.Changeset,
      ...>   name: :profile,
      ...>   source: changeset
      ...> })
      :profile

      iex> PrimerLive.Helpers.FormHelpers.get_form_name(%PrimerLive.Helpers.TestForm{
      ...>   impl: Phoenix.HTML.FormData.Ecto.Changeset,
      ...>   source: %PrimerLive.Helpers.TestForm{
      ...>     name: "test",
      ...>     source: %Phoenix.HTML.Form{
      ...>       name: "profile",
      ...>     }
      ...>   }
      ...> })
      "profile"

      iex> PrimerLive.Helpers.FormHelpers.get_form_name(:profile)
      :profile

      iex> PrimerLive.Helpers.FormHelpers.get_form_name("profile")
      "profile"

      iex> PrimerLive.Helpers.FormHelpers.get_form_name(1)
      nil

      iex> PrimerLive.Helpers.FormHelpers.get_form_name(nil)
      nil
  """
  def get_form_name(%_{source: _} = maybe_form) when not is_nil(maybe_form.source.__struct__) do
    if "#{maybe_form.source.__struct__}" |> String.contains?("Form") do
      get_form_name(maybe_form.source)
    else
      get_form_name(maybe_form.name)
    end
  end

  def get_form_name(name) when is_atom(name), do: name
  def get_form_name(name) when is_binary(name), do: name

  def get_form_name(%Phoenix.HTML.Form{} = form) do
    form.name
  end

  def get_form_name(_), do: nil

  @doc """
  Returns the form changeset extracted from `form.source`.
  Returns nil if no changeset is found.

      iex> PrimerLive.Helpers.FormHelpers.get_form_changeset(nil)
      nil

      iex> PrimerLive.Helpers.FormHelpers.get_form_changeset(%{})
      nil

      iex> PrimerLive.Helpers.FormHelpers.get_form_changeset(%Phoenix.HTML.Form{})
      nil

      iex> PrimerLive.Helpers.FormHelpers.get_form_changeset(%Phoenix.HTML.Form{
      ...>   source: %Ecto.Changeset{}
      ...> })
      %Ecto.Changeset{action: nil, changes: %{}, errors: [], data: nil, valid?: false}
  """

  # Handle other types of changesets
  def get_form_changeset(%_{source: _} = form_or_changeset)
      when not is_nil(form_or_changeset.source.__struct__) do
    form_or_changeset_type = "#{form_or_changeset.source.__struct__}"

    if String.contains?(form_or_changeset_type, "Ash.Changeset") do
      ash_changeset = form_or_changeset
      _get_ash_framework_changeset(ash_changeset)
    else
      form_or_changeset.source
    end
  end

  def get_form_changeset(%Phoenix.HTML.Form{source: _} = form) do
    form.source
  end

  def get_form_changeset(_form), do: nil

  # Handle other types of changesets: Ash Framework
  def _get_ash_framework_changeset(ash_changeset), do: ash_changeset.source

  @doc """
  Returns all errors for a given field from a changeset.

      iex> changeset = PrimerLive.TestHelpers.Repo.Users.init()
      ...> PrimerLive.Helpers.FormHelpers.get_field_errors(
      ...>   %Ecto.Changeset{
      ...>     changeset | action: :update, errors: []
      ...>   },
      ...>   :first_name
      ...> )
      []

      iex> changeset = PrimerLive.TestHelpers.Repo.Users.init()
      ...> PrimerLive.Helpers.FormHelpers.get_field_errors(
      ...>   %Ecto.Changeset{
      ...>     changeset | action: :update,
      ...>       errors: [
      ...>         first_name: {"can't be blank", [validation: :required]},
      ...>         work_experience: {"invalid value", [validation: :required]}
      ...>       ],
      ...>   },
      ...>   :first_name
      ...> )
      ["can't be blank"]

      iex> changeset = PrimerLive.TestHelpers.Repo.Users.init()
      ...> PrimerLive.Helpers.FormHelpers.get_field_errors(
      ...>   %Ecto.Changeset{
      ...>     changeset | action: :update,
      ...>       errors: [
      ...>         first_name: {"should be at most %{count} character(s)",
      ...>         [count: 255, validation: :length, kind: :max, type: :string]}
      ...>       ],
      ...>   },
      ...>   :first_name
      ...> )
      ["should be at most 255 character(s)"]

      iex> changeset = PrimerLive.TestHelpers.Repo.Users.init()
      ...> PrimerLive.Helpers.FormHelpers.get_field_errors(
      ...>   %Ecto.Changeset{
      ...>     changeset | action: :update,
      ...>       errors: [
      ...>         first_name: {"can't be blank", [validation: :required]},
      ...>         work_experience: {"invalid value", [validation: :required]}
      ...>       ],
      ...>   },
      ...>   :work_experience
      ...> )
      ["invalid value"]
  """
  def get_field_errors(%Ecto.Changeset{} = changeset, field) do
    changeset.errors
    |> Enum.filter(fn {error_field, _content} -> error_field == field end)
    |> Enum.map(fn {_error_field, {content, details}} ->
      interpolate_error_details(content, details)
    end)
  end

  # Handle other types of changesets
  def get_field_errors(%_{} = maybe_changeset, field)
      when not is_nil(maybe_changeset.__struct__) do
    changeset_type = "#{maybe_changeset.__struct__}"

    if String.contains?(changeset_type, "Ash.Changeset") do
      ash_changeset = maybe_changeset
      _get_ash_framework_field_errors(ash_changeset, field)
    else
      []
    end
  end

  def get_field_errors(_, _), do: []

  # Handle other types of changesets: Ash Framework
  def _get_ash_framework_field_errors(ash_changeset, field) do
    if Map.has_key?(ash_changeset.attributes, field) do
      ash_changeset.errors
      |> Enum.filter(fn ash_error -> ash_error.field == field end)
      |> Enum.map(fn ash_error ->
        code_to_eval =
          if Kernel.function_exported?(Ash.Error.Changes.Required, :id, 1),
            do: "Ash.ErrorKind.message(e)",
            else: "Exception.message(e)"

        {message, _binding} =
          Code.eval_string(code_to_eval, [e: ash_error],
            file: __ENV__.file,
            line: __ENV__.line
          )

        message
      end)
    else
      []
    end
  end

  @doc """
  Returns the required state for a given field from a changeset.

      iex> changeset = PrimerLive.TestHelpers.Repo.Users.init()
      ...> PrimerLive.Helpers.FormHelpers.get_field_required(
      ...>   %Phoenix.HTML.Form{
      ...>     impl: Phoenix.HTML.FormData.Ecto.Changeset,
      ...>     data: nil,
      ...>     source: changeset
      ...>  },
      ...>  changeset,
      ...>  :first_name
      ...> )
      true

      iex> changeset = PrimerLive.TestHelpers.Repo.Users.init()
      ...> PrimerLive.Helpers.FormHelpers.get_field_required(
      ...>   %Phoenix.HTML.Form{
      ...>     impl: Phoenix.HTML.FormData.Ecto.Changeset,
      ...>     data: nil,
      ...>     source: changeset
      ...>  },
      ...>  changeset,
      ...>  :work_experience
      ...> )
      false
  """
  def get_field_required(%Phoenix.HTML.Form{} = form, %Ecto.Changeset{} = _changeset, field) do
    input_validations(form, field)[:required] == true
  end

  # Handle other types of changesets
  def get_field_required(form, %_{} = maybe_changeset, field)
      when not is_nil(maybe_changeset.__struct__) do
    changeset_type = "#{maybe_changeset.__struct__}"

    if String.contains?(changeset_type, "Ash.Changeset") do
      ash_changeset = maybe_changeset
      get_ash_framework_field_required(form, ash_changeset, field)
    else
      false
    end
  end

  def get_field_required(_, _), do: false

  # Handle other types of changesets: Ash Framework
  defp get_ash_framework_field_required(form, ash_changeset, field) do
    Phoenix.HTML.FormData.input_validations(form, ash_changeset, field)[:required] == true
  end

  @doc """
  Get the input type atom from a name, e.g. "search" returns :search_input

  ## Tests

      iex> PrimerLive.Helpers.FormHelpers.text_input_type_as_atom("x")
      :text_input

      iex> PrimerLive.Helpers.FormHelpers.text_input_type_as_atom("text")
      :text_input

      iex> PrimerLive.Helpers.FormHelpers.text_input_type_as_atom("color")
      :color_input

  """
  def text_input_type_as_atom(type_name) do
    input_type = Map.get(text_input_types(), type_name)

    if is_nil(input_type), do: :text_input, else: input_type
  end

  defp interpolate_error_details(content, details) do
    Enum.reduce(details, content, fn {key, value}, content ->
      String.replace(content, "%{#{key}}", "#{inspect(value)}")
    end)
  end
end
