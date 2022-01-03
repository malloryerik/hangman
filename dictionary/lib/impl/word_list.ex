defmodule Dictionary.Impl.WordList do
  @type t :: WordList.t()

  @spec word_list :: t
  def word_list() do
    "../../assets/words.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split(~r/\n/, trim: true)
  end

  @spec random_word(t) :: String.t()
  def random_word(word_list) do
    Enum.random(word_list)
  end
end
