defmodule Dictionary.Runtime.Server do
  @type t :: pid()

  @me __MODULE__

  alias Dictionary.Impl.WordList

  # iex> {:ok, pid} = Dictionary.Runtime.Server.start_link
  #      {:ok, #PID<0.163.0>}

  # iex> Dictionary.Runtime.Server.random_word(pid)
  # "code"

  def start_link() do
    Agent.start_link(&WordList.word_list/0, name: @me)
  end

  def random_word() do
    Agent.get(@me, &WordList.random_word/1)
  end
end
