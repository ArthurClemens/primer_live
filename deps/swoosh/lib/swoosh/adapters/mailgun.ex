defmodule Swoosh.Adapters.Mailgun do
  @moduledoc ~S"""
  An adapter that sends email using the Mailgun API.

  For reference: [Mailgun API docs](https://documentation.mailgun.com/en/latest/api-sending.html#sending)

  **This adapter requires an API Client.** Swoosh comes with Hackney and Finch out of the box.
  See the [installation section](https://hexdocs.pm/swoosh/Swoosh.html#module-installation)
  for details.

  ## Dependency

  Mailgun adapter requires `Plug` to work properly.

  ## Configuration options

  * `:api_key` - the API key used with Mailgun
  * `:domain` - the domain you will be sending emails from
  * `:base_url` - the url to use as the API endpoint. For EU domains, use https://api.eu.mailgun.net/v3

  ## Example

      # config/config.exs
      config :sample, Sample.Mailer,
        adapter: Swoosh.Adapters.Mailgun,
        api_key: "my-api-key",
        domain: "avengers.com"

      # lib/sample/mailer.ex
      defmodule Sample.Mailer do
        use Swoosh.Mailer, otp_app: :sample
      end

  ## Using with provider options

      import Swoosh.Email

      new()
      |> from({"T Stark", "tony.stark@example.com"})
      |> to({"Steve Rogers", "steve.rogers@example.com"})
      |> to("wasp.avengers@example.com")
      |> reply_to("office.avengers@example.com")
      |> cc({"Bruce Banner", "hulk.smash@example.com"})
      |> cc("thor.odinson@example.com")
      |> bcc({"Clinton Francis Barton", "hawk.eye@example.com"})
      |> bcc("beast.avengers@example.com")
      |> subject("Hello, Avengers!")
      |> html_body("<h1>Hello</h1>")
      |> text_body("Hello")
      |> put_provider_option(:custom_vars, %{"key" => "value"})
      |> put_provider_option(:recipient_vars, %{"steve.rogers@example.com": %{var1: 123}, "juan.diaz@example.com": %{var1: 456}})
      |> put_provider_option(:sending_options, %{dkim: "yes", tracking: "no"})
      |> put_provider_option(:tags, ["worldwide-peace", "unity"])
      |> put_provider_option(:template_name, "avengers-templates")

  ## Provider options

    * `:custom_vars` (map) - used to translate to `v:my-var`, now
      `h:X-Mailgun-Variables`, add custom data to email

    * `:recipient_vars` (map) - `recipient-variables`, assign
      custom variable for each email recipient

    * `:sending_options` (map) - `o:my-key`, all the sending options

    * `:tags` (list[string]) - `o:tag`, was added in before `:sending_options`,
      kept for backward compatibility, use `:sending_options` instead

    * `:template_name` (string) - `template`, name of template created at Mailgun

  ## Custom headers

  Headers added via `Email.header/3` will be translated to (`h:`) values that
  Mailgun recognizes.
  """

  use Swoosh.Adapter, required_config: [:api_key, :domain], required_deps: [plug: Plug.Conn.Query]

  alias Swoosh.Email
  import Swoosh.Email.Render

  @base_url "https://api.mailgun.net/v3"
  @api_endpoint "/messages"

  @impl true
  def deliver(%Email{} = email, config \\ []) do
    headers = prepare_headers(email, config)
    url = [base_url(config), "/", config[:domain], @api_endpoint]

    case Swoosh.ApiClient.post(url, headers, prepare_body(email), email) do
      {:ok, 200, _headers, body} ->
        {:ok, %{id: Swoosh.json_library().decode!(body)["id"]}}

      {:ok, code, _headers, body} when code > 399 ->
        case Swoosh.json_library().decode(body) do
          {:ok, error} -> {:error, {code, error}}
          {:error, _} -> {:error, {code, body}}
        end

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp base_url(config), do: config[:base_url] || @base_url

  defp prepare_headers(email, config) do
    [
      {"User-Agent", "swoosh/#{Swoosh.version()}"},
      {"Authorization", "Basic #{auth(config)}"},
      {"Content-Type", content_type(email)}
    ]
  end

  defp auth(config), do: Base.encode64("api:#{config[:api_key]}")

  defp content_type(%{attachments: []}), do: "application/x-www-form-urlencoded"
  defp content_type(%{}), do: "multipart/form-data"

  defp prepare_body(email) do
    %{}
    |> prepare_from(email)
    |> prepare_to(email)
    |> prepare_subject(email)
    |> prepare_html(email)
    |> prepare_text(email)
    |> prepare_cc(email)
    |> prepare_bcc(email)
    |> prepare_reply_to(email)
    |> prepare_attachments(email)
    |> prepare_custom_vars(email)
    |> prepare_sending_options(email)
    |> prepare_recipient_vars(email)
    |> prepare_tags(email)
    |> prepare_custom_headers(email)
    |> prepare_template(email)
    |> encode_body()
  end

  defp prepare_custom_vars(body, %{provider_options: %{custom_vars: custom_vars}}) do
    Map.put(body, "h:X-Mailgun-Variables", Swoosh.json_library().encode!(custom_vars))
  end

  defp prepare_custom_vars(body, _email), do: body

  defp prepare_sending_options(body, %{provider_options: %{sending_options: sending_options}}) do
    Enum.reduce(sending_options, body, fn {k, v}, body ->
      Map.put(body, "o:#{k}", encode_variable(v))
    end)
  end

  defp prepare_sending_options(body, _email), do: body

  defp prepare_recipient_vars(body, %{provider_options: %{recipient_vars: recipient_vars}}) do
    Map.put(body, "recipient-variables", encode_variable(recipient_vars))
  end

  defp prepare_recipient_vars(body, _email), do: body

  defp prepare_tags(body, %{provider_options: %{tags: tags}}) when is_list(tags) do
    Map.put(body, "o:tag", tags)
  end

  defp prepare_tags(body, _email), do: body

  defp prepare_custom_headers(body, %{headers: headers}) do
    Enum.reduce(headers, body, fn {k, v}, body -> Map.put(body, "h:#{k}", v) end)
  end

  defp prepare_attachments(body, %{attachments: []}), do: body

  defp prepare_attachments(body, %{attachments: attachments}) do
    {normal_attachments, inline_attachments} =
      Enum.split_with(attachments, fn %{type: type} -> type == :attachment end)

    body
    |> Map.put(:attachments, Enum.map(normal_attachments, &prepare_file(&1, "attachment")))
    |> Map.put(:inline, Enum.map(inline_attachments, &prepare_file(&1, "inline")))
  end

  defp prepare_file(%{data: nil} = attachment, type) do
    {:file, attachment.path,
     {"form-data", [{"name", ~s/"#{type}"/}, {"filename", ~s/"#{attachment.filename}"/}]}, []}
  end

  defp prepare_file(attachment, type) do
    {"attachment-data", attachment.data,
     {"form-data", [{"name", ~s/"#{type}"/}, {"filename", ~s/"#{attachment.filename}"/}]},
     [{"Content-Type", attachment.content_type}]}
  end

  defp prepare_from(body, %{from: from}), do: Map.put(body, :from, render_recipient(from))

  defp prepare_to(body, %{to: to}), do: Map.put(body, :to, render_recipient(to))

  defp prepare_reply_to(body, %{reply_to: nil}), do: body

  defp prepare_reply_to(body, %{reply_to: {_name, address}}),
    do: Map.put(body, "h:Reply-To", address)

  defp prepare_cc(body, %{cc: []}), do: body
  defp prepare_cc(body, %{cc: cc}), do: Map.put(body, :cc, render_recipient(cc))

  defp prepare_bcc(body, %{bcc: []}), do: body
  defp prepare_bcc(body, %{bcc: bcc}), do: Map.put(body, :bcc, render_recipient(bcc))

  defp prepare_subject(body, %{subject: subject}), do: Map.put(body, :subject, subject)

  defp prepare_text(body, %{text_body: nil}), do: body
  defp prepare_text(body, %{text_body: text_body}), do: Map.put(body, :text, text_body)

  defp prepare_html(body, %{html_body: nil}), do: body
  defp prepare_html(body, %{html_body: html_body}), do: Map.put(body, :html, html_body)

  defp prepare_template(body, %{provider_options: %{template_name: template_name}}),
    do: Map.put(body, "template", template_name)

  defp prepare_template(body, _), do: body

  defp encode_body(%{attachments: attachments, inline: inline} = params) do
    {:multipart,
     params
     |> Map.drop([:attachments, :inline])
     |> Enum.map(fn {k, v} -> {to_string(k), v} end)
     |> Kernel.++(attachments)
     |> Kernel.++(inline)}
  end

  defp encode_body(no_attachments), do: Plug.Conn.Query.encode(no_attachments)

  defp encode_variable(var) when is_map(var) or is_list(var),
    do: Swoosh.json_library().encode!(var)

  defp encode_variable(var), do: var
end
