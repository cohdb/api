namespace :legacy_migration do
  desc 'TODO'
  task run: :environment do
    require 'csv'

    responses = {
      ok: 0,
      fail: 0,
    }

    # csv = CSV.parse(File.read('/Users/ryantaylor/replays.csv'))
    # CSV.foreach('/Users/ryantaylor/replays.csv') do |line|
    #   id = line[0].to_i
    #   created_at = line[2].to_datetime
    #   replay_json = {
    #     'version' => line[7].to_i,
    #     'duration' => line[8].to_i,
    #     'map' => {
    #       'name' => line[3],
    #     },
    #     'rng_seed' => 0,
    #     'opponent_type' => 1,
    #     'game_type' => 'COH2_REC',
    #     'date_time' => line[9],
    #     'chat' => JSON.parse(line[6]),
    #     'players' => JSON.parse(line[4]),
    #     'commands' => JSON.parse(line[5]),
    #   }
    #
    #   result = Replay.create_from_legacy(id, replay_json, created_at)
    #   responses[result] += 1
    # end

    ap "Replays processed: #{responses[:ok] + responses[:fail]}"
    ap "Succeeded: #{responses[:ok]}"
    ap "Failed: #{responses[:fail]}"
  end
end
