defmodule TextClient.Impl.Player do
  @moduledoc """
  Most of the text_client functions are here.

  """

  @type game :: Hangman.game()
  @type tally :: Hangman.tally()
  @type state :: {game, tally}

  def start() do
    game = Hangman.new_game()
    tally = Hangman.tally(game)

    interact({game, tally})
  end

  @spec interact(state) :: :ok
  def interact({_game, _tally = %{game_state: :won}}) do
    IO.puts("You win! Congratulations!")
  end

  def interact({_game, _tally = %{game_state: :lost}}) do
    IO.puts("You lost... better luck next time.")
  end

  def interact(_state = {_game, tally}) do
    # feedback -- good guess or not etc
    IO.puts(feedback_for(tally))
    # display the current word
    # get the next guess
    # make move (recurse)
    # interact()
  end

  #  @type state :: :initializing | :won | :lost | :good_guess | :bad_guess | :already_used
  defp feedback_for(tally = %{game_state: :initializing}) do
    "Get ready to rock'n'roll! I'm thinking of a #{length(tally.letters)} letter word."
  end

  defp feedback_for(%{game_state: :good_guess}), do: "Good guess!"
  defp feedback_for(%{game_state: :bad_guess}), do: "Sorry, that's not in the word."
  defp feedback_for(%{game_state: :already_used}), do: "You've already used that letter."
end
