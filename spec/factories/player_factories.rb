FactoryBot.define do
  factory :player do
    association :replay, factory: :replay, strategy: :build

    internal_id { Faker::Number.number(1) }
    name { Faker::Name.name }
    steam_id { Faker::Number.number(17).to_s }
    faction { Player::FACTIONS.sample }

    trait :with_commands do
      commands { build_list(:command, 5) }
    end

    trait :with_chat_messages do
      chat_messages { build_list(:chat_message, 2) }
    end
  end
end
