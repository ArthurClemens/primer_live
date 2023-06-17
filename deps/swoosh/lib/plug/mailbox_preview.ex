if Code.ensure_loaded?(Plug) do
  defmodule Plug.Swoosh.MailboxPreview do
    @moduledoc """
    Plug that serves pages useful for previewing emails in development.

    ## Examples

        # in a Phoenix router
        defmodule Sample.Router do
          scope "/dev" do
            pipe_through [:browser]
            forward "/mailbox", Plug.Swoosh.MailboxPreview
          end
        end
    """

    use Plug.Router
    use Plug.ErrorHandler

    alias Swoosh.Email.Render
    alias Swoosh.Adapters.Local.Storage.Memory

    require EEx

    EEx.function_from_file(
      :defp,
      :template,
      "lib/plug/templates/mailbox_viewer/index.html.eex",
      [:assigns]
    )

    def call(conn, opts) do
      conn =
        conn
        |> assign(:base_path, Path.join(["/" | conn.script_name]))
        |> assign(:storage_driver, opts[:storage_driver] || Memory)

      super(conn, opts)
    end

    plug :match
    plug :dispatch

    post "/clear" do
      conn.assigns.storage_driver.delete_all()

      conn
      |> put_resp_header("location", conn.assigns.base_path)
      |> send_resp(302, '')
    end

    get "/json" do
      emails = Enum.map(conn.assigns.storage_driver.all(), &render_email_json/1)
      response = Swoosh.json_library().encode_to_iodata!(%{data: emails})

      conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, response)
    end

    get "/" do
      emails = conn.assigns.storage_driver.all()

      conn
      |> put_resp_content_type("text/html")
      |> send_resp(200, template(emails: emails, email: nil, conn: conn))
    end

    get "/:id/html" do
      email = conn.assigns.storage_driver.get(id)

      conn
      |> put_resp_content_type("text/html")
      |> send_resp(200, replace_inline_references(email))
    end

    get "/:id/attachments/:index" do
      index = String.to_integer(index)

      id
      |> conn.assigns.storage_driver.get()
      |> case do
        %{attachments: attachments} when length(attachments) > index ->
          attachments
          |> Enum.at(index)
          |> case do
            %{data: data, content_type: content_type} when not is_nil(data) ->
              conn
              |> put_resp_content_type(content_type)
              |> send_resp(200, data)

            %{path: path, content_type: content_type} when not is_nil(path) ->
              conn
              |> put_resp_content_type(content_type)
              |> send_resp(200, File.read!(path))

            _ ->
              conn
              |> put_resp_content_type("text/html")
              |> send_resp(500, "Attachment cannot be displayed")
          end

        _ ->
          conn
          |> put_resp_content_type("text/html")
          |> send_resp(404, "Attachment Not Found")
      end
    end

    get "/:id" do
      emails = conn.assigns.storage_driver.all()
      email = conn.assigns.storage_driver.get(id)

      conn
      |> put_resp_content_type("text/html")
      |> send_resp(200, template(emails: emails, email: email, conn: conn))
    end

    defp render_email_json(email) do
      %{
        subject: email.subject,
        from: Render.render_recipient(email.from),
        to: Enum.map(email.to, &Render.render_recipient/1),
        cc: Enum.map(email.cc, &Render.render_recipient/1),
        bcc: Enum.map(email.bcc, &Render.render_recipient/1),
        reply_to: Render.render_recipient(email.reply_to),
        sent_at: Map.get(email.private, :sent_at),
        text_body: email.text_body,
        html_body: email.html_body,
        headers: email.headers,
        provider_options:
          Enum.map(email.provider_options, fn {k, v} -> %{key: k, value: inspect(v)} end),
        attachments: Enum.map(email.attachments, &render_attachment_json/1)
      }
    end

    defp render_attachment_json(attachment) do
      %{
        filename: attachment.filename,
        content_type: attachment.content_type,
        path: attachment.path,
        type: attachment.type,
        headers: Map.new(attachment.headers)
      }
    end

    defp to_absolute_url(conn, path) do
      Path.join(conn.assigns.base_path, path)
    end

    defp render_recipient(recipient) do
      case Render.render_recipient(recipient) do
        "" -> "n/a"
        recipient -> Plug.HTML.html_escape(recipient)
      end
    end

    defp replace_inline_references(%{html_body: nil, text_body: text_body}) do
      text_body
    end

    defp replace_inline_references(%{html_body: html_body, attachments: attachments}) do
      ~r/"cid:([^"]*)"/
      |> Regex.scan(html_body)
      |> Enum.reduce(html_body, fn [_, ref], body ->
        with index when is_integer(index) <- Enum.find_index(attachments, &(&1.filename == ref)) do
          String.replace(body, "cid:#{ref}", "attachments/#{index}")
        else
          nil -> html_body
        end
      end)
    end
  end
end
