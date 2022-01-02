defmodule Procs do
  def hello(count) do
    receive do
      {:quit} ->
        IO.puts("Later, tater")

      {:add, n} ->
        hello(count + n)

      {:subtract, n} ->
        hello(count - n)

      msg ->
        IO.puts("#{count}: Hello, #{inspect(msg)}")
        hello(count)
    end
  end
end

# iex(37)> pid = spawn(Procs, :hello, [ 0 ])
# #PID<0.28617.8>
# iex(38)> send(pid, "Cute Stuff.")
# 0: Hello, "Cute Stuff."
# "Cute Stuff."
# iex(39)> send(pid, "Baybeee.")
# 1: Hello, "Baybeee."
# "Baybeee."
# iex(40)> send(pid, "Sweet World.")
# 2: Hello, "Sweet World."
# "Sweet World."
