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
            start_time: %DateTime{},
            stop_time: %DateTime{}
          }
    @enforce_keys [:id, :status, :start_time, :stop_time]
    defstruct id: nil,
              status: nil,
              start_time: nil,
              stop_time: nil
  end

  defmodule ScheduledStep do
    @type t :: %__MODULE__{
            required_time: integer,
            latest_time: integer | nil,
            zero_time: boolean(),
            task: ScheduledTask.t()
          }
    @enforce_keys [:required_time, :latest_time, :task]
    defstruct required_time: nil,
              latest_time: nil,
              zero_time: false,
              task: nil
  end

  defmodule SingleStep do
    @type t :: %__MODULE__{
            required_time: %DateTime{},
            latest_time: %DateTime{},
            task: ScheduledTask.t()
          }
    @enforce_keys [:required_time, :latest_time, :task]
    defstruct required_time: nil, latest_time: nil, task: nil
  end

  defmodule MultiStep do
    @type t :: %__MODULE__{
            required_time: %DateTime{},
            latest_time: %DateTime{},
            tasks: list(ScheduledTask.t())
          }
    @enforce_keys [:required_time, :latest_time, :tasks]
    defstruct required_time: nil,
              latest_time: nil,
              tasks: []
  end
end
