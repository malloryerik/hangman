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
    for state <- [:won, :lost] do
      game = Game.new_game("mystery")
      game = Map.put(game, :game_state, state)
      {new_game, _tally} = Game.make_move(game, "x")
      assert new_game == game
    end
  end

  test "duped letter reported" do
    game = Game.new_game()
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state != :already_used
    {game, _tally} = Game.make_move(game, "y")
    assert game.game_state != :already_used
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "we record used letters" do
    game = Game.new_game()
    {game, _tally} = Game.make_move(game, "x")
    {game, _tally} = Game.make_move(game, "y")
    {game, _tally} = Game.make_move(game, "x")
    assert MapSet.equal?(game.used, MapSet.new(["x", "y"]))
  end
end
