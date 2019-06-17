defmodule RoboticaPlugins do
  defmodule Action do
    @type t :: %__MODULE__{
            message: map() | nil,
            lights: map() | nil,
            sound: map() | nil,
            music: map() | nil
          }
    defstruct message: nil,
              lights: nil,
              sound: nil,
              music: nil
  end

  defmodule Task do
    @type t :: %__MODULE__{
            locations: list(String.t()),
            action: Robotica.Types.Action.t()
          }
    @enforce_keys [:locations, :action]
    defstruct locations: [], action: nil
  end

  defmodule Mark do
    @type t :: %__MODULE__{
            id: String.t(),
            status: :done | :cancelled,
            expires_time: %DateTime{}
          }
    @enforce_keys [:id, :status, :expires_time]
    defstruct id: nil,
              status: nil,
              expires_time: nil
  end

  defmodule Plugin do
    @type t :: %__MODULE__{
            module: atom,
            location: String.t(),
            config: map,
            executor: pid | nil
          }
    @enforce_keys [:module, :location, :config]
    defstruct module: nil, location: nil, config: nil, executor: nil

    @callback config_schema :: map()

    defmacro __using__(_opts) do
      quote do
        @behaviour Plugin

        @spec start_link(plugin :: Robotica.Plugins.Plugin.t()) ::
                {:ok, pid} | {:error, String.t()}
        def start_link(plugin) do
          with {:ok, pid} <- GenServer.start_link(__MODULE__, plugin, []) do
            RoboticaPlugins.Executor.add(plugin.executor, plugin.location, pid)
            {:ok, pid}
          else
            err -> err
          end
        end

        def handle_call({:wait}, _from, state) do
          {:reply, nil, state}
        end
      end
    end
  end

  @spec execute(server :: pid, action :: Action.t()) :: nil
  def execute(server, action) do
    GenServer.cast(server, {:execute, action})
    nil
  end

  @spec wait(server :: pid) :: nil
  def wait(server) do
    GenServer.call(server, {:wait}, 60000)
  end
end
