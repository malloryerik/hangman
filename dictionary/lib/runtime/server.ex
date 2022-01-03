defmodule Dictionary.Runtime.Server do
  alias Dictionary.Impl.WordList

  @type t :: pid()

  # iex> {:ok, pid} = Dictionary.Runtime.Server.start_link
  #      {:ok, #PID<0.163.0>}

  # iex> Dictionary.Runtime.Server.random_word(pid)
  # "code"

  def start_link() do
    Agent.start_link(&WordList.word_list/0, name: :myproc)
  end

  def random_word() do
    Agent.get(:myproc, &WordList.random_word/1)
  end
end
