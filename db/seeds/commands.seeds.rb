after :players do
  Player.all.find_each do |player|
    Command.create!(player: player,
                    internal_player_id: player.internal_id,
                    tick: 100,
                    command_type: 'CMD_BuildSquad',
                    entity_id: 104)
  end
end
