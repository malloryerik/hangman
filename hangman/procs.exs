defmodule Procs do
  def hello() do
    receive do
      msg ->
        IO.puts("Hello, #{inspect(msg)}")
    end
  end
end

# Process dies after doing its thingy.

# iex(19)> spawn Procs, :hello, []
# #PID<0.1503.5>

# iex(20)> pid = spawn Procs, :hello, []
# #PID<0.3226.5>
# iex(23)> send(pid, "Hello")
# Hello, "Hello"
# "Hello"
# iex(24)> send(pid, "Again")
# "Again"
# iex(25)> Process.alive?(pid)
# false
