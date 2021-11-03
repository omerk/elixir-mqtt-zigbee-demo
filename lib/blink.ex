defmodule Blink do
  use GenServer
  require Logger

  def child_spec(opts) do
    %{
      id: Keyword.get(opts, :name, __MODULE__),
      start: {__MODULE__, :start_link, [opts]},
      restart: Keyword.get(opts, :restart, :transient),
      type: :worker
    }
  end

  def start_link(_opts \\ []) do
    Logger.debug("blink started")
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    send_toggle()
    {:ok, :on}
  end

  def handle_info(:toggle, :on) do
    MqttServer.send_message_async_to_topic("zigbee2mqtt/wall-bulb-bedroom-left/set/state", "OFF")
    send_toggle()
    {:noreply, :off}
  end

  def handle_info(:toggle, :off) do
    MqttServer.send_message_async_to_topic("zigbee2mqtt/wall-bulb-bedroom-left/set/state", "ON")
    send_toggle()
    {:noreply, :on}
  end

  def handle_info(msg, state) do
    Logger.debug("catch all: #{inspect(msg)}")
    {:noreply, state}
  end

  def send_toggle() do
    Process.send_after(self(), :toggle, 2000)
  end

end
