FactoryBot.define do
  factory :chat_message do
    association :player, factory: :player, strategy: :build

    tick { Faker::Number.number(5) }
    message { Faker::StarWars.quote }
  end
end
