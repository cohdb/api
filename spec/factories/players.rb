# == Schema Information
#
# Table name: players
#
#  id          :integer          not null, primary key
#  replay_id   :integer          not null
#  internal_id :integer          not null
#  name        :string           not null
#  steam_id    :string           not null
#  faction     :string           not null
#  team        :integer
#  commander   :string
#  cpm         :decimal(, )
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_players_on_replay_id  (replay_id)
#

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
