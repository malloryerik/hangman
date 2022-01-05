defmodule TextClient do
  @moduledoc """
  Documentation for `TextClient`.

  The text client is set up to run a game on a remote server.
  The remote server is currently named hangman@akaste but should be changed.
  It's set at the attribut @remote_server in lib/runtime/remote_hangman.
  """

  @spec start() :: :ok
  # defdelegate start(), to: TextClient.Impl.Player

  def start do
    # get connection pid and pipe into Player module
    TextClient.Runtime.RemoteHangman.connect()
    |> TextClient.Impl.Player.start()
  end
end
