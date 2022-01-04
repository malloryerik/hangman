defmodule Demo do
  def reverse do
    receive do
      # msg ->
      {from_pid, msg} ->
        IO.inspect(from_pid)
        result = msg |> String.reverse()
        #  IO.puts(result)
        send(from_pid, result)
        reverse()
    end
  end
end

## NOTES
## So a few things here.
# Imagine two nodes, in this case two iex sessions.
# :one and :two
# Processes have something called a Group Leader.

########## Group Leader
# Sounds kind of squadron-y, doesn't it?
# Elixir in Action, 2nd says, p.309,d
# That the Group Leader is responsible for in/out operations.
# What's more, if I understand it, processes run where they are spawned, however they can be spawned from other reote processes.
