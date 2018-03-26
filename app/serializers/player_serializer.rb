class PlayerSerializer < ApplicationSerializer
  set_type :player
  attributes :id, :replay_id, :name, :steam_id, :steam_avatar_url, :faction, :team, :commander_name, :cpm
end
