defmodule Mqttdemo do
  use Application
  require Logger

  def start(_type, _args) do
    Logger.debug("> starting mqtt demo")

    children = [
      {MqttServer, []},
      {Blink, []}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: __MODULE__)

  end

end
