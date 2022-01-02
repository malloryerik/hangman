defmodule Dictionary do
  alias Dictionary.Impl.WordList

  @opaque t :: WordList.t()

  @spec start() :: :ok
  defdelegate start(), to: WordList, as: :word_list

  defdelegate random_word(words), to: WordList
end
