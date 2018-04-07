# == Schema Information
#
# Table name: commands
#
#  id                 :integer          not null, primary key
#  player_id          :integer          not null
#  internal_player_id :integer          not null
#  tick               :integer          not null
#  command_type       :string           not null
#  entity_id          :integer          not null
#  x                  :decimal(, )
#  y                  :decimal(, )
#  z                  :decimal(, )
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_commands_on_player_id  (player_id)
#

class Command < ApplicationRecord
  include CommandTypes

  belongs_to :player

  validates :internal_player_id, numericality: { only_integer: true }
  validates :tick, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :command_type, presence: true
  validates :entity_id, numericality: { only_integer: true }

  scope :for_player, ->(player) { player.nil? ? all : where(player: player) }

  def entity_name
    return if entity_id.zero?
    fn = CommandTypes.entity_name_functions[command_type]
    fn ? fn.call(entity_id) : "UNHANDLED #{entity_id}"
  end

  def command_category
    CommandTypes.command_categories[command_type]
  end

  def command_text
    fn = CommandTypes.command_text_functions[command_type]
    if fn
      fn.call(self)
    else
      "Issues #{command_type} with #{entity_name} at #{x&.round(2)} #{y&.round(2)} #{z&.round(2)}"
    end
  end
end
