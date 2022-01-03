defmodule Hangman.Runtime.Server do
  use GenServer

  alias Hangman.Impl.Game

  ### Client process code
  def start_link do
    GenServer.start_link(__MODULE__, nil)
  end

  ### Server process code

  # called back in new process
  # receives as param what was passed in at start_link (nil here)
  #                                      -- we ignore this time.
  def init(_) do
    # {:ok, state} -- here we start a new game and keep as state in genserver
    {:ok, Game.new_game()}
  end

  def handle_call({:make_move, guess}, _from, game) do
    {updated_game, tally} = Game.make_move(game, guess)
    {:reply, tally, updated_game}
  end

  def handle_call({:tally}, _from, game) do
    {:reply, Game.tally(game), game}
  end
end
