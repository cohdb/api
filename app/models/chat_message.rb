# == Schema Information
#
# Table name: chat_messages
#
#  id         :integer          not null, primary key
#  player_id  :integer          not null
#  tick       :integer          not null
#  message    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_chat_messages_on_player_id  (player_id)
#

class ChatMessage < ApplicationRecord
  belongs_to :player

  validates :tick, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :for_player, ->(player) { player.nil? ? all : where(player: player) }
  scope :for_replay, ->(replay) { replay.nil? ? all : joins(player: :replay).where(players: { replay: replay }) }
end
