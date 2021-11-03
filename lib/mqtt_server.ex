defmodule MqttServer do
  require Logger

  @client_id "mqtt-demo-client"
  @broker "192.168.1.30"
  @port 1883

  def child_spec(opts) do
    %{
      id: Keyword.get(opts, :name, __MODULE__),
      start: {__MODULE__, :start_link, [opts]},
      restart: Keyword.get(opts, :restart, :transient),
      type: :worker
    }
  end

  def start_link(_opts \\ []) do
    connection_opts = [
      client_id: @client_id,
      server: {
        Tortoise.Transport.Tcp, host: @broker, port: @port
      },
      handler: {MqttHandler, []},
      subscriptions: [{"zigbee2mqtt/+", 2}]
    ]

    Tortoise.Connection.start_link(connection_opts, [])
  end

  def send_message_async_to_topic(topic, msg) do
    Logger.debug("sending #{inspect(msg)} to topic #{topic}")
    Tortoise.publish(@client_id, topic, msg, qos: 2)


    # zigbee2mqtt/wall-bulb-bedroom-left/set/state
  end


end
