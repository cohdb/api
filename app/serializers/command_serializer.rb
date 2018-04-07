# frozen_string_literal: true
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

class CommandSerializer < ApplicationSerializer
  set_type :command
  attributes :id,
             :player_id,
             :tick,
             :command_category,
             :command_text
end
