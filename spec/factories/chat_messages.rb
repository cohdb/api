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

FactoryBot.define do
  factory :chat_message do
    association :player, factory: :player, strategy: :build

    tick { Faker::Number.number(5) }
    message { Faker::StarWars.quote }
  end
end
