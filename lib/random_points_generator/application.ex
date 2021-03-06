defmodule RandomPointsGenerator.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  alias RandomPointsGenerator.Core

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      RandomPointsGenerator.Repo,
      # Start the Telemetry supervisor
      # Start the PubSub system
      {Phoenix.PubSub, name: RandomPointsGenerator.PubSub},
      {RandomPointsGenerator.Server, {Core.new(), :rand_gen}},
      # Start the Endpoint (http/https)
      RandomPointsGeneratorWeb.Endpoint
      # Start a worker by calling: RandomPointsGenerator.Worker.start_link(arg)
      # {RandomPointsGenerator.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RandomPointsGenerator.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    RandomPointsGeneratorWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
