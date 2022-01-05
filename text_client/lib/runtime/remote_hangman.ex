defmodule TextClient.Runtime.RemoteHangman do
  @moduledoc """
  This module provides a remote server connection
  for the Hangman game.
  """
  @remote_server :hangman@akaste

  def connect do
    :rpc.call(@remote_server, Hangman, :new_game, [])
  end
end
