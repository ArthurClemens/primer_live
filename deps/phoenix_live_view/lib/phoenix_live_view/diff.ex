defmodule Phoenix.LiveView.Diff do
  # The diff engine is responsible for tracking the rendering state.
  # Given that components are part of said state, they are also
  # handled here.
  @moduledoc false

  alias Phoenix.LiveView.{Utils, Rendered, Comprehension, Component, Lifecycle}

  @components :c
  @static :s
  @dynamics :d
  @events :e
  @reply :r
  @title :t
  @template :p
  @stream_id :stream

  # We use this to track which components have been marked
  # for deletion. If the component is used after being marked,
  # it should not be deleted.
  @marked_for_deletion :marked_for_deletion

  @doc """
  Returns the diff component state.
  """
  def new_components(uuids \\ 1) do
    {_cid_to_component = %{}, _id_to_cid = %{}, uuids}
  end

  @doc """
  Returns the diff fingerprint state.
  """
  def new_fingerprints do
    {nil, %{}}
  end

  @doc """
  Converts a diff into iodata.

  It only accepts a full render diff.
  """
  def to_iodata(map, component_mapper \\ fn _cid, content -> content end) do
    to_iodata(map, Map.get(map, @components, %{}), nil, component_mapper) |> elem(0)
  end

  defp to_iodata(%{@dynamics => dynamics, @static => static} = comp, components, template, mapper) do
    static = template_static(static, template)
    template = template || comp[@template]

    Enum.map_reduce(dynamics, components, fn dynamic, components ->
      many_to_iodata(static, dynamic, [], components, template, mapper)
    end)
  end

  defp to_iodata(%{@static => static} = parts, components, template, mapper) do
    static = template_static(static, template)
    one_to_iodata(static, parts, 0, [], components, template, mapper)
  end

  defp to_iodata(cid, components, _template, mapper) when is_integer(cid) do
    # Resolve component pointers and update the component entries
    components = resolve_components_xrefs(cid, components)
    {iodata, components} = to_iodata(Map.fetch!(components, cid), components, nil, mapper)
    {mapper.(cid, iodata), components}
  end

  defp to_iodata(binary, components, _template, _mapper) when is_binary(binary) do
    {binary, components}
  end

  defp one_to_iodata([last], _parts, _counter, acc, components, _template, _mapper) do
    {Enum.reverse([last | acc]), components}
  end

  defp one_to_iodata([head | tail], parts, counter, acc, components, template, mapper) do
    {iodata, components} = to_iodata(Map.fetch!(parts, counter), components, template, mapper)
    one_to_iodata(tail, parts, counter + 1, [iodata, head | acc], components, template, mapper)
  end

  defp many_to_iodata([shead | stail], [dhead | dtail], acc, components, template, mapper) do
    {iodata, components} = to_iodata(dhead, components, template, mapper)
    many_to_iodata(stail, dtail, [iodata, shead | acc], components, template, mapper)
  end

  defp many_to_iodata([shead], [], acc, components, _template, _mapper) do
    {Enum.reverse([shead | acc]), components}
  end

  defp template_static(static, template) when is_integer(static), do: Map.fetch!(template, static)
  defp template_static(static, _template) when is_list(static), do: static

  defp resolve_components_xrefs(cid, components) do
    case components[cid] do
      %{@static => static} = diff when is_integer(static) ->
        static = abs(static)
        components = resolve_components_xrefs(static, components)
        Map.put(components, cid, deep_merge(components[static], Map.delete(diff, @static)))

      %{} ->
        components
    end
  end

  defp deep_merge(_original, %{@static => _} = extra), do: extra

  defp deep_merge(original, extra) do
    Map.merge(original, extra, fn
      _, %{} = original, %{} = extra -> deep_merge(original, extra)
      _, _original, extra -> extra
    end)
  end

  @doc """
  Render information stored in private changed.
  """
  def render_private(socket, diff) do
    {_, diff} =
      diff
      |> maybe_put_reply(socket)
      |> maybe_put_events(socket)

    diff
  end

  @doc """
  Renders a diff for the rendered struct in regards to the given socket.
  """
  def render(
        %{fingerprints: {expected, _}} = socket,
        %Rendered{fingerprint: actual} = rendered,
        {_, _, uuids}
      )
      when expected != nil and expected != actual do
    render(%{socket | fingerprints: new_fingerprints()}, rendered, new_components(uuids))
  end

  def render(%{fingerprints: prints} = socket, %Rendered{} = rendered, components) do
    {diff, prints, pending, components, nil} =
      traverse(socket, rendered, prints, %{}, components, nil, true)

    # cid_to_component is used by maybe_reuse_static and it must be a copy before changes.
    # However, given traverse does not change cid_to_component, we can read it now.
    {cid_to_component, _, _} = components

    {cdiffs, components} =
      render_pending_components(socket, pending, cid_to_component, %{}, components)

    socket = %{socket | fingerprints: prints}
    diff = maybe_put_title(diff, socket)
    {diff, cdiffs} = extract_events({diff, cdiffs})

    if map_size(cdiffs) == 0 do
      {socket, diff, components}
    else
      {socket, Map.put(diff, @components, cdiffs), components}
    end
  end

  defp maybe_put_title(diff, socket) do
    if Utils.changed?(socket.assigns, :page_title) do
      Map.put(diff, @title, socket.assigns.page_title)
    else
      diff
    end
  end

  defp maybe_put_events(diff, socket) do
    case Utils.get_push_events(socket) do
      [_ | _] = events -> {true, Map.update(diff, @events, events, &(&1 ++ events))}
      [] -> {false, diff}
    end
  end

  defp extract_events({diff, component_diffs}) do
    case component_diffs do
      %{@events => component_events} ->
        {Map.update(diff, @events, component_events, &(&1 ++ component_events)),
         Map.delete(component_diffs, @events)}

      %{} ->
        {diff, component_diffs}
    end
  end

  defp maybe_put_reply(diff, socket) do
    case Utils.get_reply(socket) do
      nil -> diff
      reply -> Map.put(diff, @reply, reply)
    end
  end

  @doc """
  Execute the `fun` with the component `cid` with the given `socket` as template.

  It returns the updated `cdiffs` and the updated `components` or
  `:error` if the component cid does not exist.
  """
  def write_component(socket, cid, components, fun) when is_integer(cid) do
    # We need to extract the original cid_to_component for maybe_reuse_static later
    {cid_to_component, _, _} = components

    case cid_to_component do
      %{^cid => {component, id, assigns, private, fingerprints}} ->
        {component_socket, extra} =
          socket
          |> configure_socket_for_component(assigns, private, fingerprints)
          |> fun.(component)

        {pending, cdiffs, components} =
          render_component(
            component_socket,
            component,
            id,
            cid,
            false,
            %{},
            cid_to_component,
            %{},
            components
          )

        {cdiffs, components} =
          render_pending_components(socket, pending, %{}, cid_to_component, cdiffs, components)

        diff = maybe_put_reply(%{}, component_socket)
        {diff, cdiffs} = extract_events({diff, cdiffs})
        {Map.put(diff, @components, cdiffs), components, extra}

      %{} ->
        :error
    end
  end

  @doc """
  Execute the `fun` with the component `cid` with the given `socket` and returns the result.

  `:error` if the component cid does not exist.
  """
  def read_component(socket, cid, components, fun) when is_integer(cid) do
    {cid_to_component, _id_to_cid, _} = components

    case cid_to_component do
      %{^cid => {component, _id, assigns, private, fingerprints}} ->
        socket
        |> configure_socket_for_component(assigns, private, fingerprints)
        |> fun.(component)

      %{} ->
        :error
    end
  end

  @doc """
  Sends an update to a component.

  Like `write_component/5`, it will store the result under the `cid
   key in the `component_diffs` map.

  If the component exists, a `{diff, new_components}` tuple
  is returned. Otherwise, `:noop` is returned.

  The component is preloaded before the update callback is invoked.

  ## Example

      {diff, new_components} = Diff.update_component(socket, state.components, update)
  """
  def update_component(socket, components, {module, id, updated_assigns}) do
    case fetch_cid(module, id, components) do
      {:ok, cid} ->
        updated_assigns = maybe_call_preload!(module, updated_assigns)

        {diff, new_components, :noop} =
          write_component(socket, cid, components, fn component_socket, component ->
            {Utils.maybe_call_update!(component_socket, component, updated_assigns), :noop}
          end)

        {diff, new_components}

      :error ->
        :noop
    end
  end

  @doc """
  Marks a component for deletion.

  It won't be deleted if the component is used meanwhile.
  """
  def mark_for_deletion_component(cid, {cid_to_component, id_to_cid, uuids}) do
    cid_to_component =
      case cid_to_component do
        %{^cid => {component, id, assigns, private, prints}} ->
          private = Map.put(private, @marked_for_deletion, true)
          Map.put(cid_to_component, cid, {component, id, assigns, private, prints})

        %{} ->
          cid_to_component
      end

    {cid_to_component, id_to_cid, uuids}
  end

  @doc """
  Deletes a component by `cid` if it has not been used meanwhile.
  """
  def delete_component(cid, {cid_to_component, id_to_cid, uuids}) do
    case cid_to_component do
      %{^cid => {component, id, _, %{@marked_for_deletion => true}, _}} ->
        id_to_cid =
          case id_to_cid do
            %{^component => inner} ->
              case Map.delete(inner, id) do
                inner when inner == %{} -> Map.delete(id_to_cid, component)
                inner -> Map.put(id_to_cid, component, inner)
              end

            %{} ->
              id_to_cid
          end

        {[cid], {Map.delete(cid_to_component, cid), id_to_cid, uuids}}

      _ ->
        {[], {cid_to_component, id_to_cid, uuids}}
    end
  end

  @doc """
  Converts a component to a rendered struct.
  """
  def component_to_rendered(socket, component, assigns, mount_assigns) when is_map(assigns) do
    socket = mount_component(socket, component, mount_assigns)
    assigns = maybe_call_preload!(component, assigns)

    socket
    |> Utils.maybe_call_update!(component, assigns)
    |> component_to_rendered(component, assigns[:id])
  end

  defp component_to_rendered(socket, component, id) do
    rendered = Utils.to_rendered(socket, component)

    if rendered.root != true and id != nil do
      reason =
        case rendered.root do
          nil -> "Stateful components must return a HEEx template (~H sigil or .heex extension)"
          false -> "Stateful components must have a single static HTML tag at the root"
        end

      raise ArgumentError,
            "error on #{inspect(component)}.render/1 with id of #{inspect(id)}. #{reason}"
    end

    rendered
  end

  ## Traversal

  defp traverse(
         socket,
         %Rendered{fingerprint: fingerprint} = rendered,
         {fingerprint, children},
         pending,
         components,
         template,
         changed?
       ) do
    # If we are diff tracking, then template must be nil
    nil = template

    {_counter, diff, children, pending, components, nil} =
      traverse_dynamic(
        socket,
        invoke_dynamic(rendered, changed?),
        children,
        pending,
        components,
        nil,
        changed?
      )

    {diff, {fingerprint, children}, pending, components, nil}
  end

  defp traverse(
         socket,
         %Rendered{fingerprint: fingerprint, static: static} = rendered,
         _,
         pending,
         components,
         template,
         changed?
       ) do
    {_counter, diff, children, pending, components, template} =
      traverse_dynamic(
        socket,
        invoke_dynamic(rendered, false),
        %{},
        pending,
        components,
        template,
        changed?
      )

    {diff, template} = maybe_template_static(diff, fingerprint, static, template)
    {diff, {fingerprint, children}, pending, components, template}
  end

  # TODO: Remove me when stateless module components are removed
  defp traverse(
         socket,
         %Component{id: nil, component: component, assigns: assigns},
         fingerprints_tree,
         pending,
         components,
         template,
         changed?
       ) do
    rendered = component_to_rendered(socket, component, assigns, %{})
    traverse(socket, rendered, fingerprints_tree, pending, components, template, changed?)
  end

  defp traverse(
         socket,
         %Component{} = component,
         _fingerprints_tree,
         pending,
         components,
         template,
         _changed?
       ) do
    {cid, pending, components} = traverse_component(socket, component, pending, components)
    {cid, nil, pending, components, template}
  end

  defp traverse(
         socket,
         %Comprehension{fingerprint: fingerprint, dynamics: dynamics, stream: stream_id},
         fingerprint,
         pending,
         components,
         template,
         _changed?
       ) do
    # If we are diff tracking, then template must be nil
    nil = template

    {dynamics, {pending, components, {_, comprehension_template}}} =
      traverse_comprehension(socket, dynamics, pending, components, {%{}, %{}})

    diff =
      %{@dynamics => dynamics}
      |> maybe_add_template(comprehension_template)
      |> maybe_add_stream_id(stream_id)

    {diff, fingerprint, pending, components, nil}
  end

  defp traverse(
         _socket,
         %Comprehension{dynamics: []},
         _,
         pending,
         components,
         template,
         _changed?
       ) do
    # The comprehension has no elements and it was not rendered yet, so we skip it.
    {"", nil, pending, components, template}
  end

  defp traverse(
         socket,
         %Comprehension{fingerprint: print, static: static, dynamics: dynamics, stream: stream},
         _,
         pending,
         components,
         template,
         _changed?
       ) do
    if template do
      {dynamics, {pending, components, template}} =
        traverse_comprehension(socket, dynamics, pending, components, template)

      {diff, template} = maybe_template_static(%{@dynamics => dynamics}, print, static, template)
      diff = maybe_add_stream_id(diff, stream)

      {diff, print, pending, components, template}
    else
      {dynamics, {pending, components, {_, comprehension_template}}} =
        traverse_comprehension(socket, dynamics, pending, components, {%{}, %{}})

      diff =
        %{@dynamics => dynamics, @static => static}
        |> maybe_add_template(comprehension_template)
        |> maybe_add_stream_id(stream)

      {diff, print, pending, components, nil}
    end
  end

  defp traverse(_socket, nil, fingerprint_tree, pending, components, template, _changed?) do
    {nil, fingerprint_tree, pending, components, template}
  end

  defp traverse(_socket, iodata, _, pending, components, template, _changed?) do
    {IO.iodata_to_binary(iodata), nil, pending, components, template}
  end

  defp invoke_dynamic(%Rendered{caller: :not_available, dynamic: dynamic}, changed?) do
    dynamic.(changed?)
  end

  defp invoke_dynamic(%Rendered{caller: caller, dynamic: dynamic}, changed?) do
    try do
      dynamic.(changed?)
    rescue
      e ->
        {mod, {function, arity}, file, line} = caller
        entry = {mod, function, arity, file: String.to_charlist(file), line: line}
        reraise e, inject_stacktrace(__STACKTRACE__, entry)
    end
  end

  defp inject_stacktrace([{__MODULE__, :invoke_dynamic, 2, _} | stacktrace], entry) do
    [entry | Enum.drop_while(stacktrace, &(elem(&1, 0) == __MODULE__))]
  end

  defp inject_stacktrace([head | tail], entry) do
    [head | inject_stacktrace(tail, entry)]
  end

  defp inject_stacktrace([], entry) do
    [entry]
  end

  defp traverse_dynamic(socket, dynamic, children, pending, components, template, changed?) do
    Enum.reduce(dynamic, {0, %{}, children, pending, components, template}, fn
      entry, {counter, diff, children, pending, components, template} ->
        child = Map.get(children, counter)

        {serialized, child_fingerprint, pending, components, template} =
          traverse(socket, entry, child, pending, components, template, changed?)

        # If serialized is nil, it means no changes.
        # If it is an empty map, then it means it is a rendered struct
        # that did not change, so we don't have to emit it either.
        diff =
          if serialized != nil and serialized != %{} do
            Map.put(diff, counter, serialized)
          else
            diff
          end

        children =
          if child_fingerprint do
            Map.put(children, counter, child_fingerprint)
          else
            Map.delete(children, counter)
          end

        {counter + 1, diff, children, pending, components, template}
    end)
  end

  defp traverse_comprehension(socket, dynamics, pending, components, template) do
    Enum.map_reduce(dynamics, {pending, components, template}, fn rendereds, acc ->
      Enum.map_reduce(rendereds, acc, fn rendered, {pending, components, template} ->
        {diff, _, pending, components, template} =
          traverse(socket, rendered, {nil, %{}}, pending, components, template, false)

        {diff, {pending, components, template}}
      end)
    end)
  end

  defp maybe_template_static(map, fingerprint, static, {print_to_pos, pos_to_static}) do
    case print_to_pos do
      %{^fingerprint => pos} ->
        {Map.put(map, @static, pos), {print_to_pos, pos_to_static}}

      %{} ->
        pos = map_size(pos_to_static)
        pos_to_static = Map.put(pos_to_static, pos, static)
        print_to_pos = Map.put(print_to_pos, fingerprint, pos)
        {Map.put(map, @static, pos), {print_to_pos, pos_to_static}}
    end
  end

  defp maybe_template_static(map, _fingerprint, static, nil) do
    {Map.put(map, @static, static), nil}
  end

  defp maybe_add_template(map, template) when template == %{}, do: map
  defp maybe_add_template(map, template), do: Map.put(map, @template, template)

  defp maybe_add_stream_id(diff, nil = _stream_id), do: diff
  defp maybe_add_stream_id(diff, stream_id), do: Map.put(diff, @stream_id, stream_id)

  ## Stateful components helpers

  defp traverse_component(
         _socket,
         %Component{id: id, assigns: assigns, component: component},
         pending,
         {cid_to_component, id_to_cid, uuids}
       ) do
    {cid, new?, components} =
      case id_to_cid do
        %{^component => %{^id => cid}} -> {cid, false, {cid_to_component, id_to_cid, uuids}}
        %{} -> {uuids, true, {cid_to_component, id_to_cid, uuids + 1}}
      end

    entry = {cid, id, new?, assigns}
    pending = Map.update(pending, component, [entry], &[entry | &1])
    {cid, pending, components}
  end

  ## Component rendering

  defp render_pending_components(socket, pending, cids, diffs, components) do
    render_pending_components(socket, pending, %{}, cids, diffs, components)
  end

  defp render_pending_components(_, pending, _seen_ids, _cids, diffs, components)
       when map_size(pending) == 0 do
    {diffs, components}
  end

  defp render_pending_components(socket, pending, seen_ids, cids, diffs, components) do
    acc = {{%{}, diffs, components}, seen_ids}

    {{pending, diffs, components}, seen_ids} =
      Enum.reduce(pending, acc, fn {component, entries}, acc ->
        entries = maybe_preload_components(component, Enum.reverse(entries))

        Enum.reduce(entries, acc, fn {cid, id, new?, new_assigns}, {triplet, seen_ids} ->
          {pending, diffs, components} = triplet

          if Map.has_key?(seen_ids, [component | id]) do
            raise "found duplicate ID #{inspect(id)} " <>
                    "for component #{inspect(component)} when rendering template"
          end

          {socket, components} =
            case cids do
              %{^cid => {_component, _id, assigns, private, prints}} ->
                private = Map.delete(private, @marked_for_deletion)
                {configure_socket_for_component(socket, assigns, private, prints), components}

              %{} ->
                myself_assigns = %{myself: %Phoenix.LiveComponent.CID{cid: cid}}

                {mount_component(socket, component, myself_assigns),
                 put_cid(components, component, id, cid)}
            end

          triplet =
            socket
            |> Utils.maybe_call_update!(component, new_assigns)
            |> render_component(component, id, cid, new?, pending, cids, diffs, components)

          {triplet, Map.put(seen_ids, [component | id], true)}
        end)
      end)

    render_pending_components(socket, pending, seen_ids, cids, diffs, components)
  end

  defp maybe_preload_components(component, entries) do
    if function_exported?(component, :preload, 1) do
      list_of_assigns = Enum.map(entries, fn {_cid, _id, _new?, new_assigns} -> new_assigns end)
      result = component.preload(list_of_assigns)
      zip_preloads(result, entries, component, result)
    else
      entries
    end
  end

  defp maybe_call_preload!(module, assigns) do
    if function_exported?(module, :preload, 1) do
      [new_assigns] = module.preload([assigns])
      new_assigns
    else
      assigns
    end
  end

  defp zip_preloads([new_assigns | assigns], [{cid, id, new?, _} | entries], component, preloaded)
       when is_map(new_assigns) do
    [{cid, id, new?, new_assigns} | zip_preloads(assigns, entries, component, preloaded)]
  end

  defp zip_preloads([], [], _component, _preloaded) do
    []
  end

  defp zip_preloads(_, _, component, preloaded) do
    raise ArgumentError,
          "expected #{inspect(component)}.preload/1 to return a list of maps of the same length " <>
            "as the list of assigns given, got: #{inspect(preloaded)}"
  end

  defp render_component(socket, component, id, cid, new?, pending, cids, diffs, components) do
    {events?, diffs} = maybe_put_events(diffs, socket)
    changed? = new? or Utils.changed?(socket)

    {socket, pending, diff, {cid_to_component, id_to_cid, uuids}} =
      if changed? do
        rendered = component_to_rendered(socket, component, id)

        {changed?, linked_cid, prints} =
          maybe_reuse_static(rendered, socket, component, cids, components)

        {diff, component_prints, pending, components, nil} =
          traverse(socket, rendered, prints, pending, components, nil, changed?)

        diff = if linked_cid, do: Map.put(diff, @static, linked_cid), else: diff
        {%{socket | fingerprints: component_prints}, pending, diff, components}
      else
        {socket, pending, %{}, components}
      end

    socket =
      if changed? or events? do
        socket
        |> Lifecycle.after_render()
        |> Utils.clear_changed()
      else
        socket
      end

    diffs =
      if diff != %{} or new? do
        Map.put(diffs, cid, diff)
      else
        diffs
      end

    cid_to_component = Map.put(cid_to_component, cid, dump_component(socket, component, id))
    {pending, diffs, {cid_to_component, id_to_cid, uuids}}
  end

  @attempts 3

  # If the component is new or is getting a new static root, we search if another
  # component has the same tree root. If so, we will point to the whole existing
  # component tree but say all entries require a full render.
  #
  # When looking up for an existing component, we first look into the tree from the
  # previous render, then we look at the new render. This is to avoid using a tree
  # that will be changed before it is sent to the client.
  #
  # We don't want to traverse all of the components, so we will try it @attempts times.
  defp maybe_reuse_static(rendered, socket, component, old_cids, components) do
    {new_cids, id_to_cid, _uuids} = components
    %{fingerprint: print} = rendered
    %{fingerprints: {socket_print, _} = socket_prints} = socket

    with true <- socket_print != print,
         iterator = :maps.iterator(Map.fetch!(id_to_cid, component)),
         {cid, existing_prints} <-
           find_same_component_print(print, iterator, old_cids, new_cids, @attempts) do
      {false, cid, existing_prints}
    else
      _ -> {true, nil, socket_prints}
    end
  end

  defp find_same_component_print(_print, _iterator, _old_cids, _new_cids, 0), do: :none

  defp find_same_component_print(print, iterator, old_cids, new_cids, attempts) do
    case :maps.next(iterator) do
      {_, cid, iterator} ->
        case old_cids do
          %{^cid => {_, _, _, _, {^print, _} = tree}} ->
            {-cid, tree}

          %{} ->
            case new_cids do
              %{^cid => {_, _, _, _, {^print, _} = tree}} -> {cid, tree}
              %{} -> find_same_component_print(print, iterator, old_cids, new_cids, attempts - 1)
            end
        end

      :none ->
        :none
    end
  end

  defp put_cid({id_to_components, id_to_cid, uuids}, component, id, cid) do
    inner = Map.get(id_to_cid, component, %{})
    {id_to_components, Map.put(id_to_cid, component, Map.put(inner, id, cid)), uuids}
  end

  defp fetch_cid(component, id, {_cid_to_components, id_to_cid, _} = _components) do
    case id_to_cid do
      %{^component => %{^id => cid}} -> {:ok, cid}
      %{} -> :error
    end
  end

  defp mount_component(socket, component, assigns) do
    private =
      socket.private
      |> Map.take([:conn_session, :root_view])
      |> Map.put(:__changed__, %{})
      |> Map.put(:lifecycle, %Phoenix.LiveView.Lifecycle{})

    socket =
      configure_socket_for_component(socket, assigns, private, new_fingerprints())
      |> Utils.assign(:flash, %{})

    Utils.maybe_call_live_component_mount!(socket, component)
  end

  defp configure_socket_for_component(socket, assigns, private, prints) do
    %{
      socket
      | assigns: Map.put(assigns, :__changed__, %{}),
        private: private,
        fingerprints: prints
    }
  end

  defp dump_component(socket, component, id) do
    {component, id, socket.assigns, socket.private, socket.fingerprints}
  end
end
