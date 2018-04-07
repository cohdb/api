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

FactoryBot.define do
  factory :command do
    association :player, factory: :player, strategy: :build

    internal_player_id { Faker::Number.number(1) }
    tick { Faker::Number.number(5) }
    command_type { CommandTypes::MOVEMENT_COMMAND_TYPES.to_a.sample }
    entity_id { Faker::Number.number(5) }
  end
end
