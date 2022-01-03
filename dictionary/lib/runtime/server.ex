defmodule Dictionary.Runtime.Server do
  @type t :: pid()

  @me __MODULE__

  use Agent

  alias Dictionary.Impl.WordList

  # iex> {:ok, pid} = Dictionary.Runtime.Server.start_link
  #      {:ok, #PID<0.163.0>}

  # iex> Dictionary.Runtime.Server.random_word(pid)
  # "code"

  def start_link(_) do
    Agent.start_link(&WordList.word_list/0, name: @me)
  end

  def random_word() do
    if :rand.uniform() < 0.33 do
      Agent.get(@me, fn _ -> exit(:boom) end)
    end

    Agent.get(@me, &WordList.random_word/1)
  end
end
