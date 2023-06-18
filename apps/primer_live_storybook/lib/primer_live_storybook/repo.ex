defmodule PrimerLiveStorybook.Repo do
  use Ecto.Repo,
    otp_app: :primer_live_storybook,
    adapter: Ecto.Adapters.Postgres

  alias PrimerLiveStorybook.{JobDescription, JobDescriptions, Todos, Todo, UIState, UIStates}

  # JobDescription

  def empty_job_description() do
    %JobDescription{}
  end

  def init_job_description() do
    JobDescriptions.init()
  end

  def change_job_description(%JobDescription{} = job_description, attrs \\ %{}) do
    JobDescriptions.change(job_description, attrs)
  end

  def role_options(), do: JobDescriptions.role_options()

  # Todo

  def empty_todo() do
    %Todo{}
  end

  def init_todo() do
    Todos.init()
  end

  def change_todo(%Todo{} = todo, attrs \\ %{}) do
    Todos.change(todo, attrs)
  end

  def status_options(), do: Todos.status_options()

  # UIState

  def empty_ui_state() do
    %UIState{}
  end

  def change_ui_state(%UIState{} = ui_state, attrs \\ %{}) do
    UIStates.change(ui_state, attrs)
  end
end
