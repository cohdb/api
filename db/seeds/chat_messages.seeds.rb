after :players do
  Player.all.find_each do |player|
    ChatMessage.create!(player: player,
                        tick: 100,
                        message: "Message from player #{player.id}")
  end
end
