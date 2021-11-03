defmodule MqttHandler do
  use Tortoise.Handler
  require Logger

  def init(args) do
    {:ok, args}
  end

  def connection(status, state) do
    # `status` will be either `:up` or `:down`; you can use this to
    # inform the rest of your system if the connection is currently
    # open or closed; tortoise should be busy reconnecting if you get
    # a `:down`
    {:ok, state}
  end

  @doc """
  Example message:

  Topic: zigbee2mqtt/motion-hall
  QoS: 0
  {"battery":15.5,"elapsed":298104,"illuminance":9966,"illuminance_lux":10,
  "last_seen":"2021-10-31T19:04:09+00:00","led_indication":true,"linkquality":45,
  "motion_sensitivity":"high","occupancy":false,"occupancy_timeout":0,"temperature":18.25,
  "update":{"state":"idle"},"update_available":false}
  """
  def handle_message(["zigbee2mqttmotion-hall"], payload, state) do
    Logger.debug(payload)
    {:ok, state}
  end

  def handle_message(topic, payload, state) do
    # unhandled message! You will crash if you subscribe to something
    # and you don't have a 'catch all' matcher; crashing on unexpected
    # messages could be a strategy though.
    Logger.debug("xx On topic #{topic} got message #{inspect(payload)}")
    {:ok, state}
  end

  def subscription(status, topic_filter, state) do
    {:ok, state}
  end

  def terminate(reason, state) do
    # tortoise doesn't care about what you return from terminate/2,
    # that is in alignment with other behaviours that implement a
    # terminate-callback
    :ok
  end
end
