defmodule Expo.Message do
  @moduledoc """
  Functions to work on message structs (`Expo.Message.Singular` and `Expo.Message.Plural`).

  A message is a single PO singular or plural message. For example:

      msgid "Hello"
      msgstr ""

  Message structs are used both to represent reference messages (where the `msgstr` is empty)
  in POT files as well as actual translations.
  """

  alias Expo.Message.{Plural, Singular}

  @type msgid :: [String.t(), ...]
  @type msgstr :: [String.t(), ...]
  @type msgctxt :: String.t()

  @type t :: Singular.t() | Plural.t()

  @typedoc """
  The key that can be used to identify a message.

  See `key/1`.
  """
  @opaque key ::
            {msgctxt :: String.t(),
             msgid :: String.t() | {msgid :: String.t(), msgid_plural :: String.t()}}

  @doc """
  Returns a "key" that can be used to identify a message.

  This function returns a "key" that can be used to uniquely identify a
  message assuming that no "same" messages exist; for what "same"
  means, look at the documentation for `same?/2`.

  The purpose of this function is to be used in situations where we'd like to
  group or sort messages but where we don't need the whole structs.

  ## Examples

      iex> t1 = %Expo.Message.Singular{msgid: ["foo"]}
      iex> t2 = %Expo.Message.Singular{msgid: ["", "foo"]}
      iex> Expo.Message.key(t1) == Expo.Message.key(t2)
      true

      iex> t1 = %Expo.Message.Singular{msgid: ["foo"]}
      iex> t2 = %Expo.Message.Singular{msgid: ["bar"]}
      iex> Expo.Message.key(t1) == Expo.Message.key(t2)
      false

  """
  @spec key(t()) :: key()
  def key(message)
  def key(%Singular{} = message), do: Singular.key(message)
  def key(%Plural{} = message), do: Plural.key(message)

  @doc """
  Tells whether two messages are the same message according to their
  `msgid`.

  This function returns `true` if `message1` and `message2` are the same
  message, where "the same" means they have the same `msgid` or the same
  `msgid` and `msgid_plural`.

  ## Examples

      iex> t1 = %Expo.Message.Singular{msgid: ["foo"]}
      iex> t2 = %Expo.Message.Singular{msgid: ["", "foo"]}
      iex> Expo.Message.same?(t1, t2)
      true

      iex> t1 = %Expo.Message.Singular{msgid: ["foo"]}
      iex> t2 = %Expo.Message.Singular{msgid: ["bar"]}
      iex> Expo.Message.same?(t1, t2)
      false

  """
  @spec same?(t(), t()) :: boolean
  def same?(message1, message2), do: key(message1) == key(message2)

  @doc """
  Tells whether the given `message` has the given `flag` specified.

  ### Examples

      iex> Expo.Message.has_flag?(%Expo.Message.Singular{msgid: [], flags: [["foo"]]}, "foo")
      true

      iex> Expo.Message.has_flag?(%Expo.Message.Singular{msgid: [], flags: [["foo"]]}, "bar")
      false

  """
  @spec has_flag?(t(), String.t()) :: boolean()
  def has_flag?(%mod{flags: flags} = _message, flag)
      when mod in [Singular, Plural] and is_binary(flag) do
    flag in List.flatten(flags)
  end

  @doc """
  Appends the given `flag` to the given `message`.

  Keeps the line formatting intact.

  ### Examples

      iex> message = %Expo.Message.Singular{msgid: [], flags: []}
      iex> Expo.Message.append_flag(message, "foo")
      %Expo.Message.Singular{msgid: [], flags: [["foo"]]}

  """
  @spec append_flag(t(), String.t()) :: t()
  def append_flag(%mod{flags: flags} = message, flag) when mod in [Singular, Plural] do
    flags =
      if has_flag?(message, flag) do
        flags
      else
        case flags do
          [] -> [[flag]]
          [flag_line] -> [flag_line ++ [flag]]
          _multiple_lines -> flags ++ [[flag]]
        end
      end

    struct!(message, flags: flags)
  end

  @doc """
  Get the source line number of the message.

  ## Examples

      iex> %Expo.Messages{messages: [message]} = Expo.PO.parse_string!(\"""
      ...> msgid "foo"
      ...> msgstr "bar"
      ...> \""")
      iex> Expo.Message.source_line_number(message, :msgid)
      1

  """
  @spec source_line_number(Singular.t(), Singular.block(), default) :: non_neg_integer() | default
        when default: term
  @spec source_line_number(Plural.t(), Plural.block(), default) :: non_neg_integer() | default
        when default: term
  def source_line_number(%mod{} = message, block, default \\ nil)
      when mod in [Singular, Plural] do
    mod.source_line_number(message, block, default)
  end
end
