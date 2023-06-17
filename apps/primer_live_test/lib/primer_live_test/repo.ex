defmodule PrimerLiveTest.Repo do
  alias PrimerLiveTest.{JobDescription, JobDescriptions}

  use Ecto.Repo,
    otp_app: :primer_live_test,
    adapter: Ecto.Adapters.Postgres

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
end
