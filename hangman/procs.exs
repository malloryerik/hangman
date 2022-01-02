defmodule Procs do
  def hello() do
    receive do
      msg ->
        IO.puts("Hello, #{inspect(msg)}")
    end

    hello()
  end
end

# Loop it!

# iex(27)> pid = spawn Procs, :hello, []
# #PID<0.17267.5>
# iex(28)> send pid, 123
# Hello, 123
# 123
# iex(29)> send pid, "whattup"
# "whattup"
# iex(30)> send pid, "oomphalaboomboom"
# "oomphalaboomboom"
