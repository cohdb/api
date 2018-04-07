# frozen_string_literal: true
after :users do
  Replay.create!(version: 20_042,
                 length: 3306,
                 map: '$11050385',
                 rng_seed: 0,
                 opponent_type: 'human',
                 game_type: 'COH2_REC',
                 recorded_at: Time.zone.now)

  Replay.create!(user: User.first,
                 version: 20_043,
                 length: 5306,
                 map: '$11050385',
                 rng_seed: 0,
                 opponent_type: 'human',
                 game_type: 'COH2_REC',
                 recorded_at: Time.zone.now)
end
