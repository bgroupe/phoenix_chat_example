defmodule Chat do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    topologies = [
      chat: [
        strategy: Cluster.Strategy.Gossip,
        config: [
          port: 45892,
          if_addr: "0.0.0.0",
          multicast_addr: "255.255.255.255",
          broadcast_only: true
        ]
      ]
    ]

    children = [
      # Start the endpoint when the application starts
      {Cluster.Supervisor, [topologies, [name: Chat.ClusterSupervisor]]},
      supervisor(Chat.Endpoint, [])
      # Here you could define other workers and supervisors as children
      # worker(Chat.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Chat.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Chat.Endpoint.config_change(changed, removed)
    :ok
  end
end
