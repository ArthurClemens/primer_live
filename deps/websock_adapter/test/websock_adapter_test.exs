defmodule WebSockAdapterTest do
  use ExUnit.Case, async: true

  test "upgrades Bandit HTTP1 connections and handles all options" do
    opts = [compress: true, timeout: 1, max_frame_size: 2, fullsweep_after: 3, other: :ok]

    %Plug.Conn{adapter: {Bandit.HTTP1.Adapter, adapter}} =
      WebSockAdapter.upgrade(
        %Plug.Conn{adapter: {Bandit.HTTP1.Adapter, %{upgrade: nil}}},
        :sock,
        :arg,
        opts
      )

    assert adapter.upgrade == {:websocket, {:sock, :arg, opts}}
  end

  test "raises attemping to upgrade Bandit HTTP2 connections" do
    opts = [compress: true, timeout: 1, max_frame_size: 2, fullsweep_after: 3, other: :ok]

    assert_raise ArgumentError,
                 "upgrade to websocket not supported by Bandit.HTTP2.Adapter",
                 fn ->
                   WebSockAdapter.upgrade(
                     %Plug.Conn{adapter: {Bandit.HTTP2.Adapter, %{}}},
                     :sock,
                     :arg,
                     opts
                   )
                 end
  end

  test "upgrades Cowboy connections and handles all options" do
    opts = [compress: true, timeout: 1, max_frame_size: 2, fullsweep_after: 3, other: :ok]

    %Plug.Conn{adapter: {Plug.Cowboy.Conn, adapter}} =
      WebSockAdapter.upgrade(%Plug.Conn{adapter: {Plug.Cowboy.Conn, %{}}}, :sock, :arg, opts)

    assert adapter.upgrade ==
             {:websocket,
              {WebSockAdapter.CowboyAdapter, {:sock, %{fullsweep_after: 3}, :arg},
               %{compress: true, idle_timeout: 1, max_frame_size: 2}}}
  end

  test "raises an error on unknown adapter upgrade requests" do
    assert_raise ArgumentError, "Unknown adapter OtherServer", fn ->
      WebSockAdapter.upgrade(%Plug.Conn{adapter: {OtherServer, %{}}}, :sock, :arg, [])
    end
  end
end
