defmodule Hangman.Runtime.Server do
  use GenServer

  alias Hangman.Impl.Game

  ### Client process code
  def start_link do
    GenServer.start_link(__MODULE__, nil)
  end

  ### Server process code
  def init(_) do
    {:ok, Game.new_game()}
  end
end
