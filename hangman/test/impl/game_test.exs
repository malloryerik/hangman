defmodule Hangman.Impl.GameTest do
  use ExUnit.Case
  doctest Hangman.Impl.Game
  alias Hangman.Impl.Game

  #   def new_game do
  #   %Hangman.Impl.Game{
  #     letters: Dictionary.random_word() |> String.codepoints()
  #   }
  # end

  test "new game returns structure" do
    game = Game.new_game()

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
  end

  test "new game returns word's letter list" do
    game = Game.new_game("mystery")

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert game.letters == String.codepoints("mystery")
  end

  test "game won state, and state doesn't change" do
    game = Game.new_game("mystery")
    game = Map.put(game, :game_state, :won)
    {new_game, tally} = Game.make_move(game, "x")
  end
end
