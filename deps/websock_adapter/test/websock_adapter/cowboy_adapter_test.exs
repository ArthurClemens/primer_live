defmodule WebSockAdapterCowboyAdapterTest do
  # False due to capture_log raciness
  use ExUnit.Case, async: false

  import ExUnit.CaptureLog

  defmodule NoopWebSock do
    defmacro __using__(_) do
      quote do
        @behaviour WebSock

        @impl true
        def init(arg), do: {:ok, arg}

        @impl true
        def handle_in(_data, state), do: {:ok, state}

        @impl true
        def handle_info(_msg, state), do: {:ok, state}

        @impl true
        def terminate(_reason, _state), do: :ok

        defoverridable init: 1, handle_in: 2, handle_info: 2, terminate: 2
      end
    end
  end

  setup_all do
    {:ok, _} = Plug.Cowboy.http(__MODULE__, [], port: 0, protocol_options: [idle_timeout: 1000])
    on_exit(fn -> :ok = Plug.Cowboy.shutdown(__MODULE__.HTTP) end)
    {:ok, port: :ranch.get_port(__MODULE__.HTTP)}
  end

  @behaviour Plug

  @impl Plug
  def init(arg), do: arg

  @impl Plug
  def call(conn, _opts) do
    conn = Plug.Conn.fetch_query_params(conn)
    websock = conn.query_params["websock"] |> String.to_atom()
    WebSockAdapter.upgrade(conn, websock, [], timeout: 1000)
  end

  describe "init" do
    defmodule InitOKStateWebSock do
      use NoopWebSock
      def init(_opts), do: {:ok, :init}
      def handle_in(_data, state), do: {:push, {:text, inspect(state)}, state}
    end

    test "can return an ok tuple and update state", context do
      client = tcp_client(context)
      http1_handshake(client, InitOKStateWebSock)

      send_text_frame(client, "OK")
      {:ok, result} = recv_text_frame(client)
      assert result == inspect(:init)
    end

    defmodule InitPushStateWebSock do
      use NoopWebSock
      def init(_opts), do: {:push, {:text, "init"}, :init}
      def handle_in(_data, state), do: {:push, {:text, inspect(state)}, state}
    end

    test "can return a push tuple and update state", context do
      client = tcp_client(context)
      http1_handshake(client, InitPushStateWebSock)

      # Ignore the frame it pushes us
      _ = recv_text_frame(client)

      send_text_frame(client, "OK")
      {:ok, response} = recv_text_frame(client)
      assert response == inspect(:init)
    end

    defmodule InitReplyStateWebSock do
      use NoopWebSock
      def init(_opts), do: {:reply, :ok, {:text, "init"}, :init}
      def handle_in(_data, state), do: {:push, {:text, inspect(state)}, state}
    end

    test "can return a reply tuple and update state", context do
      client = tcp_client(context)
      http1_handshake(client, InitReplyStateWebSock)

      # Ignore the frame it pushes us
      _ = recv_text_frame(client)

      send_text_frame(client, "OK")
      {:ok, response} = recv_text_frame(client)
      assert response == inspect(:init)
    end

    defmodule InitTextWebSock do
      use NoopWebSock
      def init(_opts), do: {:push, {:text, "TEXT"}, :init}
    end

    test "can return a text frame", context do
      client = tcp_client(context)
      http1_handshake(client, InitTextWebSock)

      assert recv_text_frame(client) == {:ok, "TEXT"}
    end

    defmodule InitBinaryWebSock do
      use NoopWebSock
      def init(_opts), do: {:push, {:binary, "BINARY"}, :init}
    end

    test "can return a binary frame", context do
      client = tcp_client(context)
      http1_handshake(client, InitBinaryWebSock)

      assert recv_binary_frame(client) == {:ok, "BINARY"}
    end

    defmodule InitPingWebSock do
      use NoopWebSock
      def init(_opts), do: {:push, {:ping, "PING"}, :init}
    end

    test "can return a ping frame", context do
      client = tcp_client(context)
      http1_handshake(client, InitPingWebSock)

      assert recv_ping_frame(client) == {:ok, "PING"}
    end

    defmodule InitPongWebSock do
      use NoopWebSock
      def init(_opts), do: {:push, {:pong, "PONG"}, :init}
    end

    test "can return a pong frame", context do
      client = tcp_client(context)
      http1_handshake(client, InitPongWebSock)

      assert recv_pong_frame(client) == {:ok, "PONG"}
    end

    defmodule InitListWebSock do
      use NoopWebSock
      def init(_opts), do: {:push, [{:pong, "PONG"}, {:text, "TEXT"}], :init}
    end

    test "can return a list of frames", context do
      client = tcp_client(context)
      http1_handshake(client, InitListWebSock)

      assert recv_pong_frame(client) == {:ok, "PONG"}
      assert recv_text_frame(client) == {:ok, "TEXT"}
    end

    defmodule InitCloseWebSock do
      use NoopWebSock
      def init(_opts), do: {:stop, :normal, :init}
    end

    test "can close a connection by returning a stop tuple", context do
      client = tcp_client(context)
      http1_handshake(client, InitCloseWebSock)

      assert recv_connection_close_frame(client) == {:ok, <<1000::16>>}
      assert connection_closed_for_reading?(client)
    end

    defmodule InitCloseWithCodeWebSock do
      use NoopWebSock
      def init(_opts), do: {:stop, :normal, 5555, :init}
    end

    test "can close a connection by returning a stop tuple with a code", context do
      client = tcp_client(context)
      http1_handshake(client, InitCloseWithCodeWebSock)

      assert recv_connection_close_frame(client) == {:ok, <<5555::16>>}
      assert connection_closed_for_reading?(client)
    end

    defmodule InitRestartCloseWebSock do
      use NoopWebSock
      def init(_opts), do: {:stop, {:shutdown, :restart}, :init}
    end

    @tag capture_log: true
    test "can close a connection by returning an {:shutdown, :restart} tuple", context do
      client = tcp_client(context)
      http1_handshake(client, InitRestartCloseWebSock)

      assert recv_connection_close_frame(client) == {:ok, <<1012::16>>}
      assert connection_closed_for_reading?(client)
    end

    defmodule InitAbnormalCloseWithCodeWebSock do
      use NoopWebSock
      def init(_opts), do: {:stop, :abnormal, 5555, :init}
    end

    @tag capture_log: true
    test "can close a connection by returning an abnormal stop tuple with a code", context do
      client = tcp_client(context)
      http1_handshake(client, InitAbnormalCloseWithCodeWebSock)

      assert recv_connection_close_frame(client) == {:ok, <<5555::16>>}
      assert connection_closed_for_reading?(client)
    end

    defmodule InitCloseWithCodeAndNilDetailWebSock do
      use NoopWebSock
      def init(_opts), do: {:stop, :normal, {5555, nil}, :init}
    end

    test "can close a connection by returning a stop tuple with a code and nil detail", context do
      client = tcp_client(context)
      http1_handshake(client, InitCloseWithCodeAndNilDetailWebSock)

      assert recv_connection_close_frame(client) == {:ok, <<5555::16>>}
      assert connection_closed_for_reading?(client)
    end

    defmodule InitCloseWithCodeAndDetailWebSock do
      use NoopWebSock
      def init(_opts), do: {:stop, :normal, {5555, "BOOM"}, :init}
    end

    test "can close a connection by returning a stop tuple with a code and detail", context do
      client = tcp_client(context)
      http1_handshake(client, InitCloseWithCodeAndDetailWebSock)

      assert recv_connection_close_frame(client) == {:ok, <<5555::16, "BOOM"::binary>>}
      assert connection_closed_for_reading?(client)
    end
  end

  describe "handle_in" do
    defmodule HandleInEchoWebSock do
      use NoopWebSock
      def handle_in({data, opcode: opcode}, state), do: {:push, {opcode, data}, state}
    end

    test "can receive a text frame", context do
      client = tcp_client(context)
      http1_handshake(client, HandleInEchoWebSock)

      send_text_frame(client, "OK")

      assert recv_text_frame(client) == {:ok, "OK"}
    end

    test "can receive a bianry frame", context do
      client = tcp_client(context)
      http1_handshake(client, HandleInEchoWebSock)

      send_binary_frame(client, "OK")

      assert recv_binary_frame(client) == {:ok, "OK"}
    end

    defmodule HandleInStateWebSock do
      use NoopWebSock
      def init(_opts), do: {:ok, []}

      def handle_in({"dump", opcode: :text} = data, state),
        do: {:push, {:text, inspect(state)}, [data | state]}

      def handle_in(data, state), do: {:ok, [data | state]}
    end

    test "can return an ok tuple and update state", context do
      client = tcp_client(context)
      http1_handshake(client, HandleInStateWebSock)

      send_text_frame(client, "OK")
      send_text_frame(client, "dump")

      {:ok, response} = recv_text_frame(client)
      assert response == inspect([{"OK", opcode: :text}])
    end

    test "can return a push tuple and update state", context do
      client = tcp_client(context)
      http1_handshake(client, HandleInStateWebSock)

      send_text_frame(client, "dump")
      _ = recv_text_frame(client)
      send_text_frame(client, "dump")

      {:ok, response} = recv_text_frame(client)
      assert response == inspect([{"dump", opcode: :text}])
    end

    defmodule HandleInReplyStateWebSock do
      use NoopWebSock
      def init(_opts), do: {:ok, []}

      def handle_in({"dump", opcode: :text} = data, state),
        do: {:reply, :ok, {:text, inspect(state)}, [data | state]}

      def handle_in(data, state), do: {:ok, [data | state]}
    end

    test "can return a reply tuple and update state", context do
      client = tcp_client(context)
      http1_handshake(client, HandleInReplyStateWebSock)

      send_text_frame(client, "dump")
      _ = recv_text_frame(client)
      send_text_frame(client, "dump")

      {:ok, response} = recv_text_frame(client)
      assert response == inspect([{"dump", opcode: :text}])
    end

    defmodule HandleInTextWebSock do
      use NoopWebSock
      def handle_in(_data, state), do: {:push, {:text, "TEXT"}, state}
    end

    test "can return a text frame", context do
      client = tcp_client(context)
      http1_handshake(client, HandleInTextWebSock)

      send_text_frame(client, "OK")

      assert recv_text_frame(client) == {:ok, "TEXT"}
    end

    defmodule HandleInBinaryWebSock do
      use NoopWebSock
      def handle_in(_data, state), do: {:push, {:binary, "BINARY"}, state}
    end

    test "can return a binary frame", context do
      client = tcp_client(context)
      http1_handshake(client, HandleInBinaryWebSock)

      send_text_frame(client, "OK")

      assert recv_binary_frame(client) == {:ok, "BINARY"}
    end

    defmodule HandleInPingWebSock do
      use NoopWebSock
      def handle_in(_data, state), do: {:push, {:ping, "PING"}, state}
    end

    test "can return a ping frame", context do
      client = tcp_client(context)
      http1_handshake(client, HandleInPingWebSock)

      send_text_frame(client, "OK")

      assert recv_ping_frame(client) == {:ok, "PING"}
    end

    defmodule HandleInPongWebSock do
      use NoopWebSock
      def handle_in(_data, state), do: {:push, {:pong, "PONG"}, state}
    end

    test "can return a pong frame", context do
      client = tcp_client(context)
      http1_handshake(client, HandleInPongWebSock)

      send_text_frame(client, "OK")

      assert recv_pong_frame(client) == {:ok, "PONG"}
    end

    defmodule HandleInListWebSock do
      use NoopWebSock
      def handle_in(_data, state), do: {:push, [{:pong, "PONG"}, {:text, "TEXT"}], state}
    end

    test "can return a list of frames", context do
      client = tcp_client(context)
      http1_handshake(client, HandleInListWebSock)

      send_text_frame(client, "OK")

      assert recv_pong_frame(client) == {:ok, "PONG"}
      assert recv_text_frame(client) == {:ok, "TEXT"}
    end

    defmodule HandleInCloseWebSock do
      use NoopWebSock
      def handle_in(_data, state), do: {:stop, :normal, state}
    end

    test "can close a connection by returning a stop tuple", context do
      client = tcp_client(context)
      http1_handshake(client, HandleInCloseWebSock)

      send_text_frame(client, "OK")

      assert recv_connection_close_frame(client) == {:ok, <<1000::16>>}
      assert connection_closed_for_reading?(client)
    end

    defmodule HandleInCloseWithCodeWebSock do
      use NoopWebSock
      def handle_in(_data, state), do: {:stop, :normal, 5555, state}
    end

    test "can close a connection by returning a stop tuple with a code", context do
      client = tcp_client(context)
      http1_handshake(client, HandleInCloseWithCodeWebSock)

      send_text_frame(client, "OK")

      assert recv_connection_close_frame(client) == {:ok, <<5555::16>>}
      assert connection_closed_for_reading?(client)
    end

    defmodule HandleInCloseWithCodeAndDetailWebSock do
      use NoopWebSock
      def handle_in(_data, state), do: {:stop, :normal, {5555, "BOOM"}, state}
    end

    test "can close a connection by returning a stop tuple with a code and detail", context do
      client = tcp_client(context)
      http1_handshake(client, HandleInCloseWithCodeAndDetailWebSock)

      send_text_frame(client, "OK")

      assert recv_connection_close_frame(client) == {:ok, <<5555::16, "BOOM"::binary>>}
      assert connection_closed_for_reading?(client)
    end
  end

  describe "handle_control" do
    defmodule HandleControlNoImplWebSock do
      use NoopWebSock
      def handle_in({data, opcode: opcode}, state), do: {:push, {opcode, data}, state}
    end

    test "callback is optional", context do
      client = tcp_client(context)
      http1_handshake(client, HandleControlNoImplWebSock)

      send_ping_frame(client, "OK")
      assert recv_pong_frame(client)

      # Test that the connection is still alive
      send_text_frame(client, "OK")
      assert recv_text_frame(client) == {:ok, "OK"}
    end

    defmodule HandleControlEchoWebSock do
      use NoopWebSock
      def handle_control({data, opcode: opcode}, state), do: {:push, {opcode, data}, state}
    end

    test "can receive a ping frame", context do
      client = tcp_client(context)
      http1_handshake(client, HandleControlEchoWebSock)

      send_ping_frame(client, "OK")
      _ = recv_pong_frame(client)

      assert recv_ping_frame(client) == {:ok, "OK"}
    end

    test "can receive a pong frame", context do
      client = tcp_client(context)
      http1_handshake(client, HandleControlEchoWebSock)

      send_pong_frame(client, "OK")

      assert recv_pong_frame(client) == {:ok, "OK"}
    end

    defmodule HandleControlStateWebSock do
      use NoopWebSock
      def init(_opts), do: {:ok, []}

      def handle_control({"dump", opcode: :ping} = data, state),
        do: {:push, {:ping, inspect(state)}, [data | state]}

      def handle_control(data, state), do: {:ok, [data | state]}
    end

    test "can return an ok tuple and update state", context do
      client = tcp_client(context)
      http1_handshake(client, HandleControlStateWebSock)

      send_ping_frame(client, "OK")
      _ = recv_pong_frame(client)
      send_ping_frame(client, "dump")
      _ = recv_pong_frame(client)

      {:ok, response} = recv_ping_frame(client)
      assert response == inspect([{"OK", opcode: :ping}])
    end

    test "can return a push tuple and update state", context do
      client = tcp_client(context)
      http1_handshake(client, HandleControlStateWebSock)

      send_ping_frame(client, "dump")
      _ = recv_pong_frame(client)
      _ = recv_ping_frame(client)
      send_ping_frame(client, "dump")
      _ = recv_pong_frame(client)

      {:ok, response} = recv_ping_frame(client)
      assert response == inspect([{"dump", opcode: :ping}])
    end

    defmodule HandleControlReplyStateWebSock do
      use NoopWebSock
      def init(_opts), do: {:ok, []}

      def handle_control({"dump", opcode: :ping} = data, state),
        do: {:reply, :ok, {:ping, inspect(state)}, [data | state]}

      def handle_control(data, state), do: {:ok, [data | state]}
    end

    test "can return a reply tuple and update state", context do
      client = tcp_client(context)
      http1_handshake(client, HandleControlReplyStateWebSock)

      send_ping_frame(client, "dump")
      _ = recv_pong_frame(client)
      _ = recv_ping_frame(client)
      send_ping_frame(client, "dump")
      _ = recv_pong_frame(client)

      {:ok, response} = recv_ping_frame(client)
      assert response == inspect([{"dump", opcode: :ping}])
    end

    defmodule HandleControlTextWebSock do
      use NoopWebSock
      def handle_control(_data, state), do: {:push, {:text, "TEXT"}, state}
    end

    test "can return a text frame", context do
      client = tcp_client(context)
      http1_handshake(client, HandleControlTextWebSock)

      send_ping_frame(client, "OK")
      _ = recv_pong_frame(client)

      assert recv_text_frame(client) == {:ok, "TEXT"}
    end

    defmodule HandleControlBinaryWebSock do
      use NoopWebSock
      def handle_control(_data, state), do: {:push, {:binary, "BINARY"}, state}
    end

    test "can return a binary frame", context do
      client = tcp_client(context)
      http1_handshake(client, HandleControlBinaryWebSock)

      send_ping_frame(client, "OK")
      _ = recv_pong_frame(client)

      assert recv_binary_frame(client) == {:ok, "BINARY"}
    end

    defmodule HandleControlPingWebSock do
      use NoopWebSock
      def handle_control(_data, state), do: {:push, {:ping, "PING"}, state}
    end

    test "can return a ping frame", context do
      client = tcp_client(context)
      http1_handshake(client, HandleControlPingWebSock)

      send_ping_frame(client, "OK")
      _ = recv_pong_frame(client)

      assert recv_ping_frame(client) == {:ok, "PING"}
    end

    defmodule HandleControlPongWebSock do
      use NoopWebSock
      def handle_control(_data, state), do: {:push, {:pong, "PONG"}, state}
    end

    test "can return a pong frame", context do
      client = tcp_client(context)
      http1_handshake(client, HandleControlPongWebSock)

      send_ping_frame(client, "OK")
      _ = recv_pong_frame(client)

      assert recv_pong_frame(client) == {:ok, "PONG"}
    end

    defmodule HandleControlListWebSock do
      use NoopWebSock
      def handle_control(_data, state), do: {:push, [{:pong, "PONG"}, {:text, "TEXT"}], state}
    end

    test "can return a list of frames", context do
      client = tcp_client(context)
      http1_handshake(client, HandleControlListWebSock)

      send_ping_frame(client, "OK")
      _ = recv_pong_frame(client)

      assert recv_pong_frame(client) == {:ok, "PONG"}
      assert recv_text_frame(client) == {:ok, "TEXT"}
    end

    defmodule HandleControlCloseWebSock do
      use NoopWebSock
      def handle_control(_data, state), do: {:stop, :normal, state}
    end

    test "can close a connection by returning a stop tuple", context do
      client = tcp_client(context)
      http1_handshake(client, HandleControlCloseWebSock)

      send_ping_frame(client, "OK")
      _ = recv_pong_frame(client)

      assert recv_connection_close_frame(client) == {:ok, <<1000::16>>}
      assert connection_closed_for_reading?(client)
    end

    defmodule HandleControlCloseWithCodeWebSock do
      use NoopWebSock
      def handle_control(_data, state), do: {:stop, :normal, 5555, state}
    end

    test "can close a connection by returning a stop tuple with a code", context do
      client = tcp_client(context)
      http1_handshake(client, HandleControlCloseWithCodeWebSock)

      send_ping_frame(client, "OK")
      _ = recv_pong_frame(client)

      assert recv_connection_close_frame(client) == {:ok, <<5555::16>>}
      assert connection_closed_for_reading?(client)
    end

    defmodule HandleControlCloseWithCodeAndDetailWebSock do
      use NoopWebSock
      def handle_control(_data, state), do: {:stop, :normal, {5555, "BOOM"}, state}
    end

    test "can close a connection by returning a stop tuple with a code and detail", context do
      client = tcp_client(context)
      http1_handshake(client, HandleControlCloseWithCodeAndDetailWebSock)

      send_ping_frame(client, "OK")
      _ = recv_pong_frame(client)

      assert recv_connection_close_frame(client) == {:ok, <<5555::16, "BOOM"::binary>>}
      assert connection_closed_for_reading?(client)
    end
  end

  describe "handle_info" do
    defmodule HandleInfoStateWebSock do
      use NoopWebSock
      def init(_opts), do: {:ok, []}
      def handle_in(_data, state), do: {:push, {:text, :erlang.pid_to_list(self())}, state}
      def handle_info("dump" = data, state), do: {:push, {:text, inspect(state)}, [data | state]}
      def handle_info(data, state), do: {:ok, [data | state]}
    end

    test "can return an ok tuple and update state", context do
      client = tcp_client(context)
      http1_handshake(client, HandleInfoStateWebSock)

      send_text_frame(client, "whoami")
      {:ok, pid} = recv_text_frame(client)
      pid = pid |> String.to_charlist() |> :erlang.list_to_pid()

      Process.send(pid, "OK", [])
      Process.send(pid, "dump", [])

      {:ok, response} = recv_text_frame(client)
      assert response == inspect(["OK"])
    end

    test "can return a push tuple and update state", context do
      client = tcp_client(context)
      http1_handshake(client, HandleInfoStateWebSock)

      send_text_frame(client, "whoami")
      {:ok, pid} = recv_text_frame(client)
      pid = pid |> String.to_charlist() |> :erlang.list_to_pid()

      Process.send(pid, "dump", [])
      _ = recv_text_frame(client)
      Process.send(pid, "dump", [])

      {:ok, response} = recv_text_frame(client)
      assert response == inspect(["dump"])
    end

    defmodule HandleInfoTextWebSock do
      use NoopWebSock
      def handle_in(_data, state), do: {:push, {:text, :erlang.pid_to_list(self())}, state}
      def handle_info(_data, state), do: {:push, {:text, "TEXT"}, state}
    end

    test "can return a text frame", context do
      client = tcp_client(context)
      http1_handshake(client, HandleInfoTextWebSock)

      send_text_frame(client, "whoami")
      {:ok, pid} = recv_text_frame(client)
      pid = pid |> String.to_charlist() |> :erlang.list_to_pid()
      Process.send(pid, "OK", [])

      assert recv_text_frame(client) == {:ok, "TEXT"}
    end

    defmodule HandleInfoBinaryWebSock do
      use NoopWebSock
      def handle_in(_data, state), do: {:push, {:text, :erlang.pid_to_list(self())}, state}
      def handle_info(_data, state), do: {:push, {:binary, "BINARY"}, state}
    end

    test "can return a binary frame", context do
      client = tcp_client(context)
      http1_handshake(client, HandleInfoBinaryWebSock)

      send_text_frame(client, "whoami")
      {:ok, pid} = recv_text_frame(client)
      pid = pid |> String.to_charlist() |> :erlang.list_to_pid()
      Process.send(pid, "OK", [])

      assert recv_binary_frame(client) == {:ok, "BINARY"}
    end

    defmodule HandleInfoPingWebSock do
      use NoopWebSock
      def handle_in(_data, state), do: {:push, {:text, :erlang.pid_to_list(self())}, state}
      def handle_info(_data, state), do: {:push, {:ping, "PING"}, state}
    end

    test "can return a ping frame", context do
      client = tcp_client(context)
      http1_handshake(client, HandleInfoPingWebSock)

      send_text_frame(client, "whoami")
      {:ok, pid} = recv_text_frame(client)
      pid = pid |> String.to_charlist() |> :erlang.list_to_pid()
      Process.send(pid, "OK", [])

      assert recv_ping_frame(client) == {:ok, "PING"}
    end

    defmodule HandleInfoPongWebSock do
      use NoopWebSock
      def handle_in(_data, state), do: {:push, {:text, :erlang.pid_to_list(self())}, state}
      def handle_info(_data, state), do: {:push, {:pong, "PONG"}, state}
    end

    test "can return a pong frame", context do
      client = tcp_client(context)
      http1_handshake(client, HandleInfoPongWebSock)

      send_text_frame(client, "whoami")
      {:ok, pid} = recv_text_frame(client)
      pid = pid |> String.to_charlist() |> :erlang.list_to_pid()
      Process.send(pid, "OK", [])

      assert recv_pong_frame(client) == {:ok, "PONG"}
    end

    defmodule HandleInfoListWebSock do
      use NoopWebSock
      def handle_in(_data, state), do: {:push, {:text, :erlang.pid_to_list(self())}, state}
      def handle_info(_data, state), do: {:push, [{:pong, "PONG"}, {:text, "TEXT"}], state}
    end

    test "can return a list of frames", context do
      client = tcp_client(context)
      http1_handshake(client, HandleInfoListWebSock)

      send_text_frame(client, "whoami")
      {:ok, pid} = recv_text_frame(client)
      pid = pid |> String.to_charlist() |> :erlang.list_to_pid()
      Process.send(pid, "OK", [])

      assert recv_pong_frame(client) == {:ok, "PONG"}
      assert recv_text_frame(client) == {:ok, "TEXT"}
    end

    defmodule HandleInfoCloseWebSock do
      use NoopWebSock
      def handle_in(_data, state), do: {:push, {:text, :erlang.pid_to_list(self())}, state}
      def handle_info(_data, state), do: {:stop, :normal, state}
    end

    test "can close a connection by returning a stop tuple", context do
      client = tcp_client(context)
      http1_handshake(client, HandleInfoCloseWebSock)

      send_text_frame(client, "whoami")
      {:ok, pid} = recv_text_frame(client)
      pid = pid |> String.to_charlist() |> :erlang.list_to_pid()
      Process.send(pid, "OK", [])

      assert recv_connection_close_frame(client) == {:ok, <<1000::16>>}
      assert connection_closed_for_reading?(client)
    end

    defmodule HandleInfoCloseWithCodeWebSock do
      use NoopWebSock
      def handle_in(_data, state), do: {:push, {:text, :erlang.pid_to_list(self())}, state}
      def handle_info(_data, state), do: {:stop, :normal, 5555, state}
    end

    test "can close a connection by returning a stop tuple with a code", context do
      client = tcp_client(context)
      http1_handshake(client, HandleInfoCloseWithCodeWebSock)

      send_text_frame(client, "whoami")
      {:ok, pid} = recv_text_frame(client)
      pid = pid |> String.to_charlist() |> :erlang.list_to_pid()
      Process.send(pid, "OK", [])

      assert recv_connection_close_frame(client) == {:ok, <<5555::16>>}
      assert connection_closed_for_reading?(client)
    end

    defmodule HandleInfoCloseWithCodeAndDetailWebSock do
      use NoopWebSock
      def handle_in(_data, state), do: {:push, {:text, :erlang.pid_to_list(self())}, state}
      def handle_info(_data, state), do: {:stop, :normal, {5555, "BOOM"}, state}
    end

    test "can close a connection by returning a stop tuple with a code and detail", context do
      client = tcp_client(context)
      http1_handshake(client, HandleInfoCloseWithCodeAndDetailWebSock)

      send_text_frame(client, "whoami")
      {:ok, pid} = recv_text_frame(client)
      pid = pid |> String.to_charlist() |> :erlang.list_to_pid()
      Process.send(pid, "OK", [])

      assert recv_connection_close_frame(client) == {:ok, <<5555::16, "BOOM"::binary>>}
      assert connection_closed_for_reading?(client)
    end
  end

  describe "terminate" do
    setup do
      Process.register(self(), __MODULE__)
      :ok
    end

    def send(msg), do: send(__MODULE__, msg)

    defmodule TerminateNoImplWebSock do
      def init(_), do: {:ok, []}
      def handle_in({"normal", opcode: :text}, state), do: {:stop, :normal, state}
    end

    test "callback is optional", context do
      client = tcp_client(context)
      http1_handshake(client, TerminateNoImplWebSock)

      warnings =
        capture_log(fn ->
          # Get the websock to tell server to shut down
          send_text_frame(client, "normal")

          # Give our adapter a chance to explode if it's going to
          Process.sleep(100)
        end)

      refute warnings =~ "undef"
    end

    defmodule TerminateWebSock do
      use NoopWebSock
      def handle_in({"normal", opcode: :text}, state), do: {:stop, :normal, state}
      def terminate(reason, _state), do: WebSockAdapterCowboyAdapterTest.send(reason)
    end

    test "is called with :normal on a normal connection shutdown", context do
      client = tcp_client(context)
      http1_handshake(client, TerminateWebSock)

      # Get the websock to tell server to shut down
      send_text_frame(client, "normal")

      assert_receive :normal
    end

    test "is called with :remote on a normal remote shutdown", context do
      client = tcp_client(context)
      http1_handshake(client, TerminateWebSock)

      send_connection_close_frame(client, 1000)

      assert_receive :remote
    end

    test "is called with {:error, reason} on a protocol error", context do
      client = tcp_client(context)
      http1_handshake(client, TerminateWebSock)

      :gen_tcp.close(client)

      assert_receive {:error, :closed}
    end

    @tag capture_log: true
    test "is called with :timeout on a timeout", context do
      client = tcp_client(context)
      http1_handshake(client, TerminateWebSock)

      assert_receive :timeout, 1500
    end
  end

  # Simple WebSocket client

  def tcp_client(context) do
    {:ok, socket} = :gen_tcp.connect('localhost', context[:port], active: false, mode: :binary)

    socket
  end

  def http1_handshake(client, module, params \\ []) do
    params = params |> Keyword.put(:websock, module)

    :gen_tcp.send(client, """
    GET /?#{URI.encode_query(params)} HTTP/1.1\r
    Host: server.example.com\r
    Upgrade: websocket\r
    Connection: Upgrade\r
    Sec-WebSocket-Key: dGhlIHNhbXBsZSBub25jZQ==\r
    Sec-WebSocket-Version: 13\r
    \r
    """)

    {:ok, response} = :gen_tcp.recv(client, 234)

    [
      "HTTP/1.1 101 Switching Protocols",
      "cache-control: max-age=0, private, must-revalidate",
      "connection: Upgrade",
      "date: " <> _date,
      "sec-websocket-accept: s3pPLMBiTxaQ9kYGzzhZRbK+xOo=",
      "server: Cowboy",
      "upgrade: websocket",
      "",
      ""
    ] = String.split(response, "\r\n")
  end

  def connection_closed_for_reading?(client) do
    :gen_tcp.recv(client, 0) == {:error, :closed}
  end

  def connection_closed_for_writing?(client) do
    :gen_tcp.send(client, <<>>) == {:error, :closed}
  end

  def recv_text_frame(client) do
    {:ok, 0x8, 0x1, body} = recv_frame(client)
    {:ok, body}
  end

  def recv_binary_frame(client) do
    {:ok, 0x8, 0x2, body} = recv_frame(client)
    {:ok, body}
  end

  def recv_connection_close_frame(client) do
    {:ok, 0x8, 0x8, body} = recv_frame(client)
    {:ok, body}
  end

  def recv_ping_frame(client) do
    {:ok, 0x8, 0x9, body} = recv_frame(client)
    {:ok, body}
  end

  def recv_pong_frame(client) do
    {:ok, 0x8, 0xA, body} = recv_frame(client)
    {:ok, body}
  end

  defp recv_frame(client) do
    {:ok, header} = :gen_tcp.recv(client, 2)
    <<flags::4, opcode::4, 0::1, length::7>> = header

    {:ok, data} =
      case length do
        0 ->
          {:ok, <<>>}

        126 ->
          {:ok, <<length::16>>} = :gen_tcp.recv(client, 2)
          :gen_tcp.recv(client, length)

        127 ->
          {:ok, <<length::64>>} = :gen_tcp.recv(client, 8)
          :gen_tcp.recv(client, length)

        length ->
          :gen_tcp.recv(client, length)
      end

    {:ok, flags, opcode, data}
  end

  def send_continuation_frame(client, data, flags \\ 0x8) do
    send_frame(client, flags, 0x0, data)
  end

  def send_text_frame(client, data, flags \\ 0x8) do
    send_frame(client, flags, 0x1, data)
  end

  def send_binary_frame(client, data, flags \\ 0x8) do
    send_frame(client, flags, 0x2, data)
  end

  def send_connection_close_frame(client, reason) do
    send_frame(client, 0x8, 0x8, <<reason::16>>)
  end

  def send_ping_frame(client, data) do
    send_frame(client, 0x8, 0x9, data)
  end

  def send_pong_frame(client, data) do
    send_frame(client, 0x8, 0xA, data)
  end

  defp send_frame(client, flags, opcode, data) do
    mask = :rand.uniform(1_000_000)
    masked_data = mask(data, mask)

    mask_flag_and_size =
      case byte_size(masked_data) do
        size when size <= 125 -> <<1::1, size::7>>
        size when size <= 65_535 -> <<1::1, 126::7, size::16>>
        size -> <<1::1, 127::7, size::64>>
      end

    :gen_tcp.send(client, [<<flags::4, opcode::4>>, mask_flag_and_size, <<mask::32>>, masked_data])
  end

  # Note that masking is an involution, so we don't need a separate unmask function
  defp mask(payload, mask, acc \\ <<>>)

  defp mask(payload, mask, acc) when is_integer(mask), do: mask(payload, <<mask::32>>, acc)

  defp mask(<<h::32, rest::binary>>, <<mask::32>>, acc) do
    mask(rest, mask, acc <> <<Bitwise.bxor(h, mask)::32>>)
  end

  defp mask(<<h::8, rest::binary>>, <<current::8, mask::24>>, acc) do
    mask(rest, <<mask::24, current::8>>, acc <> <<Bitwise.bxor(h, current)::8>>)
  end

  defp mask(<<>>, _mask, acc), do: acc
end
