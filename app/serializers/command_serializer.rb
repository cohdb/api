class CommandSerializer < ApplicationSerializer
  set_type :command
  attributes :id,
             :player_id,
             :tick,
             :command_category,
             :command_text
end
