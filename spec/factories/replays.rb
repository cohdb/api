# == Schema Information
#
# Table name: replays
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  version          :integer          not null
#  length           :integer          not null
#  map              :string           not null
#  rng_seed         :integer
#  opponent_type    :string
#  game_type        :string
#  recorded_at      :datetime
#  rec_file_name    :string
#  rec_content_type :string
#  rec_file_size    :integer
#  rec_updated_at   :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  recorded_at_text :string           default(""), not null
#
# Indexes
#
#  index_replays_on_user_id  (user_id)
#

FactoryBot.define do
  factory :replay do
    rec { Rack::Test::UploadedFile.new(File.join(Rails.root, '/spec/support/fixtures', 'test_replay.rec')) }

    opponent_type { Replay::OPPONENT_TYPES.sample }
    game_type { Replay::GAME_TYPES.sample }
    map { "$#{Faker::Number.between(10000000, 99999999)}" }
    recorded_at { Faker::Time.between(1.day.ago, 1.day.from_now, :all) }
    recorded_at_text { Faker::Time.between(1.day.ago, 1.day.from_now, :all).to_s }
    version { Faker::Number.between(1, 10000) }
    length { Faker::Number.number(5) }

    trait :with_user do
      association :user, factory: :user, strategy: :build
    end

    trait :with_players do
      players { build_list(:player, 2) }
    end
  end
end
