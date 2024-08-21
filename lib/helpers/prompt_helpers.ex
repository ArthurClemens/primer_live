defmodule PrimerLive.Helpers.PromptHelpers do
  @moduledoc false

  alias Phoenix.LiveView.JS

  def open_prompt(id) when is_binary(id), do: open_prompt(%JS{}, id)
  def open_prompt(_), do: %JS{}

  def open_prompt(%JS{} = js, id) when is_binary(id) do
    JS.exec(js, "data-open", to: "##{id}")
  end

  def open_prompt(_, _), do: %JS{}

  def close_prompt(id) when is_binary(id), do: close_prompt(%JS{}, id)
  def close_prompt(_), do: %JS{}

  def close_prompt(%JS{} = js, id) when is_binary(id) do
    JS.exec(js, "data-close", to: "##{id}")
  end

  def close_prompt(_, _), do: %JS{}

  def cancel_prompt(id) when is_binary(id), do: cancel_prompt(%JS{}, id)
  def cancel_prompt(_), do: %JS{}

  def cancel_prompt(%JS{} = js, id) when is_binary(id) do
    JS.exec(js, "data-cancel", to: "##{id}")
  end

  def cancel_prompt(_, _), do: %JS{}
end
