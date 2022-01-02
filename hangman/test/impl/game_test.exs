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

  test "we recognize a letter in the word" do
    game = Game.new_game("mystery")
    {_game, tally} = Game.make_move(game, "m")
    assert tally.game_state == :good_guess
    {_game, tally} = Game.make_move(game, "y")
    assert tally.game_state == :good_guess
  end

  test "a bad guess results in :bad_guess" do
    game = Game.new_game("mystery")
    {_game, tally} = Game.make_move(game, "z")
    assert tally.game_state == :bad_guess
  end

  test "losing works" do
    game = Game.new_game("mystery")
    game = %{game | turns_left: 1}
    {game, tally} = Game.make_move(game, "z")
    assert tally.game_state == :lost
  end

  # hello
  test "can handle sequence of moves" do
    [
      # guess, state, turns_left, letters,            used
      ["a", :bad_guess, 6, ["_", "_", "_", "_", "_"], ["a"]],
      ["e", :good_guess, 6, ["_", "e", "_", "_", "_"], ["a", "e"]],
      ["x", :bad_guess, 5, ["_", "e", "_", "_", "_"], ["a", "e", "x"]]
    ]
    |> test_sequence_of_moves()
  end

  test "handle a winning game" do
    [
      # guess, state, turns_left, letters,            used
      ["a", :bad_guess, 6, ["_", "_", "_", "_", "_"], ["a"]],
      ["e", :good_guess, 6, ["_", "e", "_", "_", "_"], ["a", "e"]],
      ["x", :bad_guess, 5, ["_", "e", "_", "_", "_"], ["a", "e", "x"]],
      ["l", :good_guess, 5, ["_", "e", "l", "l", "_"], ["a", "e", "l", "x"]],
      ["o", :good_guess, 5, ["_", "e", "l", "l", "o"], ["a", "e", "l", "o", "x"]],
      ["h", :won, 5, ["h", "e", "l", "l", "o"], ["a", "e", "h", "l", "o", "x"]]
    ]
    |> test_sequence_of_moves()
  end

  test "handle a failing game" do
    [
      # guess, state, turns_left, letters,            used
      ["a", :bad_guess, 6, ["_", "_", "_", "_", "_"], ["a"]],
      ["e", :good_guess, 6, ["_", "e", "_", "_", "_"], ["a", "e"]],
      ["x", :bad_guess, 5, ["_", "e", "_", "_", "_"], ["a", "e", "x"]],
      ["l", :good_guess, 5, ["_", "e", "l", "l", "_"], ["a", "e", "l", "x"]],
      ["o", :good_guess, 5, ["_", "e", "l", "l", "o"], ["a", "e", "l", "o", "x"]],
      ["z", :bad_guess, 4, ["_", "e", "l", "l", "o"], ["a", "e", "l", "o", "x", "z"]],
      ["y", :bad_guess, 3, ["_", "e", "l", "l", "o"], ["a", "e", "l", "o", "x", "y", "z"]],
      ["q", :bad_guess, 2, ["_", "e", "l", "l", "o"], ["a", "e", "l", "o", "q", "x", "y", "z"]],
      [
        "r",
        :bad_guess,
        1,
        ["_", "e", "l", "l", "o"],
        ["a", "e", "l", "o", "q", "r", "x", "y", "z"]
      ],
      [
        "s",
        :lost,
        0,
        ["h", "e", "l", "l", "o"],
        ["a", "e", "l", "o", "q", "r", "s", "x", "y", "z"]
      ]
    ]
    |> test_sequence_of_moves()
  end

  def test_sequence_of_moves(script) do
    game = Game.new_game("hello")
    Enum.reduce(script, game, &check_one_move/2)
  end

  defp check_one_move([guess, state, turns_left, letters, used], game) do
    {game, tally} = Game.make_move(game, guess)

    assert tally.game_state == state
    assert tally.turns_left == turns_left
    assert tally.letters == letters
    assert tally.used == used

    game
  end
end
