FactoryBot.define do
  factory :command do
    association :player, factory: :player, strategy: :build

    internal_player_id { Faker::Number.number(1) }
    tick { Faker::Number.number(5) }
    command_type { CommandTypes::MOVEMENT_COMMAND_TYPES.to_a.sample }
    entity_id { Faker::Number.number(5) }
  end
end
