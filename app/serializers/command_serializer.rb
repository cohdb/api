class CommandSerializer < ApplicationSerializer
  set_type :command
  attributes :id, :player_id, :internal_player_id, :tick, :command_type, :entity_id, :x, :y, :z
end
