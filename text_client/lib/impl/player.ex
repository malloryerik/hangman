defmodule TextClient.Impl.Player do
  @moduledoc """
  Most of the text_client functions are here.

  """

  @type game :: Hangman.game()
  @type tally :: Hangman.tally()
  @type state :: {game, tally}

  @spec start(game) :: :ok
  def start(game) do
    tally = Hangman.tally(game)
    interact({game, tally})
  end

  @spec interact(state) :: :ok
  def interact({_game, tally = %{game_state: :won}}) do
    IO.puts("You win! Congratulations! The word was '#{tally.letters}'.")
  end

  def interact({_game, tally = %{game_state: :lost}}) do
    IO.puts("Sorry, you lost. The word was '#{tally.letters}'.")
  end

  def interact(_state = {game, tally}) do
    IO.puts(feedback_for(tally))
    IO.puts(current_word(tally))

    tally = Hangman.make_move(game, get_guess())

    interact({game, tally})
  end

  defp current_word(tally) do
    [
      "Word so far: ",
      tally.letters |> Enum.join(" "),
      "    Turns left: ",
      to_string(tally.turns_left),
      "    Used so far: ",
      tally.used |> Enum.join(", ")
    ]
  end

  defp get_guess() do
    IO.gets("Next guess, please: ")
    |> String.trim()
    |> String.downcase()
  end

  #  @type state :: :initializing | :won | :lost | :good_guess | :bad_guess | :already_used
  defp feedback_for(tally = %{game_state: :initializing}) do
    "Get ready to rock'n'roll! I'm thinking of a #{length(tally.letters)} letter word."
  end

  defp feedback_for(%{game_state: :good_guess}), do: "Good guess!"
  defp feedback_for(%{game_state: :bad_guess}), do: "Sorry, that's not in the word."
  defp feedback_for(%{game_state: :already_used}), do: "You've already used that letter."
end
