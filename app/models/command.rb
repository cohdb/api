class Command < ApplicationRecord
  include CommandTypes

  belongs_to :player

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
