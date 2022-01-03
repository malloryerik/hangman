defmodule Dictionary.Runtime.Application do
  use Application

  def start(_type, _aargs) do
    Dictionary.Runtime.Server.start_link()
  end
end
