defmodule Hangman.Type do
  @type state_options :: :initializing | :won | :lost | :good_guess | :bad_guess | :already_used

  @type tally :: %{
          turns_left: integer(),
          game_state: state_options,
          letters: list(String.t()),
          used: list(String.t())
        }
end
