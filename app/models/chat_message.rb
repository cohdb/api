class ChatMessage < ApplicationRecord
  belongs_to :player

  scope :for_player, ->(player) { player.nil? ? all : where(player: player) }
  scope :for_replay, ->(replay) { replay.nil? ? all : joins(player: :replay).where(players: { replay: replay }) }
end
