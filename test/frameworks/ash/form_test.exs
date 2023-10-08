defmodule PrimerLive.TestHelpers.Ash.Journal.Registry do
  use Ash.Registry,
    extensions: [
      Ash.Registry.ResourceValidations
    ]

  entries do
    entry(PrimerLive.TestHelpers.Ash.Journal.Publication)
  end
end

defmodule PrimerLive.TestHelpers.Ash.Journal do
  use Ash.Api, validate_config_inclusion?: false

  resources do
    registry(PrimerLive.TestHelpers.Ash.Journal.Registry)
  end
end

defmodule PrimerLive.TestHelpers.Ash.Journal.Publication do
  use Ash.Resource, validate_api_inclusion?: false, data_layer: Ash.DataLayer.Ets

  code_interface do
    define_for(PrimerLive.TestHelpers.Ash.Journal)
    define(:create, action: :create)
    define(:read, action: :read)
    define(:update, action: :update)
    define(:destroy, action: :destroy)
    define(:get_by_id, args: [:id], action: :by_id)
  end

  actions do
    defaults([:create, :read, :update, :destroy])

    read :by_id do
      argument(:id, :uuid, allow_nil?: false)
      get?(true)
      filter(expr(id == ^arg(:id)))
    end
  end

  attributes do
    uuid_primary_key(:id)

    attribute :title, :string do
      allow_nil?(false)
    end

    attribute(:author, :string)
    attribute(:image_url, :string)
    attribute(:isbn, :string)
    attribute(:url, :string)

    create_timestamp(:inserted_at)
    update_timestamp(:updated_at)
  end
end

defmodule PrimerLive.TestFrameworks.Ash.FormTest do
  use ExUnit.Case
  use PrimerLive
  import PrimerLive.Helpers.TestHelpers

  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "Renders a form" do
    assigns = %{
      form:
        PrimerLive.TestHelpers.Ash.Journal.Publication
        |> AshPhoenix.Form.for_create(:create,
          api: PrimerLive.TestHelpers.Ash.Journal
        )
        |> to_form()
    }

    assert rendered_to_string(~H"""
           <.form :let={f} for={@form} phx-change="validate" phx-submit="save">
             <.text_input form={f} field={:title} is_form_control />
             <.text_input form={f} field={:author} is_form_control />
             <.text_input form={f} field={:image_url} is_form_control />
             <.text_input form={f} field={:isbn} is_form_control />
             <.text_input form={f} field={:url} is_form_control />

             <.button is_submit>Save</.button>
           </.form>
           """)
           |> format_html() ==
             """
             <form method="post" phx-submit="save" phx-change="validate">
             <div class="FormControl pl-neutral">
             <div class="form-group-header"><label class="FormControl-label" for="form_title">Title</label><span
             aria-hidden="true">*</span></div><input class="FormControl-input FormControl-medium" id="form_title"
             name="form[title]" type="text" />
             </div>
             <div class="FormControl pl-neutral">
             <div class="form-group-header"><label class="FormControl-label" for="form_author">Author</label></div><input
             class="FormControl-input FormControl-medium" id="form_author" name="form[author]" type="text" />
             </div>
             <div class="FormControl pl-neutral">
             <div class="form-group-header"><label class="FormControl-label" for="form_image_url">Image url</label></div><input
             class="FormControl-input FormControl-medium" id="form_image_url" name="form[image_url]" type="text" />
             </div>
             <div class="FormControl pl-neutral">
             <div class="form-group-header"><label class="FormControl-label" for="form_isbn">Isbn</label></div><input
             class="FormControl-input FormControl-medium" id="form_isbn" name="form[isbn]" type="text" />
             </div>
             <div class="FormControl pl-neutral">
             <div class="form-group-header"><label class="FormControl-label" for="form_url">Url</label></div><input
             class="FormControl-input FormControl-medium" id="form_url" name="form[url]" type="text" />
             </div><button class="btn" type="submit"><span class="pl-button__content">Save</span></button>
             </form>
             """
             |> format_html()
  end

  def handle_event("validate", %{"form" => params}, socket) do
    form = AshPhoenix.Form.validate(socket.assigns.form, params)
    {:noreply, assign(socket, form: form)}
  end

  def handle_event("submit", %{"form" => params}, socket) do
    case AshPhoenix.Form.submit(socket.assigns.form, params: params) do
      {:ok, _publication} ->
        {:noreply, socket}

      {:error, form} ->
        {:noreply, assign(socket, form: form)}
    end
  end
end
