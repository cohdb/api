class PlayerSerializer < ApplicationSerializer
  set_type :player
  attributes :id, :replay_id, :internal_id, :name, :steam_id, :faction, :team, :commander, :cpm
end
