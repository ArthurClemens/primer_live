defmodule PrimerLive.Helpers.PromptHelpers do
  @moduledoc false

  alias Phoenix.LiveView.JS

  def default_menu_transition_duration, do: 130
  def default_dialog_transition_duration, do: 170

  def open_prompt(id) when is_binary(id), do: open_prompt(%JS{}, id)
  def open_prompt(_), do: %JS{}
  def open_prompt(%JS{} = js, id) when is_binary(id), do: JS.exec(js, "data-open", to: "##{id}")

  def open_prompt(_, _), do: %JS{}

  def close_prompt(id) when is_binary(id), do: close_prompt(%JS{}, id)
  def close_prompt(_), do: %JS{}
  def close_prompt(%JS{} = js, id) when is_binary(id), do: JS.exec(js, "data-close", to: "##{id}")

  def close_prompt(_, _), do: %JS{}

  def cancel_prompt(id) when is_binary(id), do: cancel_prompt(%JS{}, id)
  def cancel_prompt(_), do: %JS{}

  def cancel_prompt(%JS{} = js, id) when is_binary(id),
    do: JS.exec(js, "data-cancel", to: "##{id}")

  def cancel_prompt(_, _), do: %JS{}

  def toggle_prompt(id) when is_binary(id), do: toggle_prompt(%JS{}, id)

  def toggle_prompt(%JS{} = js, id) when is_binary(id),
    do: JS.dispatch(js, "prompt:toggle", to: "##{id}")
end
