class ReplaySerializer < ApplicationSerializer
  set_type :replay
  attributes :id, :user_id, :version, :length, :map, :opponent_type, :game_type, :recorded_at
end
