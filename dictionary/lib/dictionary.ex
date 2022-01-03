defmodule Dictionary do
  alias Dictionary.Runtime.Server

  @opaque t :: Server.t()

  @spec start_link :: {:ok, t}
  defdelegate start_link, to: Server

  defdelegate random_word(words), to: Server
end
