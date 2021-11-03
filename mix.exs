defmodule Mqttdemo.MixProject do
  use Mix.Project

  def project do
    [
      app: :mqttdemo,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {Mqttdemo, []},
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:tortoise, "~> 0.9"}
    ]
  end
end
