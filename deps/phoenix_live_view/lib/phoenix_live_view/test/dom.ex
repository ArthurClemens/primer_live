defmodule Phoenix.LiveViewTest.DOM do
  @moduledoc false

  @phx_static "data-phx-static"
  @phx_component "data-phx-component"
  @static :s
  @components :c
  @stream_id :stream

  def ensure_loaded! do
    unless Code.ensure_loaded?(Floki) do
      raise """
      Phoenix LiveView requires Floki as a test dependency.
      Please add to your mix.exs:

      {:floki, ">= 0.30.0", only: :test}
      """
    end
  end

  @spec parse(binary) :: [
          {:comment, binary}
          | {:pi | binary, binary | list, list}
          | {:doctype, binary, binary, binary}
        ]
  def parse(html) do
    {:ok, parsed} = Floki.parse_document(html)
    parsed
  end

  def all(html_tree, selector), do: Floki.find(html_tree, selector)

  def maybe_one(html_tree, selector, type \\ :selector) do
    case all(html_tree, selector) do
      [node] ->
        {:ok, node}

      [] ->
        {:error, :none,
         "expected #{type} #{inspect(selector)} to return a single element, but got none " <>
           "within: \n\n" <> inspect_html(html_tree)}

      many ->
        {:error, :many,
         "expected #{type} #{inspect(selector)} to return a single element, " <>
           "but got #{length(many)}: \n\n" <> inspect_html(many)}
    end
  end

  def targets_from_node(tree, node) do
    case node && all_attributes(node, "phx-target") do
      nil -> [nil]
      [] -> [nil]
      [selector] -> targets_from_selector(tree, selector)
    end
  end

  def targets_from_selector(tree, selector)

  def targets_from_selector(_tree, nil), do: [nil]

  def targets_from_selector(_tree, cid) when is_integer(cid), do: [cid]

  def targets_from_selector(tree, selector) when is_binary(selector) do
    case Integer.parse(selector) do
      {cid, ""} ->
        [cid]

      _ ->
        case all(tree, selector) do
          [] ->
            [nil]

          elements ->
            for element <- elements do
              if cid = component_id(element) do
                String.to_integer(cid)
              end
            end
        end
    end
  end

  def all_attributes(html_tree, name), do: Floki.attribute(html_tree, name)

  def all_values({_, attributes, _}) do
    for {attr, value} <- attributes, key = value_key(attr), do: {key, value}, into: %{}
  end

  def inspect_html(nodes) when is_list(nodes) do
    for dom_node <- nodes, into: "", do: inspect_html(dom_node)
  end

  def inspect_html(dom_node),
    do: "    " <> String.replace(to_html(dom_node), "\n", "\n   ") <> "\n"

  defp value_key("phx-value-" <> key), do: key
  defp value_key("value"), do: "value"
  defp value_key(_), do: nil

  def tag(node), do: elem(node, 0)

  def attribute(node, key) do
    with {tag, attrs, _children} when is_binary(tag) <- node,
         {_, value} <- List.keyfind(attrs, key, 0) do
      value
    else
      _ -> nil
    end
  end

  def to_html(html_tree), do: Floki.raw_html(html_tree)

  def to_text(html_tree), do: Floki.text(html_tree)

  def by_id!(html_tree, id) do
    case maybe_one(html_tree, "#" <> id) do
      {:ok, node} -> node
      {:error, _, message} -> raise message
    end
  end

  def child_nodes({_, _, nodes}), do: nodes

  def attrs({_, attrs, _}), do: attrs

  def inner_html!(html_tree, id), do: html_tree |> by_id!(id) |> child_nodes()

  def component_id(html_tree), do: Floki.attribute(html_tree, @phx_component) |> List.first()

  @doc """
  Find static information in the given HTML tree.
  """
  def find_static_views(html_tree) do
    html_tree
    |> all("[#{@phx_static}]")
    |> Enum.into(%{}, fn node ->
      {attribute(node, "id"), attribute(node, @phx_static)}
    end)
  end

  @doc """
  Find live views in the given HTML tree.
  """
  def find_live_views(html_tree) do
    html_tree
    |> all("[data-phx-session]")
    |> Enum.reduce([], fn node, acc ->
      id = attribute(node, "id")
      static = attribute(node, "data-phx-static")
      session = attribute(node, "data-phx-session")
      main = attribute(node, "data-phx-main")

      static = if static in [nil, ""], do: nil, else: static
      found = {id, session, static}

      if main not in [nil, "", "false"] do
        acc ++ [found]
      else
        [found | acc]
      end
    end)
    |> Enum.reverse()
  end

  @doc """
  Deep merges two maps.
  """
  def deep_merge(%{} = target, %{} = source),
    do: Map.merge(target, source, fn _, t, s -> deep_merge(t, s) end)

  def deep_merge(_target, source),
    do: source

  @doc """
  Filters nodes according to `fun`.
  """
  def filter(node, fun) do
    node |> reverse_filter(fun) |> Enum.reverse()
  end

  @doc """
  Filters nodes and returns them in reverse order.
  """
  def reverse_filter(node, fun) do
    node
    |> Floki.traverse_and_update([], fn node, acc ->
      if fun.(node), do: {node, [node | acc]}, else: {node, acc}
    end)
    |> elem(1)
  end

  # Diff merging

  def merge_diff(rendered, diff) do
    old = Map.get(rendered, @components, %{})
    # must extract streams from diff before we pop components
    streams = extract_streams(diff, [])
    {new, diff} = Map.pop(diff, @components)
    rendered = deep_merge_diff(rendered, diff)

    # If we have any component, we need to get the components
    # sent by the diff and remove any link between components
    # statics. We cannot let those links reside in the diff
    # as components can be removed at any time.
    rendered =
      cond do
        new ->
          {acc, _} =
            Enum.reduce(new, {old, %{}}, fn {cid, cdiff}, {acc, cache} ->
              {value, cache} = find_component(cid, cdiff, old, new, cache)
              {Map.put(acc, cid, value), cache}
            end)

          Map.put(rendered, @components, acc)

        old != %{} ->
          Map.put(rendered, @components, old)

        true ->
          rendered
      end

    Map.put(rendered, :streams, streams)
  end

  defp find_component(cid, cdiff, old, new, cache) do
    case cache do
      %{^cid => cached} ->
        {cached, cache}

      %{} ->
        {res, cache} =
          case cdiff do
            %{@static => cid} when is_integer(cid) and cid > 0 ->
              {res, cache} = find_component(cid, new[cid], old, new, cache)
              {deep_merge_diff(res, Map.delete(cdiff, @static)), cache}

            %{@static => cid} when is_integer(cid) and cid < 0 ->
              {deep_merge_diff(old[-cid], Map.delete(cdiff, @static)), cache}

            %{} ->
              {deep_merge_diff(Map.get(old, cid, %{}), cdiff), cache}
          end

        {res, Map.put(cache, cid, res)}
    end
  end

  def drop_cids(rendered, cids) do
    update_in(rendered[@components], &Map.drop(&1, cids))
  end

  defp deep_merge_diff(_target, %{@static => _} = source),
    do: source

  defp deep_merge_diff(%{} = target, %{} = source),
    do: Map.merge(target, source, fn _, t, s -> deep_merge_diff(t, s) end)

  defp deep_merge_diff(_target, source),
    do: source

  defp extract_streams(%{} = source, streams) do
    Enum.reduce(source, streams, fn
      {@stream_id, stream}, acc -> [stream | acc]
      {_key, value}, acc -> extract_streams(value, acc)
    end)
  end

  defp extract_streams(_value, acc), do: acc

  # Diff rendering

  def render_diff(rendered) do
    rendered
    |> Phoenix.LiveView.Diff.to_iodata(fn cid, contents ->
      contents
      |> IO.iodata_to_binary()
      |> parse()
      |> List.wrap()
      |> Enum.map(walk_fun(&inject_cid_attr(&1, cid)))
      |> to_html()
    end)
    |> IO.iodata_to_binary()
    |> parse()
    |> List.wrap()
  end

  defp inject_cid_attr({tag, attrs, children}, cid) do
    {tag, [{@phx_component, to_string(cid)}] ++ attrs, children}
  end

  # Patching

  def patch_id(id, html_tree, inner_html, streams) do
    cids_before = component_ids(id, html_tree)

    phx_update_tree =
      walk(inner_html, fn node ->
        apply_phx_update(attribute(node, "phx-update"), html_tree, node, streams)
      end)

    new_html =
      walk(html_tree, fn {tag, attrs, children} = node ->
        if attribute(node, "id") == id do
          {tag, attrs, phx_update_tree}
        else
          {tag, attrs, children}
        end
      end)

    cids_after = component_ids(id, new_html)
    {new_html, cids_before -- cids_after}
  end

  def component_ids(id, html_tree) do
    by_id!(html_tree, id)
    |> Floki.children()
    |> Enum.reduce([], &traverse_component_ids/2)
  end

  def replace_root_container(container_html, new_tag, attrs) do
    reserved_attrs = ~w(id data-phx-session data-phx-static data-phx-main)
    [{_container_tag, container_attrs_list, children}] = container_html
    container_attrs = Enum.into(container_attrs_list, %{})

    merged_attrs =
      attrs
      |> Enum.map(fn {attr, value} -> {String.downcase(to_string(attr)), value} end)
      |> Enum.filter(fn {attr, _value} -> attr not in reserved_attrs end)
      |> Enum.reduce(container_attrs_list, fn {attr, new_val}, acc ->
        if Map.has_key?(container_attrs, attr) do
          Enum.map(acc, fn
            {^attr, _old_val} -> {attr, new_val}
            {_, _} = other -> other
          end)
        else
          acc ++ [{attr, new_val}]
        end
      end)

    [{to_string(new_tag), merged_attrs, children}]
  end

  defp traverse_component_ids(current, acc) do
    acc =
      if id = attribute(current, @phx_component) do
        [String.to_integer(id) | acc]
      else
        acc
      end

    cond do
      attribute(current, @phx_static) ->
        acc

      children = Floki.children(current) ->
        Enum.reduce(children, acc, &traverse_component_ids/2)

      true ->
        acc
    end
  end

  defp apply_phx_update(type, html_tree, {tag, attrs, appended_children} = node, streams)
       when type in ["stream", "append", "prepend"] do
    {stream_inserts, stream_deletes} =
      Enum.reduce(streams, {%{}, MapSet.new()}, fn [inserts, deletes], {in_acc, deletes_acc} ->
        {Map.merge(in_acc, inserts), MapSet.union(deletes_acc, MapSet.new(deletes))}
      end)

    container_id = attribute(node, "id")
    verify_phx_update_id!(type, container_id, node)
    children_before = apply_phx_update_children(html_tree, container_id)
    existing_ids = apply_phx_update_children_id(type, children_before)
    new_ids = apply_phx_update_children_id(type, appended_children)

    content_changed? =
      new_ids != existing_ids or (Enum.any?(stream_inserts) or Enum.any?(stream_deletes))

    dup_ids =
      if content_changed? && new_ids do
        Enum.filter(new_ids, fn id -> id in existing_ids end)
      else
        []
      end

    {updated_existing_children, updated_appended} =
      Enum.reduce(dup_ids, {children_before, appended_children}, fn dup_id, {before, appended} ->
        patched_before =
          walk(before, fn {tag, _, _} = node ->
            cond do
              attribute(node, "id") == dup_id ->
                new_node = by_id!(appended, dup_id)
                {tag, attrs(new_node), child_nodes(new_node)}

              true ->
                node
            end
          end)

        {patched_before, Floki.filter_out(appended, "##{dup_id}")}
      end)

    cond do
      # reorder and/or remove stream children
      content_changed? && type == "stream" ->
        children = updated_existing_children ++ updated_appended

        new_children =
          Enum.reduce(stream_inserts, children, fn {id, insert_at}, acc ->
            old_index = Enum.find_index(acc, &(attribute(&1, "id") == id))
            child = old_index && Enum.at(acc, old_index)
            existing? = Enum.find_index(updated_existing_children, &(attribute(&1, "id") == id))
            deleted? = MapSet.member?(stream_deletes, id)

            cond do
              # skip added children that aren't ours
              parent_id(html_tree, id) != container_id ->
                acc

              # do not append existing child if already present, only update in place
              old_index && insert_at == -1 && existing? ->
                if deleted? do
                  acc |> List.delete_at(old_index) |> List.insert_at(insert_at, child)
                else
                  acc
                end

              old_index && insert_at in [0, -1] ->
                acc |> List.delete_at(old_index) |> List.insert_at(insert_at, child)

              old_index && insert_at > old_index ->
                acc |> List.delete_at(old_index) |> List.insert_at(insert_at - 1, child)

              old_index && insert_at < old_index ->
                acc |> List.delete_at(old_index) |> List.insert_at(insert_at, child)

              !old_index && insert_at ->
                List.insert_at(acc, insert_at, child)
            end
          end)
          |> Enum.reject(fn child ->
            id = attribute(child, "id")
            deleted? = MapSet.member?(stream_deletes, id)
            inserted_at = Map.get(stream_inserts, id, false)

            deleted? && !inserted_at
          end)

        {tag, attrs, new_children}

      content_changed? && type == "append" ->
        {tag, attrs, updated_existing_children ++ updated_appended}

      content_changed? && type == "prepend" ->
        {tag, attrs, updated_appended ++ updated_existing_children}

      !content_changed? ->
        {tag, attrs, updated_appended}
    end
  end

  defp apply_phx_update("ignore", _state, node, _streams) do
    verify_phx_update_id!("ignore", attribute(node, "id"), node)
    node
  end

  defp apply_phx_update(type, _state, node, _streams) when type in [nil, "replace"] do
    node
  end

  defp apply_phx_update(other, _state, _node, _streams) do
    raise ArgumentError,
          "invalid phx-update value #{inspect(other)}, " <>
            "expected one of \"stream\", \"replace\", \"append\", \"prepend\", \"ignore\""
  end

  defp verify_phx_update_id!(type, id, node) when id in ["", nil] do
    raise ArgumentError,
          "setting phx-update to #{inspect(type)} requires setting an ID on the container, " <>
            "got: \n\n #{inspect_html(node)}"
  end

  defp verify_phx_update_id!(_type, _id, _node) do
    :ok
  end

  defp apply_phx_update_children(html_tree, id) do
    case by_id(html_tree, id) do
      {_, _, children_before} -> children_before
      nil -> []
    end
  end

  defp apply_phx_update_children_id(type, children) do
    for {tag, _, _} = child when is_binary(tag) <- children do
      attribute(child, "id") ||
        raise ArgumentError,
              "setting phx-update to #{inspect(type)} requires setting an ID on each child. " <>
                "No ID was found on:\n\n#{to_html(child)}"
    end
  end

  ## Helpers

  defp walk(html_tree, fun) when is_function(fun, 1) do
    Floki.traverse_and_update(html_tree, walk_fun(fun))
  end

  defp walk_fun(fun) when is_function(fun, 1) do
    fn
      text when is_binary(text) -> text
      {:pi, _, _} = xml -> xml
      {:comment, _children} = comment -> comment
      {:doctype, _, _, _} = doctype -> doctype
      {_tag, _attrs, _children} = node -> fun.(node)
    end
  end

  defp by_id(html_tree, id) do
    html_tree |> Floki.find("##{id}") |> List.first()
  end

  def parent_id(html_tree, child_id) do
    try do
      walk(html_tree, fn {tag, attrs, children} = node ->
        parent_id = attribute(node, "id")

        if parent_id && Enum.find(children, fn child -> attribute(child, "id") == child_id end) do
          throw(parent_id)
        else
          {tag, attrs, children}
        end
      end)

      nil
    catch
      :throw, parent_id -> parent_id
    end
  end
end
