defmodule Chat.Mixfile do
  use Mix.Project

  def project do
    [
      app: :chat,
      version: "0.0.3",
      elixir: "~> 1.6",
      elixirc_paths: ["lib", "web"],
      compilers: [:phoenix] ++ Mix.compilers(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {Chat, []}, extra_applications: [:logger]]
  end

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [
      {:phoenix, "~> 1.5"},
      {:phoenix_html, "~> 3.0"},
      {:phoenix_live_reload, "~> 1.1", only: :dev},
      {:poison, "~> 3.0"},
      {:postgrex, "~> 0.13"},
      {:cowboy, "~> 2.0"},
      {:plug_cowboy, "~> 2.0"},
      {:libcluster, "~> 3.3"}
    ]
  end
end
