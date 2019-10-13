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
end
