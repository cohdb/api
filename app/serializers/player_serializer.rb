class PlayerSerializer < ApplicationSerializer
  set_type :player
  attributes :id, :replay_id, :name, :steam_id, :faction, :team, :commander_name, :cpm
end
