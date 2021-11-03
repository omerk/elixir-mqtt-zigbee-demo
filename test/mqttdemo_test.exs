defmodule MqttdemoTest do
  use ExUnit.Case
  doctest Mqttdemo

  test "greets the world" do
    assert Mqttdemo.hello() == :world
  end
end
