FactoryBot.define do
  factory :replay do
    rec { File.new(File.join(Rails.root, '/spec/support/fixtures', 'test_replay.rec')) }

    opponent_type { Replay::OPPONENT_TYPES.sample }
    game_type { Replay::GAME_TYPES.sample }
    map { "$#{Faker::Number.between(10000000, 99999999)}" }
    recorded_at { Faker::Time.between(1.day.ago, 1.day.from_now, :all) }
    version { Faker::Number.between(1, 10000) }

    trait :with_user do
      association :user, factory: :user, strategy: :build
    end

    trait :with_players do
      players { build_list(:player, 2) }
    end
  end
end
