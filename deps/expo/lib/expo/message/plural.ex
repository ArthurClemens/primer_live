defmodule Expo.Message.Plural do
  @moduledoc """
  Struct for plural messages.

  For example:

      msgid "Cat"
      msgid_plural "Cats"
      msgstr ""

  See [`%Expo.Message.Plural{}`](`__struct__/0`) for documentation on the fields of this struct.
  """

  alias Expo.Message
  alias Expo.Util

  @typedoc """
  The "component" of a message.
  """
  @type block :: :msgid | {:msgstr, non_neg_integer()} | :msgctxt | :msgid_plural

  @opaque meta :: %{optional(:source_line) => %{block() => non_neg_integer()}}

  @type t :: %__MODULE__{
          msgid: Message.msgid(),
          msgid_plural: [Message.msgid()],
          msgstr: %{required(non_neg_integer()) => Message.msgstr()},
          msgctxt: Message.msgctxt() | nil,
          comments: [String.t()],
          extracted_comments: [String.t()],
          flags: [[String.t()]],
          previous_messages: [Message.t()],
          references: [[file :: String.t() | {file :: String.t(), line :: pos_integer()}]],
          obsolete: boolean(),
          __meta__: meta()
        }

  @doc """
  The struct for a plural message.

  All fields in this struct are public except for `:__meta__`. The `:flags` and `:references`
  fields are defined as lists of lists in order to represent **lines** in the original file. For
  example, this message:

      #, flag1, flag2
      #, flag3
      #: a.ex:1
      #: b.ex:2 c.ex:3
      msgid "Hello"
      msgstr ""

  would have:

    * `flags: [["flag1", "flag2"], ["flag3"]]`
    * `references: [["a.ex:1"], ["b.ex:2", "c.ex:3"]]`

  You can use `Expo.Message.has_flag?/2` to make it easier to check whether a message
  has a given flag.
  """
  @enforce_keys [:msgid, :msgid_plural]
  @derive {Inspect, except: [:__meta__]}
  defstruct [
    :msgid,
    :msgid_plural,
    msgstr: %{},
    msgctxt: nil,
    comments: [],
    extracted_comments: [],
    flags: [],
    previous_messages: [],
    references: [],
    obsolete: false,
    __meta__: %{}
  ]

  @doc """
  Returns the **key** of the message.

  The key takes the msgctxt into consideration by returning a tuple `{msgctxt, msgid}`.
  Both `msgctxt` and `msgid` are normalized to binaries (instead of keeping line information)
  for easier comparison.

  ## Examples

      iex> Plural.key(%Plural{msgid: ["cat"], msgid_plural: ["cats"]})
      {"", {"cat", "cats"}}

  """
  @doc since: "0.5.0"
  @spec key(t()) :: {String.t(), {String.t(), String.t()}}
  def key(%__MODULE__{msgctxt: msgctxt, msgid: msgid, msgid_plural: msgid_plural} = _message) do
    {IO.iodata_to_binary(msgctxt || []),
     {IO.iodata_to_binary(msgid), IO.iodata_to_binary(msgid_plural)}}
  end

  @doc """
  Re-balances all strings in the message.

  This function does these things:

    * Put one string per newline of `msgid`/`msgid_plural`/`msgstr`
    * Put all flags onto one line
    * Put all references onto a separate line

  ### Examples

      iex> Plural.rebalance(%Plural{
      ...>   msgid: ["", "hello", "\\n", "", "world", ""],
      ...>   msgid_plural: ["", "hello", "\\n", "", "world", ""],
      ...>   msgstr: %{0 => ["", "hello", "\\n", "", "world", ""]},
      ...>   flags: [["one", "two"], ["three"]],
      ...>   references: [[{"one", 1}, {"two", 2}], ["three"]]
      ...> })
      %Plural{
        msgid: ["hello\\n", "world"],
        msgid_plural: ["hello\\n", "world"],
        msgstr: %{0 => ["hello\\n", "world"]},
        flags: [["one", "two", "three"]],
        references: [[{"one", 1}], [{"two", 2}], ["three"]]
      }

  """
  @spec rebalance(t()) :: t()
  def rebalance(
        %__MODULE__{
          msgid: msgid,
          msgid_plural: msgid_plural,
          msgstr: msgstr,
          flags: flags,
          references: references
        } = message
      ) do
    flags =
      case List.flatten(flags) do
        [] -> []
        flags -> [flags]
      end

    %__MODULE__{
      message
      | msgid: Util.rebalance_strings(msgid),
        msgid_plural: Util.rebalance_strings(msgid_plural),
        msgstr:
          Map.new(msgstr, fn {index, strings} -> {index, Util.rebalance_strings(strings)} end),
        flags: flags,
        references: references |> List.flatten() |> Enum.map(&List.wrap/1)
    }
  end

  @doc """
  Get the source line number of the message.

  ## Examples

      iex> %Expo.Messages{messages: [message]} = Expo.PO.parse_string!(\"""
      ...> msgid "foo"
      ...> msgid_plural "foos"
      ...> msgstr[0] "bar"
      ...> \""")
      iex> Plural.source_line_number(message, :msgid)
      1
      iex> Plural.source_line_number(message, {:msgstr, 0})
      3

  """
  @spec source_line_number(t(), block(), default) :: non_neg_integer() | default
        when default: term()
  def source_line_number(%__MODULE__{__meta__: meta} = _message, block, default \\ nil)
      when block in [:msgid, :msgid_plural, :msgctxt] or
             (is_tuple(block) and elem(block, 0) == :msgstr and is_integer(elem(block, 1))) do
    meta[:source_line][block] || default
  end
end
