# frozen_string_literal: true
after :replays do
  replay = Replay.first
  factions = %w[aef german]
  teams = [0, 1]

  2.times do |n|
    Player.create!(replay: replay,
                   internal_id: n,
                   name: "Player #{n}",
                   steam_id: '76561197999799366',
                   faction: factions[n],
                   team: teams[n],
                   commander: '186229',
                   cpm: 12.345)
  end

  replay = Replay.last
  factions = %w[aef aef soviet british german german west_german west_german]
  teams = [0, 0, 0, 0, 1, 1, 1, 1]

  8.times do |n|
    Player.create!(replay: replay,
                   internal_id: n,
                   name: "Player #{n}",
                   steam_id: '76561197999799366',
                   faction: factions[n],
                   team: teams[n],
                   commander: '186229',
                   cpm: 12.345)
  end
end
